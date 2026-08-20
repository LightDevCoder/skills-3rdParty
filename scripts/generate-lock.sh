#!/usr/bin/env bash
# generate-lock.sh — regenerate UPSTREAM_LOCK.json from the allowlist and the
# current collection state on disk. The manifest is derived, never hand-edited;
# CI verifies that the committed manifest matches a fresh generation.
#
# Usage:
#   scripts/generate-lock.sh [-Root <repo root>] [-Output <path|->] [-Utc <timestamp>]
#
# -Root     repository root (default: script's parent/..)
# -Output   write target (default: UPSTREAM_LOCK.json; "-" prints to stdout)
# -Utc      fixed generated_utc timestamp for reproducible regeneration
#           (used by tests/collection-checks.sh's regenerability check)

set -euo pipefail

ROOT=""
OUTPUT=""
UTC_ARG=""

while [ $# -gt 0 ]; do
  case "$1" in
    -Root) ROOT="$2"; shift 2 ;;
    -Output) OUTPUT="$2"; shift 2 ;;
    -Utc) UTC_ARG="$2"; shift 2 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

if [ -z "$ROOT" ]; then
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

ALLOWLIST="$ROOT/config/upstream-allowlist.json"
SKILL_ROOT="$ROOT/skills"

die() { echo "ERROR: $*" >&2; exit 1; }

sha256_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$1" | awk '{print $NF}'
  else
    die "no sha256 tool available"
  fi
}


local_patch_paths() {
  local src
  src=$(jq -r --arg n "$1" '.packages[] | select(.name == $n) | .source' "$ALLOWLIST")
  if [ "$src" = "blader" ]; then
    echo "UPSTREAM.md PATCHES.md"
  else
    echo "UPSTREAM.md PATCHES.md LICENSE"
  fi
}

local_package_dir() {
  jq -r --arg name "$1" '
    .packages[] | select(.name == $name) |
    if .group == null then "\(.source)/\(.name)"
    else "\(.source)/\(.group)/\(.name)" end' "$ALLOWLIST"
}

generate_entries() {
  local entries="[]"
  while read -r name; do
    local src group up dest
    src=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .source' "$ALLOWLIST")
    group=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .group // "ungrouped"' "$ALLOWLIST")
    up=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .upstream_path' "$ALLOWLIST")
    dest="$SKILL_ROOT/$(local_package_dir "$name")"

    [ -f "$dest/SKILL.md" ] || die "$name: SKILL.md missing at $dest"
    [ -f "$dest/UPSTREAM.md" ] || die "$name: UPSTREAM.md missing (run sync-upstream.sh -Mode sync)"
    [ -f "$dest/PATCHES.md" ] || die "$name: PATCHES.md missing"

    local files_json="[]"
    local exclude
    if [ "$src" = "blader" ]; then
      exclude='^(UPSTREAM\.md|PATCHES\.md)$'
    else
      exclude='^(UPSTREAM\.md|PATCHES\.md|LICENSE)$'
    fi
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      [ -f "$dest/$f" ] || die "$name: upstream file $f missing"
      local hash bytes
      hash=$(sha256_file "$dest/$f")
      bytes=$(wc -c < "$dest/$f" | tr -d ' ')
      files_json=$(jq -n --argjson a "$files_json" --arg p "$f" --arg s "$hash" --argjson b "$bytes" '$a + [{path: $p, sha256: $s, bytes: $b}]')
    done < <(cd "$dest" && find . -type f -not -path './.git/*' | sed 's|^\./||' | LC_ALL=C sort | grep -v -E "$exclude")

    local entry_checksum local_patch_checksum
    entry_checksum=$(echo "$files_json" | jq -r '.[] | "\(.path):\(.sha256)"' | (sha256_file /dev/stdin 2>/dev/null))
    local patch_json="[]"
    for p in $(local_patch_paths "$name"); do
      [ -f "$dest/$p" ] || die "$name: local record $p missing"
      local h
      h=$(sha256_file "$dest/$p")
      patch_json=$(jq -n --argjson a "$patch_json" --arg p "$p" --arg s "$h" '$a + [{path: $p, sha256: $s}]')
    done
    local_patch_checksum=$(echo "$patch_json" | jq -r '.[] | "\(.path):\(.sha256)"' | (sha256_file /dev/stdin 2>/dev/null))

    local tag commit repo url license deps state
    tag=$(jq -r --arg s "$src" '.sources[$s].selected_tag' "$ALLOWLIST")
    commit=$(jq -r --arg s "$src" '.sources[$s].resolved_commit' "$ALLOWLIST")
    repo=$(jq -r --arg s "$src" '.sources[$s].repository' "$ALLOWLIST")
    url=$(jq -r --arg s "$src" '.sources[$s].url' "$ALLOWLIST")
    license=$(jq -r --arg s "$src" '.sources[$s].license' "$ALLOWLIST")
    deps=$(jq -c --arg n "$name" '.packages[] | select(.name == $n) | .dependencies' "$ALLOWLIST")
    deps_count=$(echo "$deps" | jq 'length')
    if [ "$deps_count" = "0" ]; then state="none"; else state="peers"; fi

    local license_path src_file_count
    if [ "$src" = "blader" ]; then license_path="null"; else license_path="\"skills/$(local_package_dir "$name")/LICENSE\""; fi
    src_file_count=$(echo "$files_json" | jq 'length')

    local missing
    missing=$(referenced_resources_missing "$dest")
    local missing_json="[]"
    if [ -n "$missing" ]; then
      missing_json=$(echo "$missing" | jq -R -s 'split("\n") | map(select(length>0))')
    fi

    local entry
    entry=$(jq -n \
      --arg n "$name" --arg src "$src" --arg g "$group" --arg up "$up" \
      --arg dest "skills/$(local_package_dir "$name")" --arg tag "$tag" --arg commit "$commit" \
      --arg repo "$repo" --arg url "$url" --arg license "$license" \
      --argjson files "$files_json" --argjson patch "$patch_json" \
      --arg ec "$entry_checksum" --arg pc "$local_patch_checksum" \
      --argjson deps "$deps" --arg state "$state" --argjson lp "$license_path" \
      --argjson missing "$missing_json" --argjson nfiles "$src_file_count" \
      '{
        package_name: $n,
        source: $src,
        source_group: $g,
        source_state: "pinned-upstream-mirror",
        upstream_repository: $repo,
        upstream_url: $url,
        upstream_package_path: $up,
        local_package_path: $dest,
        pinned_revision: $tag,
        resolved_commit: $commit,
        checksum: $ec,
        files: $files,
        local_modification_state: "records-only",
        local_patch_paths: ($patch | map(.path)),
        local_patch_checksum: $pc,
        upstream_snapshot: true,
        dependency_state: { state: $state, packages: $deps },
        license: $license,
        license_path: $lp,
        provenance_path: ($dest + "/UPSTREAM.md"),
        patch_record_path: ($dest + "/PATCHES.md"),
        referenced_resource_check: { missing: $missing, source_file_count: $nfiles }
      }')
    entries=$(jq -n --argjson a "$entries" --argjson e "$entry" '$a + [$e]')
  done < <(jq -r '.packages[].name' "$ALLOWLIST")
  echo "$entries"
}

referenced_resources_missing() {
  local dest="$1" res missing=""
  while IFS= read -r res; do
    [ -z "$res" ] && continue
    if [ ! -f "$dest/$res" ]; then missing="$missing\n$res"; fi
  done < <(grep -o ']([^)]*)' "$dest/SKILL.md" 2>/dev/null | sed 's/^](//; s/)$//' \
    | cut -d'#' -f1 | cut -d'?' -f1 \
    | grep -v '^https\?://' | grep -v '^mailto:' | grep -v '^/' \
    | grep -v '^<' | grep -v '^$' | grep -vE '^(link|path|url)$' | LC_ALL=C sort -u)
  printf '%b' "$missing" | grep -v '^$' || true
}

entries=$(generate_entries)

collection_checksum=$(echo "$entries" | jq -r '.[] | "\(.package_name):\(.checksum)"' | (sha256_file /dev/stdin 2>/dev/null))

generated_utc="${UTC_ARG:-$(date -u +%Y-%m-%dT%H:%M:%SZ)}"

sources_json=$(jq -n --argjson allow "$(jq '.sources' "$ALLOWLIST")" '
  [$allow | to_entries[] | {
    key: .key,
    repository: .value.repository,
    url: .value.url,
    selected_tag: .value.selected_tag,
    resolved_commit: .value.resolved_commit,
    license: .value.license,
    license_source: .value.license_source
  }]')

manifest=$(jq -n \
  --argjson entries "$entries" \
  --argjson sources "$sources_json" \
  --arg cc "$collection_checksum" \
  --arg utc "$generated_utc" \
  '{
    schema_version: 3,
    repository: "LightDevCoder/skills-3rdParty",
    visibility: "public",
    source_kind: "pinned-upstream-mirror",
    sources: $sources,
    collection_checksum: $cc,
    generated_utc: $utc,
    installation: {
      whole_collection: "npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --yes --copy --agent codex",
      single_skill: "npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --skill <skill-name> --yes --copy --agent codex",
      revision_semantics: "The #v0.2.1 fragment pins the local collection release; mirrored content is pinned per source (mattpocock/skills v1.2.3, blader/humanizer v2.9.1, op7418/Humanizer-zh 91f3d394).",
      release_status: "released v0.2.1; self-check and CI verified; independent review gate abolished"
    },
    entries: $entries
  }')

if [ -z "$OUTPUT" ]; then
  OUTPUT="$ROOT/UPSTREAM_LOCK.json"
fi

if [ "$OUTPUT" = "-" ]; then
  echo "$manifest" | jq .
else
  echo "$manifest" | jq . > "$OUTPUT"
  echo "wrote $OUTPUT" >&2
fi

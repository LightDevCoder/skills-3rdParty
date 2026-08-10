#!/usr/bin/env bash
# sync-upstream.sh — cross-platform upstream sync and verification for
# LightDevCoder/skills-3rdParty.
#
# Modes:
#   check               verify package completeness, hashes, resources, patches
#   resource            verify every relative link inside each SKILL.md exists
#   unauthorized-patch  fail on any local change to upstream-managed files
#   diff                show local/upstream file differences without writing
#   dry-run             show what -Mode sync would do without writing
#   sync                copy upstream files into the nested collection layout
#   prune               remove manifest-recorded upstream files no longer in
#                       the current upstream snapshot (never local records)
#
# Layout: skills/<source>/<group>/<name>/ for grouped packages and
# skills/<source>/<name>/ for ungrouped ones (e.g. skills/blader/humanizer/).
#
# Usage:
#   scripts/sync-upstream.sh -Mode check [-Root <repo root>] [-SourcesRoot <dir>]
#
# The sources root must contain one checkout per source key from
# config/upstream-allowlist.json, e.g.:
#   <SourcesRoot>/mattpocock  = mattpocock/skills at the pinned tag
#   <SourcesRoot>/blader      = blader/humanizer at the pinned tag

set -euo pipefail

MODE="${1:-check}"
ROOT=""
SOURCES_ROOT=""

while [ $# -gt 0 ]; do
  case "$1" in
    -Mode) MODE="$2"; shift 2 ;;
    -Root) ROOT="$2"; shift 2 ;;
    -SourcesRoot) SOURCES_ROOT="$2"; shift 2 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

case "$MODE" in
  check|resource|unauthorized-patch|diff|dry-run|sync|prune) ;;
  *) echo "invalid mode: $MODE (expected check|resource|unauthorized-patch|diff|dry-run|sync|prune)" >&2; exit 2 ;;
esac

if [ -z "$ROOT" ]; then
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
if [ -z "$SOURCES_ROOT" ]; then
  SOURCES_ROOT="$(cd "$ROOT/.." && pwd)/sources"
fi

ALLOWLIST="$ROOT/config/upstream-allowlist.json"
MANIFEST="$ROOT/UPSTREAM_LOCK.json"
SKILL_ROOT="$ROOT/skills"

die() { echo "ERROR: $*" >&2; exit 1; }
note() { echo "$*"; }

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

jq_get() { jq -r "$1" "$2"; }

relative_files() {
  local dir="$1"
  if [ ! -d "$dir" ]; then return 0; fi
  (cd "$dir" && find . -type f -not -path './.git/*' | sed 's|^\./||' | LC_ALL=C sort)
}

frontmatter_name() {
  awk 'BEGIN{fm=0}
    /^---[[:space:]]*$/{fm++; next}
    fm==1 && /^name:[[:space:]]/{sub(/^name:[[:space:]]*/,""); gsub(/^["'"'"']|["'"'"']$/,""); print; exit}
    fm==2{exit}' "$1"
}

referenced_resources() {
  local skill="$1"
  grep -o ']([^)]*)' "$skill" 2>/dev/null | sed 's/^](//; s/)$//' \
    | cut -d'#' -f1 | cut -d'?' -f1 \
    | grep -v '^https\?://' | grep -v '^mailto:' | grep -v '^/' \
    | grep -v '^<' | grep -v '^$' | grep -vE '^(link|path|url)$' | LC_ALL=C sort -u
}

list_packages() { jq_get '.packages[] | .name' "$ALLOWLIST"; }

package_json() { jq_get ".packages[] | select(.name == \"$1\")" "$ALLOWLIST" 2>/dev/null || die "package $1 not in allowlist"; }

local_package_dir() {
  local name="$1"
  jq -r --arg name "$name" '
    .packages[] | select(.name == $name) |
    if .group == null then "\(.source)/\(.name)"
    else "\(.source)/\(.group)/\(.name)" end' "$ALLOWLIST"
}

local_patch_paths() {
  local name="$1"
  # v1.2.3 packages ship their own agents/openai.yaml; the only local
  # additions are the collection records and (for mattpocock) the license copy.
  local src
  src=$(jq -r --arg name "$name" '.packages[] | select(.name == $name) | .source' "$ALLOWLIST")
  if [ "$src" = "blader" ]; then
    echo "UPSTREAM.md PATCHES.md"
  else
    echo "UPSTREAM.md PATCHES.md LICENSE"
  fi
}

upstream_package_root() {
  local name="$1" src
  src=$(jq -r --arg name "$name" '.packages[] | select(.name == $name) | .source' "$ALLOWLIST")
  [ -d "$SOURCES_ROOT/$src" ] || die "upstream checkout missing for source $src: $SOURCES_ROOT/$src"
  echo "$SOURCES_ROOT/$src"
}

upstream_package_path() {
  jq -r --arg name "$name" '.packages[] | select(.name == $name) | .upstream_path' "$ALLOWLIST"
}

ensure_manifest() { [ -f "$MANIFEST" ] || die "manifest missing: $MANIFEST (run scripts/generate-lock.sh first)"; }

check_source_pins() {
  while read -r src; do
    local expected tag
    expected=$(jq -r --arg src "$src" '.sources[$src].resolved_commit' "$ALLOWLIST")
    [ -d "$SOURCES_ROOT/$src" ] || die "upstream checkout missing: $SOURCES_ROOT/$src"
    tag=$(jq -r --arg src "$src" '.sources[$src].selected_tag' "$ALLOWLIST")
    local actual
    actual=$(git -C "$SOURCES_ROOT/$src" rev-parse HEAD 2>/dev/null || die "not a git checkout: $SOURCES_ROOT/$src")
    if [ "$actual" != "$expected" ]; then
      die "source $src is at $actual but allowlist pins $tag ($expected)"
    fi
  done < <(jq -r '.sources | keys[]' "$ALLOWLIST")
}

verify_one_package() {
  local name="$1" entry files local_patch ok=1
  entry=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n)' "$MANIFEST" 2>/dev/null) \
    || die "manifest has no entry for $name"
  local dest
  dest="$SKILL_ROOT/$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .local_package_path' "$MANIFEST" | sed 's|^skills/||')"

  [ -d "$dest" ] || die "$name: package directory missing: $dest"
  [ -f "$dest/SKILL.md" ] || die "$name: SKILL.md missing"

  while IFS= read -r f; do
    local want actual
    want=$(jq -r --arg n "$name" --arg f "$f" '.entries[] | select(.package_name == $n) | .files[] | select(.path == $f) | .sha256' "$MANIFEST")
    if [ -z "$want" ]; then die "$name: manifest has no record for upstream file $f"; fi
    if [ ! -f "$dest/$f" ]; then die "$name: upstream file missing: $f"; fi
    actual=$(sha256_file "$dest/$f")
    if [ "$actual" != "$want" ]; then
      die "$name: upstream file changed: $f ($actual != $want)"
    fi
  done < <(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .files[].path' "$MANIFEST")

  local allowed
  allowed=$(local_patch_paths "$name")
  local actual_files
  actual_files=$(relative_files "$dest")
  local unauthorized
  unauthorized=$(grep -vxF -f \
    <({ jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .files[].path' "$MANIFEST"; echo "$allowed" | tr ' ' '\n'; } | LC_ALL=C sort -u) \
    <(echo "$actual_files") || true)
  if [ -n "$unauthorized" ]; then
    die "$name: unauthorized local files: $(echo "$unauthorized" | tr '\n' ' ')"
  fi

  local expected_missing
  expected_missing=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .referenced_resource_check.missing | length' "$MANIFEST")
  [ "$expected_missing" = "0" ] || die "$name: manifest records missing referenced resources"
  local missing
  missing=$(resources_missing "$dest")
  if [ -n "$missing" ]; then die "$name: referenced resources missing: $(echo "$missing" | tr '\n' ' ')"; fi

  local want_patch actual_patch
  want_patch=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .local_patch_checksum' "$MANIFEST")
  actual_patch=$(local_patch_checksum "$name")
  if [ "$actual_patch" != "$want_patch" ]; then
    die "$name: local records (UPSTREAM.md/PATCHES.md/LICENSE) modified without regeneration"
  fi
}

local_patch_checksum() {
  local name="$1" dest
  dest="$SKILL_ROOT/$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .local_package_path' "$MANIFEST" | sed 's|^skills/||')"
  {
    for p in $(local_patch_paths "$name"); do
      [ -f "$dest/$p" ] || { echo ""; return 0; }
      echo "$p:$(sha256_file "$dest/$p")"
    done
  } | (sha256_file /dev/stdin 2>/dev/null || die "sha256 unavailable")
}

resources_missing() {
  local dest="$1" res
  local missing=""
  while IFS= read -r res; do
    [ -z "$res" ] && continue
    local candidate="$dest/$res"
    case "$candidate" in
      "$dest/"*) ;;
      *) continue ;;
    esac
    if [ ! -f "$candidate" ]; then missing="$missing\n$res"; fi
  done < <(referenced_resources "$dest/SKILL.md")
  printf '%b' "$missing" | grep -v '^$' || true
}

mode_check() {
  ensure_manifest
  check_source_pins
  local names
  names=$(jq -r '.entries[].package_name' "$MANIFEST" | LC_ALL=C sort)
  local allow
  allow=$(list_packages | LC_ALL=C sort)
  if [ "$names" != "$allow" ]; then die "manifest packages do not match allowlist"; fi
  while read -r name; do
    verify_one_package "$name"
  done < <(list_packages)
  note "check PASS: $MODE"
}

mode_resource() {
  while read -r name; do
    local dest
    dest="$SKILL_ROOT/$(local_package_dir "$name")"
    local missing
    missing=$(resources_missing "$dest")
    if [ -n "$missing" ]; then die "$name: missing referenced resources: $(echo "$missing" | tr '\n' ' ')"; fi
  done < <(list_packages)
  note "resource PASS"
}

mode_unauthorized_patch() {
  while read -r name; do
    local dest src up_root
    dest="$SKILL_ROOT/$(local_package_dir "$name")"
    src=$(upstream_package_root "$name")
    up_root="$src/$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .upstream_path' "$ALLOWLIST")"
    local upstream_files
    upstream_files=$(relative_files "$up_root")
    local allowed
    allowed=$(local_patch_paths "$name")
    local actual
    actual=$(relative_files "$dest")
    local unauthorized
    unauthorized=$(grep -vxF -f \
      <({ echo "$upstream_files"; echo "$allowed" | tr ' ' '\n'; } | LC_ALL=C sort -u) \
      <(echo "$actual") || true)
    if [ -n "$unauthorized" ]; then die "$name: unauthorized local files: $(echo "$unauthorized" | tr '\n' ' ')"; fi
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      if [ -f "$dest/$f" ]; then
        local ua la
        ua=$(sha256_file "$up_root/$f")
        la=$(sha256_file "$dest/$f")
        if [ "$ua" != "$la" ]; then die "$name: upstream-managed file modified: $f"; fi
      fi
    done < <(echo "$upstream_files")
  done < <(list_packages)
  note "unauthorized-patch PASS"
}

diff_one_package() {
  local name="$1"
  local dest src up
  dest="$SKILL_ROOT/$(local_package_dir "$name")"
  src=$(upstream_package_root "$name")
  up=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .upstream_path' "$ALLOWLIST")
  local allowed
  allowed=$(local_patch_paths "$name")
  local up_files
  up_files=$(cd "$src/$up" && relative_files ".")
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    local ua la
    ua=$(sha256_file "$src/$up/$f")
    if [ -f "$dest/$f" ]; then
      la=$(sha256_file "$dest/$f")
      if [ "$ua" != "$la" ]; then note "~ $name/$f (upstream differs)"; fi
    else
      note "+ $name/$f (missing locally)"
    fi
  done < <(echo "$up_files")
  local actual
  actual=$(relative_files "$dest")
  local extra
  extra=$(grep -vxF -f \
    <({ echo "$up_files"; echo "$allowed" | tr ' ' '\n'; } | LC_ALL=C sort -u) \
    <(echo "$actual") || true)
  if [ -n "$extra" ]; then note "! $name: local-only files: $(echo "$extra" | tr '\n' ' ')"; fi
}

mode_diff() { while read -r name; do diff_one_package "$name"; done < <(list_packages); }

sync_one_package() {
  local name="$1" src up dest
  src=$(upstream_package_root "$name")
  up=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .upstream_path' "$ALLOWLIST")
  dest="$SKILL_ROOT/$(local_package_dir "$name")"
  [ -d "$src/$up" ] || die "$name: upstream package missing: $src/$up"

  local up_files
  up_files=$(cd "$src/$up" && relative_files ".")
  echo "$up_files" | grep -qx 'SKILL.md' || die "$name: upstream package lacks SKILL.md"

  if [ "$MODE" = "dry-run" ]; then
    note "would sync $name -> $dest ($(echo "$up_files" | wc -l | tr -d ' ') upstream files)"
    return 0
  fi

  mkdir -p "$dest"
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    mkdir -p "$(dirname "$dest/$f")"
    cp -p "$src/$up/$f" "$dest/$f"
  done < <(echo "$up_files")

  generate_records "$name"
  note "synced: $name"
}

mode_prune() {
  # Remove files the manifest recorded as upstream-managed but the current
  # upstream snapshot no longer contains. Never removes local records.
  while read -r name; do
    local src up dest
    src=$(upstream_package_root "$name")
    up=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .upstream_path' "$ALLOWLIST")
    dest="$SKILL_ROOT/$(local_package_dir "$name")"
    local cur old_files
    cur=$(local_package_dir "$name")
    old_files=""
    if [ -f "$MANIFEST" ]; then
      old_files=$(jq -r --arg n "$name" --arg cur "$cur" \
        '.entries[] | select(.package_name == $n) |
         select(.local_package_path == ("skills/" + $cur)) |
         .files[].path' "$MANIFEST" 2>/dev/null || true)
    fi
    local up_files
    up_files=$(cd "$src/$up" && relative_files ".")
    local allowed
    allowed=$(local_patch_paths "$name")
    local stale
    stale=$(grep -vxF -f \
      <({ echo "$up_files"; echo "$allowed" | tr ' ' '\n'; } | LC_ALL=C sort -u) \
      <(echo "$old_files") || true)
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      local record
      record=$(jq -r --arg n "$name" --arg f "$f" \
        '.entries[] | select(.package_name == $n) | .files[] | select(.path == $f) | .sha256' \
        "$MANIFEST" 2>/dev/null || true)
      if [ -f "$dest/$f" ] && [ -n "$record" ] && [ "$(sha256_file "$dest/$f")" = "$record" ]; then
        rm -f "$dest/$f"
        note "pruned: $dest/$f"
      else
        note "would prune (skipped, modified or unrecorded): $dest/$f"
      fi
    done < <(echo "$stale")
  done < <(list_packages)
  note "prune complete; run scripts/generate-lock.sh to refresh UPSTREAM_LOCK.json"
}

generate_records() {
  local name="$1" src up
  src=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .source' "$ALLOWLIST")
  up=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .upstream_path' "$ALLOWLIST")
  local src_root
  src_root=$(upstream_package_root "$name")
  local dest
  dest="$SKILL_ROOT/$(local_package_dir "$name")"
  local tag commit
  tag=$(jq -r --arg s "$src" '.sources[$s].selected_tag' "$ALLOWLIST")
  commit=$(jq -r --arg s "$src" '.sources[$s].resolved_commit' "$ALLOWLIST")
  local group deps
  group=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .group // "ungrouped"' "$ALLOWLIST")
  deps=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | if (.dependencies | length) == 0 then "none" else (.dependencies | join(", ")) end' "$ALLOWLIST")
  local source_url
  source_url=$(jq -r --arg s "$src" '.sources[$s].url' "$ALLOWLIST")
  local license
  license=$(jq -r --arg s "$src" '.sources[$s].license' "$ALLOWLIST")

  cat > "$dest/UPSTREAM.md" <<EOF
# Upstream Record: $name

This package is a pinned upstream snapshot. The upstream Skill instructions
and referenced resources are preserved unmodified; the only local additions
are this provenance record, the patch ledger, and (where listed) a license
copy.

## Identity

- **Source:** $src ($source_url)
- **Source group:** $group
- **Package:** $name
- **Upstream repository:** $(jq -r --arg s "$src" '.sources[$s].repository' "$ALLOWLIST")
- **Original upstream package path:** $up
- **Selected upstream tag:** $tag
- **Resolved commit:** $commit
- **Applicable license:** $license; see \`LICENSE\` in this package.
- **Upstream author/notice:** preserve the upstream license and attribution.

## Local packaging state

- **State:** pinned upstream snapshot; no upstream behavior patch.
- **Local additions:** \`UPSTREAM.md\` and \`PATCHES.md\` are collection records.
  $(if [ "$src" != "blader" ]; then echo '`LICENSE` is a package-local copy of the upstream license.'; fi)
- **Dependencies:** $deps. Declared peer Skills, not hidden runtime imports.
- **Navigation boundary:** \`ask-matt\` remains a router and does not execute or
  install the Skills it mentions.

## Installation and update

- **Whole collection (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --yes --copy --agent codex
- **Single package (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --skill $name --yes --copy --agent codex
- **Manual fallback:** copy the complete skills/$src/${group#ungrouped}/$name directory (or skills/$src/$name for ungrouped packages) into the host's recognized Skills root.
- **Update source:** run \`scripts/sync-upstream.sh -Mode check\` against the
  pinned source checkouts; review \`-Mode diff\`, then use \`-Mode sync\` and
  \`scripts/generate-lock.sh\` only after the allowlist and revision are approved.

## Differences and evidence

- **Upstream behavior preserved:** yes, for every upstream-managed file listed
  in \`UPSTREAM_LOCK.json\`.
- **Local difference:** provenance records only (plus license copy where noted).
- **Patch record:** \`PATCHES.md\`
- **Lock entry:** UPSTREAM_LOCK.json entry $name
EOF

  cat > "$dest/PATCHES.md" <<EOF
# Local Patch Record: $name

- **Upstream revision:** $tag ($commit)
- **Local state:** no upstream behavior patch; collection records only.
- **Allowed local paths:** $(local_patch_paths "$name" | tr ' ' ', ')

## Patch entries

None. Every upstream-managed file is copied unmodified and hash-checked by
\`scripts/sync-upstream.sh\`; any future behavior or compatibility change
must be recorded here with a concrete reason before admission.

## Patch-set review

- All local differences accounted for: yes (records only).
- Upstream file integrity: enforced by \`sync-upstream.sh\` and the
  collection checks in CI.
EOF

  if [ "$src" != "blader" ]; then
    cp -p "$src_root/LICENSE" "$dest/LICENSE" 2>/dev/null || die "$name: upstream LICENSE missing"
  fi
}

mode_sync() {
  while read -r name; do sync_one_package "$name"; done < <(list_packages)
  note "sync complete; run scripts/generate-lock.sh to refresh UPSTREAM_LOCK.json"
}

case "$MODE" in
  check) mode_check ;;
  resource) mode_resource ;;
  unauthorized-patch) mode_unauthorized_patch ;;
  diff) mode_diff ;;
  dry-run) mode_sync ;;
  sync) mode_sync ;;
  prune) mode_prune ;;
esac

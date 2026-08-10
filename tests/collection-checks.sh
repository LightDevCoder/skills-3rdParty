#!/usr/bin/env bash
# collection-checks.sh — structural checks for the third-party collection.
# Cross-platform (bash + jq). Verifies allowlist/manifest consistency, package
# completeness, provenance records, and governance doc invariants.

set -euo pipefail

ROOT=""
while [ $# -gt 0 ]; do
  case "$1" in
    -Root) ROOT="$2"; shift 2 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

if [ -z "$ROOT" ]; then
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

ALLOWLIST="$ROOT/config/upstream-allowlist.json"
MANIFEST="$ROOT/UPSTREAM_LOCK.json"
SKILL_ROOT="$ROOT/skills"

failures=0
fail() { echo "FAIL: $*" >&2; failures=$((failures + 1)); }
ok() { echo "ok: $*"; }
assert() { if [ "$1" = "$2" ]; then ok "$3"; else fail "$3 (expected '$2', got '$1')"; fi; }

[ -f "$ALLOWLIST" ] || fail "allowlist missing"
[ -f "$MANIFEST" ] || fail "manifest missing"
jq empty "$ALLOWLIST" 2>/dev/null || fail "allowlist is not valid JSON"
jq empty "$MANIFEST" 2>/dev/null || fail "manifest is not valid JSON"

allowlist_checks() {
  [ "$(jq -r '.schema_version' "$ALLOWLIST")" = "2" ] || fail "allowlist schema_version != 2"
  local count
  count=$(jq '.packages | length' "$ALLOWLIST")
  assert "$count" "26" "allowlist has 26 packages"

  jq -r '.packages[].name' "$ALLOWLIST" | LC_ALL=C sort | uniq -d | while read -r dup; do
    fail "duplicate package in allowlist: $dup"
  done || true

  while read -r src; do
    jq -r --arg s "$src" '.sources[$s] | [.repository, .selected_tag, .resolved_commit] | @tsv' "$ALLOWLIST" > /dev/null || fail "source $src incomplete"
  done < <(jq -r '.sources | keys[]' "$ALLOWLIST")

  while read -r name; do
    local src
    src=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | .source' "$ALLOWLIST")
    jq -r --arg s "$src" '.sources[$s]' "$ALLOWLIST" > /dev/null 2>&1 || fail "package $name references unknown source $src"
  done < <(jq -r '.packages[].name' "$ALLOWLIST")
  ok "allowlist structure"
}

manifest_checks() {
  assert "$(jq -r '.schema_version' "$MANIFEST")" "3" "manifest schema_version = 3"
  assert "$(jq -r '.visibility' "$MANIFEST")" "public" "manifest visibility is public"
  assert "$(jq -r '.repository' "$MANIFEST")" "LightDevCoder/skills-3rdParty" "manifest repository"

  local entry_count
  entry_count=$(jq '.entries | length' "$MANIFEST")
  assert "$entry_count" "26" "manifest has 26 entries"

  local allow sorted manifest_names sorted2
  allow=$(jq -r '.packages[].name' "$ALLOWLIST" | LC_ALL=C sort)
  manifest_names=$(jq -r '.entries[].package_name' "$MANIFEST" | LC_ALL=C sort)
  assert "$(echo "$allow" | diff - <(echo "$manifest_names") > /dev/null && echo same || echo diff)" "same" "allowlist and manifest package sets match"

  while read -r name; do
    local entry
    entry=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n)' "$MANIFEST" 2>/dev/null) || fail "manifest entry missing: $name"
    [ -n "$entry" ] || fail "manifest entry missing: $name"
  done < <(echo "$allow")
  ok "manifest structure"
}

package_checks() {
  while read -r name; do
    local dir
    dir=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .local_package_path' "$MANIFEST")
    local full="$SKILL_ROOT/${dir#skills/}"
    [ -f "$full/SKILL.md" ] || { fail "$name: SKILL.md missing"; continue; }

    local frontname
    frontname=$(awk 'BEGIN{fm=0} /^---[[:space:]]*$/{fm++; next} fm==1 && /^name:[[:space:]]/{sub(/^name:[[:space:]]*/,""); gsub(/^["'"'"']|["'"'"']$/,""); print; exit} fm==2{exit}' "$full/SKILL.md")
    assert "$frontname" "$name" "$name frontmatter name matches"

    grep -q '^description:' "$full/SKILL.md" || fail "$name: description missing in frontmatter"

    [ -f "$full/UPSTREAM.md" ] || fail "$name: UPSTREAM.md missing"
    [ -f "$full/PATCHES.md" ] || fail "$name: PATCHES.md missing"
    grep -q "$name" "$full/UPSTREAM.md" || fail "$name: UPSTREAM.md does not identify the package"

    local src
    src=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .source' "$MANIFEST")
    if [ "$src" != "blader" ]; then
      [ -f "$full/LICENSE" ] || fail "$name: LICENSE missing"
    fi

    local expected_dir
    expected_dir=$(jq -r --arg n "$name" '.packages[] | select(.name == $n) | if .group == null then "skills/\(.source)/\(.name)" else "skills/\(.source)/\(.group)/\(.name)" end' "$ALLOWLIST")
    assert "$dir" "$expected_dir" "$name nested layout path matches allowlist"

    local missing
    missing=$(jq -r --arg n "$name" '.entries[] | select(.package_name == $n) | .referenced_resource_check.missing | length' "$MANIFEST")
    assert "$missing" "0" "$name referenced resources all present"
  done < <(jq -r '.packages[].name' "$ALLOWLIST")
}

no_stray_packages() {
  while read -r dir; do
    local rel
    rel=${dir#"$SKILL_ROOT/"}
    case "$rel" in
      mattpocock|blader) ;;
      *) fail "stray directory under skills/: $rel" ;;
    esac
  done < <(find "$SKILL_ROOT" -mindepth 1 -maxdepth 1 -type d | LC_ALL=C sort)

  while read -r dir; do
    local rel
    rel=${dir#"$SKILL_ROOT/"}
    case "$rel" in
      mattpocock/engineering|mattpocock/productivity|blader/humanizer) ;;
      *) fail "unexpected source/group directory: $rel" ;;
    esac
  done < <(find "$SKILL_ROOT" -mindepth 2 -maxdepth 2 -type d | LC_ALL=C sort)
  ok "no stray packages under skills/"
}

manifest_regenerable() {
  local tmp pinned
  tmp=$(mktemp -d)
  pinned=$(jq -r '.generated_utc' "$MANIFEST")
  "$ROOT/scripts/generate-lock.sh" -Root "$ROOT" -Output "$tmp/lock.json" -Utc "$pinned"
  local diffout
  diffout=$(diff "$MANIFEST" "$tmp/lock.json" 2>&1 || true)
  rm -rf "$tmp"
  if [ -n "$diffout" ]; then
    fail "committed UPSTREAM_LOCK.json is not regenerable: $diffout"
  else
    ok "committed manifest matches fresh generation"
  fi
}

governance_docs() {
  [ -f "$ROOT/docs/POLICIES.md" ] || fail "docs/POLICIES.md missing"
  [ -f "$ROOT/CATALOG.md" ] || fail "CATALOG.md missing"
  [ -f "$ROOT/CATALOG.zh-CN.md" ] || fail "CATALOG.zh-CN.md missing"
  [ -f "$ROOT/README.md" ] || fail "README.md missing"
  [ -f "$ROOT/README.zh-CN.md" ] || fail "README.zh-CN.md missing"

  for stale in THIRD_PARTY_ADMISSION REVIEW_POLICY PROVENANCE_POLICY UPDATE_POLICY; do
    [ -f "$ROOT/docs/$stale.md" ] && fail "obsolete governance doc still present: docs/$stale.md"
    [ -f "$ROOT/docs/$stale.zh-CN.md" ] && fail "obsolete governance doc still present: docs/$stale.zh-CN.md"
  done

  grep -q 'v0.2.0' "$ROOT/README.md" || fail "README does not reference v0.2.0"
  grep -q 'v0.2.0' "$ROOT/CATALOG.md" || fail "CATALOG does not reference v0.2.0"

  local ps1_files
  ps1_files=$(find "$ROOT" -name '*.ps1' -not -path '*/.git/*' | wc -l | tr -d ' ')
  assert "$ps1_files" "0" "no PowerShell files remain"

  local v11_refs
  v11_refs=$(grep -rn 'v1\.1\.0' "$ROOT" --include='*.md' --include='*.json' --include='*.sh' --include='*.yml' -l 2>/dev/null | grep -v '.git/' | grep -v 'docs/evidence/releases/v0.1.1' | grep -v 'CHANGELOG' | grep -v 'tests/collection-checks.sh' | wc -l | tr -d ' ' || true)
  assert "$v11_refs" "0" "no stale v1.1.0 references outside v0.1.1 evidence"
}

allowlist_checks
manifest_checks
package_checks
no_stray_packages
manifest_regenerable
governance_docs

if [ "$failures" -gt 0 ]; then
  echo "collection-checks FAILED: $failures failure(s)" >&2
  exit 1
fi
echo "collection-checks PASS"

# Changelog

[简体中文](CHANGELOG.zh-CN.md)

All release claims below require the corresponding repository evidence under
`docs/evidence/releases/`.

## v0.2.0 — 2026-08-10

### Changed

- **Repository made public** and released as `v0.2.0`; installation no longer
  requires private-repository credentials.
- **Upstream upgraded** from mattpocock/skills `v1.1.0` (23 packages) to
  `v1.2.3` (25 packages): added `setup-matt-pocock-skills`, `triage`,
  `resolving-merge-conflicts`, `wizard`, `to-questionnaire`, `wait-what`, and
  `writing-for-agents`; removed `design-an-interface`, `qa`,
  `ubiquitous-language`, `loop-me`, and `writing-great-skills` (superseded by
  the rewritten `writing-for-agents`).
- **`humanizer` admitted as a second mirrored source** (`blader/humanizer`
  `v2.9.1`), promoted from external direct dependency to pinned mirror under
  `skills/blader/humanizer/`.
- **Nested layout**: packages now live at `skills/<source>/<group>/<name>/`
  (or `skills/<source>/<name>/` for ungrouped packages), preserving upstream
  grouping and remaining Skills CLI-discoverable.
- **Tooling rewritten cross-platform**: PowerShell sync script and tests
  replaced by bash + jq (`scripts/sync-upstream.sh`, `scripts/generate-lock.sh`,
  `tests/collection-checks.sh`); CI moved to ubuntu-latest.
- **`UPSTREAM_LOCK.json` is now generated** (`schema_version: 3`, multi-source)
  and verified regenerable in CI; no more hand-maintained manifest.
- **Governance slimmed**: admission and review policy documents removed; the
  independent acceptance gate is abolished. Remaining policy consolidated in
  `docs/POLICIES.md` (Chinese); README and CATALOG stay bilingual.

## v0.1.1 — 2026-07-26

- Initial private release: 23 pinned Matt Pocock Skills from upstream `v1.1.0`
  with metadata adapters, provenance, sync tooling, and bilingual governance
  docs. Historical evidence retained under `docs/evidence/releases/v0.1.1/`.

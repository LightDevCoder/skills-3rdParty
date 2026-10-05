# Changelog

[简体中文](CHANGELOG.zh-CN.md)

All release claims below require the corresponding repository evidence under
`docs/evidence/releases/`.

## Unreleased — v0.3.0 (release candidate)

Release evidence: `docs/evidence/releases/v0.3.0/` — `NOT TESTED` until the
fresh-install gate runs against the published tag.

### Changed

- **Upstream upgraded** from `mattpocock/skills` `v1.2.3` (`6acc160e`) to
  `v1.3.1` (`24fe0ef7`); the source group now contributes 27 packages
  (engineering 20 + productivity 7).
- **Content refresh across the mattpocock packages**: the domain-doc convention
  moved from `CONTEXT.md`/`CONTEXT-MAP.md` to `GLOSSARY.md`/`GLOSSARY-MAP.md`
  (`domain-modeling`'s `CONTEXT-FORMAT.md` became `GLOSSARY-FORMAT.md`),
  cross-skill invocation is now an explicit "Call the Skill tool with ..."
  instruction, upstream prose dropped its em-dashes, and invalid YAML front
  matter was quoted in `to-spec`, `code-review`, `setup-matt-pocock-skills`,
  and `wait-what`.
- **Tooling**: `tests/collection-checks.sh` now fails when the `SKILL.md` set
  under `skills/` does not match the allowlist exactly, so a package removed
  from the allowlist cannot stay discoverable in a release.

### Added

- **`implement-spec`** (engineering, pinned mirror): implements a whole spec in
  one run, working the tickets as a task graph on a single integration branch.
  Declared peer dependencies: `tdd`, `code-review`.
- **`pr`** (engineering, pinned mirror): the shape a pull request body should
  take, with before/after evidence and a merge-danger call.
- **`retro`** (engineering, pinned mirror): a retrospective over the coding
  agent's environment rather than the code. Declared peer dependency:
  `writing-for-agents`.
- Collection grows to **29 pinned packages from three sources**; allowlist, CI
  source checkout, `UPSTREAM_LOCK.json`, catalog, and bilingual docs updated.

### Removed

- **`resolving-merge-conflicts` is gone** (breaking for installs that use it):
  upstream deleted the skill in `v1.3.0` with no replacement, so the agent
  works through an in-progress merge or rebase conflict without a dedicated
  skill. The package directory was deleted; upgrade destinations should drop
  the stale copy.

## v0.2.1 — 2026-08-20

### Added

- **`humanizer-zh` admitted as a third mirrored source** (`op7418/Humanizer-zh`
  `91f3d394db8419c20d67ebe22a96cf8fee0a404b`), the Chinese localized variant
  of the Humanizer writing editor, mirrored unmodified under
  `skills/op7418/humanizer-zh/` alongside the English `blader/humanizer`.
- Collection grows to **27 pinned packages from three sources**; allowlist,
  `UPSTREAM_LOCK.json`, CI source checkouts, catalog, and bilingual docs
  updated for the new source.

### Release evidence

- `docs/evidence/releases/v0.2.1/` — verified 2026-08-20.
- CLI: `npx skills` 1.5.23; released commit `1c68526ccfa02b9cbbc8827b78fab5fceba722a8`;
  CI run `32320186456` success (ubuntu).
- Fresh install verified against published `#v0.2.1` tag: whole collection
  27/27 (pinned and latest), single `humanizer-zh` (pinned and latest),
  repeat install idempotent, discovery without source checkout (`Found 27
  skills`). See the evidence docs for the full matrix and limitations.

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

# Changelog

[简体中文](CHANGELOG.zh-CN.md)

All release claims below require the corresponding repository evidence. A
draft entry is not proof of a tag, release, installation, or independent
review.

## Unreleased

### Added

- Admitted `humanizer` (upstream `blader/humanizer`, tag `v2.9.1`, commit
  `523374dee72d67c7b2b5f858ea0094ffda49c3ac`) as an **external direct
  dependency** per user decision on 2026-08-10. The package is deliberately
  not copied into `skills/`; the authoritative upstream, pin, license, and
  installation guidance are recorded in
  [config/external-dependencies.json](config/external-dependencies.json),
  the `external_dependencies` section of
  [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json), and
  [sources/blader-humanizer/README.md](sources/blader-humanizer/README.md).
- Catalog entries for the external dependency in English and Chinese.

### Notes

- The 23-package pinned mirror, its allowlist, and the single-upstream sync
  tooling are unchanged; the external dependency is a manifest-level record
  and does not affect `skills/` discovery.

## 0.1.1 — 2026-07-26

### Added

- Exactly 23 selected Matt Pocock Skills from upstream `v1.1.0`, pinned to
  `d574778f94cf620fcc8ce741584093bc650a61d3`.
- Complete per-package upstream resources, license copies, metadata adapters,
  provenance records, patch ledgers, and machine-readable checksums.
- Explicit pinned-mirror, modified-fork, and external-dependency governance.
- `check`, `dry-run`, `diff`, and `sync` maintenance tooling with an
  unauthorized-local-patch negative fixture.
- English/Chinese catalogs, installation, maintenance, provenance, update,
  review, source-group, and release-evidence documents.

### Release evidence

See [v0.1.1 release receipt](docs/evidence/releases/v0.1.1/RELEASE_RECEIPT.md).
The tag, private release, fresh-install verification, and CI are verified.
Independent acceptance remains `BLOCKED` when no independent evaluator record
is available.

Release commit: `a891d39d7f34793d857c5b8eec3429c23871f421`.

## 0.1.0 — 2026-07-23

The initial private governance-only release. Its empty boundary has been
superseded by the explicitly admitted pinned upstream mirror in `v0.1.1`.

# Third-Party Maintenance

[简体中文](MAINTENANCE.zh-CN.md)

## Sources of truth

| Fact | Authority |
| --- | --- |
| Selected allowlist and upstream paths | `config/upstream-allowlist.json` |
| Resolved revision, files, checksums, state, dependencies | `UPSTREAM_LOCK.json` |
| Upstream package behavior | package `SKILL.md` and its referenced resources |
| Package-local difference | package `PATCHES.md` |
| Installation proof | `docs/evidence/releases/` |
| Human catalog and release history | `CATALOG.md`, `CHANGELOG.md` |

## Synchronization matrix

| Change | Required checks and records |
| --- | --- |
| Upstream revision update | Review tag/commit, upstream diff, license, resources, metadata adapter, and all package checksums. |
| Package add/remove | Update allowlist, manifest, catalog, source-group record, docs, tests, changelog, and release evidence. |
| Local adapter/patch | Add a patch record, focused behavior/negative test, and independent review. |
| Installation change | Fresh whole and single-package installs, discovery outside source checkout, repeat-install result, and limitation record. |
| Release | `check`, package/resource tests, bilingual/link tests, CI, review verdict, tag/release receipt, and remote verification. |

## Sync commands

```powershell
.\scripts\sync-upstream.ps1 -Mode check
.\scripts\sync-upstream.ps1 -Mode dry-run
.\scripts\sync-upstream.ps1 -Mode diff
.\scripts\sync-upstream.ps1 -Mode sync
```

`sync` copies only the allowlisted upstream package paths, refreshes the local
metadata adapter and provenance files, and regenerates the manifest. It may
remove stale files previously recorded as upstream-managed, but only inside
the named package directory. It must never silently resolve a conflict.

## Release discipline

Keep the repository private. Do not publish a package as first-party. Every
release note names upstream revision, selected packages, local patch state,
dependencies, installation evidence, and limitations. A missing independent
review is `BLOCKED`; an unrun test is `NOT TESTED`.

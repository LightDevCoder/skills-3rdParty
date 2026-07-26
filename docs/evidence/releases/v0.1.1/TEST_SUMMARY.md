# v0.1.1 Test Summary

All rows must contain the actual command, environment, assertion count, and
result. A structural test is not runtime proof.

| Area | Command / environment | Assertions | Result |
| --- | --- | ---: | --- |
| Pinned sync check | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode check` | 23 packages | `PASS` — pinned `v1.1.0/d574778f94cf620fcc8ce741584093bc650a61d3` |
| Sync dry-run | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode dry-run` | 23 packages | `PASS` — reports all allowlisted package paths and the pinned revision; writes nothing |
| Sync diff | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode diff` | 23 packages | `PASS` — no `DIFF` lines |
| Resource mode | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode resource` | 23 packages | `PASS` — complete package and referenced-resource boundary |
| Unauthorized-patch mode | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode unauthorized-patch` | 23 packages | `PASS` — managed-file hashes, local patch checksum, and extra-file boundary |
| Successful sync fixture | `scripts/sync-upstream.ps1 -Mode sync -Root <temporary-copy> -UpstreamRoot <clean-pinned-checkout>` | 23 packages | `PASS` — all packages regenerated in a disposable copy; exercised by the collection test |
| Whole package contract | `powershell -NoProfile -ExecutionPolicy Bypass -File tests/third-party-collection-tests.ps1` | 959 | `PASS` |
| Unauthorized local patch and manifest negative fixtures | included in collection test | 7 negative assertions | `PASS` — upstream-file mutation, extra local file, patch-record mutation, sync-overwrite attempt, package/collection checksum tampering, and ignored upstream resource are rejected |
| Dirty upstream negative | `scripts/sync-upstream.ps1 -Mode check -UpstreamRoot <dirty-temporary-clone>` | 1 negative scenario | `PASS` — dirty pinned checkout is rejected before reading package content |
| Whole-repository fresh install | Skills CLI, fresh destination | NOT RECORDED | NOT TESTED |
| Single-package fresh install | Skills CLI, fresh destination | NOT RECORDED | NOT TESTED |
| Representative dependency smoke | `grill-me`, `grill-with-docs` | NOT RECORDED | NOT TESTED |
| Private release verification | GitHub release API / remote | NOT RECORDED | `NOT TESTED` — release is not yet published |

## Non-claims

No row may be promoted from `NOT TESTED` by copying a source-checkout scan or a
simulated output.

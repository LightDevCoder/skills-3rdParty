# v0.1.1 Test Summary

[中文摘要](TEST_SUMMARY.zh-CN.md)

Every row records a real command, environment, assertion count, and result. A
structural test is not runtime proof.

| Area | Command / environment | Assertions | Result |
| --- | --- | ---: | --- |
| Pinned sync check | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode check` | 23 packages | `PASS` — pinned `v1.1.0/d574778f94cf620fcc8ce741584093bc650a61d3` |
| Sync dry-run | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode dry-run` | 23 packages | `PASS` — all allowlisted package paths reported; no writes |
| Sync diff | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode diff` | 23 packages | `PASS` — no `DIFF` lines |
| Resource mode | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode resource` | 23 packages | `PASS` — complete package and referenced-resource boundary |
| Unauthorized-patch mode | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode unauthorized-patch` | 23 packages | `PASS` — managed hashes, patch checksum, and extra-file boundary |
| Successful sync fixture | collection test disposable copy | 23 packages | `PASS` — regenerated packages in a disposable copy |
| Whole package contract | `powershell -File tests/third-party-collection-tests.ps1` | 954 | `PASS` |
| Negative fixtures | included in collection test | 7 negative assertions | `PASS` — upstream mutation, extra file, patch-record mutation, sync overwrite attempt, package/collection checksum tampering, and ignored resource |
| Governance docs | `powershell -File tests/governance-docs-tests.ps1` | 86 | `PASS` |
| Fresh whole-repository install | Skills CLI `1.5.20`, private fresh destination | 23 packages | `PASS` — exit 0, exactly 23 listed, source checkout absent |
| Fresh single-package install | Skills CLI `1.5.20`, private fresh destination | 1 package | `PASS` — exit 0, exactly `grill-with-docs` listed, peer directories absent |
| Repeat installation | repeated whole install | 23 packages | `PASS` — exit 0; all 23 reported `overwrites: Codex` |
| Dependency boundary smoke | whole and single fresh destinations | 2 peer-boundary checks | `PASS` — whole includes peers; single install does not silently install them |
| Private release verification | GitHub release API / remote | 1 release | `PASS` — `v0.1.1` exists at the verified release commit and remains private |
| Release-commit CI | GitHub Actions quality run `30189147755` | workflow | `PASS` |
| Host refresh / model runtime | Agent host refresh and model-mediated invocation | — | `NOT TESTED` |
| Independent acceptance | separate evaluator record | — | `BLOCKED` |

The evidence records destination classes rather than absolute private paths and
does not include tokens, usernames, or credentials.

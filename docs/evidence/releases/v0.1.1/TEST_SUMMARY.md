# v0.1.1 Test Summary

All rows must contain the actual command, environment, assertion count, and
result. A structural test is not runtime proof.

| Area | Command / environment | Assertions | Result |
| --- | --- | ---: | --- |
| Pinned sync check | `scripts/sync-upstream.ps1 -Mode check` | NOT RECORDED | NOT TESTED |
| Sync dry-run | `scripts/sync-upstream.ps1 -Mode dry-run` | NOT RECORDED | NOT TESTED |
| Whole package contract | `tests/third-party-collection-tests.ps1` | NOT RECORDED | NOT TESTED |
| Unauthorized local patch negative fixture | included in collection test | NOT RECORDED | NOT TESTED |
| Whole-repository fresh install | Skills CLI, fresh destination | NOT RECORDED | NOT TESTED |
| Single-package fresh install | Skills CLI, fresh destination | NOT RECORDED | NOT TESTED |
| Representative dependency smoke | `grill-me`, `grill-with-docs` | NOT RECORDED | NOT TESTED |
| Private release verification | GitHub release API / remote | NOT RECORDED | NOT TESTED |

## Non-claims

No row may be promoted from `NOT TESTED` by copying a source-checkout scan or a
simulated output.

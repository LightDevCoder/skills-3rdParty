# Third-Party Review Policy

[简体中文](REVIEW_POLICY.zh-CN.md)

Third-party review checks provenance and boundaries as well as behavior.

## Required review axes

- Standards: package shape, resource containment, metadata, license retention,
  source grouping, link integrity, and maintainability.
- Spec: exact allowlist, pinned revision, local modification classification,
  dependency declarations, installation semantics, and private boundary.

The final verdict is owned by `review-loop`: `PASS`, `FAIL`, or `BLOCKED`.
`sync-upstream.ps1`, package tests, and specialist `code-review` findings are
evidence only. A structural scan cannot substitute for fresh installation or
an independent evaluator.

## Release gate

No tag or release may claim package readiness until the clean worktree has:

- a passing sync check and complete-resource assertion;
- a passing allowlist, manifest, checksum, license, and dependency test;
- a failing negative fixture for unauthorized local changes;
- fresh whole-collection and single-package installation evidence;
- discovery without the source checkout and repeat-install results; and
- an independent review record with no unresolved P1/P2 finding.

Unrun evidence is `NOT TESTED`; missing independent review is `BLOCKED`.

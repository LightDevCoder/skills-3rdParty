# Limitations — v0.2.0

- **Behavior is upstream-owned.** Every package is a pinned snapshot of its
  upstream; any behavior question must be answered by the upstream
  repository, not by this collection.
- **Independent acceptance abolished.** v0.2.0 drops the previous
  "independent review-loop acceptance" gate. Acceptance is: self-check +
  CI + manual review. There is no third-party reviewer.
- **Host refresh/model runtime not re-verified per host.** Fresh install and
  discovery were verified with the Skills CLI for a codex-style agent
  destination; specific agent-host runtime behavior was not exercised in
  this release cycle.
- **Upstream pins are static.** The collection does not track upstream
  branches; updating requires editing the allowlist, re-syncing, and
  re-verifying per POLICIES.md.
- **v0.1.1 evidence remains historical.** The old private release evidence
  documents the previous toolchain (PowerShell) and layout; it is retained
  for history and not re-validated.

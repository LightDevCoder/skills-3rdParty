# Limitations — v0.2.1

- **Behavior is upstream-owned.** Every package is a pinned snapshot of its
  upstream; any behavior question must be answered by the upstream
  repository, not by this collection. `humanizer-zh` behavior is owned by
  `op7418/Humanizer-zh`.
- **Source pin without tags.** `op7418/Humanizer-zh` publishes no tags; the
  source is pinned to resolved commit
  `91f3d394db8419c20d67ebe22a96cf8fee0a404b`. Updating requires editing the
  allowlist and re-running sync + generation per `docs/POLICIES.md`.
- **Independent acceptance abolished.** v0.2.0 dropped the previous
  "independent review-loop acceptance" gate. Acceptance is: self-check +
  CI + manual review. There is no third-party reviewer.
- **Host refresh/model runtime not re-verified per host.** Fresh install and
  discovery are verified with the Skills CLI for an agent destination;
  specific agent-host runtime behavior is not exercised in this release
  cycle.
- **Upstream pins are static.** A package in the collection tracks a pined
  commit, never an upstream branch.

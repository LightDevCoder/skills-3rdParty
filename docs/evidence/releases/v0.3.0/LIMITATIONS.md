# Limitations — v0.3.0

- **Behavior is upstream-owned.** Every package is a pinned snapshot of its
  upstream; any behavior question must be answered by the upstream repository,
  not by this collection. The mattpocock packages are owned by
  `mattpocock/skills` `v1.3.1`.
- **Upstream groups out of scope.** `mattpocock/skills` also ships
  `in-progress/` and `misc/` groups. They are deliberately not mirrored;
  the collection covers `engineering` and `productivity` only.
- **Removed package leaves a stale copy on upgrade.** `resolving-merge-conflicts`
  was deleted upstream in `v1.3.0` and is no longer in the collection. The
  Skills CLI copies files in; it does not delete a skill that disappeared from
  a later revision, so a destination installed from `#v0.2.1` or earlier keeps
  `resolving-merge-conflicts` until it is removed by hand.
- **Source pin without tags.** `op7418/Humanizer-zh` publishes no tags; the
  source is pinned to resolved commit
  `91f3d394db8419c20d67ebe22a96cf8fee0a404b`. Updating requires editing the
  allowlist and re-running sync + generation per `docs/POLICIES.md`.
- **Independent acceptance abolished.** v0.2.0 dropped the previous
  "independent review-loop acceptance" gate. Acceptance is: self-check + CI +
  manual review. There is no third-party reviewer.
- **Host refresh/model runtime not re-verified per host.** Fresh install and
  discovery are verified with the Skills CLI for multi-agent destinations;
  specific agent-host runtime behavior is not exercised in this release cycle.
- **`--agent '*'` compaction quirk (non-collection, older CLI).** With `npx
  skills` 1.5.23, installing to every agent wrote one non-dotted generic root
  (`agent/skills`) in a compacted SKILL.md that omitted the `name` front matter
  field, so that root was skipped by name-based discovery. The quirk was not
  observed with the CLI used for this release (1.7.0): every agent root that
  received the collection held all 29 packages and `agent/skills` kept the
  `name` field for 29/29 packages. It remains a CLI behavior on an
  opportunistic root, not a collection defect.
- **Upstream pins are static.** A package in the collection tracks a pinned
  commit, never an upstream branch.

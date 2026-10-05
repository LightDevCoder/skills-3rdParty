# Test Summary — v0.3.0 (candidate)

Status: `NOT TESTED` — pending the fresh-install gate against the published
`#v0.3.0` tag. Structural checks below have run; installation and discovery
evidence are recorded after the tag is published.

Date: 2026-10-06 (local, Asia/Taipei). Environment: macOS (local) and GitHub
Actions `ubuntu-latest` (CI). CLI: `npx skills` 1.7.0 (Node v26.7.0). No
PowerShell tooling remains in the repository.

| Check | Command | Result |
| --- | --- | --- |
| Collection structural checks | `tests/collection-checks.sh -Root <repo>` | `PASS` (local) — allowlist/manifest/package/nesting (29)/allowlist↔directory match/regenerability/governance |
| Manifest regenerable | via `collection-checks.sh` | `PASS` — committed `UPSTREAM_LOCK.json` equals fresh generation (same `generated_utc`) |
| Sync check (hashes, resources, records) | `sync-upstream.sh -Mode check` | `PASS` — 29/29 packages |
| Referenced resources | `sync-upstream.sh -Mode resource` | `PASS` — all SKILL.md relative links resolve |
| Unauthorized patch | `sync-upstream.sh -Mode unauthorized-patch` | `PASS` — no local modification of upstream-managed files |
| Diff vs pinned upstream | `sync-upstream.sh -Mode diff` | `PASS` — only local records differ (no output) |
| Prune consistency | `sync-upstream.sh -Mode prune` | `PASS` — nothing stale to remove |
| CLI discovery (nested layout) | `npx skills` `add <repo> --list` | `NOT TESTED` |
| CLI whole install (29) | `npx skills add <repo>#v0.3.0 --yes --copy --agent '*'` | `NOT TESTED` |
| CLI single install (`retro`, pinned) | `--skill retro` (`#v0.3.0`) | `NOT TESTED` |
| CLI single install (`humanizer-zh`, latest) | `--skill humanizer-zh` | `NOT TESTED` |
| CLI repeat install | second run on same destination | `NOT TESTED` |
| CLI discovery, pinned tag, no checkout | `npx skills add <repo>#v0.3.0 --list` | `NOT TESTED` |
| CI (candidate commit) | GitHub Actions `quality` (ubuntu) | `NOT TESTED` |

## Smoke checks (local, structural)

- `implement-spec`, `pr`, and `retro` carry `name` front matter matching their
  package directory names, and a `description` field.
- `domain-modeling` ships `GLOSSARY-FORMAT.md`; the upstream-deleted
  `CONTEXT-FORMAT.md` was pruned, not left behind.
- `skills/mattpocock/engineering/resolving-merge-conflicts/` no longer exists,
  and no `SKILL.md` under `skills/` sits outside the allowlist.
- Manifest dependency state: `implement-spec` → `tdd`, `code-review`;
  `retro` → `writing-for-agents`; `grill-me` → `grilling`; `grill-with-docs` →
  `grilling`, `domain-modeling`. Every declared peer is present in the
  collection.

Structural checks do not replace fresh installation, discovery, or manual
review evidence.

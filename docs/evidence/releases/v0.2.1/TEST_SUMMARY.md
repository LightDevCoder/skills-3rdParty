# Test Summary — v0.2.1 (candidate)

Status: `NOT TESTED` — pending fresh-install gate against the published
`#v0.2.1` tag. Structural checks below have run; installation and discovery
evidence are recorded after the tag is published.

Date: 2026-08-20 (local). Environment: macOS (local) and GitHub Actions
`ubuntu-latest` (CI). No PowerShell tooling remains in the repository.

| Check | Command | Result |
| --- | --- | --- |
| Collection structural checks | `tests/collection-checks.sh -Root <repo>` | `PASS` (local) — allowlist/manifest/package/nesting (27)/regenerability/governance |
| Manifest regenerable | via `collection-checks.sh` | `PASS` — committed `UPSTREAM_LOCK.json` equals fresh generation (same `generated_utc`) |
| Sync check (hashes, resources, records) | `sync-upstream.sh -Mode check` | `PASS` — 27/27 packages |
| Referenced resources | `sync-upstream.sh -Mode resource` | `PASS` — all SKILL.md relative links resolve |
| Unauthorized patch | `sync-upstream.sh -Mode unauthorized-patch` | `PASS` — no local modification of upstream-managed files |
| Diff vs pinned upstream | `sync-upstream.sh -Mode diff` | `PASS` — only local records differ (no output) |
| Prune consistency | `sync-upstream.sh -Mode prune` | `PASS` — nothing stale to remove |
| CLI discovery (nested layout) | `npx skills` `add <repo> --list` | `NOT TESTED` |
| CLI whole install (27) | `npx skills add <repo>#v0.2.1 --yes --copy --agent '*'` | `NOT TESTED` |
| CLI single install (`humanizer-zh`) | `--skill humanizer-zh` | `NOT TESTED` |
| CLI repeat install | second run on same destination | `NOT TESTED` |
| CLI discovery, pinned tag, no checkout | `npx skills add <repo>#v0.2.1 --list` | `NOT TESTED` |

Structural checks do not replace fresh installation, discovery, or manual
review evidence.

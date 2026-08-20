# Test Summary — v0.2.1

Date: 2026-08-20. Environment: macOS (local) and GitHub Actions
`ubuntu-latest` (CI). CLI: `npx skills` 1.5.23 (Node v24.19.0). No PowerShell
tooling remains in the repository.

| Check | Command | Result |
| --- | --- | --- |
| Collection structural checks | `tests/collection-checks.sh -Root <repo>` | `PASS` (local) — allowlist/manifest/package/nesting (27)/regenerability/governance |
| Manifest regenerable | via `collection-checks.sh` | `PASS` — committed `UPSTREAM_LOCK.json` equals fresh generation (same `generated_utc`) |
| Sync check (hashes, resources, records) | `sync-upstream.sh -Mode check` | `PASS` — 27/27 packages |
| Referenced resources | `sync-upstream.sh -Mode resource` | `PASS` — all SKILL.md relative links resolve |
| Unauthorized patch | `sync-upstream.sh -Mode unauthorized-patch` | `PASS` — no local modification of upstream-managed files |
| Diff vs pinned upstream | `sync-upstream.sh -Mode diff` | `PASS` — only local records differ (no output) |
| Prune consistency | `sync-upstream.sh -Mode prune` | `PASS` — nothing stale to remove |
| CI (candidate commit) | GitHub Actions `quality` (ubuntu) | `PASS` — run `32320186456` success |
| CLI discovery, pinned tag, no checkout | `npx skills add <repo>#v0.2.1 --list` | `PASS` — "Found 27 skills"; `humanizer-zh` listed |
| CLI whole install (pinned) | `npx skills add <repo>#v0.2.1 --yes --copy --agent '*'` | `PASS` — exit 0, 27 packages in fresh destination |
| CLI whole install (latest) | `npx skills add <repo> --yes --copy --agent '*'` | `PASS` — exit 0, 27 packages in fresh destination |
| CLI single install (`humanizer-zh`, pinned) | `--skill humanizer-zh` (`#v0.2.1`) | `PASS` — exactly `humanizer-zh` |
| CLI single install (`humanizer-zh`, latest) | `--skill humanizer-zh` (latest) | `PASS` — exactly `humanizer-zh` |
| CLI repeat install | second run on same destination | `PASS` — idempotent no-op overwrite, exit 0 |

## Smoke checks

- Installed `humanizer-zh/SKILL.md` retains `name: humanizer-zh` and a
  `description` multiline field; parses as a directory-bundle skill.
- Manifest dependency state for `humanizer-zh`: `none` (no peer/missing
  dependencies to satisfy).
- Installed `SKILL.md` and `README.md` are byte-identical to the pinned
  upstream snapshot (`op7418/Humanizer-zh` @ `91f3d394`).

Structural checks do not replace fresh installation, discovery, or manual
review evidence.

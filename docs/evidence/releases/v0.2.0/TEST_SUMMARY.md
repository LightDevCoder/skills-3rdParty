# Test Summary — v0.2.0

Date: 2026-08-10. Environment: macOS (local) and GitHub Actions
`ubuntu-latest` (CI). No PowerShell tooling remains in the repository.

| Check | Command | Result |
| --- | --- | --- |
| Collection structural checks (89 assertions) | `tests/collection-checks.sh -Root <repo>` | `PASS` — allowlist/manifest/package/nesting/regenerability/governance |
| Manifest regenerable | via `collection-checks.sh` | `PASS` — committed `UPSTREAM_LOCK.json` equals fresh generation (same `generated_utc`) |
| Sync check (hashes, resources, records) | `sync-upstream.sh -Mode check` | `PASS` — 26/26 packages |
| Referenced resources | `sync-upstream.sh -Mode resource` | `PASS` — all SKILL.md relative links resolve |
| Unauthorized patch | `sync-upstream.sh -Mode unauthorized-patch` | `PASS` — no local modification of upstream-managed files |
| Diff vs pinned upstream | `sync-upstream.sh -Mode diff` | `PASS` — only local records differ |
| Prune consistency | `sync-upstream.sh -Mode prune` | `PASS` — nothing stale to remove |
| CLI discovery (nested layout) | `npx skills` 1.5.22 `add <repo> --list` | `PASS` — exactly 26 skills found |
| CLI whole install | `npx skills add <repo> --yes --copy --agent codex` | `PASS` — exit 0, 26 packages in fresh destination |
| CLI single install | `--skill grill-with-docs --skill humanizer` | `PASS` — exactly the 2 requested packages |
| CLI repeat install | second run on same destination | `PASS` — idempotent, no errors |
| Deprecated exclusion | grep of listed skills | `PASS` — no `loop-me`, `writing-great-skills`, `qa`, `design-an-interface`, `ubiquitous-language` |

Structural checks do not replace fresh installation, discovery, or manual
review evidence.

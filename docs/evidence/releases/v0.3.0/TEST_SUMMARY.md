# Test Summary — v0.3.0

Status: `VERIFIED` — structural checks green locally and in CI, fresh-install
gate run against the published `#v0.3.0` tag.

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
| CI (candidate commit) | GitHub Actions `third-party-quality` (ubuntu) | `PASS` — run `37358048011` success on `e376baa` |
| CLI discovery, pinned tag, no checkout | `npx skills add <repo>#v0.3.0 --list` | `PASS` — "Found 29 skills"; `implement-spec`, `pr`, `retro` listed; no `resolving-merge-conflicts` |
| CLI whole install (pinned) | `npx skills add <repo>#v0.3.0 --yes --copy --agent '*'` | `PASS` — exit 0, 29 packages in a fresh destination |
| CLI whole install (latest) | `npx skills add <repo> --yes --copy --agent '*'` | `PASS` — exit 0, 29 packages in a fresh destination |
| CLI single install (`retro`, pinned) | `--skill retro` (`#v0.3.0`) | `PASS` — exactly `retro` |
| CLI single install (`humanizer-zh`, latest) | `--skill humanizer-zh` (latest) | `PASS` — exactly `humanizer-zh` |
| CLI repeat install | second run on same destination | `PASS` — idempotent no-op overwrite, exit 0 |
| Installed-vs-mirror integrity | `diff -r` over the 29 installed packages | `PASS` — 0 packages differ; records and `LICENSE` included |

## Smoke checks

- Installed `retro/SKILL.md` is byte-identical to the pinned snapshot
  (`skills/mattpocock/engineering/retro/SKILL.md`).
- `implement-spec`, `pr`, and `retro` carry `name` front matter matching their
  package directory names, and a `description` field.
- `domain-modeling` ships `GLOSSARY-FORMAT.md`; the upstream-deleted
  `CONTEXT-FORMAT.md` was pruned, not left behind.
- `skills/mattpocock/engineering/resolving-merge-conflicts/` no longer exists,
  and no `SKILL.md` under `skills/` sits outside the allowlist. The whole
  install contains no `resolving-merge-conflicts` directory.
- Manifest dependency state: `implement-spec` → `tdd`, `code-review`;
  `retro` → `writing-for-agents`; `grill-me` → `grilling`; `grill-with-docs` →
  `grilling`, `domain-modeling`. Every declared peer is present in the
  collection, and the installed `implement-spec` / `retro` call exactly those
  peers through the Skill tool.
- `ask-matt` contains no install or Skill-tool call, so the navigation-only
  boundary holds in the installed copy.

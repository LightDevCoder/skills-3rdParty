# skills-3rdParty v0.1.1 Release Receipt

[中文记录](RELEASE_RECEIPT.zh-CN.md)

Status: `RELEASED WITH ACCEPTANCE LIMITATION` — the private tag, GitHub
release, merged CI, and fresh-install evidence are verified; independent
`review-loop agent-skill` acceptance remains `BLOCKED`.

## Identity

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` (private) |
| Release | `v0.1.1` |
| Release commit | `a891d39d7f34793d857c5b8eec3429c23871f421` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.1.1 |
| Date | `2026-07-26` |
| Upstream | `mattpocock/skills` `v1.1.0` / `d574778f94cf620fcc8ce741584093bc650a61d3` |
| Scope | Exactly 23 pinned third-party packages, metadata adapters, provenance, sync tooling, and bilingual governance docs. |

## Acceptance evidence

- [Admission record](ADMISSION_RECORD.md)
- [Test summary](TEST_SUMMARY.md)
- [Installation verification](INSTALLATION_VERIFICATION.md)
- [Discovery verification](DISCOVERY_VERIFICATION.md)
- [Limitations](LIMITATIONS.md)
- [First-party collection evidence](https://github.com/LightDevCoder/skills/blob/main/docs/evidence/releases/v0.1.1/RELEASE_RECEIPT.md)

## Release gate

| Gate | Status | Evidence |
| --- | --- | --- |
| Private visibility | `VERIFIED` | Remote repository remains private; visibility change is out of scope. |
| Exactly 23 selected packages | `VERIFIED` | Allowlist, manifest, package directories, and collection tests agree. |
| Pinned upstream and resources | `VERIFIED` | `UPSTREAM_LOCK.json`, per-package provenance, and sync modes. |
| Fresh whole-repository install | `VERIFIED` | CLI `1.5.20` installed exactly 23 packages from `v0.1.1`. |
| Fresh per-Skill install | `VERIFIED` | CLI `1.5.20` installed exactly `grill-with-docs`; peer directories stayed absent. |
| Repeat installation | `VERIFIED` | Whole-collection repeat exited 0 and reported `overwrites: Codex` for all 23 packages. |
| GitHub Actions | `VERIFIED` | Quality run `30189147755` passed on the release line. |
| Independent `review-loop agent-skill` acceptance | `BLOCKED` | No separate evaluator record is available; same-context review is not independent evidence. |

This is a release record, not an independent acceptance record. Structural
checks and CLI discovery do not prove host refresh or model-mediated runtime
behavior.

# skills-3rdParty v0.2.0 Release Receipt

[中文记录](RELEASE_RECEIPT.zh-CN.md)

Status: `RELEASED` — public tag, public GitHub release, CI green, fresh
install evidence present. Acceptance statement: **self-check + CI + manual
review**; the independent `review-loop` gate was abolished in v0.2.0.

## Identity

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` (public as of v0.2.0) |
| Release | `v0.2.0` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.2.0 |
| Upstream | `mattpocock/skills` `v1.2.3` / `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`; `blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac` |
| Scope | 26 pinned packages (25 mattpocock + 1 blader), nested layout, bash+jq tooling, generative manifest, public governance |

## Acceptance evidence

- [Test summary](TEST_SUMMARY.md)
- [Installation verification](INSTALLATION_VERIFICATION.md)
- [Discovery verification](DISCOVERY_VERIFICATION.md)
- [Limitations](LIMITATIONS.md)
- Policy: [docs/POLICIES.md](../../../POLICIES.md)

## Release gate

- [x] All sync modes pass locally (macOS) and in CI (ubuntu): `check`,
      `resource`, `unauthorized-patch`, `diff`, `prune`.
- [x] `tests/collection-checks.sh` passes; committed `UPSTREAM_LOCK.json`
      verified regenerable.
- [x] Fresh whole-collection install (26 packages) and single-package install
      into clean destinations; repeat install idempotent.
- [x] Discovery without the source checkout confirmed via the public
      repository URL.
- [x] Repository visibility switched to public; release tag created.
- [x] No PowerShell files remain; tooling runs on macOS/Linux/CI.

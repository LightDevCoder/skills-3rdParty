# skills-3rdParty v0.2.1 Release Receipt

[中文记录](RELEASE_RECEIPT.zh-CN.md)

Status: `RELEASE CANDIDATE` — public tag and GitHub release pending
fresh-install verification against the published tag. Acceptance statement:
**self-check + CI + manual review**; the independent `review-loop` gate was
abolished in v0.2.0.

## Identity

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` |
| Release | `v0.2.1` (candidate) |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.2.1 |
| Upstream | `mattpocock/skills` `v1.2.3` / `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`; `blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`; `op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| Scope | 27 pinned packages (25 mattpocock + 1 blader + 1 op7418), nested layout, bash+jq tooling, generative manifest |

## Changes since v0.2.0

- **Admitted `humanizer-zh`** (`op7418/Humanizer-zh`, pinned mirror) — the
  Chinese localized Humanizer writing editor, unmodified, under
  `skills/op7418/humanizer-zh/`.
- Collection grows to 27 packages from three sources; allowlist, CI source
  checkouts, `UPSTREAM_LOCK.json`, catalog, and bilingual docs updated.

## Acceptance evidence

- [Test summary](TEST_SUMMARY.md) — `NOT TESTED` until the gate runs.
- [Installation verification](INSTALLATION_VERIFICATION.md) — `NOT TESTED`.
- [Discovery verification](DISCOVERY_VERIFICATION.md) — `NOT TESTED`.
- [Limitations](LIMITATIONS.md)
- Policy: [docs/POLICIES.md](../../../POLICIES.md)

## Release gate (candidate)

- [x] All sync modes pass locally (macOS): `check`, `resource`,
      `unauthorized-patch`, `diff`, `prune`.
- [x] `tests/collection-checks.sh` passes (27 packages); committed
      `UPSTREAM_LOCK.json` verified regenerable.
- [ ] Fresh whole-collection install (27 packages) against the published
      `#v0.2.1` tag into clean destinations; single-package install;
      repeat install idempotent.
- [ ] Discovery without the source checkout confirmed via the public
      repository URL / tag.
- [ ] Release tag and GitHub release created from the candidate commit.
- [ ] CI green on the candidate commit (ubuntu).

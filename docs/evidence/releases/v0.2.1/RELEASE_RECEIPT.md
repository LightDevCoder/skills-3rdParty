# skills-3rdParty v0.2.1 Release Receipt

[中文记录](RELEASE_RECEIPT.zh-CN.md)

Status: `RELEASED` — public tag, public GitHub release, CI green, fresh
install evidence present. Acceptance statement: **self-check + CI + manual
review**; the independent `review-loop` gate was abolished in v0.2.0.

## Identity

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` |
| Release | `v0.2.1` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.2.1 |
| Released commit | `1c68526ccfa02b9cbbc8827b78fab5fceba722a8` |
| Upstream | `mattpocock/skills` `v1.2.3` / `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`; `blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`; `op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| Scope | 27 pinned packages (25 mattpocock + 1 blader + 1 op7418), nested layout, bash+jq tooling, generative manifest |

## Changes since v0.2.0

- **Admitted `humanizer-zh`** (`op7418/Humanizer-zh`, pinned mirror) — the
  Chinese localized Humanizer writing editor, unmodified, under
  `skills/op7418/humanizer-zh/`.
- Collection grows to 27 packages from three sources; allowlist, CI source
  checkouts, `UPSTREAM_LOCK.json`, catalog, and bilingual docs updated.

## Acceptance evidence

- [Test summary](TEST_SUMMARY.md)
- [Installation verification](INSTALLATION_VERIFICATION.md)
- [Discovery verification](DISCOVERY_VERIFICATION.md)
- [Limitations](LIMITATIONS.md)
- Policy: [docs/POLICIES.md](../../../POLICIES.md)

## Release gate

- [x] All sync modes pass locally (macOS) and in CI (ubuntu): `check`,
      `resource`, `unauthorized-patch`, `diff`, `prune`.
- [x] `tests/collection-checks.sh` passes (27 packages); committed
      `UPSTREAM_LOCK.json` verified regenerable.
- [x] CI green on the candidate commit: run `32320186456` (success).
- [x] Fresh whole-collection install (27 packages) and single-package
      (`humanizer-zh`) install against the published `#v0.2.1` tag into clean
      destinations; repeat install idempotent.
- [x] Discovery without the source checkout confirmed via the published tag
      (`Found 27 skills`, `humanizer-zh` listed).
- [x] Release tag `v0.2.1` created from the candidate commit and GitHub
      release published.

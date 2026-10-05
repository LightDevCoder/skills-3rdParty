# skills-3rdParty v0.3.0 Release Receipt

[中文记录](RELEASE_RECEIPT.zh-CN.md)

Status: `RELEASE CANDIDATE` — public tag and GitHub release pending
fresh-install verification against the published tag. Acceptance statement:
**self-check + CI + manual review**; the independent `review-loop` gate was
abolished in v0.2.0.

## Identity

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` |
| Release | `v0.3.0` (candidate) |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.3.0 |
| Upstream | `mattpocock/skills` `v1.3.1` / `24fe0ef7737efae15c87225755e9f6f5965e4888`; `blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`; `op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| Scope | 29 pinned packages (27 mattpocock + 1 blader + 1 op7418), nested layout, bash+jq tooling, generative manifest |

## Changes since v0.2.1

- **Upstream upgraded** `mattpocock/skills` `v1.2.3` → `v1.3.1`: three
  packages admitted (`implement-spec`, `pr`, `retro`) and one removed
  (`resolving-merge-conflicts`, deleted upstream with no replacement).
- **Content refresh** across every mattpocock package: `CONTEXT.md` →
  `GLOSSARY.md` convention (with `domain-modeling`'s `CONTEXT-FORMAT.md` →
  `GLOSSARY-FORMAT.md`), explicit "Call the Skill tool with …" cross-skill
  invocation, em-dash removal, and quoted YAML descriptions.
- **New declared peer dependencies**: `implement-spec` → `tdd`, `code-review`;
  `retro` → `writing-for-agents`.
- **New structural guard**: the `SKILL.md` set under `skills/` must match the
  allowlist exactly, so a removed package cannot stay discoverable.
- Collection grows to 29 packages from three sources; allowlist, CI source
  checkout, `UPSTREAM_LOCK.json`, catalog, and bilingual docs updated.

## Acceptance evidence

- [Test summary](TEST_SUMMARY.md) — `NOT TESTED` until the gate runs.
- [Installation verification](INSTALLATION_VERIFICATION.md) — `NOT TESTED`.
- [Discovery verification](DISCOVERY_VERIFICATION.md) — `NOT TESTED`.
- [Limitations](LIMITATIONS.md)
- Policy: [docs/POLICIES.md](../../../POLICIES.md)

## Release gate (candidate)

- [x] All sync modes pass locally (macOS): `check`, `resource`,
      `unauthorized-patch`, `diff`, `prune`.
- [x] `tests/collection-checks.sh` passes (29 packages); committed
      `UPSTREAM_LOCK.json` verified regenerable.
- [ ] CI green on the candidate commit.
- [ ] Fresh whole-collection install (29 packages) against the published
      `#v0.3.0` tag into clean destinations; single-package install; repeat
      install idempotent.
- [ ] Discovery without the source checkout confirmed via the public tag
      (`Found 29 skills`).
- [ ] Release tag `v0.3.0` created from the candidate commit and GitHub
      release published.

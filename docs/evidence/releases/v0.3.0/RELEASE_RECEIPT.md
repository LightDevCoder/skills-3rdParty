# skills-3rdParty v0.3.0 Release Receipt

[中文记录](RELEASE_RECEIPT.zh-CN.md)

Status: `RELEASED` — public annotated tag, public GitHub release, CI green,
fresh-install evidence present. Acceptance statement: **self-check + CI +
manual review**; the independent `review-loop` gate was abolished in v0.2.0.

## Identity

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` |
| Release | `v0.3.0` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.3.0 |
| Published | 2026-10-05T18:47:51Z (2026-10-06 02:47:51 +08:00) |
| Tag object | `a8d390b6069051cc944778fa7588705eaee136b1` (annotated tag) |
| Peeled commit | `e376baadafdcb3a6d6609de138ea5f42d594752b` |
| CI run | `37358048011` — workflow `third-party-quality`, job `quality`, conclusion `success` |
| Upstream | `mattpocock/skills` `v1.3.1` / `24fe0ef7737efae15c87225755e9f6f5965e4888`; `blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`; `op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| CLI | `npx skills` 1.7.0 (Node v26.7.0) |
| Scope | 29 pinned packages (27 mattpocock + 1 blader + 1 op7418), nested layout, bash+jq tooling, generative manifest |

## Changes since v0.2.1

- **Upstream upgraded** `mattpocock/skills` `v1.2.3` → `v1.3.1`: three packages
  admitted (`implement-spec`, `pr`, `retro`) and one removed
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

- [Test summary](TEST_SUMMARY.md)
- [Installation verification](INSTALLATION_VERIFICATION.md)
- [Discovery verification](DISCOVERY_VERIFICATION.md)
- [Limitations](LIMITATIONS.md)
- Policy: [docs/POLICIES.md](../../../POLICIES.md)

## Release gate

- [x] All sync modes pass locally (macOS) and in CI (ubuntu): `check`,
      `resource`, `unauthorized-patch`, `diff`, `prune`.
- [x] `tests/collection-checks.sh` passes (29 packages); committed
      `UPSTREAM_LOCK.json` verified regenerable.
- [x] CI green on the candidate commit: run `37358048011` (success).
- [x] Fresh whole-collection install (29 packages, pinned and latest) against
      the published `#v0.3.0` tag into clean destinations; installed tree
      byte-identical to the pinned mirror; single-package installs for `retro`
      (pinned) and `humanizer-zh` (latest); repeat install idempotent.
- [x] Discovery without the source checkout confirmed via the published tag
      (`Found 29 skills`; `implement-spec`, `pr`, `retro` listed; no
      `resolving-merge-conflicts`).
- [x] Release tag `v0.3.0` created from the candidate commit and GitHub
      release published.

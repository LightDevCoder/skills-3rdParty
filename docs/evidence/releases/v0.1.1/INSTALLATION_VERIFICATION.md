# v0.1.1 Installation Verification

[中文记录](INSTALLATION_VERIFICATION.zh-CN.md)

Status: `PASS` for the private tagged repository using Skills CLI `1.5.20`.
Host refresh is host-specific and was not claimed; CLI discovery was run from
fresh destinations without a source checkout.

| Field | Whole collection | Per-Skill |
| --- | --- | --- |
| Command | `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --yes --copy --agent codex` | `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill grill-with-docs --yes --copy --agent codex` |
| CLI version | `1.5.20` | `1.5.20` |
| Release commit | `a891d39d7f34793d857c5b8eec3429c23871f421` | same |
| Fresh destination | New empty temporary project; exactly 23 packages under `.agents/skills/` | New empty temporary project; exactly 1 package under `.agents/skills/` |
| Install result | `PASS`, exit code 0 | `PASS`, exit code 0 |
| Discovery without source checkout | `npx --yes skills list` exit 0; all 23 listed; source checkout absent | `npx --yes skills list` exit 0; only `grill-with-docs` listed; source checkout absent |
| Complete resources | All 23 package directories retained `SKILL.md`, `agents/openai.yaml`, `LICENSE`, `UPSTREAM.md`, `PATCHES.md`, and referenced resources | `SKILL.md`, `agents/openai.yaml`, `LICENSE`, `UPSTREAM.md`, `PATCHES.md` present |
| Dependency boundary | Whole install includes `grilling` and `domain-modeling` as selected packages | `grilling` and `domain-modeling` peer directories absent; the single-package result did not silently install peers |
| Repeat-install behavior | Same command exit 0; CLI reported `overwrites: Codex` for all 23 packages | Not repeated separately; whole-collection repeat covered the installer path |
| Limitation | Host refresh and model-mediated runtime invocation were not tested | Same |

The destination records intentionally omit absolute private paths, usernames,
and credentials. The single-package wrapper was re-run with corrected
inspection after the first wrapper's reporting bug; the installer itself had
already returned exit 0, and the corrected run is the recorded result.

# Installation Verification — v0.3.0 (candidate)

Status: `NOT TESTED` — recorded after the `#v0.3.0` tag is published, from
fresh disposable destinations with no source checkout present.

Planned matrix (date: 2026-10-06; CLI: `npx skills` 1.7.0, Node v26.7.0;
source: public `LightDevCoder/skills-3rdParty`):

| Run | Command | Expected |
| --- | --- | --- |
| Whole collection, pinned | `npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --yes --copy --agent '*'` | exit 0, 29 package directories |
| Whole collection, latest | `npx skills add LightDevCoder/skills-3rdParty --yes --copy --agent '*'` | exit 0, 29 package directories |
| Single package, pinned | `… #v0.3.0 --skill retro --yes --copy --agent '*'` | exactly `retro` |
| Single package, latest | `… --skill humanizer-zh --yes --copy --agent '*'` | exactly `humanizer-zh` |
| Repeat install | second run on the same destination | exit 0, idempotent, no duplicates |
| Byte identity | compare installed `SKILL.md` against the pinned snapshot | identical |

Destination paths are recorded as classes, not absolute paths, and no tokens,
usernames, or credentials appear in evidence.

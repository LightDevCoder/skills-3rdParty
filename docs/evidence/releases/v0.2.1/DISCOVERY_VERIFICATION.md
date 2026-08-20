# Discovery Verification — v0.2.1 (candidate)

Status: `NOT TESTED` — pending verification against the published tag.

Planned checks:

- Nested-layout discovery: `npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --list`
  → expect exactly 27 skills, including `humanizer-zh`, `humanizer`,
  `ask-matt`, `grill-with-docs`.
- Discovery without source checkout: discovery from the public repository
  URL / tag with no local source checkout and no credentials.
- Shadowing check: no `SKILL.md` at `skills/<source>/SKILL.md` or
  `skills/SKILL.md`, so no catalog shadowing is possible.

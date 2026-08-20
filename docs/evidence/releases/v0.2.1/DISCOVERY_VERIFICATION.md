# Discovery Verification — v0.2.1

Date: 2026-08-20. CLI: `npx skills` 1.5.23.

## Nested-layout discovery via published tag

```text
npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --list
```

Result: `PASS` — "Found 27 skills" from the published tag, including
`humanizer-zh`, `humanizer`, `ask-matt`, `grill-with-docs`.

## Discovery without source checkout

The above listing ran from a neutral temporary directory with **no local
source checkout and no credentials**; discovery resolved
`https://github.com/LightDevCoder/skills-3rdParty.git @ v0.2.1` entirely from
the published tag.

## Fresh-destination local listing

`npx skills list` from a fresh install destination listed `humanizer-zh` at
the agent skills root. The .agents copy retains `name: humanizer-zh` and a
`description` field, so it is discovered as a directory-bundle skill.

## Shadowing check

No `SKILL.md` exists at a shallower level than the package directories
(`skills/<source>/SKILL.md` and `skills/SKILL.md` absent), so no catalog
shadowing is possible.

## Note

CLI behavior is the authority; the documented two-level catalog layout was
confirmed by the live runs above.

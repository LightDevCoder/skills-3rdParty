# Discovery Verification — v0.2.0

Date: 2026-08-10. CLI: `npx skills` 1.5.22.

## Nested-layout discovery

The repository now organizes packages as
`skills/<source>/<group>/<name>/SKILL.md` (two catalog category levels, the
documented CLI maximum). Verified by listing without installing:

```text
npx skills add LightDevCoder/skills-3rdParty --list
```

Result: `PASS` — exactly 26 skills discovered, including `ask-matt`,
`grill-with-docs`, and `humanizer`; excluded skills (`loop-me`,
`writing-great-skills`, `qa`, `design-an-interface`, `ubiquitous-language`)
are absent.

## Discovery without source checkout

After the v0.2.0 tag was pushed and the repository made public:

```text
npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --list
```

Result: `PASS` — 26 skills discovered from the published tag without any
local source checkout or credentials.

## Shadowing check

No `SKILL.md` exists at a shallower level than the package directories
(`skills/<source>/SKILL.md` and `skills/SKILL.md` absent), so no catalog
shadowing is possible.

## Note

CLI behavior is the authority; the documented two-level catalog layout was
confirmed by the live run above.

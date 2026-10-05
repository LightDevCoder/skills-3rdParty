# Discovery Verification — v0.3.0 (candidate)

Status: `NOT TESTED` — recorded after the `#v0.3.0` tag is published, from a
neutral temporary directory with no source checkout and no credentials.

Planned checks (date: 2026-10-06; CLI: `npx skills` 1.7.0):

```text
npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --list
```

- Expect `Found 29 skills`, including the newly admitted `implement-spec`,
  `pr`, and `retro`, and no `resolving-merge-conflicts`.
- Expect discovery to resolve
  `https://github.com/LightDevCoder/skills-3rdParty.git @ v0.3.0` entirely
  from the published tag.
- Shadowing check: no `SKILL.md` at a shallower level than the package
  directories (`skills/<source>/SKILL.md` and `skills/SKILL.md` absent), so no
  catalog shadowing is possible.
- Fresh-destination local listing: `npx skills list` in an install destination
  lists the newly admitted packages from their installed copies.

CLI behavior is the authority; the documented two-level catalog layout is
confirmed by the live runs above.

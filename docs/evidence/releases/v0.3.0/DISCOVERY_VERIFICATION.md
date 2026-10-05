# Discovery Verification — v0.3.0

Date: 2026-10-06 (Asia/Taipei). CLI: `npx skills` 1.7.0. Destination: a neutral
temporary directory.

## Nested-layout discovery via published tag

```text
npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --list
```

Result: `PASS` — exit 0, `Source: https://github.com/LightDevCoder/skills-3rdParty.git
@ v0.3.0`, **`Found 29 skills`**, and exactly 29 names listed. The newly
admitted `implement-spec`, `pr`, and `retro` are listed; the upstream-deleted
`resolving-merge-conflicts` is absent.

## Discovery without source checkout

The listing above ran from a temporary directory with **no local source
checkout and no credentials**; discovery resolved the collection entirely from
the published tag.

## Shadowing check

No `SKILL.md` exists at a shallower level than the package directories
(`skills/<source>/SKILL.md` and `skills/SKILL.md` are absent in the repository),
so no catalog shadowing is possible. `tests/collection-checks.sh` enforces the
same invariant: the `SKILL.md` set under `skills/` must match the 29-package
allowlist exactly.

## Fresh-destination local listing

The fresh whole-collection install wrote 29 complete package directories into
the agent roots, with `name` front matter intact (checked over all 29 entries),
so the installed copies are name-discoverable without re-reading the remote.

## Note

CLI behavior is the authority; the documented two-level catalog layout was
confirmed by the live runs above.

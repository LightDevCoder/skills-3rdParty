# Installation Verification — v0.2.0

Date: 2026-08-10. CLI: `npx skills` 1.5.22 (Node v24.19.0). Source:
public repository `LightDevCoder/skills-3rdParty`.

## Whole-collection install

Command (from a clean temp destination):

```text
npx skills add LightDevCoder/skills-3rdParty --yes --copy --agent codex
```

Result: `PASS` — CLI reported "Found 26 skills / Installing all 26 skills",
exit 0. Fresh destination contained exactly 26 package directories:
`ask-matt` … `writing-for-agents` (mattpocock 25) + `humanizer` (blader 1).
Installed copies are flat at the agent skills root (CLI install semantics);
the repository's nested layout is a source-side organization.

## Single-package install

```text
npx skills add LightDevCoder/skills-3rdParty --skill grill-with-docs --skill humanizer --yes --copy --agent codex
```

Result: `PASS` — exactly `grill-with-docs` and `humanizer` installed; no peer
directories present.

## Repeat install

Running the whole-collection command a second time: `PASS` — exit 0, no
errors, no duplicate or orphan files.

## Notes

- The `#v0.2.0` fragment pins the collection release; mirror content is
  pinned per source (mattpocock/skills v1.2.3, blader/humanizer v2.9.1).
- Verification used the local checkout path; the public-URL install and
  discovery check is recorded in DISCOVERY_VERIFICATION.md.
- Destination paths are recorded as classes, not absolute paths, and no
  tokens, usernames, or credentials appear in evidence.

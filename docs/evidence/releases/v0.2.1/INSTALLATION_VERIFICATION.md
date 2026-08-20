# Installation Verification — v0.2.1 (candidate)

Status: `NOT TESTED` — these runs execute against the published `#v0.2.1`
tag after the release is cut, never against the source checkout.

Planned matrix (per [docs/POLICIES.md](../../../POLICIES.md)):

- Whole-collection install into a clean temp destination
  (`npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --yes --copy --agent '*'`)
  → expect 27 packages: mattpocock 25 + `humanizer` (blader) +
  `humanizer-zh` (op7418).
- Single-package install (`--skill humanizer-zh`) → expect exactly
  `humanizer-zh`, no peer directories.
- Repeat install on the same destination → expect no-op overwrite, exit 0.

Scope: CLI and destination class are recorded as classes, not absolute
paths; no tokens, usernames, or credentials appear in evidence.

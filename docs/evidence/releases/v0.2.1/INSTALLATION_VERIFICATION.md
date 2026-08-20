# Installation Verification — v0.2.1

Date: 2026-08-20. CLI: `npx skills` 1.5.23 (Node v24.19.0). Source: public
`LightDevCoder/skills-3rdParty`. All runs against fresh disposable
destinations with no source checkout present.

## Whole-collection install (pinned)

```text
npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --yes --copy --agent '*'
```

Result: `PASS` — exit 0, CLI reported "Found 27 skills"; fresh destination's
agent skills root contained exactly **27 package directories**,
`ask-matt` … `writing-for-agents` (mattpocock 25) + `humanizer` (blader 1) +
`humanizer-zh` (op7418 1). `humanizer-zh/SKILL.md` and `README.md` were
byte-identical to the pinned upstream snapshot.

## Whole-collection install (generic latest)

```text
npx skills add LightDevCoder/skills-3rdParty --yes --copy --agent '*'
```

Result: `PASS` — exit 0, 27 package directories, `humanizer-zh` present.

## Single-package install (pinned and latest)

```text
npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --skill humanizer-zh --yes --copy --agent '*'
```

Result: `PASS` — exactly `humanizer-zh` installed; no peer directories
present. Same result for the generic `latest` form.

## Repeat install

Running the pinned single-package command a second time on the same
destination: `PASS` — exit 0, no errors, no duplicate or orphan files
(idempotent no-op overwrite).

## Notes

- The `#v0.2.1` fragment pins the collection release; mirrored content is
  pinned per source (mattpocock/skills v1.2.3, blader/humanizer v2.9.1,
  op7418/Humanizer-zh 91f3d394).
- `--agent '*'` writes per-agent roots (`.agents`, `.claude`, `.codex`,
  …); the `.agents/skills` copy used by the agent-hosts user root keeps a
  full `name` frontmatter. One non-dotted generic root (`agent/skills`) is
  written in a compacted form without `name`; see LIMITATIONS.md. The
  collection and the documented agent roots are unaffected.
- Destination paths are recorded as classes, not absolute paths, and no
  tokens, usernames, or credentials appear in evidence.

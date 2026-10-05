# Installation Verification — v0.3.0

Date: 2026-10-06 (Asia/Taipei). CLI: `npx skills` 1.7.0 (Node v26.7.0). Source:
public `LightDevCoder/skills-3rdParty`. All runs against fresh disposable
destinations under a temporary directory with no source checkout present.

## Whole-collection install (pinned)

```text
npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --yes --copy --agent '*'
```

Result: `PASS` — exit 0, CLI reported "Found 29 skills" and "Installed 29
skills"; the fresh destination's `.agents/skills` root contained exactly **29
package directories** (mattpocock 27 + `humanizer` + `humanizer-zh`), with no
`resolving-merge-conflicts`.

## Whole-collection install (generic latest)

```text
npx skills add LightDevCoder/skills-3rdParty --yes --copy --agent '*'
```

Result: `PASS` — exit 0, resolved `https://github.com/LightDevCoder/skills-3rdParty.git`,
29 package directories.

## Byte integrity of the whole install

`diff -r` of each of the 29 installed package directories against the pinned
mirror in the source checkout: **0 packages differ**. Installed packages carry
`SKILL.md`, upstream resources, `agents/openai.yaml`, the collection records
(`UPSTREAM.md`, `PATCHES.md`), and the `LICENSE` copy unchanged.

The destination also carries `skills-lock.json`, recording
`"source": "LightDevCoder/skills-3rdParty"`, `"ref": "v0.3.0"`, and a
`computedHash` per skill.

## Single-package install (pinned and latest)

```text
npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --skill retro --yes --copy --agent '*'
npx skills add LightDevCoder/skills-3rdParty --skill humanizer-zh --yes --copy --agent '*'
```

Result: `PASS` — each install wrote exactly one package directory (`retro`,
`humanizer-zh`); no peer directories were pulled in.

## Repeat install

Running the pinned single-package command a second time on the same
destination: `PASS` — exit 0, no errors, no duplicate or orphan files
(idempotent no-op overwrite); the destination still contains exactly `retro`.

## Notes

- The `#v0.3.0` fragment pins the collection release; mirrored content is
  pinned per source (mattpocock/skills v1.3.1, blader/humanizer v2.9.1,
  op7418/Humanizer-zh 91f3d394).
- `--agent '*'` writes per-agent roots. In CLI 1.7.0 every agent root that
  received the collection held all 29 packages, and the non-dotted
  `agent/skills` root kept the `name` front matter field (29/29). See
  LIMITATIONS.md for the older-CLI behavior.
- Destination paths are recorded as classes, not absolute paths, and no
  tokens, usernames, or credentials appear in evidence.

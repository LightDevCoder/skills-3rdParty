# Upstream Record: humanizer-zh

This package is a pinned upstream snapshot. The upstream Skill instructions
and referenced resources are preserved unmodified; the only local additions
are this provenance record, the patch ledger, and (where listed) a license
copy.

## Identity

- **Source:** op7418 (https://github.com/op7418/Humanizer-zh)
- **Source group:** ungrouped
- **Package:** humanizer-zh
- **Upstream repository:** op7418/Humanizer-zh
- **Original upstream package path:** .
- **Selected upstream tag:** 91f3d394db8419c20d67ebe22a96cf8fee0a404b
- **Resolved commit:** 91f3d394db8419c20d67ebe22a96cf8fee0a404b
- **Applicable license:** MIT; see `LICENSE` in this package.
- **Upstream author/notice:** preserve the upstream license and attribution.

## Local packaging state

- **State:** pinned upstream snapshot; no upstream behavior patch.
- **Local additions:** `UPSTREAM.md` and `PATCHES.md` are collection records.
  `LICENSE` is a package-local copy of the upstream license.
- **Dependencies:** none. Declared peer Skills, not hidden runtime imports.
- **Navigation boundary:** `ask-matt` remains a router and does not execute or
  install the Skills it mentions.

## Installation and update

- **Whole collection (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --yes --copy --agent codex
- **Single package (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --skill humanizer-zh --yes --copy --agent codex
- **Manual fallback:** copy the complete skills/op7418//humanizer-zh directory (or skills/op7418/humanizer-zh for ungrouped packages) into the host's recognized Skills root.
- **Update source:** run `scripts/sync-upstream.sh -Mode check` against the
  pinned source checkouts; review `-Mode diff`, then use `-Mode sync` and
  `scripts/generate-lock.sh` only after the allowlist and revision are approved.

## Differences and evidence

- **Upstream behavior preserved:** yes, for every upstream-managed file listed
  in `UPSTREAM_LOCK.json`.
- **Local difference:** provenance records only (plus license copy where noted).
- **Patch record:** `PATCHES.md`
- **Lock entry:** UPSTREAM_LOCK.json entry humanizer-zh

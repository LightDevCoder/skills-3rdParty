# Upstream Record: humanizer

This package is a pinned upstream snapshot. The upstream Skill instructions
and referenced resources are preserved unmodified; the only local additions
are this provenance record, the patch ledger, and (where listed) a license
copy.

## Identity

- **Source:** blader (https://github.com/blader/humanizer)
- **Source group:** ungrouped
- **Package:** humanizer
- **Upstream repository:** blader/humanizer
- **Original upstream package path:** .
- **Selected upstream tag:** v2.9.1
- **Resolved commit:** 523374dee72d67c7b2b5f858ea0094ffda49c3ac
- **Applicable license:** MIT; see `LICENSE` in this package.
- **Upstream author/notice:** preserve the upstream license and attribution.

## Local packaging state

- **State:** pinned upstream snapshot; no upstream behavior patch.
- **Local additions:** `UPSTREAM.md` and `PATCHES.md` are collection records.
  
- **Dependencies:** none. Declared peer Skills, not hidden runtime imports.
- **Navigation boundary:** `ask-matt` remains a router and does not execute or
  install the Skills it mentions.

## Installation and update

- **Whole collection (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --yes --copy --agent codex
- **Single package (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.3.0 --skill humanizer --yes --copy --agent codex
- **Manual fallback:** copy the complete skills/blader//humanizer directory (or skills/blader/humanizer for ungrouped packages) into the host's recognized Skills root.
- **Update source:** run `scripts/sync-upstream.sh -Mode check` against the
  pinned source checkouts; review `-Mode diff`, then use `-Mode sync` and
  `scripts/generate-lock.sh` only after the allowlist and revision are approved.

## Differences and evidence

- **Upstream behavior preserved:** yes, for every upstream-managed file listed
  in `UPSTREAM_LOCK.json`.
- **Local difference:** provenance records only (plus license copy where noted).
- **Patch record:** `PATCHES.md`
- **Lock entry:** UPSTREAM_LOCK.json entry humanizer

# Upstream Record: grill-with-docs

This package is a pinned upstream snapshot. The upstream Skill instructions
and referenced resources are preserved unmodified; the only local additions
are this provenance record, the patch ledger, and (where listed) a license
copy.

## Identity

- **Source:** mattpocock (https://github.com/mattpocock/skills)
- **Source group:** engineering
- **Package:** grill-with-docs
- **Upstream repository:** mattpocock/skills
- **Original upstream package path:** skills/engineering/grill-with-docs
- **Selected upstream tag:** v1.2.3
- **Resolved commit:** 6acc160e4e0cd062dbbbd7a1b26ae92855edf07e
- **Applicable license:** MIT; see `LICENSE` in this package.
- **Upstream author/notice:** preserve the upstream license and attribution.

## Local packaging state

- **State:** pinned upstream snapshot; no upstream behavior patch.
- **Local additions:** `UPSTREAM.md` and `PATCHES.md` are collection records.
  `LICENSE` is a package-local copy of the upstream license.
- **Dependencies:** grilling, domain-modeling. Declared peer Skills, not hidden runtime imports.
- **Navigation boundary:** `ask-matt` remains a router and does not execute or
  install the Skills it mentions.

## Installation and update

- **Whole collection (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --yes --copy --agent codex
- **Single package (published release):** npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --skill grill-with-docs --yes --copy --agent codex
- **Manual fallback:** copy the complete skills/mattpocock/engineering/grill-with-docs directory (or skills/mattpocock/grill-with-docs for ungrouped packages) into the host's recognized Skills root.
- **Update source:** run `scripts/sync-upstream.sh -Mode check` against the
  pinned source checkouts; review `-Mode diff`, then use `-Mode sync` and
  `scripts/generate-lock.sh` only after the allowlist and revision are approved.

## Differences and evidence

- **Upstream behavior preserved:** yes, for every upstream-managed file listed
  in `UPSTREAM_LOCK.json`.
- **Local difference:** provenance records only (plus license copy where noted).
- **Patch record:** `PATCHES.md`
- **Lock entry:** UPSTREAM_LOCK.json entry grill-with-docs

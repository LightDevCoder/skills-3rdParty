# Upstream Record: prototype

This package is a pinned upstream snapshot with a local host-metadata adapter.
The upstream Skill instructions and referenced resources are preserved.

## Identity

- **Source group:** engineering
- **Package:** prototype
- **Upstream repository:** `mattpocock/skills`
- **Canonical URL:** https://github.com/mattpocock/skills
- **Original package path:** skills/engineering/prototype
- **Selected upstream tag:** v1.1.0
- **Resolved commit:** d574778f94cf620fcc8ce741584093bc650a61d3
- **Applicable license:** MIT; see `LICENSE` in this package.
- **Upstream author/notice:** Matt Pocock and contributors; preserve the upstream license.

## Local packaging state

- **State:** pinned upstream snapshot with metadata-adapter-only local change.
- **Local patch:** `agents/openai.yaml` supplies the host metadata required by
  this collection's discovery checks; it does not alter `SKILL.md` behavior or
  upstream resources.
- **Why the adapter exists:** the upstream package does not ship this
  collection-specific `agents/openai.yaml`; omitting it makes metadata-aware
  discovery unable to report invocation policy reliably.
- **Dependencies:** none. These are declared peer Skills, not hidden runtime
  imports. Install them separately when a workflow explicitly needs them.
- **Navigation boundary:** `ask-matt` remains a router and does not execute or
  install the Skills it mentions.

## Installation and update

- **Whole collection:** npx skills add LightDevCoder/skills-3rdParty#v1.1.0
- **Single package:** npx skills add LightDevCoder/skills-3rdParty#v1.1.0 --skill prototype
- **Manual fallback:** copy this complete skills/prototype/ directory
  into the host's recognized Skills root.
- **Update source:** run `scripts/sync-upstream.ps1 -Mode check` against the
  pinned checkout; review upstream diff, then use `-Mode sync` only after the
  allowlist and revision are approved.

## Differences and evidence

- **Upstream behavior preserved:** yes, for the upstream package files listed
  in `UPSTREAM_LOCK.json`.
- **Local difference:** metadata adapter and this provenance record only.
- **Known limitations:** host-specific discovery and private-repository access
  remain dependent on the installer and credentials used by the consumer.
- **Patch record:** `PATCHES.md`
- **Lock entry:** UPSTREAM_LOCK.json entry prototype

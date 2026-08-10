# Matt Pocock upstream source group

[中文说明](README.zh-CN.md)

This source group records the pinned `mattpocock/skills` snapshot. The
install-facing packages live in the nested layout
`skills/mattpocock/<group>/<skill-name>/`, which preserves the upstream
organization (`engineering`, `productivity`) and is discoverable by the Skills
CLI (catalog layout, one category level).

- Repository: https://github.com/mattpocock/skills
- Selected tag: `v1.2.3`
- Resolved commit: `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`
- License: MIT, copied into each package as `LICENSE`
- Package inventory: [UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)

Groups represented: `engineering` (18 packages) and `productivity` (7
packages). `grill-me` depends on `grilling`; `grill-with-docs` depends on
`grilling` and `domain-modeling`; `ask-matt` remains navigation-only.
`writing-for-agents` is authoring knowledge, not an implicit runtime
dependency of the first-party `learn-anything`.

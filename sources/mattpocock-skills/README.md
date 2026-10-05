# Matt Pocock upstream source group

[中文说明](README.zh-CN.md)

This source group records the pinned `mattpocock/skills` snapshot. The
install-facing packages live in the nested layout
`skills/mattpocock/<group>/<skill-name>/`, which preserves the upstream
organization (`engineering`, `productivity`) and is discoverable by the Skills
CLI (catalog layout, one category level).

- Repository: https://github.com/mattpocock/skills
- Selected tag: `v1.3.1`
- Resolved commit: `24fe0ef7737efae15c87225755e9f6f5965e4888`
- License: MIT, copied into each package as `LICENSE`
- Package inventory: [UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)

Groups represented: `engineering` (20 packages) and `productivity` (7
packages). Upstream's `in-progress` and `misc` groups are out of scope for this
collection and are not mirrored. `grill-me` depends on `grilling`;
`grill-with-docs` depends on `grilling` and `domain-modeling`; `implement-spec`
depends on `tdd` and `code-review`; `retro` depends on `writing-for-agents`;
`ask-matt` remains navigation-only. `writing-for-agents` is authoring
knowledge, not an implicit runtime dependency of the first-party
`learn-anything`.

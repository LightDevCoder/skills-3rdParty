# Matt Pocock upstream source group

[中文说明](README.zh-CN.md)

This source group records the original grouping for the pinned `mattpocock/skills`
snapshot. The install-facing packages live in `skills/<skill-name>/` so the
Skills CLI can discover them; this file preserves upstream organization rather
than introducing a nested discovery path.

- Repository: https://github.com/mattpocock/skills
- Selected tag: `v1.1.0`
- Resolved commit: `d574778f94cf620fcc8ce741584093bc650a61d3`
- License: MIT, copied into each package as `LICENSE`
- Package inventory: [UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)

Groups represented: `engineering`, `productivity`, `deprecated`, and
`in-progress`. `grill-me` and `grill-with-docs` retain their peer dependency
notes; `ask-matt` remains navigation-only.

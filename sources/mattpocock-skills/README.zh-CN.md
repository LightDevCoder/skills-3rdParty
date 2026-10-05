# Matt Pocock 上游来源记录

[English](README.md)

本来源组记录固定的 `mattpocock/skills` 快照。安装面对包的目录为嵌套布局
`skills/mattpocock/<group>/<skill-name>/`，保留了上游分组（`engineering`、
`productivity`），且是 Skills CLI 可发现的目录布局（catalog 布局，一层分类）。

- 仓库：https://github.com/mattpocock/skills
- 固定 tag：`v1.3.1`
- Resolved commit：`24fe0ef7737efae15c87225755e9f6f5965e4888`
- License：MIT，复制进每个包作为 `LICENSE`
- 包清单：[UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)

覆盖分组：`engineering`（20 个包）与 `productivity`（7 个包）。上游的
`in-progress` 与 `misc` 分组不在本收藏集范围内，不予镜像。`grill-me` 依赖
`grilling`；`grill-with-docs` 依赖 `grilling` 与 `domain-modeling`；
`implement-spec` 依赖 `tdd` 与 `code-review`；`retro` 依赖
`writing-for-agents`；`ask-matt` 保持纯导航。`writing-for-agents` 是写作知识源，
不是 first-party `learn-anything` 的隐式运行时依赖。

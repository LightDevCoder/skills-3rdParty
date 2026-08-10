# Matt Pocock 上游来源记录

[English](README.md)

本来源组记录固定的 `mattpocock/skills` 快照。安装面对包的目录为嵌套布局
`skills/mattpocock/<group>/<skill-name>/`，保留了上游分组（`engineering`、
`productivity`），且是 Skills CLI 可发现的目录布局（catalog 布局，一层分类）。

- 仓库：https://github.com/mattpocock/skills
- 固定 tag：`v1.2.3`
- Resolved commit：`6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`
- License：MIT，复制进每个包作为 `LICENSE`
- 包清单：[UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)

覆盖分组：`engineering`（18 个包）与 `productivity`（7 个包）。
`grill-me` 依赖 `grilling`；`grill-with-docs` 依赖 `grilling` 与
`domain-modeling`；`ask-matt` 保持纯导航。`writing-for-agents` 是写作知识源，
不是 first-party `learn-anything` 的隐式运行时依赖。

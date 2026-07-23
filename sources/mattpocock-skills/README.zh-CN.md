# Matt Pocock upstream source group

[English](README.md)

本记录保留 pinned `mattpocock/skills` snapshot 的原始分组。为确保 Skills CLI
发现能力，实际安装包位于 `skills/<skill-name>/`；这里记录 upstream 组织方式，
不再引入会破坏发现的嵌套安装路径。

- Repository: https://github.com/mattpocock/skills
- 选定 tag：`v1.1.0`
- 解析 commit：`d574778f94cf620fcc8ce741584093bc650a61d3`
- License：MIT，每个包均携带 `LICENSE`
- 包清单：[UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)

包含 `engineering`、`productivity`、`deprecated`、`in-progress` 四个原始分组；
`grill-me`、`grill-with-docs` 的 peer dependency 和 `ask-matt` 的导航边界均已保留。

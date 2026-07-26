# 私有第三方 Skills 集合

[English](README.md)

`LightDevCoder/skills-3rdParty` 是私有、可审计的第三方 Agent Skill 集合，
与公开的[第一方集合](https://github.com/LightDevCoder/skills)严格分开，
仓库保持 private。

## 当前版本

本次变更目标版本为 `v0.1.1`；只有真实 tag、release 和 fresh-install 证据
产生后才可宣称已发布。集合准确收录 Matt Pocock 上游 `v1.1.0` 的 23 个
指定 Skill，解析 commit 为 `d574778f94cf620fcc8ce741584093bc650a61d3`。

[UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) 是权威清单，记录 upstream 路径、
逐文件 checksum、source group、许可证、依赖、本地修改状态和安装语义。

## 三种来源状态

- **Pinned upstream mirror：** 在不可变 revision 上保存完整 upstream 包；
  若主机需要，额外的集合 metadata adapter 必须单独标记。
- **Modified upstream fork：** 有明确兼容性、重打包、稳定 pin、主机支持或
  行为差异原因，并在 `PATCHES.md` 中记录。
- **External direct dependency：** 不复制，记录权威 upstream 与安装方式。

23 个包位于 `skills/<skill-name>/` 以保持 Skills CLI 发现能力；原始的
`engineering`、`productivity`、`deprecated`、`in-progress` 分组保存在
manifest 和 [source-group 记录](sources/mattpocock-skills/README.md)中。

## 安装

```text
npx skills add LightDevCoder/skills-3rdParty#v0.1.1
npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill grill-me
```

上面的命令是 release gate 目标：`v0.1.1` 尚未创建 tag、发布或完成
fresh-install 验证。gate 通过后，`#v0.1.1` 固定本地集合 release；包内容另外固定在 upstream
`v1.1.0`/完整 commit。不带 fragment 的简写不能描述为 immutable。请阅读[安装指南](docs/INSTALLATION.md)了解 private
凭据、全新目录、重复安装、发现验证和手工回退。

## 边界与维护

- `grill-me` 保留 `grilling` 依赖。
- `grill-with-docs` 保留 `grilling` 与 `domain-modeling` 依赖。
- `ask-matt` 只能导航，不得自动执行或安装。
- `writing-great-skills` 是 authoring knowledge，不是 `learn-anything` 的
  隐式运行时依赖。

请从[第三方准入](docs/THIRD_PARTY_ADMISSION.md)、[provenance policy](docs/PROVENANCE_POLICY.md)、
[update policy](docs/UPDATE_POLICY.md)、[维护](docs/MAINTENANCE.md)、[review policy](docs/REVIEW_POLICY.md)、
[目录](CATALOG.md)和[发布证据](docs/evidence/releases/v0.1.1/RELEASE_RECEIPT.md)开始。

```powershell
.\scripts\sync-upstream.ps1 -Mode check
.\tests\third-party-collection-tests.ps1
```

结构测试不等于 fresh installation、runtime 或独立 review 证据。

# 第三方 Skills 目录

[English](CATALOG.md)

本目录由 23 项 allowlist 与 [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) 同步，
只记录来源和安装事实；行为仍以各 upstream `SKILL.md` 及其资源为准。

## 集合状态

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty` |
| 可见性 | Private，刻意不公开 |
| 包数量 | Matt Pocock 指定 Skill 23 个 |
| upstream tag | `v1.1.0` |
| upstream commit | `d574778f94cf620fcc8ce741584093bc650a61d3` |
| 本地 release | `v0.1.1`，发布提交 `a891d39d7f34793d857c5b8eec3429c23871f421` |
| manifest | [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) |
| 同步工具 | [scripts/sync-upstream.ps1](scripts/sync-upstream.ps1) |
| 准入记录 | [v0.1.1 admission evidence](docs/evidence/releases/v0.1.1/ADMISSION_RECORD.zh-CN.md) |

## Source group

| 分组 | 数量 | upstream 根路径 |
| --- | ---: | --- |
| engineering | 14 | `skills/engineering/` |
| productivity | 5 | `skills/productivity/` |
| deprecated | 3 | `skills/deprecated/` |
| in-progress | 1 | `skills/in-progress/` |

本地安装路径保持为 `skills/` 下的扁平目录，以符合 CLI 发现规则；原始分组
和完整 upstream path 均保留在 manifest 中。

## 依赖重点

- `grill-me` → `grilling`
- `grill-with-docs` → `grilling`、`domain-modeling`
- `ask-matt`：仅导航；不执行、不安装、不编排
- `writing-great-skills`：authoring knowledge only

23 个包的逐项路径、资源、checksum、本地状态和 provenance 请直接查看
[UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) 及包内 `UPSTREAM.md` / `PATCHES.md`。

## 外部依赖

以 **external direct dependency** 状态准入（刻意不复制，从权威 upstream
安装）。记录见 [config/external-dependencies.json](config/external-dependencies.json)
与 [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) 的 `external_dependencies` 段。

| Skill | Upstream | Pin | License | 安装 |
| --- | --- | --- | --- | --- |
| `humanizer` | [blader/humanizer](https://github.com/blader/humanizer) | tag `v2.9.1`，commit `523374dee72d67c7b2b5f858ea0094ffda49c3ac` | MIT | 复制仓库根到宿主 Skills 根目录，或 Claude Code `/plugin marketplace add blader/humanizer` |

Source-group 记录：[sources/blader-humanizer/README.md](sources/blader-humanizer/README.md)。


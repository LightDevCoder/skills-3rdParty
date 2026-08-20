# 更新日志

[English](CHANGELOG.md)

以下发布声明均需 `docs/evidence/releases/` 下对应证据支撑。

## Unreleased — v0.2.1（release candidate）

发布证据：`docs/evidence/releases/v0.2.1/` — 在针对已发布 tag 跑
fresh-install gate 前标记为 `NOT TESTED`。

### 新增

- **`humanizer-zh` 作为第三个镜像来源入库**（`op7418/Humanizer-zh`
  `91f3d394db8419c20d67ebe22a96cf8fee0a404b`），即 Humanizer 写作编辑器的
  中文汉化版，原样镜像到 `skills/op7418/humanizer-zh/`，与英文版
  `blader/humanizer` 并存。
- 收藏集扩至 **三个来源共 27 个固定版本包**；allowlist、`UPSTREAM_LOCK.json`、
  CI 来源 checkout、目录与双语文档同步更新。

## v0.2.0 — 2026-08-10

### 变更

- **仓库公开化**并发布 `v0.2.0`；安装不再需要私有仓库凭据。
- **上游升级**：mattpocock/skills 从 `v1.1.0`（23 包）升级到 `v1.2.3`
  （25 包）：新增 `setup-matt-pocock-skills`、`triage`、
  `resolving-merge-conflicts`、`wizard`、`to-questionnaire`、`wait-what` 与
  `writing-for-agents`；移除 `design-an-interface`、`qa`、
  `ubiquitous-language`、`loop-me` 与 `writing-great-skills`（由重写后的
  `writing-for-agents` 取代）。
- **`humanizer` 作为第二个镜像来源入库**（`blader/humanizer` `v2.9.1`），
  由外部直接依赖升级为 pinned mirror，位于 `skills/blader/humanizer/`。
- **嵌套目录**：包改为 `skills/<source>/<group>/<name>/`（无分组包为
  `skills/<source>/<name>/`），保留上游分组且仍可被 Skills CLI 发现。
- **工具链跨平台重写**：PowerShell 同步脚本与测试替换为 bash + jq
  （`scripts/sync-upstream.sh`、`scripts/generate-lock.sh`、
  `tests/collection-checks.sh`）；CI 迁到 ubuntu-latest。
- **`UPSTREAM_LOCK.json` 改为生成式**（`schema_version: 3`，多来源），CI
  校验可重新生成；不再手工维护 manifest。
- **治理精简**：删除准入与审查策略文档，废除独立验收 gate；剩余策略合并
  到 `docs/POLICIES.md`（中文）；README 与 CATALOG 保持双语。

## v0.1.1 — 2026-07-26

- 初始私有发布：23 个固定版本 Matt Pocock Skills（上游 `v1.1.0`），含
  metadata 适配器、来源记录、同步工具与双语治理文档。历史证据保留在
  `docs/evidence/releases/v0.1.1/`。

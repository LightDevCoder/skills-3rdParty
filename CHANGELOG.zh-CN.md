# 更新日志

[English](CHANGELOG.md)

以下发布声明均需 `docs/evidence/releases/` 下对应证据支撑。

## v0.3.0 — 2026-10-06

### 变更

- **上游升级**：mattpocock/skills 从 `v1.2.3`（`6acc160e`）升级到 `v1.3.1`
  （`24fe0ef7`）；该来源贡献 27 个包（engineering 20 + productivity 7）。
- **mattpocock 各包内容刷新**：领域文档约定由 `CONTEXT.md`/`CONTEXT-MAP.md`
  改为 `GLOSSARY.md`/`GLOSSARY-MAP.md`（`domain-modeling` 的
  `CONTEXT-FORMAT.md` 改名为 `GLOSSARY-FORMAT.md`）；跨 Skill 调用统一为
  显式的 "Call the Skill tool with ..." 指令；上游正文去除破折号；`to-spec`、
  `code-review`、`setup-matt-pocock-skills`、`wait-what` 的非法 YAML
  front matter 已加引号修正。
- **工具**：`tests/collection-checks.sh` 新增校验——`skills/` 下的 `SKILL.md`
  集合必须与 allowlist 完全一致，避免从 allowlist 移除的包仍留在发布 tag 里
  可被发现。

### 新增

- **`implement-spec`**（engineering，pinned mirror）：一次运行实现整份 spec，
  把 tickets 当作任务图在单一 integration branch 上推进。声明 peer 依赖：
  `tdd`、`code-review`。
- **`pr`**（engineering，pinned mirror）：PR 正文应有的形状，包含前后对比
  证据与合并风险判断。
- **`retro`**（engineering，pinned mirror）：面向编码 agent 环境而非代码的
  复盘。声明 peer 依赖：`writing-for-agents`。
- 收藏集扩至 **三个来源共 29 个固定版本包**；allowlist、CI 来源 checkout、
  `UPSTREAM_LOCK.json`、目录与双语文档同步更新。

### 移除

- **`resolving-merge-conflicts` 已移除**（对使用它的安装是破坏性变更）：
  上游在 `v1.3.0` 删除了该 skill 且无替代品，agent 直接处理进行中的 merge
  或 rebase 冲突。包目录已删除；升级目标应清理残留副本。

### 发布证据

- `docs/evidence/releases/v0.3.0/` — 2026-10-06 验证通过。
- CLI：`npx skills` 1.7.0（Node v26.7.0）；发布 commit
  `e376baadafdcb3a6d6609de138ea5f42d594752b`；annotated tag 对象
  `a8d390b6069051cc944778fa7588705eaee136b1`；CI run `37358048011` success
  （ubuntu）。
- 针对已发布 `#v0.3.0` tag 的全新安装已验证：整仓 29/29（pinned 与 latest，
  安装树与镜像逐字节一致）、单包 `retro`（pinned）与 `humanizer-zh`
  （latest）、重复安装幂等、无源码 checkout 的发现（`Found 29 skills`）。
  完整矩阵与限制见证据文档。

## v0.2.1 — 2026-08-20

### 新增

- **`humanizer-zh` 作为第三个镜像来源入库**（`op7418/Humanizer-zh`
  `91f3d394db8419c20d67ebe22a96cf8fee0a404b`），即 Humanizer 写作编辑器的
  中文汉化版，原样镜像到 `skills/op7418/humanizer-zh/`，与英文版
  `blader/humanizer` 并存。
- 收藏集扩至 **三个来源共 27 个固定版本包**；allowlist、`UPSTREAM_LOCK.json`、
  CI 来源 checkout、目录与双语文档同步更新。

### 发布证据

- `docs/evidence/releases/v0.2.1/` — 2026-08-20 验证通过。
- CLI：`npx skills` 1.5.23；发布 commit `1c68526ccfa02b9cbbc8827b78fab5fceba722a8`；
  CI run `32320186456` success（ubuntu）。
- 针对已发布 `#v0.2.1` tag 的全新安装已验证：整仓 27/27（pinned 与 latest）、
  单包 `humanizer-zh`（pinned 与 latest）、重复安装幂等、无源码 checkout
  的发现（`Found 27 skills`）。完整矩阵与限制见证据文档。

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

# blader/humanizer 来源记录

`humanizer` 是第二个来源仓库（与 `mattpocock/skills` 平级），自 v0.2.0 起以
**pinned mirror** 状态入库：上游仓库根即一个 skill，完整复制到
`skills/blader/humanizer/`，包含 `SKILL.md`、`LICENSE`、`README.md`、
`AGENTS.md`、`agents/`、`scripts/`、`.claude-plugin/`、`.github/`。

## Identity

- Repository: https://github.com/blader/humanizer
- Skill location: repository root is the skill (`SKILL.md` at root)
- Selected tag: `v2.9.1`
- Resolved commit: `523374dee72d67c7b2b5f858ea0094ffda49c3ac`
- License: MIT (`LICENSE` at upstream repository root)
- Upstream author/notice: blader and contributors; preserve the upstream license.
- Local package path: `skills/blader/humanizer/`

## 什么是 humanizer

一个写作编辑 skill：识别并去除 AI 写作痕迹（inflated symbolism、promotional
language、superficial -ing analyses、vague attributions、em dash overuse、
rule of three、AI vocabulary words、passive voice、negative parallelisms、
filler phrases）。基于 Wikipedia 的 "Signs of AI writing" 指南
（WikiProject AI Cleanup），版本 2.9.1。

## 为什么从 external dependency 改为镜像

- v0.2.0 起收集目录按 `<source>/<group>/<skill>` 组织，来源仓库已成为一等
  公民；humanizer 作为第二个来源入库，与其他包同等治理（哈希受检、
  `UPSTREAM.md`/`PATCHES.md` 记录）。
- 上游自带 `agents/openai.yaml` 与 `LICENSE`，无需本地适配器。

## 安装与更新

- **整仓安装：** `npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --yes --copy --agent codex`
- **单包安装：** `npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --skill humanizer --yes --copy --agent codex`
- **更新来源：** 修改 allowlist 中 `blader` 的 tag/commit → 重跑
  `scripts/sync-upstream.sh -Mode sync` 与 `scripts/generate-lock.sh`。

## Record

- 机器记录：[config/upstream-allowlist.json](../../config/upstream-allowlist.json)
- Lock entry：[UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json) 中 `humanizer`
- 准入决策：user-requested 2026-08-10（v0.2.0 由 external 转为 mirror）

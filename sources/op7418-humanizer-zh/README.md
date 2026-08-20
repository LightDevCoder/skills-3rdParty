# op7418/Humanizer-zh 来源记录

`humanizer-zh` 是第三个来源仓库（与 `mattpocock/skills`、`blader/humanizer`
平级），自 v0.2.1 起以 **pinned mirror** 状态入库：上游仓库根即一个 skill，
完整复制到 `skills/op7418/humanizer-zh/`，包含 `SKILL.md`、`README.md`、
`LICENSE`、`.gitignore`。

## Identity

- Repository: https://github.com/op7418/Humanizer-zh
- Skill location: repository root is the skill (`SKILL.md` at root)
- Selected tag/ref: `91f3d394db8419c20d67ebe22a96cf8fee0a404b`（仓库无 tag，
  固定 resolved commit）
- Resolved commit: `91f3d394db8419c20d67ebe22a96cf8fee0a404b`
- License: MIT（`LICENSE` at upstream repository root）
- Upstream author/notice: 歸藏 (op7418) 与上游声明；保留上游 LICENSE 与署名。
- Local package path: `skills/op7418/humanizer-zh/`

## 什么是 humanizer-zh

`blader/humanizer` 的中文汉化版：一个写作编辑 skill，识别并去除 AI 写作痕迹
（夸大的象征意义、宣传性语言、-ing 肤浅分析、模糊归因、破折号过度使用、
三段式法则、AI 词汇、否定式排比、填充短语）。核心文件翻译自
[blader/humanizer](https://github.com/blader/humanizer)，规则速查/清单部分
参考 [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop)，
其本身基于维基百科 "Signs of AI writing" 指南。与英文版 `humanizer`
（blader）并存，互不冲突。

## 为什么作为独立来源入库

- `humanizer-zh` 是独立的第三方仓库（op7418/Humanizer-zh），提供中文能力，
  与 `blader/humanizer`（英文原版）是不同的包、不同的 `SKILL.md`。
- 按收集目录 `<source>/<group>/<skill>` 组织，来源仓库是一等公民；入库方式
  与其他包同等治理（哈希受检、`UPSTREAM.md`/`PATCHES.md` 记录、`LICENSE`
  副本随包）。
- 上游自带 `LICENSE`，无本地适配器；默认状态为只镜像、不改行为。

## 安装与更新

- **整仓安装：** `npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --yes --copy --agent codex`
- **单包安装：** `npx skills add LightDevCoder/skills-3rdParty#v0.2.1 --skill humanizer-zh --yes --copy --agent codex`
- **更新来源：** 修改 allowlist 中 `op7418` 的 tag/commit → 重跑
  `scripts/sync-upstream.sh -Mode sync` 与 `scripts/generate-lock.sh`。

## Record

- 机器记录：[config/upstream-allowlist.json](../../config/upstream-allowlist.json)
- Lock entry：[UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json) 中 `humanizer-zh`
- 准入决策：user-requested 2026-08-20（v0.2.1 以 pinned mirror 入库）

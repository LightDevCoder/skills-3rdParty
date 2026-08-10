# 第三方 Skills 收藏集

[English](README.md)

`LightDevCoder/skills-3rdParty` 是一个公开的、带来源审计的第三方 Agent
Skills 收藏集，刻意与 first-party 的
[LightDevCoder/skills](https://github.com/LightDevCoder/skills) 仓库分离。

## 当前版本

稳定版本为 `v0.2.0`，公开发布并带全新安装证据。镜像 **两个来源仓库共
26 个包**：

| 来源 | Pin | 包数 |
| --- | --- | --- |
| [mattpocock/skills](https://github.com/mattpocock/skills) | tag `v1.2.3`，commit `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e` | 25（engineering 18，productivity 7） |
| [blader/humanizer](https://github.com/blader/humanizer) | tag `v2.9.1`，commit `523374dee72d67c7b2b5f858ea0094ffda49c3ac` | 1 |

权威清单是 [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json)：记录每个来源的 pin、
逐文件 checksum、源分组、license 路径、依赖与本地修改状态。该 manifest 由
[scripts/generate-lock.sh](scripts/generate-lock.sh) 生成，禁止手工编辑。

## 目录

```
skills/mattpocock/engineering/<skill>/  18 个包
skills/mattpocock/productivity/<skill>/  7 个包
skills/blader/humanizer/                 1 个包
```

每个包包含未经修改的上游文件，加上 `UPSTREAM.md`（来源记录）与
`PATCHES.md`（本地改动账本）；mattpocock 包另带 `LICENSE` 副本。上游文件
受哈希校验，本地记录是唯一的本地差异。

## 快速安装

```text
npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --yes --copy --agent codex
```

只装一个包：

```text
npx skills add LightDevCoder/skills-3rdParty#v0.2.0 --skill grill-with-docs --yes --copy --agent codex
```

收录、同步与发布策略见 [POLICIES.md](docs/POLICIES.md)。

## 依赖与边界

- `grill-me` 依赖 `grilling`；`grill-with-docs` 依赖 `grilling` 与
  `domain-modeling`（声明的 peer Skills，不是隐藏运行时依赖）。
- `ask-matt` 纯导航，永不自动作执行器。
- `writing-for-agents` 是写作知识源，不是 first-party `learn-anything` 的
  隐式运行时依赖。

## 维护

全部工具跨平台（bash + jq；macOS/Linux/CI 通用）：

```bash
scripts/sync-upstream.sh -Mode check        # 完整性/哈希/资源/记录
scripts/sync-upstream.sh -Mode diff         # 本地与上游差异
scripts/sync-upstream.sh -Mode sync         # 从固定上游快照复制
scripts/generate-lock.sh                    # 重新生成 UPSTREAM_LOCK.json
tests/collection-checks.sh                  # 结构性检查
```

源快照放在一个 `sources/` 根下，每个来源一个 checkout
（`sources/mattpocock`、`sources/blader`）；工具用 `-SourcesRoot <dir>`
指定。发布证据：[docs/evidence/releases/](docs/evidence/releases/)。

- [目录](CATALOG.md)
- [更新日志](CHANGELOG.md)
- [收录与维护策略](docs/POLICIES.md)

# 第三方 Skills 目录

[English](CATALOG.md)

本目录由 29 项允许清单与 [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) 派生。
包行为仍归各上游 `SKILL.md` 所有；本文件只记录来源与安装事实。

## 收藏集状态

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty` |
| 可见性 | 公开 |
| 包数 | 29（mattpocock 27 + blader 1 + op7418 1） |
| 来源 pin | mattpocock/skills `v1.3.1`（`24fe0ef`）；blader/humanizer `v2.9.1`（`523374de`）；op7418/Humanizer-zh `91f3d394` |
| 本地版本 | `v0.3.0` — 公开 tag 与 release |
| 清单 | [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json)（生成物，禁止手工编辑） |
| 同步 | [scripts/sync-upstream.sh](scripts/sync-upstream.sh) |
| 策略 | [docs/POLICIES.md](docs/POLICIES.md) |

## 收录的包

| Skill | 来源 | 分组 | 本地路径 | 依赖 |
| --- | --- | --- | --- | --- |
| `ask-matt` | mattpocock | engineering | `skills/mattpocock/engineering/ask-matt` | none |
| `code-review` | mattpocock | engineering | `skills/mattpocock/engineering/code-review` | none |
| `codebase-design` | mattpocock | engineering | `skills/mattpocock/engineering/codebase-design` | none |
| `diagnosing-bugs` | mattpocock | engineering | `skills/mattpocock/engineering/diagnosing-bugs` | none |
| `domain-modeling` | mattpocock | engineering | `skills/mattpocock/engineering/domain-modeling` | none |
| `grill-with-docs` | mattpocock | engineering | `skills/mattpocock/engineering/grill-with-docs` | grilling、domain-modeling |
| `implement` | mattpocock | engineering | `skills/mattpocock/engineering/implement` | none |
| `implement-spec` | mattpocock | engineering | `skills/mattpocock/engineering/implement-spec` | tdd、code-review |
| `improve-codebase-architecture` | mattpocock | engineering | `skills/mattpocock/engineering/improve-codebase-architecture` | none |
| `pr` | mattpocock | engineering | `skills/mattpocock/engineering/pr` | none |
| `prototype` | mattpocock | engineering | `skills/mattpocock/engineering/prototype` | none |
| `research` | mattpocock | engineering | `skills/mattpocock/engineering/research` | none |
| `retro` | mattpocock | engineering | `skills/mattpocock/engineering/retro` | writing-for-agents |
| `setup-matt-pocock-skills` | mattpocock | engineering | `skills/mattpocock/engineering/setup-matt-pocock-skills` | none |
| `tdd` | mattpocock | engineering | `skills/mattpocock/engineering/tdd` | none |
| `to-spec` | mattpocock | engineering | `skills/mattpocock/engineering/to-spec` | none |
| `to-tickets` | mattpocock | engineering | `skills/mattpocock/engineering/to-tickets` | none |
| `triage` | mattpocock | engineering | `skills/mattpocock/engineering/triage` | none |
| `wayfinder` | mattpocock | engineering | `skills/mattpocock/engineering/wayfinder` | none |
| `wizard` | mattpocock | engineering | `skills/mattpocock/engineering/wizard` | none |
| `grill-me` | mattpocock | productivity | `skills/mattpocock/productivity/grill-me` | grilling |
| `grilling` | mattpocock | productivity | `skills/mattpocock/productivity/grilling` | none |
| `handoff` | mattpocock | productivity | `skills/mattpocock/productivity/handoff` | none |
| `teach` | mattpocock | productivity | `skills/mattpocock/productivity/teach` | none |
| `to-questionnaire` | mattpocock | productivity | `skills/mattpocock/productivity/to-questionnaire` | none |
| `wait-what` | mattpocock | productivity | `skills/mattpocock/productivity/wait-what` | none |
| `writing-for-agents` | mattpocock | productivity | `skills/mattpocock/productivity/writing-for-agents` | none |
| `humanizer` | blader | — | `skills/blader/humanizer` | none |
| `humanizer-zh` | op7418 | — | `skills/op7418/humanizer-zh` | none |

每个包内都有 [UPSTREAM.md](skills/mattpocock/engineering/ask-matt/UPSTREAM.md)
与 [PATCHES.md](skills/mattpocock/engineering/ask-matt/PATCHES.md)；改路径
即可查看其他包。

## 来源记录

- [sources/mattpocock-skills/README.md](sources/mattpocock-skills/README.md)
- [sources/blader-humanizer/README.md](sources/blader-humanizer/README.md)
- [sources/op7418-humanizer-zh/README.md](sources/op7418-humanizer-zh/README.md)

## 更新日志

[CHANGELOG.md](CHANGELOG.md)

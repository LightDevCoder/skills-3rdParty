# skills-3rdParty v0.2.1 发布凭证

[English](RELEASE_RECEIPT.md)

状态：`RELEASED` — 公开 tag、公开 GitHub release、CI 通过、fresh-install
证据齐全。验收声明：**自检 + CI + 人工核对**；v0.2.0 起已废除独立
`review-loop` gate。

## 身份

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty` |
| 版本 | `v0.2.1` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.2.1 |
| 发布 commit | `1c68526ccfa02b9cbbc8827b78fab5fceba722a8` |
| 上游 | `mattpocock/skills` `v1.2.3` / `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`；`blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`；`op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| 范围 | 27 个固定版本包（mattpocock 25 + blader 1 + op7418 1），嵌套目录，bash+jq 工具链，生成式 manifest |

## 自 v0.2.0 以来的变更

- **新增 `humanizer-zh`**（`op7418/Humanizer-zh`，pinned mirror）——Humanizer
  写作编辑器的中文汉化版，原样镜像，位于 `skills/op7418/humanizer-zh/`。
- 收藏集扩至三个来源共 27 包；allowlist、CI 来源 checkout、`UPSTREAM_LOCK.json`、
  目录与双语文档同步更新。

## 验收证据

- [测试摘要](TEST_SUMMARY.md)
- [安装验证](INSTALLATION_VERIFICATION.md)
- [发现验证](DISCOVERY_VERIFICATION.md)
- [限制](LIMITATIONS.md)
- 策略：[docs/POLICIES.md](../../../POLICIES.md)

## 发布闸门

- [x] 本地（macOS）与 CI（ubuntu）全部 sync 模式通过：`check`、`resource`、
      `unauthorized-patch`、`diff`、`prune`。
- [x] `tests/collection-checks.sh` 通过（27 包）；提交的 `UPSTREAM_LOCK.json`
      已验证可重新生成。
- [x] 候选 commit 上 CI 通过：run `32320186456`（success）。
- [x] 针对已发布 `#v0.2.1` tag 在全新目录做整仓（27 包）与单包
      （`humanizer-zh`）安装；重复安装幂等。
- [x] 通过已发布 tag 验证了无源码 checkout 的发现（`Found 27 skills`，
      `humanizer-zh` 在列）。
- [x] 从候选 commit 创建了 `v0.2.1` tag 并发布 GitHub release。

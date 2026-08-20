# skills-3rdParty v0.2.1 发布凭证

[English](RELEASE_RECEIPT.md)

状态：`RELEASE CANDIDATE` — 待对已发布 tag 做 fresh-install 验证后再打公开
tag 与 GitHub release。验收声明：**自检 + CI + 人工核对**；v0.2.0 起已废除
独立 `review-loop` gate。

## 身份

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty` |
| 版本 | `v0.2.1`（候选） |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.2.1 |
| 上游 | `mattpocock/skills` `v1.2.3` / `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`；`blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`；`op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| 范围 | 27 个固定版本包（mattpocock 25 + blader 1 + op7418 1），嵌套目录，bash+jq 工具链，生成式 manifest |

## 自 v0.2.0 以来的变更

- **新增 `humanizer-zh`**（`op7418/Humanizer-zh`，pinned mirror）——Humanizer
  写作编辑器的中文汉化版，原样镜像，位于 `skills/op7418/humanizer-zh/`。
- 收藏集扩至三个来源共 27 包；allowlist、CI 来源 checkout、`UPSTREAM_LOCK.json`、
  目录与双语文档同步更新。

## 验收证据

- [测试摘要](TEST_SUMMARY.md) — 网关运行前为 `NOT TESTED`。
- [安装验证](INSTALLATION_VERIFICATION.md) — `NOT TESTED`。
- [发现验证](DISCOVERY_VERIFICATION.md) — `NOT TESTED`。
- [限制](LIMITATIONS.md)
- 策略：[docs/POLICIES.md](../../../POLICIES.md)

## 发布闸门（候选）

- [x] 本地（macOS）全部 sync 模式通过：`check`、`resource`、
      `unauthorized-patch`、`diff`、`prune`。
- [x] `tests/collection-checks.sh` 通过（27 包）；提交的 `UPSTREAM_LOCK.json`
      已验证可重新生成。
- [ ] 针对已发布 `#v0.2.1` tag 在全新目录做整仓（27 包）与单包安装；
      重复安装幂等。
- [ ] 通过公开仓库 URL / tag 验证无源码 checkout 的发现。
- [ ] 从候选 commit 创建发布 tag 与 GitHub release。
- [ ] CI 在候选 commit 上通过（ubuntu）。

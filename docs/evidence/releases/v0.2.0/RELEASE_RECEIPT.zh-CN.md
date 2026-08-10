# skills-3rdParty v0.2.0 发布回执

[English](RELEASE_RECEIPT.md)

状态：`RELEASED` — 公开 tag、公开 GitHub release、CI 全绿、全新安装证据齐备。
验收声明：**自检 + CI + 人工核对**；独立 `review-loop` gate 已于 v0.2.0 废除。

## Identity

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty`（v0.2.0 起公开） |
| 版本 | `v0.2.0` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.2.0 |
| 上游 | `mattpocock/skills` `v1.2.3` / `6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`；`blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac` |
| 范围 | 26 个固定版本包（mattpocock 25 + blader 1）、嵌套目录、bash+jq 工具链、生成式 manifest、公开治理 |

## 验收证据

- [测试摘要](TEST_SUMMARY.md)
- [安装验证](INSTALLATION_VERIFICATION.md)
- [发现验证](DISCOVERY_VERIFICATION.md)
- [已知限制](LIMITATIONS.md)
- 策略：[docs/POLICIES.md](../../../POLICIES.md)

## Release gate

- [x] 全部 sync 模式在本地（macOS）与 CI（ubuntu）通过：`check`、
      `resource`、`unauthorized-patch`、`diff`、`prune`。
- [x] `tests/collection-checks.sh` 通过；提交的 `UPSTREAM_LOCK.json` 验证可
      重新生成。
- [x] 全新目录整仓安装（26 包）与单包安装；重复安装幂等。
- [x] 通过公开仓库 URL 验证无源码 checkout 的发现。
- [x] 仓库可见性切换为 public；创建 release tag。
- [x] 无 PowerShell 文件残留；工具在 macOS/Linux/CI 可运行。

# skills-3rdParty v0.1.1 发布收据

[English receipt](RELEASE_RECEIPT.md)

状态：`RELEASED WITH ACCEPTANCE LIMITATION`；私有 tag、GitHub release、合并后的
CI 和 fresh-install 证据已核验；独立 `review-loop agent-skill` acceptance 仍为
`BLOCKED`。

## 身份

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty`，保持 private |
| Release | `v0.1.1` |
| Release commit | `a891d39d7f34793d857c5b8eec3429c23871f421` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.1.1 |
| 日期 | `2026-07-26` |
| Upstream | `mattpocock/skills` `v1.1.0` / `d574778f94cf620fcc8ce741584093bc650a61d3` |
| 范围 | 恰好 23 个 pinned 第三方包、metadata adapter、provenance、同步工具和双语治理文档。 |

## Acceptance 证据

- [准入记录](ADMISSION_RECORD.md)
- [测试摘要](TEST_SUMMARY.md)
- [安装验证](INSTALLATION_VERIFICATION.md)
- [Discovery 验证](DISCOVERY_VERIFICATION.md)
- [限制](LIMITATIONS.md)
- [第一方集合证据](https://github.com/LightDevCoder/skills/blob/main/docs/evidence/releases/v0.1.1/RELEASE_RECEIPT.md)

## Release gate

| Gate | 状态 | 证据 |
| --- | --- | --- |
| Private visibility | `VERIFIED` | 远程仓库仍为 private；改变可见性不在范围内。 |
| 恰好 23 个指定包 | `VERIFIED` | allowlist、manifest、包目录和 collection tests 一致。 |
| Pinned upstream 与资源 | `VERIFIED` | `UPSTREAM_LOCK.json`、逐包 provenance 和同步模式验证。 |
| Fresh 整仓安装 | `VERIFIED` | CLI `1.5.20` 从 `v0.1.1` 恰好安装 23 个包。 |
| Fresh 单 Skill 安装 | `VERIFIED` | CLI `1.5.20` 恰好安装 `grill-with-docs`；peer 目录保持不存在。 |
| 重复安装 | `VERIFIED` | 整仓重复安装 exit 0，23 个包均报告 `overwrites: Codex`。 |
| GitHub Actions | `VERIFIED` | quality run `30189147755` 在发布线上通过。 |
| 独立 `review-loop agent-skill` acceptance | `BLOCKED` | 没有独立 evaluator 记录；同一上下文审阅不构成独立证据。 |

这是一份 release 记录，不是独立 acceptance 记录。结构测试和 CLI discovery
不能证明 host refresh 或模型介导的 runtime 行为。

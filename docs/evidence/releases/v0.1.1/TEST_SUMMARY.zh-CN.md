# v0.1.1 测试摘要

[English summary](TEST_SUMMARY.md)

每行记录真实命令、环境、断言数量和结果；结构测试不能当作 runtime proof。

| 范围 | 命令 / 环境 | 断言 | 结果 |
| --- | --- | ---: | --- |
| Pinned sync check | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode check` | 23 个包 | `PASS`；固定为 `v1.1.0/d574778f94cf620fcc8ce741584093bc650a61d3` |
| Sync dry-run | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode dry-run` | 23 个包 | `PASS`；报告全部 allowlist 路径且不写入 |
| Sync diff | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode diff` | 23 个包 | `PASS`；没有 `DIFF` 行 |
| Resource mode | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode resource` | 23 个包 | `PASS`；完整包和引用资源边界通过 |
| Unauthorized-patch mode | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/sync-upstream.ps1 -Mode unauthorized-patch` | 23 个包 | `PASS`；managed hash、patch checksum 和 extra-file 边界通过 |
| 成功 sync fixture | collection test disposable copy | 23 个包 | `PASS`；在 disposable copy 中重新生成包 |
| 整仓包契约 | `powershell -File tests/third-party-collection-tests.ps1` | 954 | `PASS` |
| 负向 fixture | collection test 内置 | 7 条负向断言 | `PASS`；覆盖 upstream 修改、extra file、patch 记录、sync 覆盖、包/集合 checksum 和 ignored resource |
| 治理文档 | `powershell -File tests/governance-docs-tests.ps1` | 86 | `PASS` |
| Fresh 整仓安装 | Skills CLI `1.5.20`，private fresh destination | 23 个包 | `PASS`；exit 0，恰好列出 23 个，source checkout 不存在 |
| Fresh 单包安装 | Skills CLI `1.5.20`，private fresh destination | 1 个包 | `PASS`；exit 0，恰好列出 `grill-with-docs`，peer 目录不存在 |
| 重复安装 | 整仓重复安装 | 23 个包 | `PASS`；exit 0，23 个均报告 `overwrites: Codex` |
| 依赖边界 smoke | 整仓和单包 fresh destination | 2 条 peer 边界 | `PASS`；整仓含 peer，单包不静默安装 peer |
| Private release 验证 | GitHub release API / remote | 1 个 release | `PASS`；`v0.1.1` 位于已核验提交且仓库保持 private |
| Release-commit CI | GitHub Actions quality run `30189147755` | workflow | `PASS` |
| Host refresh / model runtime | Agent host refresh 和模型介导 invocation | — | `NOT TESTED` |
| 独立 acceptance | 独立 evaluator 记录 | — | `BLOCKED` |

证据只记录 destination 类别，不包含绝对私人路径、token、用户名或凭据。

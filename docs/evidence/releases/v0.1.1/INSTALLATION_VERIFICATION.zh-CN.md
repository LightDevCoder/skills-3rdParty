# v0.1.1 安装验证

[English record](INSTALLATION_VERIFICATION.md)

状态：使用 Skills CLI `1.5.20` 从私有 tag 安装后为 `PASS`。host refresh 仍是
host-specific 行为，因此不作已完成声明；CLI discovery 均从没有 source
checkout 的 fresh destination 执行。

| 字段 | 整个集合 | 单 Skill |
| --- | --- | --- |
| 命令 | `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --yes --copy --agent codex` | `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill grill-with-docs --yes --copy --agent codex` |
| CLI version | `1.5.20` | `1.5.20` |
| Release commit | `a891d39d7f34793d857c5b8eec3429c23871f421` | 同左 |
| Fresh destination | 新建空临时项目；`.agents/skills/` 下恰好 23 个包 | 新建空临时项目；`.agents/skills/` 下恰好 1 个包 |
| 安装结果 | `PASS`，exit code 0 | `PASS`，exit code 0 |
| 脱离 source checkout 的 discovery | `npx --yes skills list` exit 0；列出全部 23 个；不存在 source checkout | `npx --yes skills list` exit 0；只列出 `grill-with-docs`；不存在 source checkout |
| 完整资源 | 23 个包均保留 `SKILL.md`、`agents/openai.yaml`、`LICENSE`、`UPSTREAM.md`、`PATCHES.md` 和引用资源 | 存在 `SKILL.md`、`agents/openai.yaml`、`LICENSE`、`UPSTREAM.md`、`PATCHES.md` |
| 依赖边界 | 整仓安装包含作为指定包的 `grilling` 与 `domain-modeling` | 单包目录中不存在 `grilling` 和 `domain-modeling`；没有静默安装 peer |
| 重复安装行为 | 同命令 exit 0；23 个包均报告 `overwrites: Codex` | 未单独重复；整仓重复已覆盖安装器路径 |
| 限制 | 未测试 host refresh 和模型介导的 runtime invocation | 同左 |

记录刻意不包含绝对私人路径、用户名或凭据。首次单包 wrapper 的安装本身已
exit 0，但检查输出有字段读取错误；随后用修正后的 wrapper 重跑，以上结果以
修正后的可复核检查为准。

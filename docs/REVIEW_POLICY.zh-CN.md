# 第三方 Review 政策

[English](REVIEW_POLICY.md)

Review 同时检查 Standards 与 Spec：包结构、资源 containment、metadata、license、
source grouping、链接、allowlist、revision、修改状态、依赖、安装语义和 private
边界。

最终 verdict 由 `review-loop` 持有：`PASS`、`FAIL` 或 `BLOCKED`。同步脚本、测试和
`code-review` 只是证据。发布前必须有完整资源与 checksum 检查、负向未授权修改
fixture、fresh whole/per-Skill install、脱离 source checkout 的 discovery、重复安装
结果和无未解决 P1/P2 的独立 review。未运行标记 `NOT TESTED`，缺独立 review 标记
`BLOCKED`。

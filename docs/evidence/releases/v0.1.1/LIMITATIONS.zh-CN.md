# v0.1.1 限制

[English limitations](LIMITATIONS.md)

- `PASS`：已用 CLI `1.5.20` 针对 `v0.1.1` tag 完成私有整仓和单 Skill 安装；
  在已认证的验证环境中可访问 private repository。
- `PASS`：GitHub Actions quality run `30189147755` 在发布线上通过。
- `BLOCKED`：尚无独立 `review-loop agent-skill` evaluator 记录；同一上下文检查
  不能标为 independent。
- Host-specific Skill refresh 行为和模型介导的 runtime invocation 仍未测试。
- `agents/openai.yaml` 是集合所需的 local metadata adapter，因为所选上游包不
  提供该文件；它不能证明 host-specific loading。
- 上游 `wayfinder` 含示例 Markdown `link` placeholder；原样保留，不把它当成本地资源。
- Peer dependency 作为安装边界记录和测试，而不是隐式 import：工作流实际使用
  `grill-me` 时需要 `grilling`，使用 `grill-with-docs` 时需要 `grilling` 与
  `domain-modeling`。

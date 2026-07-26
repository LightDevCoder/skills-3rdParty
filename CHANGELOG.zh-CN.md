# 更新日志

[English](CHANGELOG.md)

## 0.1.1 — 2026-07-23（待真实发布证据确认）

### 新增与修复

- 按 allowlist 收录 Matt Pocock upstream `v1.1.0` 的 23 个 Skill，并锁定完整
  commit、逐文件 checksum、license、provenance 和依赖状态。
- 支持 pinned upstream mirror、modified upstream fork、external direct dependency
  三种第三方状态。
- 增加 `check`、`dry-run`、`diff`、`sync` 同步工具与 unauthorized patch 负向测试。
- 增加中英文目录、安装、维护、provenance、更新、review、source-group 和 release
  evidence 文档。

### 发布证据

tag/release、fresh install 和 CI 已有真实证据；如果没有独立 evaluator 记录，
independent acceptance 仍保持 `BLOCKED`。发布提交为
`a891d39d7f34793d857c5b8eec3429c23871f421`，详见 `docs/evidence/releases/v0.1.1/`。

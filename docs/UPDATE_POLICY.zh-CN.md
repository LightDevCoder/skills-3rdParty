# Upstream 更新政策

[English](UPDATE_POLICY.md)

更新必须显式、固定、可审计：先在只读 checkout 中检查 tag/ref 并解析完整
commit，再运行 `dry-run` 和 `diff`，审查资源、license、metadata、依赖和
删除；随后才可 `sync`，运行 `check`、负向 unauthorized patch fixture、文档与
安装测试，并取得独立 review。

若 upstream 文件发生本地变更而没有 patch record，`check` 必须失败。缺少 peer
dependency 时记录为 external dependency，不能静默扩大 allowlist。

# 安装与全新环境验证

[English](INSTALLATION.md)

这是 private collection，v0.1.1 当前仍是 release candidate，尚未发布。下面命令是目标，不是安装证据。tag
发布后，消费者必须通过 Git 凭据、SSH 或已认证 CLI 访问私有 GitHub 仓库；
安装应来自 release，而不是 source checkout。

官方 CLI 支持 `#ref` 语义，因此 release gate 通过后使用：

```text
npx skills add LightDevCoder/skills-3rdParty#v0.1.1
npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill grill-me
```

`v0.1.1` 固定本地集合；`UPSTREAM_LOCK.json` 另行固定 Matt 的
`v1.1.0`/`d574778f94cf620fcc8ce741584093bc650a61d3`。不带 fragment 的简写
会跟随默认 revision，不能描述为 immutable。

Fresh-install 必须在无 source checkout 的空目录中运行，记录 CLI 版本、命令、
tag/commit、目标目录、完整资源、刷新后的发现结果、重复安装、成功/边界/缺失
依赖 smoke 以及限制。结果写入 `docs/evidence/releases/`；未运行标记
`NOT TESTED`，缺少独立 reviewer 标记 `BLOCKED`。

安装器不可用时，必须在 `v0.1.1` 发布后 checkout，并复制完整的
`skills/<skill-name>/`，不能只复制 `SKILL.md`。

# v0.1.1 第三方准入记录

[English record](ADMISSION_RECORD.md)

本记录覆盖 [THIRD_PARTY_ADMISSION.md](../../../THIRD_PARTY_ADMISSION.md) 要求的
23 个 Matt Pocock allowlist 字段；每个包仍保留自己的 `UPSTREAM.md` 与
`PATCHES.md`。

## 来源与状态

| 字段 | 记录 |
| --- | --- |
| 仓库 | `mattpocock/skills` — https://github.com/mattpocock/skills |
| 固定 revision | `v1.1.0` → `d574778f94cf620fcc8ce741584093bc650a61d3` |
| License/notice | MIT；每个 `skills/<name>/LICENSE` 都保留副本，作者 notice 写入各包 `UPSTREAM.md`。 |
| Source groups | `engineering`、`productivity`、`deprecated`、`in-progress`；原始路径记录在 `UPSTREAM_LOCK.json`。 |
| 本地布局 | 为适配 Skills CLI discovery 使用扁平 `skills/<skill-name>/`，原始分组仍保存在 manifest。 |
| 本地状态 | pinned upstream snapshot 加 metadata adapter；没有上游行为补丁。 |
| Allowlist | `config/upstream-allowlist.json` 与 `UPSTREAM_LOCK.json` 中恰好 23 个名称。 |
| Peer dependencies | `grill-me` → `grilling`；`grill-with-docs` → `grilling` + `domain-modeling`；都是声明的 peer，不是隐藏 import。 |
| 外部依赖边界 | `writing-great-skills` 只提供 authoring knowledge；`ask-matt` 只负责导航。 |

## 安装与审查证据

| 必需字段 | 证据 |
| --- | --- |
| 安装方法 | 目标命令：`npx skills add LightDevCoder/skills-3rdParty#v0.1.1` 和 `... --skill grill-me`；本地 tag/release 仍为 `NOT TESTED`。 |
| Host 与 discovery | 私有仓库 fresh-install 证据写入 [INSTALLATION_VERIFICATION.md](INSTALLATION_VERIFICATION.md) 和 [DISCOVERY_VERIFICATION.md](DISCOVERY_VERIFICATION.md) 前保持 `NOT TESTED`。 |
| 已知限制 | 私有 GitHub 访问、host refresh/discovery、重复安装和 peer dependency smoke 在 [LIMITATIONS.md](LIMITATIONS.md) 中标记 `NOT TESTED`。 |
| 更新方法 | 运行 `scripts/sync-upstream.ps1 -Mode check`，审查 `dry-run`/`diff`，仅在批准固定 revision 后执行 `sync`。 dirty upstream、额外本地文件和未授权 managed-file 改动会失败或报告。 |
| 冲突负责人 | 集合维护者；不静默解决冲突。上游文件变化必须采用新 pinned revision 或建立明确 patch record。 |
| 证据链接 | [TEST_SUMMARY.md](TEST_SUMMARY.md)、[RELEASE_RECEIPT.md](RELEASE_RECEIPT.md)、[UPSTREAM_LOCK.json](../../../../UPSTREAM_LOCK.json) 以及各包 provenance/patch 记录。 |

## 当前决定

本地 mirror、provenance、manifest 以及 structural/negative checks 为
`IMPLEMENTED`。本地 tag/release、私有 fresh installation、host discovery
和独立最终 reviewer 仍为 `NOT TESTED` 或 `BLOCKED`；本记录不将它们提升为
acceptance。

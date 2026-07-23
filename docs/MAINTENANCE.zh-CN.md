# 第三方维护

[English](MAINTENANCE.md)

权威关系如下：allowlist 在 `config/upstream-allowlist.json`，revision、资源
与 checksum 在 `UPSTREAM_LOCK.json`，行为在包内 `SKILL.md`，本地差异在
`PATCHES.md`，安装证据在 `docs/evidence/releases/`，人类目录和变更历史在
`CATALOG.md` / `CHANGELOG.md`。

同步命令：

```powershell
.\scripts\sync-upstream.ps1 -Mode check
.\scripts\sync-upstream.ps1 -Mode dry-run
.\scripts\sync-upstream.ps1 -Mode diff
.\scripts\sync-upstream.ps1 -Mode sync
```

`check` 发现缺包、资源缺失、revision 漂移或未经授权的 upstream 文件修改时
必须失败；`dry-run`、`diff` 不写文件。`sync` 只同步 allowlist，并重建 adapter、
provenance 和 manifest；冲突不得静默解决。

发布前须保持 private，并记录 upstream revision、包清单、patch、依赖、安装、
review 和 limitation。缺独立 review 是 `BLOCKED`，未运行测试是 `NOT TESTED`。

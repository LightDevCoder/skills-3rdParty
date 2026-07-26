# v0.1.1 Discovery 验证

[English verification](DISCOVERY_VERIFICATION.md)

状态：`PASS`；tagged artifact 已安装到 fresh destination，并在没有 source
checkout 的情况下成功列出。

## Fresh artifact 观察

- 整仓安装命令 `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --yes --copy --agent codex`
  exit 0；`npx --yes skills list` 恰好列出 23 个包。
- 单包安装使用同一 tag 加 `--skill grill-with-docs`，exit 0；恰好列出
  `grill-with-docs`。
- 两个 destination 都不存在 `skills/` source checkout。
- 整仓 destination 包含依赖 peer `grilling` 和 `domain-modeling`；单包
  destination 没有静默安装任一 peer。
- 所有已安装包均保留完整资源；单包 `grill-with-docs` 包含 `SKILL.md`、
  `agents/openai.yaml`、`LICENSE`、`UPSTREAM.md` 和 `PATCHES.md`。
- 整仓安装重复执行成功，23 个包均报告 `overwrites: Codex`。

## 结构命令

```text
powershell -File tests/third-party-collection-tests.ps1
```

本地结果：`THIRD_PARTY_COLLECTION_ASSERTIONS=959`、
`THIRD_PARTY_COLLECTION=PASS`。这属于 collection/resource 证据，不能证明
host refresh 或模型介导的 runtime 行为。

# skills-3rdParty 维护契约

English | [简体中文](README.zh-CN.md)

本仓库是第三方 Skill 包的公开收藏夹，内容全部来自固定版本的上游快照
（pinned mirror）。三种来源状态：

1. **Pinned upstream mirror** — 上游包在不可变修订上原样复制；本地只加
   收集记录（`UPSTREAM.md`、`PATCHES.md`，mattpocock 包另有 `LICENSE`
   副本）。
2. **Modified upstream fork** — 有行为/兼容性改动，必须在 `PATCHES.md`
   说明原因后才可入库。当前仓库没有此类包。
3. **External direct dependency** — 不复制，只记录权威来源。当前仓库没有
   此类包（humanizer 已于 v0.2.0 转为 mirror）。

这个第三方边界不削弱公开 first-party 仓库的所有权门：未修改的第三方包
永远不得进入 `LightDevCoder/skills` 的 `skills/`。

## 布局与清单

安装面对包的根目录是 `skills/<source>/<group>/<name>/`（无分组包为
`skills/<source>/<name>/`），Skills CLI 与各 Agent host 都能发现。
来源分组同时保留在 `UPSTREAM_LOCK.json`、allowlist 与
`sources/<source>/README.md` 中；美观嵌套不得破坏发现。

机器可读清单是 `UPSTREAM_LOCK.json`——它是生成物，只由
`scripts/generate-lock.sh` 写入，禁止手工编辑。允许清单是
`config/upstream-allowlist.json`。

## 准入与来源门

- 不得在允许清单之外添加包；添加必须改 allowlist 并重新同步。
- 每个来源固定 tag/ref，并在同步前核对完整 resolved commit。
- 保持上游文件哈希不变：任何对上游管理文件的改动都会让
  `sync-upstream.sh -Mode check` 失败，直到在 `PATCHES.md` 明确记录。
- 保留上游 LICENSE；快照/镜像/外部依赖状态在 manifest 中区分。
- `grill-me` 依赖 `grilling`；`grill-with-docs` 依赖 `grilling` 与
  `domain-modeling`。这是声明的 peer Skills，不是隐藏执行。
- `ask-matt` 保持纯导航：可以指路，不得安装、调用或编排其他 Skill。
- `writing-for-agents` 是写作知识源，不是 first-party `learn-anything` 的
  隐式运行时依赖。

## 同步

全部工具跨平台（bash + jq，macOS/Linux/CI）：

```bash
scripts/sync-upstream.sh -Mode check
scripts/sync-upstream.sh -Mode diff
scripts/sync-upstream.sh -Mode sync
scripts/sync-upstream.sh -Mode prune
scripts/generate-lock.sh
tests/collection-checks.sh
```

`check` 在缺包、缺引用资源、偏离固定修订、或对上游管理文件存在未授权
本地改动时失败。`diff`/`dry-run` 不写盘。`sync` 只增不删；删除由
`prune` 显式执行（先看 `diff`）。`generate-lock.sh` 重新生成 manifest。
绝不静默解决冲突或覆盖未记录的本地补丁。

## 发布与证据

发布声明为"自检 + CI + 人工核对"，不再设置独立验收 gate。发布前必须：
整仓与单包安装到全新目录、无源码 checkout 的发现验证、重复安装行为、
依赖边界抽查。真实结果记入 `docs/evidence/releases/<version>/`；未执行项
必须标 `NOT TESTED`。

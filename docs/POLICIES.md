# 收录与维护策略

本仓库是个人第三方 Skills 收藏夹：从可信上游**固定版本镜像**选定的包，
保留完整来源记录，不做行为修改。策略很薄，因为这里的每个包都是本人手动
筛选、手动入库的，风险模型是"自己抄错文件"而不是"被投毒"。

## 收录原则

- **只收录固定版本**。每个来源锁定 tag 与 resolved commit；不跟最新分支。
- **只镜像，不改行为**。上游文件原样复制；本地只添加收集记录
  （`UPSTREAM.md`、`PATCHES.md`，及 mattpocock 包的 `LICENSE` 副本）。
  任何行为或兼容性改动必须先在 `PATCHES.md` 里写清原因。
- **来源必须记录**。每个包在 `UPSTREAM_LOCK.json` 中记录上游仓库、tag、
  commit、路径、license；包内 `UPSTREAM.md` 是同一份信息的人类可读版。
- **允许清单驱动**。新增/删除包必须改 `config/upstream-allowlist.json`，
  然后重新同步和生成 manifest；不在清单里的包不进入 `skills/`。
- **许可保留**。镜像必须保留上游 LICENSE；来源许可证记录在 allowlist 与
  manifest 中。

## 目录与状态

```
skills/<source>/<group>/<name>/   分组包（如 skills/mattpocock/engineering/ask-matt）
skills/<source>/<name>/           无分组包（如 skills/blader/humanizer）
```

每个包目录包含：上游文件（哈希受检）+ `UPSTREAM.md` + `PATCHES.md`
（mattpocock 包另有 `LICENSE` 副本）。

三种来源状态：
- **pinned mirror**：上游快照原样镜像（本仓库唯一的默认状态）。
- **modified fork**：有行为/兼容性改动，必须在 `PATCHES.md` 说明原因后才可
  入库。当前仓库没有任何此类包。
- **external dependency**：不复制，只记录权威来源。当前仓库没有此类包
  （humanizer 已于 v0.2.0 以 mirror 状态入库）。

## 同步与校验

本机（macOS/Linux）直接运行，不需要 Windows：

```bash
scripts/sync-upstream.sh -Mode check        # 完整性/哈希/资源/记录校验
scripts/sync-upstream.sh -Mode resource     # SKILL.md 引用资源存在性
scripts/sync-upstream.sh -Mode unauthorized-patch  # 上游文件未被本地改动
scripts/sync-upstream.sh -Mode diff         # 与上游快照的差异
scripts/sync-upstream.sh -Mode dry-run      # 预览 sync 动作，不写盘
scripts/sync-upstream.sh -Mode sync         # 从上游快照复制（只增不删）
scripts/sync-upstream.sh -Mode prune        # 移除上游已删除的文件（先看 diff）
scripts/generate-lock.sh                    # 重新生成 UPSTREAM_LOCK.json（支持 -Utc 固定时间戳）
tests/collection-checks.sh                  # 结构性检查（CI 与本地同一条命令）
```

**同步流程**：更新 allowlist（新 tag/commit）→ `sync` → `generate-lock` →
`collection-checks.sh` + `sync-upstream.sh -Mode check` 全绿 → 提交。

- 源快照目录：`-SourcesRoot <dir>`，其下每个来源一个 checkout，例如
  `sources/mattpocock`、`sources/blader`；CI 与本地共用同一布局。
- `UPSTREAM_LOCK.json` 是**生成物**，禁止手工编辑；`collection-checks.sh`
  会验证提交的 manifest 与重新生成结果一致。

## 发布

- 发布前：`collection-checks.sh` 与全部 sync 模式通过；用
  `npx skills` 在全新目录做整仓/单包安装与发现验证，结果记入
  `docs/evidence/releases/<version>/`。
- 发布声明：自检 + CI + 人工核对。不再设置独立验收 gate。
- 安装命令固定版本号（`#v0.2.0`），保证可复现。

## 已知边界

- `grill-me` 依赖 `grilling`；`grill-with-docs` 依赖 `grilling` 与
  `domain-modeling`。这是声明的 peer Skills，不是隐藏运行时依赖。
- `ask-matt` 只做导航，不得安装、调用或编排其他 Skill。
- `writing-for-agents` 是写作知识源，不是 first-party `learn-anything` 的
  隐式运行时依赖。
- 本仓库永远不把未修改的第三方包放进 `LightDevCoder/skills` 的 `skills/`。

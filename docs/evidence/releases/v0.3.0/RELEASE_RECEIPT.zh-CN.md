# skills-3rdParty v0.3.0 发布凭证

[English](RELEASE_RECEIPT.md)

状态：`RELEASED` — 公开 annotated tag、公开 GitHub release、CI 通过、
fresh-install 证据齐全。验收声明：**自检 + CI + 人工核对**；v0.2.0 起已废除
独立 `review-loop` gate。

## 身份

| 字段 | 值 |
| --- | --- |
| 仓库 | `LightDevCoder/skills-3rdParty` |
| 版本 | `v0.3.0` |
| Release URL | https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.3.0 |
| 发布时间 | 2026-10-05T18:47:51Z（2026-10-06 02:47:51 +08:00） |
| Tag 对象 | `a8d390b6069051cc944778fa7588705eaee136b1`（annotated tag） |
| Peeled commit | `e376baadafdcb3a6d6609de138ea5f42d594752b` |
| CI run | `37358048011` — workflow `third-party-quality`，job `quality`，结论 `success` |
| 上游 | `mattpocock/skills` `v1.3.1` / `24fe0ef7737efae15c87225755e9f6f5965e4888`；`blader/humanizer` `v2.9.1` / `523374dee72d67c7b2b5f858ea0094ffda49c3ac`；`op7418/Humanizer-zh` `91f3d394db8419c20d67ebe22a96cf8fee0a404b` |
| CLI | `npx skills` 1.7.0（Node v26.7.0） |
| 范围 | 29 个固定版本包（mattpocock 27 + blader 1 + op7418 1），嵌套目录，bash+jq 工具链，生成式 manifest |

## 自 v0.2.1 以来的变更

- **上游升级**：mattpocock/skills 由 `v1.2.3` 升级到 `v1.3.1`：新增三个包
  （`implement-spec`、`pr`、`retro`），移除一个包
  （`resolving-merge-conflicts`，上游已删除且无替代）。
- **内容刷新**：mattpocock 各包统一 `CONTEXT.md` → `GLOSSARY.md` 约定
  （`domain-modeling` 的 `CONTEXT-FORMAT.md` → `GLOSSARY-FORMAT.md`）、
  显式 "Call the Skill tool with …" 跨 Skill 调用、去除破折号、修正 YAML
  description 引号。
- **新增声明的 peer 依赖**：`implement-spec` → `tdd`、`code-review`；
  `retro` → `writing-for-agents`。
- **新增结构校验**：`skills/` 下的 `SKILL.md` 集合必须与 allowlist 完全一致，
  被移除的包无法继续留在发布 tag 里被发现。
- 收藏集扩至三个来源共 29 包；allowlist、CI 来源 checkout、`UPSTREAM_LOCK.json`、
  目录与双语文档同步更新。

## 验收证据

- [测试摘要](TEST_SUMMARY.md)
- [安装验证](INSTALLATION_VERIFICATION.md)
- [发现验证](DISCOVERY_VERIFICATION.md)
- [限制](LIMITATIONS.md)
- 策略：[docs/POLICIES.md](../../../POLICIES.md)

## 发布闸门

- [x] 本地（macOS）与 CI（ubuntu）全部 sync 模式通过：`check`、`resource`、
      `unauthorized-patch`、`diff`、`prune`。
- [x] `tests/collection-checks.sh` 通过（29 包）；提交的 `UPSTREAM_LOCK.json`
      已验证可重新生成。
- [x] 候选 commit 上 CI 通过：run `37358048011`（success）。
- [x] 针对已发布 `#v0.3.0` tag 在全新目录做整仓（29 包，pinned 与 latest）安装，
      安装树与镜像逐字节一致；单包安装 `retro`（pinned）与 `humanizer-zh`
      （latest）；重复安装幂等。
- [x] 通过已发布 tag 验证无源码 checkout 的发现（`Found 29 skills`；
      `implement-spec`、`pr`、`retro` 在列；无 `resolving-merge-conflicts`）。
- [x] 从候选 commit 创建了 `v0.3.0` tag 并发布 GitHub release。

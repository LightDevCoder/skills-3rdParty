# 第三方准入政策

[English](THIRD_PARTY_ADMISSION.md)

本政策规定哪些内容可以进入私有第三方集合。它不同于公开第一方仓库的
ownership gate，但同样要求 provenance 与证据。

## 允许的来源状态

- **Pinned upstream mirror：** 在选定 tag/ref 和完整 commit 上保存完整包；
  主机 metadata adapter 可以存在，但必须标记为本地 patch，不能改写 upstream
  行为。
- **Modified upstream fork：** 只有兼容性、重打包、稳定 pin、主机支持或
  行为差异等具体原因，且直接 upstream 不足时才允许；差异必须可审查。
- **External direct dependency：** 有意不复制，只记录权威来源、revision 和
  安装方法。

便利、备份、集中管理或未经验证的偏好都不是 fork 理由。allowlist 是封闭的，
不得静默追加 Skill。

## 必备记录与边界

每个包必须记录仓库、URL、原始 path、tag/ref、完整 commit、license、逐文件
checksum、本地修改状态、依赖、安装结果、更新方式和证据。`grill-me` 与
`grill-with-docs` 的依赖必须保留；`ask-matt` 只能导航；
`writing-great-skills` 不能成为 `learn-anything` 的隐式运行时依赖。

不得把这些包放入公开第一方 `skills` 仓库。缺少实际引用资源时，包不算完整；
结构扫描也不能替代 fresh install、runtime 或独立 review。

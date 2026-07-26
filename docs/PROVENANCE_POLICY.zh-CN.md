# Provenance 政策

[English](PROVENANCE_POLICY.md)

每个第三方包都必须回答：文件来自哪里、使用哪个不可变 upstream revision、
本地改了什么、如何更新或移除。

`UPSTREAM_LOCK.json` 保存 repository、原始 path、tag、commit、逐文件 SHA-256、
包 checksum、license、依赖和本地修改状态；`UPSTREAM.md` 是解释记录，
`PATCHES.md` 是差异台账。

当前集合使用 `metadata-adapter-only`：upstream 文件保持 hash 一致，
`agents/openai.yaml` 仅补充主机 discovery 所需的 metadata，不代表 upstream
行为或第一方 authorship。每个包携带 MIT `LICENSE`，不得静默删除或改写。

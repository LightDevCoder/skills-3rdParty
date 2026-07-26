# Provenance Policy

[简体中文](PROVENANCE_POLICY.zh-CN.md)

Every third-party package must make it possible to answer: where did this file
come from, which immutable upstream revision was used, what changed locally,
and how can it be updated or removed?

`UPSTREAM_LOCK.json` is the machine-readable answer. Each entry stores the
source repository, original path, selected tag, resolved commit, per-file
SHA-256 inventory, package checksum, license path, dependency state, and local
modification state. `UPSTREAM.md` is the human-readable explanation;
`PATCHES.md` is the local difference ledger.

The current mirror uses `metadata-adapter-only`: upstream package files are
hash-checked and unchanged, while `agents/openai.yaml` provides collection
metadata because the selected upstream package does not ship it. This adapter
must not be described as upstream behavior or first-party authorship.

License files are copied into every package for self-contained installation.
The upstream MIT license remains authoritative. Do not remove, rewrite, or
replace it without a recorded license review.

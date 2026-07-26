# Upstream Update Policy

[简体中文](UPDATE_POLICY.zh-CN.md)

Updates are explicit, pinned, and reviewable:

1. fetch or inspect the proposed upstream tag/ref in a read-only checkout;
2. resolve it to a full commit and update the allowlist only if the package set
   remains authorized;
3. run `sync-upstream.ps1 -Mode dry-run`, `-Mode resource`, `-Mode diff`, and
   `-Mode unauthorized-patch`;
4. review removals, additions, references, licenses, metadata, and dependency
   changes;
5. run `-Mode sync`, then `-Mode check` and the negative unauthorized-patch
   fixture;
6. refresh catalog, bilingual docs, changelog, evidence, and CI; and
7. obtain independent review before tagging a release.

If an upstream file changes locally without a patch record, `check` must fail.
If a peer dependency is missing, record it as an external dependency and do
not silently add a package outside the allowlist.

# Third-Party Admission Policy

[简体中文](THIRD_PARTY_ADMISSION.zh-CN.md)

This policy governs what may enter the private third-party collection. It is
deliberately different from the public first-party ownership policy, while
still requiring provenance and evidence.

## Allowed source states

Every entry must be exactly one of:

- **Pinned upstream mirror:** a complete package snapshot at a selected tag/ref
  and full resolved commit. A small collection metadata adapter is allowed and
  must be listed as a local patch. No upstream behavior may be silently edited.
- **Modified upstream fork:** a package with a concrete compatibility,
  repackaging, stable-pin, host-support, or behavior-variation reason that
  direct upstream installation cannot meet. The patch and difference must be
  reviewed.
- **External direct dependency:** a package deliberately not copied. Record its
  authoritative source, revision, and installation guidance instead.

Convenience, backup, centralization, or an untested preference is not a fork
reason. A pinned mirror is allowed only when the owner explicitly requests the
auditable snapshot or when a reproducible collection boundary is required; it
must not be misrepresented as first-party authorship.

## Required admission record

Before release, each package and source group must identify:

1. upstream repository, URL, original package path, author, and license/notice;
2. selected tag/ref and full resolved commit;
3. source group and local install path;
4. snapshot, adapter, patch, or external-dependency state;
5. complete upstream file inventory and checksum;
6. every local patch and why it exists;
7. declared peer dependencies and whether they are installed or external;
8. installation method, host, discovery result, and known limitations; and
9. update method, conflict owner, and evidence links.

The 23-package Matt snapshot is admitted by the user-provided T19 scope. Its
allowlist is intentionally closed; `UPSTREAM_LOCK.json` must contain exactly
the names in `config/upstream-allowlist.json`.

## Boundary rules

- Do not add these packages to the public first-party `skills` repository.
- Preserve upstream `SKILL.md`, scripts, references, assets, templates, and
  other resources; a package is not complete if its referenced resources are
  missing.
- Keep `grill-me` → `grilling` and `grill-with-docs` → `grilling` +
  `domain-modeling` as declared peer dependencies.
- Keep `ask-matt` as a navigation-only router.
- Treat `writing-great-skills` as authoring knowledge, not a hidden runtime
  dependency of `learn-anything`.
- A structural scan is not fresh-install, runtime, or review evidence.

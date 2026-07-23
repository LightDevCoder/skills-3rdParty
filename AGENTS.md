# skills-3rdParty Maintenance Contract

English | [简体中文](README.zh-CN.md)

This repository is the private, auditable home for approved third-party Skill
packages. It supports three explicit source states:

1. **Pinned upstream mirror** — an unchanged upstream package snapshot at an
   immutable revision, plus clearly labeled collection metadata adapters when
   the host contract requires them.
2. **Modified upstream fork** — an upstream package with a documented,
   behavior-affecting or compatibility patch and a concrete reason direct use
   is insufficient.
3. **External direct dependency** — a package that is intentionally not copied;
   its authoritative upstream URL and required revision are recorded instead.

This broader third-party boundary does not weaken the public first-party
repository's ownership gate. Unmodified third-party packages must never enter
`skills/` in `LightDevCoder/skills`.

## Package and source layout

The installer-facing package root is `skills/<skill-name>/` because the Skills
CLI and Agent hosts discover packages there. Source grouping is preserved in
`UPSTREAM_LOCK.json`, `sources/mattpocock-skills/README.md`, and each package's
`source_group` and upstream path; aesthetic nesting must not break discovery.

Every mirrored package contains the complete upstream package files plus:

- `agents/openai.yaml` — collection metadata adapter, if upstream does not
  provide host metadata;
- `LICENSE` — package-local copy of the upstream license;
- `UPSTREAM.md` — provenance, pin, installation, and update record; and
- `PATCHES.md` — explicit local-difference ledger.

The machine-readable manifest is `UPSTREAM_LOCK.json`; the selected allowlist
is `config/upstream-allowlist.json`.

## Allowlist and provenance gates

- Never add a package outside the named allowlist without a separate user
  decision and a manifest update.
- Pin an upstream tag/ref and verify its full resolved commit before sync.
- Preserve every upstream-referenced resource; a source checkout scan is not
  a fresh-install proof.
- Keep upstream-managed file hashes unchanged unless a local patch record
  explicitly names and reviews the difference.
- Preserve the upstream license and distinguish snapshot, patch, and external
  dependency states in catalog and release records.
- `grill-me` depends on `grilling`; `grill-with-docs` depends on `grilling` and
  `domain-modeling`. These are declared peer Skills, not hidden execution.
- `ask-matt` remains navigation-only. It may describe routes but must not
  install, invoke, or orchestrate another Skill.
- `writing-great-skills` is an authoring knowledge source, not an implicit
  runtime dependency of first-party `learn-anything`.

## Synchronization

Use the controlled script with the read-only upstream checkout:

```powershell
.\scripts\sync-upstream.ps1 -Mode check
.\scripts\sync-upstream.ps1 -Mode dry-run
.\scripts\sync-upstream.ps1 -Mode diff
.\scripts\sync-upstream.ps1 -Mode sync
```

`check` fails on missing packages, missing referenced resources, drift from the
pinned revision, or unauthorized local changes to upstream-managed files.
`dry-run` and `diff` do not write. `sync` is allowed only after reviewing the
upstream revision and its diff. Never silently resolve a conflict or overwrite
an unrecorded local patch.

## Review, installation, and release

Package changes require structural, resource, provenance, synchronization,
installation, invocation, and negative-path evidence. `review-loop` owns the
final `PASS`, `FAIL`, or `BLOCKED` verdict; a script or specialist report is
evidence, not the verdict.

Before release, verify whole-collection and single-package installation into
fresh destinations, discovery without the source checkout, repeat-install
behavior, representative dependency boundaries, and private-repository
access. Record real results under `docs/evidence/releases/` and mark any
unexecuted item `NOT TESTED` or missing independent review `BLOCKED`.

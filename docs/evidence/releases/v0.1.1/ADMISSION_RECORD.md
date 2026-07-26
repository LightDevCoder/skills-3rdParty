# v0.1.1 third-party admission record

[中文记录](ADMISSION_RECORD.zh-CN.md)

This record satisfies the admission fields in
[THIRD_PARTY_ADMISSION.md](../../../THIRD_PARTY_ADMISSION.md) for the closed
23-package Matt Pocock allowlist. It is a collection-level record; each
package retains its detailed `UPSTREAM.md` and `PATCHES.md`.

## Source and state

| Field | Record |
| --- | --- |
| Repository | `mattpocock/skills` — https://github.com/mattpocock/skills |
| Selected revision | `v1.1.0` → `d574778f94cf620fcc8ce741584093bc650a61d3` |
| License/notice | MIT; copied to every `skills/<name>/LICENSE`; upstream author notice is preserved in each `UPSTREAM.md`. |
| Source groups | `engineering`, `productivity`, `deprecated`, `in-progress`; original paths are in `UPSTREAM_LOCK.json`. |
| Local layout | Flat `skills/<skill-name>/` for Skills CLI discovery; source grouping remains manifest metadata. |
| Local state | Pinned upstream snapshot plus metadata adapter; no upstream-managed file behavior patch. |
| Allowlist | Exactly 23 names in `config/upstream-allowlist.json` and `UPSTREAM_LOCK.json`. |
| Peer dependencies | `grill-me` → `grilling`; `grill-with-docs` → `grilling` + `domain-modeling`; all are declared peers, not hidden imports. |
| External dependency boundary | `writing-great-skills` is authoring knowledge only; `ask-matt` is navigation-only. |

## Installation and review evidence

| Required field | Evidence |
| --- | --- |
| Installation method | Published commands: `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --yes --copy --agent codex` and the same command with `--skill grill-with-docs`; CLI `1.5.20` evidence is recorded. |
| Host and discovery | Fresh destinations listed exactly 23 packages for whole install and exactly `grill-with-docs` for single install; source checkout was absent. |
| Known limitations | Private access passed in the authenticated run; host refresh/model runtime remain `NOT TESTED`, and independent acceptance is `BLOCKED`; see [LIMITATIONS.md](LIMITATIONS.md). |
| Update method | Run `scripts/sync-upstream.ps1 -Mode check`, review `dry-run`/`diff`, then use `sync` only for an approved pinned revision. Dirty upstream checkouts, extra local files, and unauthorized managed-file mutations fail or report. |
| Conflict owner | Collection maintainer; no silent conflict resolution. A changed upstream file requires a new pinned revision or explicit patch record. |
| Evidence links | [TEST_SUMMARY.md](TEST_SUMMARY.md), [RELEASE_RECEIPT.md](RELEASE_RECEIPT.md), [UPSTREAM_LOCK.json](../../../../UPSTREAM_LOCK.json), and package-local provenance/patch records. |

## Current decision

`VERIFIED` for the local mirror, provenance, manifest, structural/negative
checks, private tag/release, and fresh installation/discovery evidence.
Independent final acceptance remains `BLOCKED`; this record does not promote
same-context evidence to independent acceptance.

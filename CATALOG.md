# Third-Party Skills Catalog

[中文目录](CATALOG.zh-CN.md)

This catalog is derived from the 29-entry allowlist and
[UPSTREAM_LOCK.json](UPSTREAM_LOCK.json). Package behavior remains owned by
each upstream `SKILL.md`; this file records source and installation facts.

## Collection status

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` |
| Visibility | Public |
| Packages | 29 (27 mattpocock + 1 blader + 1 op7418) |
| Source pins | mattpocock/skills `v1.3.1` (`24fe0ef`); blader/humanizer `v2.9.1` (`523374de`); op7418/Humanizer-zh `91f3d394` |
| Local release | `v0.3.0` — public tag and release |
| Manifest | [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) (generated, never hand-edited) |
| Sync | [scripts/sync-upstream.sh](scripts/sync-upstream.sh) |
| Policy | [docs/POLICIES.md](docs/POLICIES.md) |

## Selected packages

| Skill | Source | Group | Local path | Dependencies |
| --- | --- | --- | --- | --- |
| `ask-matt` | mattpocock | engineering | `skills/mattpocock/engineering/ask-matt` | none |
| `code-review` | mattpocock | engineering | `skills/mattpocock/engineering/code-review` | none |
| `codebase-design` | mattpocock | engineering | `skills/mattpocock/engineering/codebase-design` | none |
| `diagnosing-bugs` | mattpocock | engineering | `skills/mattpocock/engineering/diagnosing-bugs` | none |
| `domain-modeling` | mattpocock | engineering | `skills/mattpocock/engineering/domain-modeling` | none |
| `grill-with-docs` | mattpocock | engineering | `skills/mattpocock/engineering/grill-with-docs` | grilling, domain-modeling |
| `implement` | mattpocock | engineering | `skills/mattpocock/engineering/implement` | none |
| `implement-spec` | mattpocock | engineering | `skills/mattpocock/engineering/implement-spec` | tdd, code-review |
| `improve-codebase-architecture` | mattpocock | engineering | `skills/mattpocock/engineering/improve-codebase-architecture` | none |
| `pr` | mattpocock | engineering | `skills/mattpocock/engineering/pr` | none |
| `prototype` | mattpocock | engineering | `skills/mattpocock/engineering/prototype` | none |
| `research` | mattpocock | engineering | `skills/mattpocock/engineering/research` | none |
| `retro` | mattpocock | engineering | `skills/mattpocock/engineering/retro` | writing-for-agents |
| `setup-matt-pocock-skills` | mattpocock | engineering | `skills/mattpocock/engineering/setup-matt-pocock-skills` | none |
| `tdd` | mattpocock | engineering | `skills/mattpocock/engineering/tdd` | none |
| `to-spec` | mattpocock | engineering | `skills/mattpocock/engineering/to-spec` | none |
| `to-tickets` | mattpocock | engineering | `skills/mattpocock/engineering/to-tickets` | none |
| `triage` | mattpocock | engineering | `skills/mattpocock/engineering/triage` | none |
| `wayfinder` | mattpocock | engineering | `skills/mattpocock/engineering/wayfinder` | none |
| `wizard` | mattpocock | engineering | `skills/mattpocock/engineering/wizard` | none |
| `grill-me` | mattpocock | productivity | `skills/mattpocock/productivity/grill-me` | grilling |
| `grilling` | mattpocock | productivity | `skills/mattpocock/productivity/grilling` | none |
| `handoff` | mattpocock | productivity | `skills/mattpocock/productivity/handoff` | none |
| `teach` | mattpocock | productivity | `skills/mattpocock/productivity/teach` | none |
| `to-questionnaire` | mattpocock | productivity | `skills/mattpocock/productivity/to-questionnaire` | none |
| `wait-what` | mattpocock | productivity | `skills/mattpocock/productivity/wait-what` | none |
| `writing-for-agents` | mattpocock | productivity | `skills/mattpocock/productivity/writing-for-agents` | none |
| `humanizer` | blader | — | `skills/blader/humanizer` | none |
| `humanizer-zh` | op7418 | — | `skills/op7418/humanizer-zh` | none |

Each package has a package-local [UPSTREAM.md](skills/mattpocock/engineering/ask-matt/UPSTREAM.md)
and [PATCHES.md](skills/mattpocock/engineering/ask-matt/PATCHES.md); replace
the path to inspect another entry.

## Source records

- [sources/mattpocock-skills/README.md](sources/mattpocock-skills/README.md)
- [sources/blader-humanizer/README.md](sources/blader-humanizer/README.md)
- [sources/op7418-humanizer-zh/README.md](sources/op7418-humanizer-zh/README.md)

## Changelog

[CHANGELOG.md](CHANGELOG.md)

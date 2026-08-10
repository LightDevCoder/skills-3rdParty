# Third-Party Skills Catalog

[中文目录](CATALOG.zh-CN.md)

This catalog is derived from the 23-entry allowlist and
[UPSTREAM_LOCK.json](UPSTREAM_LOCK.json). Package behavior remains owned by
each upstream `SKILL.md`; this file records source and installation facts.

## Collection status

| Field | Value |
| --- | --- |
| Repository | `LightDevCoder/skills-3rdParty` |
| Visibility | Private; intentionally not public |
| Packages | 23 selected Matt Pocock Skills |
| Upstream tag | `v1.1.0` |
| Upstream commit | `d574778f94cf620fcc8ce741584093bc650a61d3` |
| Local release | `v0.1.1` — published at `a891d39d7f34793d857c5b8eec3429c23871f421` |
| Manifest | [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) |
| Sync | [scripts/sync-upstream.ps1](scripts/sync-upstream.ps1) |
| Admission record | [v0.1.1 admission evidence](docs/evidence/releases/v0.1.1/ADMISSION_RECORD.md) |

## Source groups

| Source group | Packages | Original upstream root |
| --- | ---: | --- |
| engineering | 14 | `skills/engineering/` |
| productivity | 5 | `skills/productivity/` |
| deprecated | 3 | `skills/deprecated/` |
| in-progress | 1 | `skills/in-progress/` |

The local install layout is intentionally flat under `skills/` to match the
Skills CLI's discovery paths. The upstream grouping is not discarded: every
manifest entry retains its original path and source group.

## Selected packages

| Skill | Source group | Upstream path | Local state | Dependencies |
| --- | --- | --- | --- | --- |
| `ask-matt` | engineering | `skills/engineering/ask-matt` | snapshot + metadata adapter | none; navigation-only |
| `codebase-design` | engineering | `skills/engineering/codebase-design` | snapshot + metadata adapter | none |
| `code-review` | engineering | `skills/engineering/code-review` | snapshot + metadata adapter | none |
| `design-an-interface` | deprecated | `skills/deprecated/design-an-interface` | snapshot + metadata adapter | none |
| `diagnosing-bugs` | engineering | `skills/engineering/diagnosing-bugs` | snapshot + metadata adapter | none |
| `domain-modeling` | engineering | `skills/engineering/domain-modeling` | snapshot + metadata adapter | none |
| `grilling` | productivity | `skills/productivity/grilling` | snapshot + metadata adapter | none |
| `grill-me` | productivity | `skills/productivity/grill-me` | snapshot + metadata adapter | `grilling` |
| `grill-with-docs` | engineering | `skills/engineering/grill-with-docs` | snapshot + metadata adapter | `grilling`, `domain-modeling` |
| `handoff` | productivity | `skills/productivity/handoff` | snapshot + metadata adapter | none |
| `implement` | engineering | `skills/engineering/implement` | snapshot + metadata adapter | none |
| `improve-codebase-architecture` | engineering | `skills/engineering/improve-codebase-architecture` | snapshot + metadata adapter | none |
| `loop-me` | in-progress | `skills/in-progress/loop-me` | snapshot + metadata adapter | none |
| `prototype` | engineering | `skills/engineering/prototype` | snapshot + metadata adapter | none |
| `qa` | deprecated | `skills/deprecated/qa` | snapshot + metadata adapter | none |
| `research` | engineering | `skills/engineering/research` | snapshot + metadata adapter | none |
| `tdd` | engineering | `skills/engineering/tdd` | snapshot + metadata adapter | none |
| `teach` | productivity | `skills/productivity/teach` | snapshot + metadata adapter | none |
| `to-spec` | engineering | `skills/engineering/to-spec` | snapshot + metadata adapter | none |
| `to-tickets` | engineering | `skills/engineering/to-tickets` | snapshot + metadata adapter | none |
| `ubiquitous-language` | deprecated | `skills/deprecated/ubiquitous-language` | snapshot + metadata adapter | none |
| `wayfinder` | engineering | `skills/engineering/wayfinder` | snapshot + metadata adapter | none; upstream template contains an example `link` placeholder |
| `writing-great-skills` | productivity | `skills/productivity/writing-great-skills` | snapshot + metadata adapter | authoring knowledge only |

Each package has a package-local [UPSTREAM.md](skills/ask-matt/UPSTREAM.md)
and [PATCHES.md](skills/ask-matt/PATCHES.md); replace the package name in the
path to inspect another entry.

## External dependencies

Admitted as **external direct dependencies** (deliberately not copied; install
from the authoritative upstream source). Recorded in
[config/external-dependencies.json](config/external-dependencies.json) and the
`external_dependencies` section of [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json).

| Skill | Upstream | Pin | License | Install |
| --- | --- | --- | --- | --- |
| `humanizer` | [blader/humanizer](https://github.com/blader/humanizer) | tag `v2.9.1`, commit `523374dee72d67c7b2b5f858ea0094ffda49c3ac` | MIT | copy repository root into the host Skills root, or Claude Code `/plugin marketplace add blader/humanizer` |

Source-group record: [sources/blader-humanizer/README.md](sources/blader-humanizer/README.md).


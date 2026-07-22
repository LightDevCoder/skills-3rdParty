# skills-3rdParty

This repository is the governed home for locally modified third-party Skills.
It is not a mirror, convenience cache, or alternative installation source for
an unchanged upstream Skill.

The repository currently contains governance only. No source group, third-party
package, installer verification, or release has been admitted.

## Admission boundary

A Skill may enter only when direct upstream use is concretely insufficient for
one of these reasons:

- a compatibility fix is needed;
- another Agent host must be supported;
- stable pinned behavior is unavailable through direct installation;
- the upstream package needs repair or repackaging; or
- the owner deliberately maintains a behaviorally different variant.

Convenience, discoverability, backup, or a preference for one catalog is never
enough. An upstream Skill that works unchanged stays upstream and is installed
from its original source.

## Structure

~~~text
.
├── AGENTS.md
├── CHANGELOG.md
├── UPSTREAM_LOCK.json
├── docs/
│   ├── THIRD_PARTY_ADMISSION.md
│   ├── INSTALLATION.md
│   └── MAINTENANCE.md
└── templates/
    ├── PATCHES.md
    ├── SOURCE_README.md
    └── UPSTREAM.md
~~~

An admitted package is grouped by original source, never by generic capability:

~~~text
<source-id>/
├── README.md
└── <skill-id>/
    ├── SKILL.md
    ├── UPSTREAM.md
    ├── PATCHES.md
    └── <applicable license or notice files>
~~~

Create source groups only after admission. Use
[templates/SOURCE_README.md](templates/SOURCE_README.md) for the source record
and [templates/UPSTREAM.md](templates/UPSTREAM.md) plus
[templates/PATCHES.md](templates/PATCHES.md) for every package.

## Installation distinction

| Need | Authoritative source | Required record |
| --- | --- | --- |
| Original unchanged upstream Skill | Original upstream repository and its documentation | No local copy or lock entry. |
| Locally modified third-party Skill | A released source-grouped package in this repository | Provenance, license, patch, synchronization, and installation records. |

Read [docs/INSTALLATION.md](docs/INSTALLATION.md) before using either path.
Its command forms are placeholders until a release verifies actual installer
behavior.

## Governance

- [Admission policy](docs/THIRD_PARTY_ADMISSION.md) defines fork-necessity and
  evidence gates.
- [Maintenance](docs/MAINTENANCE.md) defines synchronization, conflict,
  regression, release, and removal rules.
- [Installation](docs/INSTALLATION.md) separates original-upstream and
  locally-modified installation, pinning, fallback, and provenance checks.
- [AGENTS.md](AGENTS.md) is the maintenance contract.
- [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json) is the inventory of admitted
  modified packages and is intentionally empty today.

This foundation makes no runtime, installer, or release claim.

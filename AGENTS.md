# skills-3rdParty Maintenance Contract

## Boundary

This repository contains only third-party Skills requiring a local
modification, compatibility adaptation, repackaging, deliberate version
stabilization, or behaviorally different variant. It is a provenance and
maintenance boundary, not a generic Skill catalog.

Do not add an unchanged upstream Skill. If direct upstream use works, document
or recommend the upstream source outside this repository. Do not present a
modified third-party Skill as original work.

## Source-based layout

Group every admitted package by original source:

~~~text
<source-id>/
├── README.md
└── <skill-id>/
    ├── SKILL.md
    ├── UPSTREAM.md
    ├── PATCHES.md
    └── <license or notice files>
~~~

Do not make empty source groups or group primarily by generic capability.

## Admission before import

Before copying or modifying an upstream package:

1. Follow [docs/THIRD_PARTY_ADMISSION.md](docs/THIRD_PARTY_ADMISSION.md).
2. Record concrete evidence that direct upstream use is insufficient.
3. Identify the original repository, package path, canonical URL, selected
   tag/ref, immutable resolved commit, author, and license obligations.
4. Define the smallest local change set, expected behavioral differences,
   synchronization method, installation record, and test evidence.
5. Obtain the required review before release.

Only these categories can justify a fork: compatibility fix, additional Agent
host support, stable pinned behavior unavailable upstream, package
repair/repackaging, or deliberate behavioral variation. Convenience is a
rejection.

## Required records

Every admitted package must include:

- completed UPSTREAM.md from [templates/UPSTREAM.md](templates/UPSTREAM.md);
- completed PATCHES.md from [templates/PATCHES.md](templates/PATCHES.md);
- applicable upstream license and notices;
- original repository/path and immutable upstream revision;
- local-change rationale, scope, known differences, and install record;
- synchronization procedure and last synchronization date; and
- an entry in [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json).

Its source group must include README.md from
[templates/SOURCE_README.md](templates/SOURCE_README.md). It owns source-wide
provenance, installation, and synchronization facts; package files own
package-specific facts.

## Updates and release

Follow [docs/MAINTENANCE.md](docs/MAINTENANCE.md). Preserve and reapply the
documented patch set when synchronizing. Do not silently resolve a rebase
conflict or license change. Imports are snapshots, never merged upstream Git
histories.

Follow [docs/INSTALLATION.md](docs/INSTALLATION.md) to distinguish original
upstream installation from locally modified installation. Never publish an
installer command until its actual behavior has been verified for the released
package and target host.

For a package add, rename, update, deprecation, sync, or removal, review:

- root README and source README;
- package provenance and patch records;
- licenses/notices and UPSTREAM_LOCK.json;
- installation guidance and verification evidence;
- test/review evidence; and
- release notes.

Static path or Markdown checks are not runtime evidence. Do not release with
unresolved provenance, license, patch, synchronization, installation, or
behavioral-difference records. If upstream eliminates the concrete fork need,
prefer removal and direct users to upstream.

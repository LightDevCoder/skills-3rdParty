# Third-Party Source Catalog

This catalog records modified third-party source groups only. It is
intentionally empty while direct upstream use remains sufficient and no
concrete fork has passed admission.

## Current state

| Field | Value |
| --- | --- |
| Source groups | 0 |
| Modified packages | 0 |
| Lock inventory | [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json), entries: 0 |
| Stable release | [v0.1.0](https://github.com/LightDevCoder/skills-3rdParty/releases/tag/v0.1.0) — private governance release |
| Installation authority | [docs/INSTALLATION.md](docs/INSTALLATION.md) |
| Admission authority | [docs/THIRD_PARTY_ADMISSION.md](docs/THIRD_PARTY_ADMISSION.md) |

No package is admitted here. An empty catalog is a valid governance-only
state; do not create a source group merely to populate this table.

## Direct upstream boundary

Unmodified Matt Pocock Skills remain at
[mattpocock/skills](https://github.com/mattpocock/skills) and are installed
directly from upstream. They must not be copied into this repository.

## Future source-group record

When a justified variant is admitted, add one entry with:

- original source identifier and repository;
- package path, immutable upstream ref and resolved commit;
- concrete fork necessity;
- license or notice record;
- local patch record and known differences;
- released local installation path; and
- synchronization date and evidence.

The corresponding source README, UPSTREAM.md, PATCHES.md, license/notices,
lock entry, installation evidence, and release notes must be updated in the
same change.

# Private Third-Party Skills Collection

[中文说明](README.zh-CN.md)

`LightDevCoder/skills-3rdParty` is a private, source-audited collection of
third-party Agent Skills. It is intentionally separate from the public
first-party [LightDevCoder/skills](https://github.com/LightDevCoder/skills)
repository and remains private.

## Current release

The next stable release is `v0.1.1` on the local `codex/t19-skills-3rdParty`
change set; publication is recorded only after the real tag, release, and
fresh-install evidence exist. The collection mirrors exactly 23 selected Matt
Pocock Skills from upstream tag `v1.1.0`, resolved to
`d574778f94cf620fcc8ce741584093bc650a61d3`.

The authoritative inventory is [UPSTREAM_LOCK.json](UPSTREAM_LOCK.json). It
records upstream paths, per-file checksums, source groups, license paths,
dependencies, local modification state, and release installation semantics.

## What is included

| State | Meaning | Record |
| --- | --- | --- |
| Pinned upstream mirror | Upstream package files are copied at an immutable revision; only the collection metadata adapter is local. | `UPSTREAM_LOCK.json`, `skills/<name>/UPSTREAM.md` |
| Modified upstream fork | A behavior or compatibility change is explicitly justified and patched. | `UPSTREAM.md`, `PATCHES.md`, tests |
| External direct dependency | The package is not copied; users install from its authoritative upstream source. | Source record and installation docs |

The 23 selected packages are installed under `skills/<skill-name>/` so the
Skills CLI can discover them. Original upstream grouping (`engineering`,
`productivity`, `deprecated`, and `in-progress`) remains auditable in the
manifest and [source-group record](sources/mattpocock-skills/README.md).

## Quick installation

The commands below are release-gate targets: `v0.1.1` has not yet been tagged,
published, or fresh-install verified. Once the gate passes, the `#v0.1.1`
fragment pins this private collection release. It does not claim that the
shorthand without a fragment is immutable.

Install the complete private collection:

```text
npx skills add LightDevCoder/skills-3rdParty#v0.1.1
```

Install one package:

```text
npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill grill-me
```

Read [Installation](docs/INSTALLATION.md) for private-repository credentials,
fresh destinations, repeat installation, discovery, and the manual fallback.

## Dependencies and boundaries

- `grill-me` retains its `grilling` dependency.
- `grill-with-docs` retains its `grilling` and `domain-modeling` dependencies.
- `ask-matt` is navigation-only; it never becomes an automatic executor.
- `writing-great-skills` is authoring knowledge, not an implicit runtime
  dependency of first-party `learn-anything`.

## Maintenance and evidence

- [Third-party admission](docs/THIRD_PARTY_ADMISSION.md)
- [Provenance policy](docs/PROVENANCE_POLICY.md)
- [Update policy](docs/UPDATE_POLICY.md)
- [Maintenance](docs/MAINTENANCE.md)
- [Installation and fresh-install verification](docs/INSTALLATION.md)
- [Review policy](docs/REVIEW_POLICY.md)
- [Catalog](CATALOG.md)
- [Changelog](CHANGELOG.md)
- [Release evidence](docs/evidence/releases/v0.1.1/RELEASE_RECEIPT.md)
- [Sync tool](scripts/sync-upstream.ps1)

Run the repository checks from a clean checkout:

```powershell
.\scripts\sync-upstream.ps1 -Mode check
.\tests\third-party-collection-tests.ps1
```

Structural checks do not replace fresh installation, discovery, or independent
review evidence.

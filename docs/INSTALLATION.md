# Installation

## Current status

This repository contains governance only. It has no admitted source group or
modified package, so it has no usable local installation command, version pin,
or runtime-installation evidence.

The source catalog and empty lock inventory are authoritative:
[CATALOG.md](../CATALOG.md) and [UPSTREAM_LOCK.json](../UPSTREAM_LOCK.json).

## Select the correct path

| Need | Install from | Do not |
| --- | --- | --- |
| Original unchanged upstream Skill | Original upstream repository using official instructions | Use this repository as a proxy or expect a local lock entry. |
| Locally modified third-party Skill | Released source-grouped package in this repository | Substitute upstream instructions, which omit local changes. |

An upstream Skill that works unchanged stays on the original-upstream path.
The existence of a local variant signals an intentional documented
difference, not a preference to avoid upstream.

## Installer form

The general command shape is a template until a real local release and fresh
host verification exist:

~~~
npx skills add <owner>/<repository> --skill <skill-name>
~~~

The [Skills CLI documentation](https://www.skills.sh/docs/cli) describes the
general syntax. This repository does not publish an owner, repository,
revision, installer version, destination, or verified local command while its
catalog is empty.

For an original upstream Skill, use the original repository's exact command
and record its revision and host evidence. For a locally modified package,
wait for a completed source-group record and a released immutable local
revision.

## Manual fallback for a future local package

When a verified installer is unavailable:

1. Obtain the exact released local package using its documented release pin.
2. Copy the complete source-grouped package, including SKILL.md, resources,
   UPSTREAM.md, PATCHES.md, and license/notices, to the host-supported Skills
   location.
3. Follow the host discovery/refresh procedure.
4. Verify package identity, local pin, upstream revision, license/notices, and
   documented differences.
5. Run the package's independent installation/runtime check.

Manual copying is a fallback mechanism, not permission to copy an unchanged
upstream package here.

## Provenance verification after local installation

Confirm that the source/package path matches the release record; UPSTREAM.md
names original repository, path, ref, and resolved commit; PATCHES.md accounts
for local changes; license/notices are present; the matching lock entry agrees;
and installation evidence matches host and release.

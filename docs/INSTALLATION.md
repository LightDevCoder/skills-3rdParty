# Installation

## Current status

This repository contains governance only. It has no admitted source group or
modified package, so it has no usable local installation command, version pin,
or runtime-installation evidence.

The command forms below show the required distinction for a future admitted
package. They are placeholders, not verified commands, and must not be
published or run verbatim. Exact behavior must be tested against the released
package and target Agent host first.

## Select the correct path

| Need | Install from | Do not |
| --- | --- | --- |
| Original unchanged upstream Skill | Original upstream repository using official instructions | Use this repository as a proxy or expect a local lock entry. |
| Locally modified third-party Skill | Released source-grouped package in this repository | Substitute upstream instructions, which omit local changes. |

An upstream Skill that works unchanged stays on the original-upstream path.
The existence of a local variant signals an intentional documented difference,
not a preference to avoid upstream.

## Preferred installer form where supported

After verification for the intended host, the general installer shape may be:

~~~text
npx skills@latest add <owner>/<repository> --skill <skill-name>
~~~

Original upstream form:

~~~text
npx skills@latest add <upstream-owner>/<upstream-repository> --skill <upstream-skill-name>
~~~

Locally modified form:

~~~text
npx skills@latest add <hub-owner>/skills-3rdParty --skill <modified-skill-name>
~~~

Whether an installer supports a revision, source subdirectory, or other
pinning syntax must be verified rather than assumed. Until then, the completed
UPSTREAM.md, source README, and release record are authoritative for a real
package command.

## Version pinning and verification

Every locally modified installation record must state:

- released repository and package identifier;
- release tag, immutable release commit, or other supported version pin;
- exact verified installer command;
- target Agent host and version;
- verification date and evidence; and
- upstream revision from which the local variant derives.

An installation is not reproducible if it only names a moving default branch.
The local release pin does not replace the upstream commit recorded in
UPSTREAM.md and UPSTREAM_LOCK.json.

## Manual fallback

When a verified installer is unavailable:

1. Obtain the exact released local package using its documented release pin.
2. Copy the complete package directory, including SKILL.md, resources,
   UPSTREAM.md, PATCHES.md, and license/notices, to the host-supported Skills
   location.
3. Follow the host discovery/refresh procedure.
4. Verify package identity, local pin, upstream revision, license/notices, and
   documented differences.
5. Run the package's independent installation/runtime check.

For an original upstream Skill, follow the upstream manual instructions
instead. Do not copy an unchanged package into this repository as a fallback.

## Provenance verification after local installation

Confirm that the source/package path matches the release record; UPSTREAM.md
names original repository, path, ref, and resolved commit; PATCHES.md accounts
for local changes; license/notices are present; the matching lock entry agrees;
and installation evidence matches host and release.

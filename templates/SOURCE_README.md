# <source-id> Modified Skills

This source group contains only approved, locally modified packages originating
from <upstream owner/repository>. It is not a mirror of the upstream source.

## Source identity and attribution

- **Upstream owner/repository:** <owner/repository>
- **Canonical upstream URL:** <URL>
- **Source license/notice policy:** <details>
- **Source-group maintainer:** <role/contact>
- **Last source review:** <YYYY-MM-DD>

## Why this source group exists

State the approved fork-necessity basis shared by the group and link every
package to package-specific concrete evidence. Convenience and source mirroring
are not valid reasons.

## Packages

| Modified package | Original upstream path | Pinned upstream revision | Local difference | Modified-install record |
| --- | --- | --- | --- | --- |
| <skill-id> | <path> | <tag/ref and full commit> | <short summary> | <link to UPSTREAM.md> |

Add only admitted packages. Remove the example row before release if no package
has passed admission.

## Installation paths

### Original upstream Skill

Install an unchanged upstream package from its original repository using
official verified instructions. Do not route it through this source group.

- **Authoritative upstream installation source:** <URL>
- **Verified upstream command/manual method:** <exact value and evidence>

### Locally modified package

Install only a released documented modified variant from this repository. Each
package UPSTREAM.md must name the local release pin, verified command, manual
fallback, host, and verification evidence.

- **Repository release source:** <URL or immutable release reference>
- **Verified modified-install command:** <exact command>
- **Manual fallback:** <method>
- **Provenance verification:** <link to package records>

## Synchronization

- **Upstream change detection/cadence:** <method>
- **Last checked:** <YYYY-MM-DD>
- **Last synchronized revision:** <tag/ref and full commit>
- **Patch reapplication/rebase:** <link or summary>
- **Conflict escalation:** <method>
- **Regression and interaction requirements:** <link or summary>

## Release and removal

Every release identifies packages as modified third-party variants, preserves
attribution/licenses, and links package records. If upstream removes the
concrete need for a variant, deprecate/remove it and direct users upstream.

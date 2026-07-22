# Upstream Record: <skill-id>

Complete every field before release. Replace placeholders with concrete source
facts.

## Identity

- **Source group:** <source-id>
- **Modified package:** <skill-id>
- **Upstream name and author:** <value>
- **Upstream owner/repository:** <owner/repository>
- **Canonical upstream URL:** <URL>
- **Original upstream package path:** <path>
- **Snapshot obtained:** <YYYY-MM-DD and method>

## Immutable upstream revision and licensing

- **Selected upstream tag/ref:** <value>
- **Resolved commit SHA:** <full immutable SHA>
- **Reason for selecting revision:** <value>
- **Applicable license identifier:** <SPDX or source wording>
- **License/notice path in this package:** <relative path>
- **Additional attribution/notice obligations:** <details or none>

## Fork-necessity record

- **Direct upstream installation evaluated:** <date, host, and version>
- **Permitted category:** <compatibility fix | additional host support | stable pin | package repair/repackaging | behavioral variation>
- **Concrete reason direct upstream is insufficient:** <observed behavior or reproducible need>
- **Evidence for reason:** <test, issue, receipt, or durable link>
- **Why configuration, Profile/Layer, or wrapper is insufficient:** <analysis>
- **Local-change objective:** <what changes and what does not>

Convenience, centralization, discovery, backup, and untested preference are not
valid answers to this section.

## Behavior and differences

- **Behavior preserved from upstream:** <summary>
- **Intentional local behavior:** <summary>
- **Known differences/compatibility impact:** <summary>
- **Known limitations:** <summary>

## Installation records

### Original upstream installation

- **Authoritative instructions:** <URL or durable source path>
- **Verified command/manual method:** <exact value and evidence>

### Locally modified installation

- **Local repository and source/package path:** <value>
- **Local release tag/immutable commit:** <value>
- **Target Agent host and version:** <value>
- **Verified installer command:** <exact command>
- **Manual fallback:** <exact method>
- **Verification date/evidence:** <value>

## Synchronization record

- **Upstream change-detection method/cadence:** <method>
- **Last upstream check:** <YYYY-MM-DD>
- **Last synchronization date:** <YYYY-MM-DD>
- **Last synchronized ref and commit:** <values>
- **Patch reapplication/rebase method:** <method>
- **Conflict escalation owner/path:** <method>
- **Required regression/interaction checks:** <checks>

## Cross-references

- **Patch record:** PATCHES.md
- **Source record:** <relative source README link>
- **Lock inventory entry:** <identifier>
- **Release/review evidence:** <link>

# Third-Party Skill Admission

## Policy

A package may enter only as a source-grouped, locally modified third-party
Skill. The proposer must first show that direct use of original upstream is
insufficient for a concrete, reproducible reason.

Do not accept unmodified copies for convenience, discovery, backup,
centralization, or a preference for one catalog. Passing admission does not
transfer ownership: upstream attribution and licensing remain visible.

## Direct-upstream gate

Record one permitted category and concrete evidence:

| Category | Required evidence |
| --- | --- |
| Compatibility fix | Host/version, observed failure, and why direct upstream cannot work. |
| Additional Agent-host support | Required host behavior, upstream gap, and bounded adaptation. |
| Stable pinned behavior | Required behavior, upstream drift/unavailability, immutable revision, and why upstream cannot provide it. |
| Package repair or repackaging | Broken/incompatible upstream structure and the smallest repair. |
| Behavioral variation | Intentional difference, user value, compatibility cost, and why a wrapper/configuration is insufficient. |

Reject a proposal based only on convenience, unchanged mirroring,
discoverability, generic future-proofing, or unsubstantiated preference.

Consider this order before a fork:

1. use upstream directly;
2. configure or adapt at the boundary;
3. add a local Profile or Layer;
4. create a wrapper only when necessary; then
5. create a local modified variant only when a permitted category remains.

## Provenance and license gate

Record all of the following:

- source identifier and source-group directory;
- upstream owner, repository, canonical URL, and original package path;
- selected upstream tag/ref and immutable resolved commit SHA;
- required upstream author attribution;
- applicable license identifier, license text location, and notices;
- compatibility of that license with planned local distribution; and
- snapshot date and method.

A missing or incompatible license blocks admission. Carry required license text
and notices with the modified package unless the license requires another
equally visible documented location.

## Bounded-change gate

Define the smallest local change set before import:

- rationale for every local change;
- affected files or package elements;
- behavior preserved from upstream;
- intentional behavior changes and compatibility effects;
- known differences and limitations;
- rollback/removal path; and
- independent runtime and relevant interaction-boundary tests.

Reject a fork when a Profile, Layer, configuration, boundary adaptation, or
wrapper solves the actual need.

## Required records

Before release, complete:

| Record | Required content |
| --- | --- |
| source README | Source identity, grouped packages, source-wide attribution/licensing, original-upstream versus local-modified installation, synchronization, and release status. |
| package UPSTREAM.md | Original identity/path, immutable revision, license, fork rationale, upstream and local installation, synchronization, and differences. |
| package PATCHES.md | Every local change, rationale, revision, reapplication status, conflict decision, and regression evidence. |
| package license/notices | Applicable license text and notices. |
| UPSTREAM_LOCK.json entry | Source/package identity, immutable revision, license, record paths, sync date, and modified installation reference. |

Use [templates/UPSTREAM.md](../templates/UPSTREAM.md),
[templates/PATCHES.md](../templates/PATCHES.md), and
[templates/SOURCE_README.md](../templates/SOURCE_README.md). The completed
source and package records are the human-readable provenance authority; the
lock file is the repository-wide inventory.

## Synchronization and installation gate

Define upstream change detection, owner/cadence, patch reapplication/rebase,
conflict escalation, post-sync regression and interaction tests, original
upstream installation source, local modified installation source/release pin,
manual fallback, and post-install verification.

Installer syntax is not evidence. Publish a command only after testing the
actual released package and source group on the intended host.

## Decision and pre-release checklist

Independent review must confirm concrete direct-upstream insufficiency,
complete provenance/license/revision, bounded changes, complete records,
feasible synchronization/removal, independent local runtime evidence, and
relevant interaction-boundary evidence. It returns PASS, FAIL, or BLOCKED.

- [ ] Direct upstream installation was evaluated.
- [ ] Permitted fork category and concrete evidence are recorded.
- [ ] Boundary, Profile/Layer, and wrapper alternatives were considered.
- [ ] Source, path, URL, tag/ref, and resolved commit are recorded.
- [ ] License compatibility, text, and notices are identified.
- [ ] Local changes, known differences, and behavioral effects are recorded.
- [ ] Source README, package records, license/notices, and lock entry exist.
- [ ] Synchronization, conflict, regression, installation, and removal plans
      are defined.
- [ ] Original-upstream and local-modified installation paths are distinct.
- [ ] Independent runtime and relevant interaction evidence is recorded before
      release.

# Third-Party Maintenance

## Operating rule

Maintain each admitted package as a documented modification of a specific
immutable upstream revision. A local package must never become an anonymous
snapshot or drift without updated provenance, patch, and synchronization
records.

The repository is governance-only today. These steps apply once a package has
passed admission.

## Current synchronization baseline

There are currently no source groups, modified packages, or lock entries.
CATALOG.md is the human-readable source inventory and UPSTREAM_LOCK.json
remains the authoritative empty machine-readable inventory. Direct-use
upstream Skills stay outside this repository.

## Upstream change detection

Each source README and package UPSTREAM.md must state:

- upstream canonical repository and original package path;
- tracked branch, tag, release feed, or inspection point;
- owner/cadence for checks;
- last checked date;
- last synchronized ref and resolved commit; and
- relevant security, license, compatibility, or deprecation notices.

Record the resolved commit in UPSTREAM_LOCK.json. A moving branch name alone
does not meet the revision requirement.

## Synchronization workflow

1. Read the source README, UPSTREAM.md, PATCHES.md, lock entry,
   license/notices, release notes, and existing evidence.
2. Inspect the declared upstream reference and choose a candidate immutable
   revision.
3. Re-evaluate the concrete fork reason. If upstream now satisfies it, start
   removal instead of synchronization.
4. Obtain a fresh package snapshot without merging upstream Git history into
   this repository.
5. Reapply or rebase documented local patches one at a time and update each
   patch status.
6. Stop on conflicts or unclear behavior. Record the issue; do not silently
   choose a resolution.
7. Review upstream license, notices, package structure, host compatibility,
   and behavioral changes.
8. Run defined regression, independent runtime, installation, and relevant
   interaction-boundary tests.
9. Update source/package records, license/notices, lock entry, installation
   evidence, and release notes together.
10. Obtain required review before publishing.

## Conflicts and regressions

A conflict, license change, missing source, failed installation, behavior
regression, or failed independent test blocks release. Preserve the
last-known-good package and records while investigating. A static diff,
Markdown parse, or fixture cannot be reported as runtime validation.

If the proper resolution materially changes local scope or requirements, return
to admission review rather than treating it as routine rebase work.

## Documentation synchronization

For an add, update, rename, deprecation, synchronization, or removal, update
or deliberately review:

- root README;
- source catalog;
- source README;
- package UPSTREAM.md and PATCHES.md;
- license and notice files;
- UPSTREAM_LOCK.json;
- installation guidance and evidence;
- test/review evidence; and
- release notes.

Remove stale installer commands and references in the same change. Retain
provenance and release history as required by license obligations and project
retention policy.

## Release, removal, and rollback

Before release, confirm matching immutable revisions across human records and
the lock entry; complete compatible license/notices; explicit local patches and
differences; verified modified-installation behavior; original-upstream
installation that is not redirected here; and independent runtime/interaction
evidence where applicable.

If upstream eliminates the concrete fork need, prefer deprecation/removal and
direct users to upstream. For a faulty local release, preserve provenance,
identify the last known-good release, update installation guidance through the
authorized release process, and document the rollback decision. Do not erase
upstream facts or patch history.

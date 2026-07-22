# Local Patch Record: <skill-id>

This is the complete local-change ledger. Keep one entry for every
behavior-affecting, compatibility, packaging, licensing, or documentation
change from the selected upstream snapshot. Do not hide several changes in an
unexplained synchronization note.

## Package baseline

- **Source group:** <source-id>
- **Original upstream repository/path:** <owner/repository and path>
- **Upstream tag/ref:** <value>
- **Resolved upstream commit:** <full SHA>
- **Local package release/commit:** <value>
- **Last synchronized:** <YYYY-MM-DD>

## Patch entries

### P0001 — <short title>

- **Status:** <active | reapplied | replaced | dropped | reverted>
- **Local files affected:** <paths>
- **Upstream baseline affected:** <paths or behavior>
- **Rationale:** <link to concrete fork need>
- **Change summary:** <what changed>
- **Behavior preserved:** <what remains compatible>
- **Intentional difference/compatibility impact:** <what differs>
- **Reapplication or rebase steps:** <ordered method>
- **Conflict decision:** <none or durable decision/evidence>
- **Regression evidence:** <test/receipt link>
- **Last reviewed:** <YYYY-MM-DD>

Copy this section for every patch. A synchronization that eliminates a patch
must retain the entry as dropped or reverted and explain why.

## Patch-set review

- **All local differences accounted for:** <yes/no and evidence>
- **Known untracked differences:** <none or blocker>
- **Independent runtime evidence:** <link>
- **Interaction-boundary evidence:** <link or not applicable with reason>
- **Next synchronization trigger:** <release, date, or event>

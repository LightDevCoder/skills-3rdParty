# blader/humanizer external dependency

This source group records the authoritative upstream for the `humanizer`
package, which is admitted as an **external direct dependency**: it is
deliberately not copied into `skills/`, and is installed from its authoritative
upstream source instead. This state is one of the three allowed by
[THIRD_PARTY_ADMISSION.md](../../docs/THIRD_PARTY_ADMISSION.md).

## Identity

- Repository: https://github.com/blader/humanizer
- Skill location: repository root is the skill (`SKILL.md` at root)
- Selected tag: `v2.9.1`
- Resolved commit: `523374dee72d67c7b2b5f858ea0094ffda49c3ac`
- License: MIT (`LICENSE` at upstream repository root)
- Upstream author/notice: blader and contributors; preserve the upstream license.
- Homepage: https://skills.sh/blader/humanizer

## What it is

An agent skill (writing editor) that identifies and removes signs of
AI-generated writing: inflated symbolism, promotional language, superficial
-ing analyses, vague attributions, em dash overuse, rule of three, AI
vocabulary words, passive voice, negative parallelisms, and filler phrases.
Based on Wikipedia's "Signs of AI writing" guide (WikiProject AI Cleanup),
version 2.9.1.

## Why external direct dependency

- The collection's pinned-mirror tooling and allowlist are scoped to the
  23-package `mattpocock/skills` snapshot; a second mirrored upstream would
  require extending the sync tooling, manifest schema, and tests.
- Mirroring is not required by the admission policy; copying for convenience
  is explicitly not a fork reason. The authoritative upstream is public, MIT,
  and installable directly.
- The upstream publishes installers for common harnesses (Claude Code
  marketplace, manual copy), which keeps installation reproducible without a
  local snapshot.

## Installation and update

- **Manual fallback:** copy the complete upstream repository root (`SKILL.md`,
  `README.md`, `AGENTS.md`, `scripts/`, `agents/`, `.claude-plugin/`) into the
  host's recognized Skills root.
- **Claude Code:** `/plugin marketplace add blader/humanizer`.
- **Update source:** track the upstream repository; pin a new tag/ref and
  resolved commit in [config/external-dependencies.json](../../config/external-dependencies.json)
  and [UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json) before relying on a newer
  revision.

## Record

- Machine record: [config/external-dependencies.json](../../config/external-dependencies.json)
- Lock entry: `external_dependencies` in [UPSTREAM_LOCK.json](../../UPSTREAM_LOCK.json)
- Admission decision: user-requested 2026-08-10

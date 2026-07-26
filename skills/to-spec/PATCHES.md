# Local Patch Record: to-spec

- **Upstream revision:** v1.1.0 (d574778f94cf620fcc8ce741584093bc650a61d3)
- **Local state:** metadata-adapter-only; no upstream behavior patch.
- **Allowed local paths:** `agents/openai.yaml`, `UPSTREAM.md`, `PATCHES.md`, `LICENSE`

## P0001 — Collection host metadata adapter

- **Status:** active
- **Local file:** `agents/openai.yaml`
- **Rationale:** make display name, description, default prompt, and explicit
  invocation policy available to metadata-aware hosts and `ask-light`.
- **Behavior preserved:** all upstream `SKILL.md`, scripts, references, assets,
  and templates are copied without modification.
- **Compatibility impact:** none to the upstream Skill contract; the adapter
  is ignored by hosts that do not consume it.
- **Regression evidence:** `tests/third-party-collection-tests.ps1` and the
  release evidence under `docs/evidence/releases/`.

## Patch-set review

- All upstream file differences are hash-checked by `sync-upstream.ps1`.
- Any change to an upstream-managed file fails `-Mode check` until explicitly
  reviewed and represented by a new patch record.

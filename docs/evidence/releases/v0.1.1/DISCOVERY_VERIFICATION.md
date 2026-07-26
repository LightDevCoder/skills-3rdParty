# v0.1.1 Discovery Verification

[中文验证](DISCOVERY_VERIFICATION.zh-CN.md)

Status: `PASS` — the tagged artifact was installed into fresh destinations
and listed successfully without a source checkout.

## Fresh artifact observations

- Whole install: `npx --yes skills add LightDevCoder/skills-3rdParty#v0.1.1 --yes --copy --agent codex`
  exited 0; exactly 23 packages were listed by `npx --yes skills list`.
- Single install: the same tagged command with `--skill grill-with-docs`
  exited 0; exactly `grill-with-docs` was listed.
- Both destinations had no `skills/` source checkout.
- The whole destination contained the dependency peers `grilling` and
  `domain-modeling`; the single destination did not silently install either
  peer.
- All installed packages retained their complete resources; the single
  `grill-with-docs` package contained `SKILL.md`, `agents/openai.yaml`,
  `LICENSE`, `UPSTREAM.md`, and `PATCHES.md`.
- The whole install was repeated successfully and reported `overwrites: Codex`
  for all 23 packages.

## Structural command

```text
powershell -File tests/third-party-collection-tests.ps1
```

Observed local result: `THIRD_PARTY_COLLECTION_ASSERTIONS=959`,
`THIRD_PARTY_COLLECTION=PASS`. This is collection/resource evidence; it does
not prove host refresh or model-mediated runtime behavior.

# v0.1.1 Limitations

[中文限制](LIMITATIONS.zh-CN.md)

- `PASS`: Fresh private whole-collection and per-Skill installation were run
  against tag `v0.1.1` with CLI `1.5.20`; the private repository was reachable
  in the authenticated verification environment.
- `PASS`: GitHub Actions quality run `30189147755` passed on the release line.
- `BLOCKED`: An independent `review-loop agent-skill` evaluator record is not
  present; same-context inspection cannot be labeled independent.
- Host-specific Skill refresh behavior and model-mediated runtime invocation
  remain untested.
- `agents/openai.yaml` is a local metadata adapter because the selected
  upstream packages do not provide it; it does not prove host-specific loading.
- Upstream `wayfinder` includes an example Markdown `link` placeholder; it is
  preserved as upstream content and is not treated as a local resource.
- Peer dependencies are declared and tested as install boundaries, not as
  hidden imports: `grill-me` needs `grilling`, and `grill-with-docs` needs
  `grilling` plus `domain-modeling` when a workflow explicitly uses them.

# v0.1.1 Limitations

- The collection is private; consumers need repository access credentials.
- The Skills CLI `#ref` pin was confirmed from official source semantics, but a
  fresh private-repository install must still be recorded for this release.
- `agents/openai.yaml` is a local metadata adapter because the selected upstream
  packages do not provide it; it does not prove host-specific loading.
- Upstream `wayfinder` includes an example Markdown `link` placeholder; it is
  preserved as upstream content and is not treated as a local resource.
- Other Agent hosts, global scopes, and host-specific refresh behavior remain
  `NOT TESTED` until evidence is captured.
- Independent final review remains `BLOCKED` until a fresh reviewer record is
  supplied.

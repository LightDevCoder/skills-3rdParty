# Installation and Fresh-Install Verification

[简体中文](INSTALLATION.zh-CN.md)

This private collection is intended to be installed from the published
repository, not from a source checkout. Release `v0.1.1` points to commit
`a891d39d7f34793d857c5b8eec3429c23871f421`. A consumer must also have access to
the private GitHub repository through configured Git credentials, SSH, or an
authenticated CLI.

## Revision semantics

The official Skills CLI accepts GitHub shorthand and GitHub tree URLs, and its
source parser also accepts a `#ref` fragment. Therefore these commands pin the
published local collection release:

```text
npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --yes --copy --agent codex
npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill grill-with-docs --yes --copy --agent codex
```

The first `v0.1.1` is the local repository tag. The mirrored Matt package
content is independently pinned in `UPSTREAM_LOCK.json` to upstream
`v1.1.0` / `d574778f94cf620fcc8ce741584093bc650a61d3`. A shorthand without
`#v0.1.1` resolves the repository's default revision and is not described as
immutable.

## Fresh installation procedure

1. Create an empty destination project with no source checkout of this
   repository present.
2. Run the whole-collection or single-package command above with the exact CLI
   version recorded in the release evidence.
3. Confirm the destination contains the selected complete package(s), including
   `SKILL.md`, `agents/openai.yaml`, references, scripts, templates, assets,
   `LICENSE`, and provenance records.
4. Refresh or restart the Agent host and verify discovery from the destination,
   not from this repository.
5. Repeat the same command and record whether the installer is idempotent.
6. Smoke-test a successful package, a stopping boundary, a missing peer
   dependency, and the explicit invocation policy.

The actual CLI `1.5.20` fresh-install result is recorded in [release
evidence](evidence/releases/v0.1.1/INSTALLATION_VERIFICATION.md).

## Manual fallback

When the installer cannot authenticate to the private repository, manually
copy a complete package from a checkout of the published tag `v0.1.1`:

```powershell
$sourceRoot = '<v0.1.1-release-checkout>'
$skillName = '<skill-name>'
$destinationRoot = '<host-recognized-skills-root>'
Copy-Item -LiteralPath (Join-Path $sourceRoot "skills/$skillName") `
  -Destination (Join-Path $destinationRoot $skillName) -Recurse
```

Do not copy only `SKILL.md`. If a linked file is absent, discovery or runtime
use is not proven; mark the result `BLOCKED` or `NOT TESTED`.

## What this repository does not claim

- The public `skills` repository does not contain these third-party packages.
- The local release pin does not make upstream `v1.1.0` current forever.
- A source-checkout scan is not fresh-host discovery.
- A metadata file is not proof that the host actually loaded the Skill.

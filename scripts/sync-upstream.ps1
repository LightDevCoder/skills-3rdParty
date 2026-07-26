[CmdletBinding()]
param(
    [ValidateSet('check', 'dry-run', 'sync', 'diff', 'resource', 'unauthorized-patch')]
    [string]$Mode = 'check',
    [string]$Root = '',
    [string]$UpstreamRoot = ''
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent $PSScriptRoot }
$Root = (Resolve-Path -LiteralPath $Root).Path
if ([string]::IsNullOrWhiteSpace($UpstreamRoot)) {
    $UpstreamRoot = Join-Path $Root '..\..\sources\mattpocock-skills'
}
$UpstreamRoot = (Resolve-Path -LiteralPath $UpstreamRoot).Path
$allowlistPath = Join-Path $Root 'config/upstream-allowlist.json'
$manifestPath = Join-Path $Root 'UPSTREAM_LOCK.json'
$skillRoot = Join-Path $Root 'skills'

function Write-Utf8 {
    param([string]$Path, [string]$Text)
    $parent = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    [IO.File]::WriteAllText($Path, $Text, [Text.UTF8Encoding]::new($false))
}

function Read-JsonFile {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "JSON file is missing: $Path" }
    return Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
}

function Get-FullPath {
    param([string]$Path)
    return [IO.Path]::GetFullPath($Path).TrimEnd('\')
}

function Test-Contained {
    param([string]$Path, [string]$Parent)
    $child = Get-FullPath $Path
    $root = Get-FullPath $Parent
    return $child.Equals($root, [StringComparison]::OrdinalIgnoreCase) -or
        $child.StartsWith($root + '\', [StringComparison]::OrdinalIgnoreCase)
}

function Get-RelativeFiles {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) { return @() }
    $base = (Resolve-Path -LiteralPath $Path).Path.TrimEnd('\')
    return @(Get-ChildItem -LiteralPath $base -Recurse -File -Force |
        ForEach-Object { $_.FullName.Substring($base.Length + 1).Replace('\', '/') } |
        Sort-Object)
}

function Get-Sha256 {
    param([string]$Path)
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Invoke-UpstreamGit {
    param([string[]]$Arguments)
    $safe = "safe.directory=$UpstreamRoot"
    $output = & git -c $safe -C $UpstreamRoot @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) { throw "git failed in upstream checkout: $($output -join "`n")" }
    return (($output -join "`n").Trim())
}

function Get-UpstreamCommit {
    param([string]$Revision)
    return Invoke-UpstreamGit @('rev-parse', "$Revision^{commit}")
}

function Get-ManifestEntries {
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) { return @() }
    $manifest = Read-JsonFile $manifestPath
    return @($manifest.entries)
}

function Get-Frontmatter {
    param([string]$Path)
    $text = Get-Content -Raw -LiteralPath $Path
    $match = [regex]::Match($text, '(?ms)^---\r?\n(?<body>.*?)\r?\n---')
    if (-not $match.Success) { throw "SKILL.md has no complete frontmatter: $Path" }
    $body = $match.Groups['body'].Value
    $nameMatch = [regex]::Match($body, '(?m)^name:\s*(?<value>.+?)\s*$')
    $descriptionMatch = [regex]::Match($body, '(?m)^description:\s*(?<value>.+?)\s*$')
    if (-not $nameMatch.Success -or -not $descriptionMatch.Success) { throw "SKILL.md frontmatter is incomplete: $Path" }
    $name = $nameMatch.Groups['value'].Value.Trim().Trim('"').Trim("'")
    $description = $descriptionMatch.Groups['value'].Value.Trim().Trim('"').Trim("'")
    [pscustomobject]@{
        name = $name
        description = $description
        allowImplicitInvocation = -not ($body -match '(?m)^disable-model-invocation:\s*true\s*$')
    }
}

function Get-LocalAllowedPaths {
    return @('agents/openai.yaml', 'UPSTREAM.md', 'PATCHES.md', 'LICENSE')
}

function Get-UnauthorizedLocalFiles {
    param([string]$Destination, [string[]]$UpstreamFiles)
    $allowed = Get-LocalAllowedPaths
    return @(Get-RelativeFiles $Destination | Where-Object {
        $UpstreamFiles -notcontains $_ -and $allowed -notcontains $_
    })
}

function Get-ReferencedResources {
    param([string]$PackagePath)
    $body = Get-Content -Raw -LiteralPath (Join-Path $PackagePath 'SKILL.md')
    $links = [regex]::Matches($body, '\]\(([^)]+)\)') |
        ForEach-Object { $_.Groups[1].Value.Split('#')[0].Split('?')[0] } |
        Where-Object { $_ -and $_ -notmatch '^(https?|mailto):' -and $_ -notmatch '^/' -and $_ -notmatch '^<.*>$' -and $_ -notmatch '^(link|path|url)$' } |
        Select-Object -Unique
    $missing = [System.Collections.Generic.List[string]]::new()
    foreach ($link in $links) {
        $candidate = Join-Path $PackagePath $link
        if (-not (Test-Contained $candidate $PackagePath) -or -not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            $missing.Add($link)
        }
    }
    return @($missing)
}

function Get-IgnoredUpstreamFiles {
    param($Package)
    $status = Invoke-UpstreamGit @('status', '--ignored', '--porcelain', '--untracked-files=all', '--', $Package.upstream_path)
    return @($status -split "`n" | Where-Object { $_ -match '^!!\s+' })
}

function New-AgentMetadata {
    param($Package, [string]$Destination)
    $front = Get-Frontmatter (Join-Path $Destination 'SKILL.md')
    $title = [Globalization.CultureInfo]::InvariantCulture.TextInfo.ToTitleCase(($Package.name -replace '-', ' '))
    $short = $front.description.Replace('"', '\"')
    $prompt = ('Use $' + $Package.name + ' when this task matches its upstream contract; preserve its explicit stopping boundary.')
    $metadata = @(
        'interface:',
        ('  display_name: "' + $title + '"'),
        ('  short_description: "' + $short + '"'),
        ('  default_prompt: "' + $prompt.Replace('"', '\"') + '"'),
        '',
        'policy:',
        ('  allow_implicit_invocation: ' + ($(if ($front.allowImplicitInvocation) { 'true' } else { 'false' })))
    ) -join "`n"
    Write-Utf8 (Join-Path $Destination 'agents/openai.yaml') ($metadata + "`n")
}

function New-ProvenanceFiles {
    param($Package, [string]$Destination, [string]$Revision, [string]$Commit)
    $front = Get-Frontmatter (Join-Path $Destination 'SKILL.md')
    $deps = if (@($Package.dependencies).Count -gt 0) { (@($Package.dependencies) -join ', ') } else { 'none' }
    $upstream = @(
        "# Upstream Record: $($Package.name)",
        '',
        'This package is a pinned upstream snapshot with a local host-metadata adapter.',
        'The upstream Skill instructions and referenced resources are preserved.',
        '',
        '## Identity',
        '',
        "- **Source group:** $($Package.source_group)",
        "- **Package:** $($Package.name)",
        '- **Upstream repository:** `mattpocock/skills`',
        '- **Canonical URL:** https://github.com/mattpocock/skills',
        "- **Original package path:** $($Package.upstream_path)",
        "- **Selected upstream tag:** $Revision",
        "- **Resolved commit:** $Commit",
        '- **Applicable license:** MIT; see `LICENSE` in this package.',
        '- **Upstream author/notice:** Matt Pocock and contributors; preserve the upstream license.',
        '',
        '## Local packaging state',
        '',
        '- **State:** pinned upstream snapshot with metadata-adapter-only local change.',
        '- **Local patch:** `agents/openai.yaml` supplies the host metadata required by',
        '  this collection''s discovery checks; it does not alter `SKILL.md` behavior or',
        '  upstream resources.',
        '- **Why the adapter exists:** the upstream package does not ship this',
        '  collection-specific `agents/openai.yaml`; omitting it makes metadata-aware',
        '  discovery unable to report invocation policy reliably.',
        "- **Dependencies:** $deps. These are declared peer Skills, not hidden runtime",
        '  imports. Install them separately when a workflow explicitly needs them.',
        '- **Navigation boundary:** `ask-matt` remains a router and does not execute or',
        '  install the Skills it mentions.',
        '',
        '## Installation and update',
        '',
        '- **Whole collection (target after the local v0.1.1 release gate):** npx skills add LightDevCoder/skills-3rdParty#v0.1.1',
        "- **Single package (target after the local v0.1.1 release gate):** npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill $($Package.name)",
        "- **Manual fallback:** copy this complete skills/$($Package.name)/ directory",
        "  into the host's recognized Skills root.",
        '- **Update source:** run `scripts/sync-upstream.ps1 -Mode check` against the',
        '  pinned checkout; review upstream diff, then use `-Mode sync` only after the',
        '  allowlist and revision are approved.',
        '',
        '## Differences and evidence',
        '',
        '- **Upstream behavior preserved:** yes, for the upstream package files listed',
        '  in `UPSTREAM_LOCK.json`.',
        '- **Local difference:** metadata adapter and this provenance record only.',
        '- **Known limitations:** host-specific discovery and private-repository access',
        '  remain dependent on the installer and credentials used by the consumer.',
        '- **Patch record:** `PATCHES.md`',
        "- **Lock entry:** UPSTREAM_LOCK.json entry $($Package.name)"
    ) -join "`n"
    $patches = @(
        "# Local Patch Record: $($Package.name)",
        '',
        "- **Upstream revision:** $Revision ($Commit)",
        '- **Local state:** metadata-adapter-only; no upstream behavior patch.',
        '- **Allowed local paths:** `agents/openai.yaml`, `UPSTREAM.md`, `PATCHES.md`, `LICENSE`',
        '',
        '## P0001 — Collection host metadata adapter',
        '',
        '- **Status:** active',
        '- **Local file:** `agents/openai.yaml`',
        '- **Rationale:** make display name, description, default prompt, and explicit',
        '  invocation policy available to metadata-aware hosts and `ask-light`.',
        '- **Behavior preserved:** all upstream `SKILL.md`, scripts, references, assets,',
        '  and templates are copied without modification.',
        '- **Compatibility impact:** none to the upstream Skill contract; the adapter',
        '  is ignored by hosts that do not consume it.',
        '- **Regression evidence:** `tests/third-party-collection-tests.ps1` and the',
        '  release evidence under `docs/evidence/releases/`.',
        '',
        '## Patch-set review',
        '',
        '- All upstream file differences are hash-checked by `sync-upstream.ps1`.',
        '- Any change to an upstream-managed file fails `-Mode check` until explicitly',
        '  reviewed and represented by a new patch record.'
    ) -join "`n"
    Write-Utf8 (Join-Path $Destination 'UPSTREAM.md') ($upstream.Trim() + "`n")
    Write-Utf8 (Join-Path $Destination 'PATCHES.md') ($patches.Trim() + "`n")
    Copy-Item -LiteralPath (Join-Path $UpstreamRoot 'LICENSE') -Destination (Join-Path $Destination 'LICENSE') -Force
}

function Get-FileRecords {
    param([string]$Destination, [string[]]$UpstreamFiles)
    return @($UpstreamFiles | ForEach-Object {
        $filePath = Join-Path $Destination $_
        [ordered]@{ path = $_; sha256 = Get-Sha256 $filePath; bytes = (Get-Item -LiteralPath $filePath).Length }
    })
}

function Get-EntryChecksum {
    param($Files)
    $serialized = (@($Files | ForEach-Object { "$($_.path):$($_.sha256)" }) -join "`n")
    $bytes = [Text.UTF8Encoding]::new($false).GetBytes($serialized)
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant() }
    finally { $sha.Dispose() }
}

function Get-CollectionChecksum {
    param($Entries)
    $serialized = (@($Entries | ForEach-Object { "$($_.package_name):$($_.checksum)" }) -join "`n")
    $bytes = [Text.UTF8Encoding]::new($false).GetBytes($serialized)
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant() }
    finally { $sha.Dispose() }
}

function Get-LocalPatchChecksum {
    param([string]$Destination)
    $paths = @(Get-LocalAllowedPaths)
    foreach ($path in $paths) {
        if (-not (Test-Path -LiteralPath (Join-Path $Destination $path) -PathType Leaf)) {
            return ''
        }
    }
    return Get-EntryChecksum (Get-FileRecords $Destination $paths)
}

function Sync-OnePackage {
    param($Package, [string]$Revision, [string]$Commit)
    $source = Join-Path $UpstreamRoot $Package.upstream_path
    $destination = Join-Path $skillRoot $Package.name
    if (-not (Test-Contained $source $UpstreamRoot)) { throw "Unsafe upstream path: $($Package.upstream_path)" }
    if (-not (Test-Path -LiteralPath $source -PathType Container)) { throw "Upstream package is missing: $($Package.upstream_path)" }
    $sourceFiles = Get-RelativeFiles $source
    if (-not ($sourceFiles -contains 'SKILL.md')) { throw "Upstream package lacks SKILL.md: $($Package.name)" }
    $oldEntry = @(Get-ManifestEntries | Where-Object package_name -eq $Package.name | Select-Object -First 1)
    if (Test-Path -LiteralPath $destination -PathType Container) {
        if ($oldEntry.Count -eq 0 -and (Get-RelativeFiles $destination).Count -gt 0) {
            throw "$($Package.name) cannot be synced over an existing package without a manifest entry"
        }
        $knownManagedFiles = @($sourceFiles)
        if ($oldEntry.Count -gt 0) { $knownManagedFiles += @($oldEntry[0].files | ForEach-Object path) }
        $unauthorized = @(Get-UnauthorizedLocalFiles $destination $knownManagedFiles)
        if ($unauthorized.Count -gt 0) {
            throw "$($Package.name) has unauthorized local files: $($unauthorized -join ', ')"
        }
        if ($oldEntry.Count -gt 0) {
            if ([string]::IsNullOrWhiteSpace([string]$oldEntry[0].local_patch_checksum)) {
                throw "$($Package.name) manifest lacks a local patch checksum; refusing to overwrite local records"
            }
            $localPatchChecksum = Get-LocalPatchChecksum $destination
            if ([string]::IsNullOrWhiteSpace($localPatchChecksum) -or $localPatchChecksum -ne [string]$oldEntry[0].local_patch_checksum) {
                throw "$($Package.name) has unauthorized local modification: local patch records"
            }
            foreach ($relative in $sourceFiles) {
                $existing = Join-Path $destination $relative
                if (-not (Test-Path -LiteralPath $existing -PathType Leaf)) { continue }
                if (@($oldEntry[0].files | Where-Object path -eq $relative).Count -eq 0) {
                    throw "$($Package.name) has an unrecorded local file colliding with new upstream resource: $relative"
                }
                $record = @($oldEntry[0].files | Where-Object path -eq $relative | Select-Object -First 1)
                if ($record.Count -eq 1 -and (Get-Sha256 $existing) -ne $record[0].sha256) {
                    throw "$($Package.name) has unauthorized local modification: $relative"
                }
            }
        }
    }
    if ((Test-Path -LiteralPath $destination -PathType Container) -and $oldEntry.Count -gt 0) {
        $oldFiles = @($oldEntry[0].files | ForEach-Object path)
        foreach ($old in $oldFiles | Where-Object { $sourceFiles -notcontains $_ -and (Get-LocalAllowedPaths) -notcontains $_ }) {
            $stale = Join-Path $destination $old
            if ((Test-Contained $stale $destination) -and (Test-Path -LiteralPath $stale -PathType Leaf)) {
                $record = @($oldEntry[0].files | Where-Object path -eq $old | Select-Object -First 1)
                if ($record.Count -eq 1 -and (Get-Sha256 $stale) -ne $record[0].sha256) {
                    throw "$($Package.name) has unauthorized local modification: $old"
                }
                Remove-Item -LiteralPath $stale -Force
            }
        }
    }
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    foreach ($relative in $sourceFiles) {
        $from = Join-Path $source $relative
        $to = Join-Path $destination $relative
        if (-not (Test-Contained $to $destination)) { throw "Unsafe destination path: $relative" }
        $parent = Split-Path -Parent $to
        if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        Copy-Item -LiteralPath $from -Destination $to -Force
    }
    New-AgentMetadata $Package $destination
    New-ProvenanceFiles $Package $destination $Revision $Commit
    $missing = Get-ReferencedResources $destination
    if ($missing.Count -gt 0) { throw "$($Package.name) has missing referenced resources: $($missing -join ', ')" }
    [pscustomobject]@{ name = $Package.name; files = $sourceFiles.Count; destination = $destination }
}

function Build-Manifest {
    param($Config, [string]$Revision, [string]$Commit)
    $entries = [System.Collections.Generic.List[object]]::new()
    foreach ($package in @($Config.packages)) {
        $destination = Join-Path $skillRoot $package.name
        $source = Join-Path $UpstreamRoot $package.upstream_path
        $sourceFiles = Get-RelativeFiles $source
        $files = Get-FileRecords $destination $sourceFiles
        $entry = [ordered]@{
            package_name = $package.name
            source_group = $package.source_group
            source_state = 'pinned-upstream-mirror'
            upstream_repository = 'mattpocock/skills'
            upstream_package_path = $package.upstream_path
            local_package_path = ('skills/' + $package.name)
            pinned_revision = $Revision
            resolved_commit = $Commit
            checksum = Get-EntryChecksum $files
            files = @($files)
            local_modification_state = 'metadata-adapter-only'
            local_patch_paths = @('agents/openai.yaml', 'UPSTREAM.md', 'PATCHES.md', 'LICENSE')
            local_patch_checksum = Get-LocalPatchChecksum $destination
            upstream_snapshot = $true
            dependency_state = [ordered]@{
                state = if (@($package.dependencies).Count -gt 0) { 'declared-peer-dependency' } else { 'none' }
                packages = @($package.dependencies)
                writing_great_skills_is_authoring_knowledge_only = ($package.name -eq 'writing-great-skills')
                learn_anything_runtime_dependency = $false
            }
            license_path = ('skills/' + $package.name + '/LICENSE')
            provenance_path = ('skills/' + $package.name + '/UPSTREAM.md')
            patch_record_path = ('skills/' + $package.name + '/PATCHES.md')
            referenced_resource_check = [ordered]@{ missing = @(Get-ReferencedResources $destination); source_file_count = $sourceFiles.Count }
        }
        $entries.Add($entry)
    }
    $collectionChecksum = Get-CollectionChecksum $entries
    $manifest = [ordered]@{
        schema_version = 2
        repository = 'LightDevCoder/skills-3rdParty'
        visibility = 'private'
        source_kind = 'pinned-upstream-mirror-with-collection-metadata-adapter'
        source_states = [ordered]@{
            pinned_upstream_mirror = [ordered]@{ copied = $true; record = 'Complete package snapshot at a pinned upstream revision; collection metadata adapters are recorded as local patches.' }
            modified_upstream_fork = [ordered]@{ copied = $false; record = 'Requires a concrete compatibility or behavior-difference rationale and an explicit patch review before admission.' }
            external_direct_dependency = [ordered]@{ copied = $false; record = 'Record the authoritative upstream source and revision; do not copy the package into this collection.' }
        }
        upstream = [ordered]@{
            repository = 'mattpocock/skills'
            url = 'https://github.com/mattpocock/skills'
            selected_tag = $Revision
            resolved_commit = $Commit
            license = 'MIT'
            license_source = 'LICENSE at upstream repository root'
        }
        allowlist = @($Config.packages | ForEach-Object name)
        collection_checksum = $collectionChecksum
        generated_utc = (Get-Date).ToUniversalTime().ToString('o')
        installation = [ordered]@{
            whole_collection = 'npx skills add LightDevCoder/skills-3rdParty#v0.1.1'
            single_skill = 'npx skills add LightDevCoder/skills-3rdParty#v0.1.1 --skill <skill-name>'
            revision_semantics = 'The #v0.1.1 fragment pins the local collection release; the mirrored package content is pinned to upstream v1.1.0 and its resolved commit.'
        }
        entries = @($entries)
    }
    Write-Utf8 $manifestPath (($manifest | ConvertTo-Json -Depth 16) + "`n")
}

function Test-Manifest {
    param($Config, [string]$Revision, [string]$Commit)
    $failures = [System.Collections.Generic.List[string]]::new()
    $manifest = Read-JsonFile $manifestPath
    $manifestEntries = @(Get-ManifestEntries)
    if ($manifestEntries.Count -ne @($Config.packages).Count) { $failures.Add("manifest entry count $($manifestEntries.Count) does not equal allowlist count $(@($Config.packages).Count)") }
    $manifestNames = @($manifestEntries | ForEach-Object package_name | Sort-Object)
    $allowNames = @($Config.packages | ForEach-Object name | Sort-Object)
    if (($manifestNames -join ',') -ne ($allowNames -join ',')) { $failures.Add('manifest names do not exactly match the selected allowlist') }
    $manifestAllowNames = @($manifest.allowlist | ForEach-Object { [string]$_ } | Sort-Object)
    if (($manifestAllowNames -join ',') -ne ($allowNames -join ',')) { $failures.Add('manifest allowlist names do not exactly match config/upstream-allowlist.json') }
    foreach ($state in @('pinned_upstream_mirror', 'modified_upstream_fork', 'external_direct_dependency')) {
        if ($null -eq $manifest.source_states.$state) { $failures.Add("manifest source state is missing: $state") }
    }
    foreach ($package in @($Config.packages)) {
        $entry = @($manifestEntries | Where-Object package_name -eq $package.name | Select-Object -First 1)
        if ($entry.Count -eq 0) { $failures.Add("missing manifest entry: $($package.name)"); continue }
        if ($entry[0].resolved_commit -ne $Commit) { $failures.Add("$($package.name) resolved commit is not $Commit") }
        if ([string]$entry[0].source_state -ne 'pinned-upstream-mirror') { $failures.Add("$($package.name) source state is not pinned-upstream-mirror") }
        if ([string]$entry[0].source_group -ne [string]$package.source_group) { $failures.Add("$($package.name) source group does not match the allowlist") }
        if ([string]$entry[0].upstream_package_path -ne [string]$package.upstream_path) { $failures.Add("$($package.name) upstream package path does not match the allowlist") }
        if ([string]$entry[0].local_package_path -ne ('skills/' + $package.name)) { $failures.Add("$($package.name) local package path is not canonical") }
        if ([string]$entry[0].license_path -ne ('skills/' + $package.name + '/LICENSE')) { $failures.Add("$($package.name) license path is not canonical") }
        if ([string]$entry[0].provenance_path -ne ('skills/' + $package.name + '/UPSTREAM.md')) { $failures.Add("$($package.name) provenance path is not canonical") }
        if ([string]$entry[0].patch_record_path -ne ('skills/' + $package.name + '/PATCHES.md')) { $failures.Add("$($package.name) patch record path is not canonical") }
        if ([string]$entry[0].checksum -ne (Get-EntryChecksum $entry[0].files)) { $failures.Add("$($package.name) package checksum does not match its manifest file records") }
        if ([string]::IsNullOrWhiteSpace([string]$entry[0].local_patch_checksum)) { $failures.Add("$($package.name) local patch checksum is missing") }
        $source = Join-Path $UpstreamRoot $package.upstream_path
        $destination = Join-Path $skillRoot $package.name
        if (-not (Test-Path -LiteralPath $source -PathType Container)) { $failures.Add("missing upstream package: $($package.upstream_path)"); continue }
        if (-not (Test-Path -LiteralPath $destination -PathType Container)) { $failures.Add("missing local package: skills/$($package.name)"); continue }
        $sourceFiles = Get-RelativeFiles $source
        $manifestFiles = @($entry[0].files | ForEach-Object path | Sort-Object)
        if (($sourceFiles -join ',') -ne ($manifestFiles -join ',')) { $failures.Add("$($package.name) manifest resources differ from pinned upstream") }
        foreach ($relative in $sourceFiles) {
            $path = Join-Path $destination $relative
            if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { $failures.Add("$($package.name) missing upstream resource: $relative"); continue }
            $expected = @($entry[0].files | Where-Object path -eq $relative | Select-Object -First 1)
            $actualHash = Get-Sha256 $path
            if ($expected.Count -eq 0 -or $actualHash -ne $expected[0].sha256) { $failures.Add("$($package.name) unauthorized local modification: $relative") }
        }
        foreach ($extra in @(Get-UnauthorizedLocalFiles $destination $sourceFiles)) {
            $failures.Add("$($package.name) unauthorized local file: $extra")
        }
        if (-not [string]::IsNullOrWhiteSpace([string]$entry[0].local_patch_checksum) -and (Get-LocalPatchChecksum $destination) -ne [string]$entry[0].local_patch_checksum) {
            $failures.Add("$($package.name) unauthorized local patch record modification")
        }
        foreach ($required in @('SKILL.md', 'agents/openai.yaml', 'UPSTREAM.md', 'PATCHES.md', 'LICENSE')) {
            if (-not (Test-Path -LiteralPath (Join-Path $destination $required) -PathType Leaf)) { $failures.Add("$($package.name) missing required package file: $required") }
        }
        $missing = Get-ReferencedResources $destination
        if ($missing.Count -gt 0) { $failures.Add("$($package.name) missing referenced resources: $($missing -join ', ')") }
        $provenance = Get-Content -Raw -LiteralPath (Join-Path $destination 'UPSTREAM.md')
        if ($provenance -notmatch [regex]::Escape("# Upstream Record: $($package.name)")) { $failures.Add("$($package.name) provenance package identity does not match the manifest") }
        if ($provenance -notmatch [regex]::Escape("- **Original package path:** $($package.upstream_path)")) { $failures.Add("$($package.name) provenance upstream path does not match the manifest") }
        if ($provenance -notmatch [regex]::Escape("UPSTREAM_LOCK.json entry $($package.name)")) { $failures.Add("$($package.name) provenance lock entry does not match the manifest") }
        $front = Get-Frontmatter (Join-Path $destination 'SKILL.md')
        $metadata = Get-Content -Raw -LiteralPath (Join-Path $destination 'agents/openai.yaml')
        foreach ($marker in @('display_name:', 'short_description:', 'default_prompt:', 'allow_implicit_invocation:')) {
            if ($metadata -notmatch [regex]::Escape($marker)) { $failures.Add("$($package.name) metadata missing $marker") }
        }
        if ($metadata -notmatch ('allow_implicit_invocation:\s*' + $(if ($front.allowImplicitInvocation) { 'true' } else { 'false' }))) { $failures.Add("$($package.name) metadata invocation policy disagrees with upstream frontmatter") }
    }
    $orderedEntries = [System.Collections.Generic.List[object]]::new()
    foreach ($package in @($Config.packages)) {
        $entry = @($manifestEntries | Where-Object package_name -eq $package.name | Select-Object -First 1)
        if ($entry.Count -eq 1) { $orderedEntries.Add($entry[0]) }
    }
    if ([string]$manifest.collection_checksum -ne (Get-CollectionChecksum $orderedEntries)) { $failures.Add('manifest collection checksum does not match package checksums') }
    $actualPackages = @(Get-ChildItem -LiteralPath $skillRoot -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name | Sort-Object)
    if (($actualPackages -join ',') -ne ($allowNames -join ',')) { $failures.Add('local skills/ package directories do not exactly match the 23-Skill allowlist') }
    return @($failures)
}

$config = Read-JsonFile $allowlistPath
$revision = [string]$config.upstream_tag
$expectedCommit = [string]$config.upstream_commit
$resolvedCommit = Get-UpstreamCommit $revision
if ($resolvedCommit -ne $expectedCommit) { throw "Pinned upstream revision mismatch: expected $expectedCommit, got $resolvedCommit" }
$headCommit = Invoke-UpstreamGit @('rev-parse', 'HEAD')
if ($headCommit -ne $expectedCommit) { throw "Upstream checkout HEAD mismatch: expected $expectedCommit, got $headCommit" }
$upstreamStatus = Invoke-UpstreamGit @('status', '--porcelain', '--untracked-files=all')
if (-not [string]::IsNullOrWhiteSpace($upstreamStatus)) {
    throw "Upstream checkout is dirty; refusing to read working-tree content under the pinned commit: $upstreamStatus"
}
foreach ($package in @($config.packages)) {
    $ignored = @(Get-IgnoredUpstreamFiles $package)
    if ($ignored.Count -gt 0) {
        throw "Upstream checkout contains ignored files under $($package.upstream_path); refusing to read working-tree content: $($ignored -join '; ')"
    }
}

if ($Mode -eq 'dry-run') {
    foreach ($package in @($config.packages)) {
        $source = Join-Path $UpstreamRoot $package.upstream_path
        if (-not (Test-Path -LiteralPath $source -PathType Container)) { throw "Missing upstream package: $($package.upstream_path)" }
        Write-Output ("DRY-RUN sync {0} <= {1} ({2} files)" -f $package.name, $package.upstream_path, (Get-RelativeFiles $source).Count)
    }
    Write-Output "DRY-RUN revision $revision ($resolvedCommit)"
    exit 0
}

if ($Mode -eq 'sync') {
    foreach ($package in @($config.packages)) {
        $result = Sync-OnePackage $package $revision $resolvedCommit
        Write-Output ("SYNCED {0}: {1} upstream files" -f $result.name, $result.files)
    }
    Build-Manifest $config $revision $resolvedCommit
}

if ($Mode -eq 'diff') {
    $manifestEntries = @(Get-ManifestEntries)
    foreach ($package in @($config.packages)) {
        $entry = @($manifestEntries | Where-Object package_name -eq $package.name | Select-Object -First 1)
        $source = Join-Path $UpstreamRoot $package.upstream_path
        $destination = Join-Path $skillRoot $package.name
        if (-not (Test-Path -LiteralPath $destination)) { Write-Output "DIFF $($package.name): local package missing"; continue }
        foreach ($relative in (Get-RelativeFiles $source)) {
            $path = Join-Path $destination $relative
            if (-not (Test-Path -LiteralPath $path)) { Write-Output "DIFF $($package.name): missing $relative"; continue }
            $expected = @($entry[0].files | Where-Object path -eq $relative | Select-Object -First 1)
            if ($expected.Count -eq 0 -or (Get-Sha256 $path) -ne $expected[0].sha256) { Write-Output "DIFF $($package.name): changed $relative" }
        }
        foreach ($extra in @(Get-UnauthorizedLocalFiles $destination (Get-RelativeFiles $source))) {
            Write-Output "DIFF $($package.name): unauthorized local file $extra"
        }
        $entryPatchChecksum = [string]$entry[0].local_patch_checksum
        if ([string]::IsNullOrWhiteSpace($entryPatchChecksum) -or (Get-LocalPatchChecksum $destination) -ne $entryPatchChecksum) {
            Write-Output "DIFF $($package.name): unauthorized local patch record"
        }
    }
    exit 0
}

if ($Mode -eq 'resource') {
    $resourceFailures = @(Test-Manifest $config $revision $resolvedCommit | Where-Object { $_ -match 'resource|missing|manifest resources|referenced' })
    if ($resourceFailures.Count -gt 0) {
        $resourceFailures | ForEach-Object { Write-Output "FAIL: $_" }
        throw "UPSTREAM_SYNC=resource FAIL ($($resourceFailures.Count) failures)"
    }
    Write-Output "UPSTREAM_SYNC=resource PASS ($(@($config.packages).Count) packages, complete resources verified)"
    exit 0
}

if ($Mode -eq 'unauthorized-patch') {
    $patchFailures = @(Test-Manifest $config $revision $resolvedCommit | Where-Object { $_ -match 'unauthorized|local patch|extra|modification' })
    if ($patchFailures.Count -gt 0) {
        $patchFailures | ForEach-Object { Write-Output "FAIL: $_" }
        throw "UPSTREAM_SYNC=unauthorized-patch FAIL ($($patchFailures.Count) failures)"
    }
    Write-Output "UPSTREAM_SYNC=unauthorized-patch PASS ($(@($config.packages).Count) packages, local patch boundary verified)"
    exit 0
}

$failures = @(Test-Manifest $config $revision $resolvedCommit)
if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Output "FAIL: $_" }
    throw "UPSTREAM_SYNC=$Mode FAIL ($($failures.Count) failures)"
}
Write-Output "UPSTREAM_SYNC=$Mode PASS ($(@($config.packages).Count) packages, pinned $revision/$resolvedCommit)"

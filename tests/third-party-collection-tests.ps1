[CmdletBinding()]
param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$UpstreamRoot = ''
)

$ErrorActionPreference = 'Stop'
$script:assertions = 0
$script:failures = [System.Collections.Generic.List[string]]::new()
if ([string]::IsNullOrWhiteSpace($UpstreamRoot)) { $UpstreamRoot = Join-Path $Root '..\..\sources\mattpocock-skills' }
$UpstreamRoot = (Resolve-Path -LiteralPath $UpstreamRoot).Path
$syncScript = Join-Path $Root 'scripts/sync-upstream.ps1'

function Assert-ThirdParty {
    param([bool]$Condition, [string]$Message)
    $script:assertions++
    if (-not $Condition) { $script:failures.Add($Message) }
}

function Read-Json {
    param([string]$Path)
    return Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
}

function Hash-File {
    param([string]$Path)
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Relative-Files {
    param([string]$Path)
    $base = (Resolve-Path -LiteralPath $Path).Path.TrimEnd('\')
    return @(Get-ChildItem -LiteralPath $base -Recurse -File -Force |
        ForEach-Object { $_.FullName.Substring($base.Length + 1).Replace('\', '/') } |
        Sort-Object)
}

function Frontmatter {
    param([string]$Path)
    $body = Get-Content -Raw -LiteralPath $Path
    $match = [regex]::Match($body, '(?ms)^---\r?\n(?<front>.*?)\r?\n---')
    if (-not $match.Success) { return [pscustomobject]@{ name = ''; allow = $null } }
    $front = $match.Groups['front'].Value
    $name = [regex]::Match($front, '(?m)^name:\s*(.+?)\s*$').Groups[1].Value.Trim().Trim('"').Trim("'")
    [pscustomobject]@{ name = $name; allow = -not ($front -match '(?m)^disable-model-invocation:\s*true\s*$') }
}

function Run-Script {
    param([string]$Mode, [string]$ScriptRoot = $Root, [string]$ScriptUpstream = $UpstreamRoot)
    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $syncScript -Mode $Mode -Root $ScriptRoot -UpstreamRoot $ScriptUpstream 2>&1
    [pscustomobject]@{ exitCode = $LASTEXITCODE; output = ($output -join "`n") }
}

$allowlist = Read-Json (Join-Path $Root 'config/upstream-allowlist.json')
$manifest = Read-Json (Join-Path $Root 'UPSTREAM_LOCK.json')
$expected = @('ask-matt','codebase-design','code-review','design-an-interface','diagnosing-bugs','domain-modeling','grilling','grill-me','grill-with-docs','handoff','implement','improve-codebase-architecture','loop-me','prototype','qa','research','tdd','teach','to-spec','to-tickets','ubiquitous-language','wayfinder','writing-great-skills')
$names = @($allowlist.packages | ForEach-Object name | Sort-Object)
Assert-ThirdParty (($names -join ',') -eq (@($expected | Sort-Object) -join ',')) 'allowlist is exactly the requested 23 Skill names'
Assert-ThirdParty ($manifest.entries.Count -eq 23) 'manifest has exactly 23 entries'
Assert-ThirdParty ($manifest.allowlist.Count -eq 23) 'manifest allowlist has exactly 23 entries'
Assert-ThirdParty ($manifest.upstream.selected_tag -eq 'v1.1.0') 'manifest records upstream tag v1.1.0'
Assert-ThirdParty ($manifest.upstream.resolved_commit -eq 'd574778f94cf620fcc8ce741584093bc650a61d3') 'manifest records the pinned upstream commit'
Assert-ThirdParty ($manifest.visibility -eq 'private') 'third-party repository remains private in manifest'
Assert-ThirdParty ($manifest.source_kind -match 'pinned-upstream-mirror') 'manifest distinguishes pinned upstream mirror state'

$skillRoot = Join-Path $Root 'skills'
$actualDirs = @(Get-ChildItem -LiteralPath $skillRoot -Directory | Select-Object -ExpandProperty Name | Sort-Object)
Assert-ThirdParty (($actualDirs -join ',') -eq (@($expected | Sort-Object) -join ',')) 'skills directory has no package outside the allowlist'

foreach ($package in @($allowlist.packages)) {
    $entry = @($manifest.entries | Where-Object package_name -eq $package.name | Select-Object -First 1)
    Assert-ThirdParty ($entry.Count -eq 1) "$($package.name) has exactly one manifest entry"
    if ($entry.Count -ne 1) { continue }
    $entry = $entry[0]
    $source = Join-Path $UpstreamRoot $package.upstream_path
    $destination = Join-Path $Root ('skills/' + $package.name)
    Assert-ThirdParty (Test-Path -LiteralPath (Join-Path $destination 'SKILL.md') -PathType Leaf) "$($package.name) has SKILL.md"
    Assert-ThirdParty (Test-Path -LiteralPath (Join-Path $destination 'agents/openai.yaml') -PathType Leaf) "$($package.name) has agents/openai.yaml"
    Assert-ThirdParty (Test-Path -LiteralPath (Join-Path $destination 'LICENSE') -PathType Leaf) "$($package.name) has a license copy"
    Assert-ThirdParty (Test-Path -LiteralPath (Join-Path $destination 'UPSTREAM.md') -PathType Leaf) "$($package.name) has UPSTREAM.md"
    Assert-ThirdParty (Test-Path -LiteralPath (Join-Path $destination 'PATCHES.md') -PathType Leaf) "$($package.name) has PATCHES.md"
    $sourceFiles = Relative-Files $source
    $manifestFiles = @($entry.files | ForEach-Object path | Sort-Object)
    Assert-ThirdParty ($entry.files -is [array]) "$($package.name) manifest files field is an array"
    Assert-ThirdParty (($sourceFiles -join ',') -eq ($manifestFiles -join ',')) "$($package.name) manifest resources equal upstream resources"
    foreach ($file in $sourceFiles) {
        $local = Join-Path $destination $file
        $record = @($entry.files | Where-Object path -eq $file | Select-Object -First 1)
        Assert-ThirdParty ($record.Count -eq 1) "$($package.name) records $file"
        Assert-ThirdParty (Test-Path -LiteralPath $local -PathType Leaf) "$($package.name) contains $file"
        if ($record.Count -eq 1 -and (Test-Path -LiteralPath $local -PathType Leaf)) {
            Assert-ThirdParty ((Hash-File $local) -eq $record[0].sha256) "$($package.name) preserves the upstream hash for $file"
        }
    }
    $metadata = Get-Content -Raw -LiteralPath (Join-Path $destination 'agents/openai.yaml')
    foreach ($field in @('display_name:', 'short_description:', 'default_prompt:', 'allow_implicit_invocation:')) {
        Assert-ThirdParty ($metadata -match [regex]::Escape($field)) "$($package.name) metadata has $field"
    }
    $front = Frontmatter (Join-Path $destination 'SKILL.md')
    Assert-ThirdParty ($front.name -eq $package.name) "$($package.name) frontmatter name matches allowlist"
    Assert-ThirdParty ($metadata -match ('allow_implicit_invocation:\s*' + $(if ($front.allow) { 'true' } else { 'false' }))) "$($package.name) invocation metadata agrees with frontmatter"
    Assert-ThirdParty ((Get-Content -Raw -LiteralPath (Join-Path $destination 'UPSTREAM.md')) -match [regex]::Escape([string]$manifest.upstream.resolved_commit)) "$($package.name) provenance records the resolved commit"
    Assert-ThirdParty ((Get-Content -Raw -LiteralPath (Join-Path $destination 'PATCHES.md')) -match 'P0001') "$($package.name) has a local patch ledger"
    Assert-ThirdParty ($entry.local_modification_state -eq 'metadata-adapter-only') "$($package.name) local modification state is explicit"
    Assert-ThirdParty ((@($entry.referenced_resource_check.missing).Count -eq 0)) "$($package.name) has no missing referenced resources"
}

$grillMe = @($manifest.entries | Where-Object package_name -eq 'grill-me')[0]
$grillDocs = @($manifest.entries | Where-Object package_name -eq 'grill-with-docs')[0]
Assert-ThirdParty ((@($grillMe.dependency_state.packages) -join ',') -eq 'grilling') 'grill-me retains grilling dependency'
Assert-ThirdParty ((@($grillDocs.dependency_state.packages | Sort-Object) -join ',') -eq 'domain-modeling,grilling') 'grill-with-docs retains grilling and domain-modeling dependencies'
$writing = @($manifest.entries | Where-Object package_name -eq 'writing-great-skills')[0]
Assert-ThirdParty ($writing.dependency_state.writing_great_skills_is_authoring_knowledge_only -eq $true) 'writing-great-skills is authoring knowledge only'
Assert-ThirdParty ($writing.dependency_state.learn_anything_runtime_dependency -eq $false) 'learn-anything has no hidden writing-great-skills runtime dependency'

$paired = @(
    @('README.md','README.zh-CN.md'), @('CATALOG.md','CATALOG.zh-CN.md'), @('CHANGELOG.md','CHANGELOG.zh-CN.md'),
    @('docs/INSTALLATION.md','docs/INSTALLATION.zh-CN.md'), @('docs/MAINTENANCE.md','docs/MAINTENANCE.zh-CN.md'),
    @('docs/THIRD_PARTY_ADMISSION.md','docs/THIRD_PARTY_ADMISSION.zh-CN.md'), @('docs/PROVENANCE_POLICY.md','docs/PROVENANCE_POLICY.zh-CN.md'),
    @('docs/UPDATE_POLICY.md','docs/UPDATE_POLICY.zh-CN.md'), @('docs/REVIEW_POLICY.md','docs/REVIEW_POLICY.zh-CN.md'),
    @('sources/mattpocock-skills/README.md','sources/mattpocock-skills/README.zh-CN.md')
)
foreach ($pair in $paired) {
    $enPath = Join-Path $Root $pair[0]; $zhPath = Join-Path $Root $pair[1]
    Assert-ThirdParty (Test-Path -LiteralPath $enPath -PathType Leaf) "English pair exists: $($pair[0])"
    Assert-ThirdParty (Test-Path -LiteralPath $zhPath -PathType Leaf) "Chinese pair exists: $($pair[1])"
    if ((Test-Path -LiteralPath $enPath) -and (Test-Path -LiteralPath $zhPath)) {
        $en = Get-Content -Raw -LiteralPath $enPath; $zh = Get-Content -Raw -LiteralPath $zhPath
        Assert-ThirdParty ($en -match [regex]::Escape($pair[1].Split('/')[-1])) "$($pair[0]) links its Chinese counterpart"
        Assert-ThirdParty ($zh -match [regex]::Escape($pair[0].Split('/')[-1])) "$($pair[1]) links its English counterpart"
    }
}

$docs = @('README.md','README.zh-CN.md','CATALOG.md','CATALOG.zh-CN.md','CHANGELOG.md','CHANGELOG.zh-CN.md') + @(Get-ChildItem -LiteralPath (Join-Path $Root 'docs') -Recurse -Filter '*.md' -File | ForEach-Object { $_.FullName.Substring($Root.Length + 1).Replace('\','/') }) + @('sources/mattpocock-skills/README.md','sources/mattpocock-skills/README.zh-CN.md')
foreach ($file in $docs) {
    $path = Join-Path $Root $file
    if (-not (Test-Path -LiteralPath $path)) { continue }
    $text = Get-Content -Raw -LiteralPath $path
    foreach ($match in [regex]::Matches($text, '\[[^\]]+\]\(([^)]+)\)')) {
        $link = $match.Groups[1].Value.Split('#')[0]
        if ([string]::IsNullOrWhiteSpace($link) -or $link -match '^(https?|mailto):') { continue }
        $resolved = Join-Path (Split-Path -Parent $path) $link
        Assert-ThirdParty (Test-Path -LiteralPath $resolved) "$file has a resolvable relative link: $link"
    }
}

$check = Run-Script 'check'
Assert-ThirdParty ($check.exitCode -eq 0 -and $check.output -match 'UPSTREAM_SYNC=check PASS') 'sync check passes with real assertions'
$dry = Run-Script 'dry-run'
Assert-ThirdParty ($dry.exitCode -eq 0 -and $dry.output -match 'DRY-RUN revision') 'sync dry-run is non-writing and reports the pinned revision'

$fixture = Join-Path ([IO.Path]::GetTempPath()) ('third-party-negative-' + [guid]::NewGuid().ToString('N'))
try {
    Copy-Item -LiteralPath $Root -Destination $fixture -Recurse -Force
    $mutated = Join-Path $fixture 'skills/ask-matt/SKILL.md'
    Add-Content -LiteralPath $mutated -Value "`nlocal unauthorized mutation fixture`n"
    $negative = Run-Script 'check' $fixture $UpstreamRoot
    Assert-ThirdParty ($negative.exitCode -ne 0 -and $negative.output -match 'unauthorized local modification') 'unauthorized upstream-file mutation fails check'
} finally {
    if (Test-Path -LiteralPath $fixture) { Remove-Item -LiteralPath $fixture -Recurse -Force }
}

if ($script:failures.Count -gt 0) {
    $script:failures | ForEach-Object { "FAIL: $_" }
    throw "THIRD_PARTY_COLLECTION=FAIL ($($script:failures.Count) failures, $($script:assertions) assertions)"
}
"THIRD_PARTY_COLLECTION_ASSERTIONS=$($script:assertions)"
'THIRD_PARTY_COLLECTION=PASS'

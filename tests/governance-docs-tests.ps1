param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
$script:assertions = 0
$script:failures = @()

function Assert-Governance {
    param(
        [bool]$Condition,
        [string]$Message
    )

    $script:assertions++
    if (-not $Condition) {
        $script:failures += $Message
    }
}

$required = @(
    "README.md",
    "CATALOG.md",
    "AGENTS.md",
    "CHANGELOG.md",
    "UPSTREAM_LOCK.json",
    "docs/INSTALLATION.md",
    "docs/MAINTENANCE.md",
    "docs/THIRD_PARTY_ADMISSION.md"
)
foreach ($path in $required) {
    Assert-Governance (Test-Path -LiteralPath (Join-Path $Root $path)) "Required path is missing: $path"
}

$lock = Get-Content -LiteralPath (Join-Path $Root "UPSTREAM_LOCK.json") -Raw | ConvertFrom-Json
$expectedPackages = @(
    "ask-matt", "codebase-design", "code-review", "design-an-interface",
    "diagnosing-bugs", "domain-modeling", "grilling", "grill-me",
    "grill-with-docs", "handoff", "implement", "improve-codebase-architecture",
    "loop-me", "prototype", "qa", "research", "tdd", "teach", "to-spec",
    "to-tickets", "ubiquitous-language", "wayfinder", "writing-great-skills"
)
$actualPackages = @(Get-ChildItem -LiteralPath (Join-Path $Root "skills") -Directory | Select-Object -ExpandProperty Name | Sort-Object)
Assert-Governance ($lock.entries.Count -eq 23) "Pinned collection must record exactly 23 upstream entries."
Assert-Governance ((@($lock.allowlist | ForEach-Object { [string]$_ } | Sort-Object) -join ",") -eq (@($expectedPackages | Sort-Object) -join ",")) "Manifest allowlist must equal the approved 23-package set."
Assert-Governance (($actualPackages -join ",") -eq (@($expectedPackages | Sort-Object) -join ",")) "Installed package directories must equal the approved 23-package set."
Assert-Governance (@(Get-ChildItem -LiteralPath (Join-Path $Root "skills") -Recurse -Filter "SKILL.md" -File).Count -eq 23) "Pinned collection must contain one complete Skill contract per package."
Assert-Governance ($lock.visibility -eq "private") "Third-party collection must remain private."
Assert-Governance ($lock.upstream.selected_tag -eq "v1.1.0" -and $lock.upstream.resolved_commit -eq "d574778f94cf620fcc8ce741584093bc650a61d3") "Manifest must pin the declared upstream tag and resolved commit."

$catalog = Get-Content -LiteralPath (Join-Path $Root "CATALOG.md") -Raw
$installation = Get-Content -LiteralPath (Join-Path $Root "docs/INSTALLATION.md") -Raw
$readme = Get-Content -LiteralPath (Join-Path $Root "README.md") -Raw
$admission = Get-Content -LiteralPath (Join-Path $Root "docs/THIRD_PARTY_ADMISSION.md") -Raw
Assert-Governance (($catalog -match "\| engineering \|") -and ($catalog -match "\| productivity \|") -and ($catalog -match "\| deprecated \|") -and ($catalog -match "\| in-progress \|")) "Catalog must record all four upstream source groups."
Assert-Governance ($catalog -match "23 selected Matt Pocock Skills") "Catalog must record the selected collection size."
Assert-Governance ($installation -match "npx skills add LightDevCoder/skills-3rdParty#v0\.1\.1") "Installation guide must provide the pinned collection command."
Assert-Governance ($installation -match "npx skills add LightDevCoder/skills-3rdParty#v0\.1\.1 --skill") "Installation guide must provide the pinned single-Skill command."
Assert-Governance ($installation -match "not published yet|targets, not installation evidence") "Unpublished release targets must remain explicitly labeled."
Assert-Governance ($catalog -match "v0\.1\.1") "Catalog must record the current release gate."
Assert-Governance ($readme -match "v0\.1\.1") "README must record the current release gate."
Assert-Governance ($installation -match "Manual fallback") "Installation guidance must retain a manual fallback."
Assert-Governance ($readme -match "Pinned upstream mirror" -and $readme -match "External direct dependency" -and $readme -match "Modified upstream fork") "README must preserve all third-party source-state boundaries."
Assert-Governance ($installation -match "private collection" -and $installation -match "mirrored Matt\s+package") "Installation guide must distinguish the private collection from its upstream content."
Assert-Governance ($admission -match "concrete" -and $admission -match "fork") "Admission policy must retain concrete fork-necessity wording."

$documentationFiles = @("README.md", "CATALOG.md", "CHANGELOG.md", "AGENTS.md") + @(rg --files docs)
foreach ($file in $documentationFiles) {
    $filePath = Join-Path $Root $file
    $text = Get-Content -LiteralPath $filePath -Raw
    foreach ($match in [regex]::Matches($text, "\[[^\]]+\]\(([^)]+)\)")) {
        $link = $match.Groups[1].Value.Split("#")[0]
        if ($link -match "^https?://" -or [string]::IsNullOrWhiteSpace($link)) {
            continue
        }
        $resolved = Join-Path (Split-Path -Parent $filePath) $link
        Assert-Governance (Test-Path -LiteralPath $resolved) "$file contains an unresolved relative link: $link"
    }
}

if ($script:failures.Count -gt 0) {
    $script:failures | ForEach-Object { "FAIL: $_" }
    throw "GOVERNANCE_DOCS=FAIL ($($script:failures.Count) failures, $($script:assertions) assertions)"
}

"GOVERNANCE_DOCS_ASSERTIONS=$($script:assertions)"
"GOVERNANCE_DOCS=PASS"

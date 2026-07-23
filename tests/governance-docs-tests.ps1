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
Assert-Governance ($lock.entries.Count -eq 0) "Governance-only target must have an empty upstream lock."
Assert-Governance (-not (Get-ChildItem -LiteralPath $Root -Recurse -Filter "SKILL.md" -File)) "Governance-only target must contain no Skill package."

$catalog = Get-Content -LiteralPath (Join-Path $Root "CATALOG.md") -Raw
$installation = Get-Content -LiteralPath (Join-Path $Root "docs/INSTALLATION.md") -Raw
$readme = Get-Content -LiteralPath (Join-Path $Root "README.md") -Raw
$admission = Get-Content -LiteralPath (Join-Path $Root "docs/THIRD_PARTY_ADMISSION.md") -Raw
Assert-Governance ($catalog -match "Source groups \| 0") "Catalog must record zero source groups."
Assert-Governance ($catalog -match "Modified packages \| 0") "Catalog must record zero modified packages."
Assert-Governance ($installation -match "npx skills add <owner>/<repository> --skill <skill-name>") "Installation template is missing."
Assert-Governance ($installation -match "no usable local installation command") "Empty installation state must be explicit."
Assert-Governance ($catalog -match "v0\.1\.0") "Catalog must record the stable governance release."
Assert-Governance ($readme -match "v0\.1\.0") "README must record the stable governance release."
Assert-Governance ($installation -match "Manual fallback") "Installation guidance must retain a manual fallback."
Assert-Governance ($readme -match "governance-only" -and $readme -match "unchanged upstream") "README must preserve governance-only and direct-upstream boundaries."
Assert-Governance ($installation -match "Original unchanged upstream Skill" -and $installation -match "Locally modified third-party Skill") "Installation guide must distinguish upstream and modified paths."
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

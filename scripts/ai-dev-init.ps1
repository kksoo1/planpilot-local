param(
    [switch]$Force
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$aiDevDirectory = Join-Path $projectRoot ".ai-dev"

$requiredFiles = @(
    ".ai-dev/goal.md",
    ".ai-dev/queue.example.json",
    ".ai-dev/state.example.json"
)

$missingFiles = @()
$createdFiles = @()
$skippedFiles = @()

foreach ($relativePath in $requiredFiles) {
    $fullPath = Join-Path $projectRoot $relativePath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        $missingFiles += $relativePath
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "누락된 필수 파일:"
    foreach ($relativePath in $missingFiles) {
        Write-Host "  - $relativePath"
    }

    Write-Error "AI 개발 루프 초기화에 필요한 파일이 없습니다."
    exit 1
}

function Copy-ExampleFile {
    param(
        [string]$SourceRelativePath,
        [string]$TargetRelativePath
    )

    $sourcePath = Join-Path $projectRoot $SourceRelativePath
    $targetPath = Join-Path $projectRoot $TargetRelativePath

    if ((Test-Path -LiteralPath $targetPath -PathType Leaf) -and -not $Force) {
        $script:skippedFiles += $TargetRelativePath
        return
    }

    Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Force
    $script:createdFiles += $TargetRelativePath
}

function Write-MarkdownTemplate {
    param(
        [string]$TargetRelativePath,
        [string]$Content
    )

    $targetPath = Join-Path $projectRoot $TargetRelativePath

    if ((Test-Path -LiteralPath $targetPath -PathType Leaf) -and -not $Force) {
        $script:skippedFiles += $TargetRelativePath
        return
    }

    $utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($targetPath, $Content, $utf8WithoutBom)
    $script:createdFiles += $TargetRelativePath
}

if (-not (Test-Path -LiteralPath $aiDevDirectory -PathType Container)) {
    Write-Error ".ai-dev 폴더가 없습니다."
    exit 1
}

Copy-ExampleFile ".ai-dev/queue.example.json" ".ai-dev/queue.json"
Copy-ExampleFile ".ai-dev/state.example.json" ".ai-dev/state.json"

$markdownTemplates = [ordered]@{
    ".ai-dev/plan.md" = "# AI Dev Plan`r`n`r`n아직 계획이 생성되지 않았습니다.`r`n"
    ".ai-dev/loop-log.md" = "# AI Dev Loop Log`r`n`r`n아직 실행 기록이 없습니다.`r`n"
    ".ai-dev/test-result.md" = "# AI Dev Test Result`r`n`r`n아직 테스트가 실행되지 않았습니다.`r`n"
    ".ai-dev/review.md" = "# AI Dev Review`r`n`r`n아직 리뷰가 실행되지 않았습니다.`r`n"
}

foreach ($entry in $markdownTemplates.GetEnumerator()) {
    Write-MarkdownTemplate $entry.Key $entry.Value
}

Write-Host "생성된 파일:"
if ($createdFiles.Count -eq 0) {
    Write-Host "  - 없음"
} else {
    foreach ($relativePath in $createdFiles) {
        Write-Host "  - $relativePath"
    }
}

Write-Host "이미 존재해서 건너뛴 파일:"
if ($skippedFiles.Count -eq 0) {
    Write-Host "  - 없음"
} else {
    foreach ($relativePath in $skippedFiles) {
        Write-Host "  - $relativePath"
    }
}

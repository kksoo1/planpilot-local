# AI Dev Diff

## Generated At

2026-07-09 23:01:42

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-run-codex.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-run-codex.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-run-codex.ps1 | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-run-codex.ps1 b/scripts/ai-dev-run-codex.ps1
index d91e711..0556efc 100644
--- a/scripts/ai-dev-run-codex.ps1
+++ b/scripts/ai-dev-run-codex.ps1
@@ -118,7 +118,45 @@ function New-CodexPrompt {
         [string]$PromptFilePath
     )
 
-    return "Read and follow the full task prompt at this absolute file path: $PromptFilePath"
+    return @"
+Read and follow the full task prompt at this absolute file path: $PromptFilePath
+
+Additional safety rules for this local AI Dev Loop run:
+- Do not run git commit, git reset, git checkout, git clean, git rebase, git merge, or git push.
+- Do not run npm install.
+- Do not modify package.json, package-lock.json, node_modules, dist, or .git.
+- Do not broaden the current task scope beyond the prompt file.
+- If the task requirements conflict with repository rules, stop and report the conflict.
+"@
+}
+
+function New-RunCommandText {
+    $arguments = @(
+        "-ExecutionPolicy",
+        "Bypass",
+        "-File",
+        "scripts/ai-dev-run-codex.ps1"
+    )
+
+    if ($PromptPath -ne ".ai-dev/current-task-prompt.md") {
+        $arguments += "-PromptPath"
+        $arguments += $promptRelativePath
+    }
+
+    if ($ResultPath -ne ".ai-dev/codex-result.md") {
+        $arguments += "-ResultPath"
+        $arguments += $resultRelativePath
+    }
+
+    if ($AllowDirty) {
+        $arguments += "-AllowDirty"
+    }
+
+    if ($GeneratePromptIfMissing) {
+        $arguments += "-GeneratePromptIfMissing"
+    }
+
+    return "powershell $($arguments -join ' ')"
 }
 
 Set-Location $repoRoot
@@ -161,15 +199,17 @@ if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
 }
 
 $codexPrompt = New-CodexPrompt $resolvedPromptPath
-$commandText = "codex exec <short wrapper pointing to $promptRelativePath>"
+$commandText = New-RunCommandText
 
 if ($DryRun) {
     $message = @"
 Codex 구현 실행 DryRun입니다.
+- EntryPoint: scripts/ai-dev-run-codex.ps1
 - Repository: $repoRoot
 - Prompt: $promptRelativePath
 - Result: $resultRelativePath
 - Command: $commandText
+- CodexCommand: codex exec <wrapper prompt reading $promptRelativePath>
 - AllowDirty: $([bool]$AllowDirty)
 - DirtyCount: $($statusLines.Count)
 "@
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```
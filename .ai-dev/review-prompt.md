# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 App Change Files와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- .ai-dev 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# 목표
Codex 구현 실행 스크립트 추가

## 배경
현재 저장소의 P0 백로그 항목인 "Codex 구현 실행 스크립트 추가"를 현재 구조에 맞는 가장 작은 실행 가능한 개발 목표로 준비한다. 목표는 로컬 AI Dev Loop에서 Codex 구현 단계를 일관되게 실행할 수 있는 스크립트 초안을 추가하는 것이다.

## 성공 기준
- 저장소의 기존 스크립트/설정 구조를 확인한다.
- Codex 구현 실행에 필요한 최소 스크립트를 추가하거나 기존 설정에 연결한다.
- 실행 방법이 명확하게 드러나도록 필요한 최소 문서를 함께 정리한다.
- 변경 범위는 스크립트 추가와 직접 관련된 파일로 제한한다.

## 제약사항
- 한 번에 하나의 기능만 구현한다.
- 기존 프로젝트 구조와 명명 규칙을 따른다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 불필요한 대규모 재작성이나 추상화를 하지 않는다.
- lock file은 수정하지 않는다.

## 범위 제외
- 앱 UI 변경은 포함하지 않는다.
- 데이터베이스 스키마 변경은 포함하지 않는다.
- 알림, 동기화, 인증 기능은 포함하지 않는다.
- 배포 자동화나 외부 연동 확장은 포함하지 않는다.

## 수동 검증
- 추가된 스크립트 파일 또는 package script가 의도한 명령을 가리키는지 확인한다.
- 스크립트 실행 전 필요한 입력 파일 경로가 저장소 기준으로 올바른지 확인한다.
- 변경된 파일만 검토하여 범위가 과도하게 넓어지지 않았는지 확인한다.

## Current Task

- Task ID: T001
- Title: Codex 구현 실행 스크립트 추가
- Description: 현재 저장소의 스크립트 구조를 확인하고, Codex 구현 단계를 실행하기 위한 최소 스크립트 또는 설정 연결을 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 변경 파일을 확인해 스크립트 경로와 명령이 저장소 구조와 일치하는지 검토한다.
- 허용된 경우에만 관련 스크립트를 수동으로 실행해 동작을 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-09 23:01:35

- Overall result: passed
- Current task: T001
- Mode: BuildOnly (build + lint when available)
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: passed

### npm run build

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 build
> tsc -b && vite build

[36mvite v8.0.10 [32mbuilding client environment for production...[36m[39m
[2K
transforming...✓ 48 modules transformed.
rendering chunks...
computing gzip size...
dist/index.html                   0.46 kB │ gzip:   0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 259ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
package.json에 test script가 없습니다.
```
### npm run lint

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 lint
> eslint .
```

## Diff To Review

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

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 .ai-dev 운영 산출물이 구분되어 있는가
- .ai-dev 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

{
  "decision": "pass | revise | blocked",
  "severity": "none | low | medium | high | critical",
  "summary": "짧은 요약",
  "required_changes": [
    {
      "file": "파일 경로 또는 unknown",
      "reason": "수정이 필요한 이유",
      "suggestion": "구체적 수정 방향"
    }
  ],
  "optional_suggestions": [
    {
      "file": "파일 경로 또는 unknown",
      "suggestion": "선택 개선 의견"
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": []
  },
  "next_step": "complete_task | revise_with_codex | stop_for_user"
}

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요
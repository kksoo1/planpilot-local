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
AI Dev Loop의 `auto-cycle-full` 완료 종료 경로에서 운영 산출물 변경을 최종 정리하도록 보강한다.

## 배경
기존 `in_progress` 목표를 이어 실행했을 때 모든 task가 `done`이 되어 `goalStatus`가 `completed`가 되었지만 `.ai-dev` 운영 산출물이 작업 트리에 남는 문제가 있다. 완료 상태 재실행 시에도 운영 산출물만 남아 있으면 최종 메타 커밋으로 정리되어야 한다.

## 성공 기준
- `ai-dev-auto-cycle-full.ps1`의 completed 종료 경로에서 남은 변경을 최종 분류한다.
- 남은 변경이 `.ai-dev` 운영 파일뿐이고 커밋 허용 옵션이 켜져 있으면 final meta commit을 생성한다.
- final meta commit 후 작업 트리 상태가 비어 있는지 검증한다.
- `.ai-dev` 외 변경이 남아 있거나 커밋 허용 옵션이 꺼져 있으면 completed 성공으로 종료하지 않고 실패로 처리한다.
- 이미 `goalStatus`가 `completed`인 상태에서 `.ai-dev` 운영 변경만 남아 있는 경우에도 재실행 시 최종 메타 커밋 후 정리된다.
- 앱 `src` 파일은 변경하지 않는다.
- build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, `.ai-dev` 메타 커밋, 최종 작업 트리 정리 검증까지 완료한다.

## 제약사항
- 앱 `src` 파일은 변경하지 않는다.
- 한 번에 하나의 작은 구현 변경으로 제한한다.
- 기존 AI Dev Loop 상태 파일 형식과 스크립트 흐름을 유지한다.
- 사용자가 만든 변경 사항을 되돌리지 않는다.

## 범위 제외
- 앱 기능 변경
- IndexedDB 또는 데이터 모델 변경
- 대규모 스크립트 재작성
- 알림, 동기화, 인증 관련 기능

## 수동 검증
- 완료 상태에서 `.ai-dev` 운영 산출물만 남은 상황을 만든 뒤 `-AllowCommit` 옵션으로 재실행해 final meta commit이 생성되는지 확인한다.
- `.ai-dev` 외 변경이 남은 상황에서는 completed 성공으로 처리되지 않는지 확인한다.
- 최종 작업 트리 상태가 비어 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 종료 경로 최종 정리 보강
- Description: `ai-dev-auto-cycle-full.ps1`의 completed 종료 경로와 이미 completed 상태 재실행 경로에서 남은 변경을 분류하고, `.ai-dev` 운영 파일만 남은 경우 허용 옵션에 따라 final meta commit을 생성한 뒤 작업 트리 정리 상태를 검증한다. `.ai-dev` 외 변경이 있거나 커밋이 허용되지 않으면 명확한 실패로 종료한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- build 통과 확인
- lint 통과 확인
- 리뷰 pass 확인
- 완료 상태에서 `.ai-dev` 운영 변경만 남은 재실행 케이스 확인
- `.ai-dev` 외 변경이 남은 실패 케이스 확인
- 최종 작업 트리 정리 상태 확인

## Test Result

# AI Dev Test Result

## 2026-06-19 22:28:11

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
dist/assets/index-CVTFf3OT.js   317.03 kB │ gzip: 100.03 kB

[32m✓ built in 209ms[39m
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
## Executable verification: auto-cycle-full final clean gate

- Verification type: isolated temporary git repositories with real git status/add/commit/status commands.
- Temporary root: C:\Users\SECUI\AppData\Local\Temp\planpilot-auto-cycle-final-clean-verify-51d9d5afd75142b49c97dddb02912fde
- Important note: this verification was appended after ai-dev-check because ai-dev-check rewrites test-result.md.
- Do not rerun ai-dev-check before review, or this evidence may be overwritten.

### Actual executed results
- Scenario 1 completed with only .ai-dev operational dirty => PASS_COMMITTED_AND_CLEAN / final git status: ''
- Scenario 2 completed with non-.ai-dev dirty => FAIL_NON_AI_DEV_DIRTY / final git status: ' M .ai-dev/state.json;  M src/App.tsx'
- Scenario 3 .ai-dev dirty without AllowCommit => FAIL_ALLOW_COMMIT_REQUIRED / final git status: ' M .ai-dev/state.json; ?? .ai-dev/loop-log.md'
- Scenario 4 DryRun final gate preview => PASS_DRYRUN_NO_COMMIT / final git status: ' M .ai-dev/state.json' / log: '72a8dc8 initial'
- Scenario 5 already clean => PASS_ALREADY_CLEAN / final git status: ''

### Pass/fail interpretation
- Scenario 1 proves completed auto-cycle-full can absorb leftover .ai-dev operational files into a final meta commit and finish with clean git status.
- Scenario 2 proves remaining non-.ai-dev dirty files are rejected instead of being reported as a clean completed run.
- Scenario 3 proves .ai-dev operational cleanup requiring a commit fails when AllowCommit is false.
- Scenario 4 proves DryRun does not create a final meta commit and remains a preview path.
- Scenario 5 proves already-clean completion remains clean.

### Final conclusion
- auto-cycle-full completed success requires final git status --short to be clean.
- Only .ai-dev operational leftovers are eligible for final meta commit when AllowCommit is enabled.
- non-.ai-dev dirty and missing AllowCommit paths fail instead of silently succeeding.
- DryRun does not mutate the repository or create final commits.


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-19 22:32:23

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
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

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
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 | 5 +++++
 1 file changed, 5 insertions(+)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 419656a..476fb1e 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -229,6 +229,11 @@ function Complete-Cycle {
                 Stop-Cycle $Steps "completed_ai_dev_changes_require_commit" $false 1
             }
 
+            if ($DryRun) {
+                $Steps += New-StepResult $StepNumber "completed-clean-gate" "git status --short; git add/commit final .ai-dev operational changes; git status --short" $false $true 0 "DryRun: only new .ai-dev operational changes remain, but the final auto-cycle meta commit was not created.`n$remainingStatus"
+                Stop-Cycle $Steps "dry_run" $false 0
+            }
+
             $addOutput = & git add -- $eligibleAiDevPaths 2>&1 | Out-String
             $addExitCode = $LASTEXITCODE
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
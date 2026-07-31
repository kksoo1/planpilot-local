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

auto-goal 실행 시 `ai-dev-auto-goal.ps1`이 full-cycle을 안정적으로 호출할 수 있도록 MaxSteps 기본값 및 전달 흐름을 정리한다.

## 배경

현재 auto-goal 흐름에서 내부적으로 `ai-dev-auto-cycle-full.ps1`을 호출할 때 전달되는 MaxSteps 값이 full-cycle의 최소 요구 단계보다 작아 `max_steps_too_small_for_full_cycle`로 중단될 수 있다. 이로 인해 auto-goal이 생성한 task가 별도 수동 재실행 없이 full-cycle까지 이어지지 못한다.

## 성공 기준

- `ai-dev-auto-goal.ps1`의 기본 MaxSteps가 full-cycle 최소 요구 단계보다 작지 않다.
- 사용자가 MaxSteps를 지정한 경우 full-cycle 호출 시 의도한 값이 안전하게 반영된다.
- 기존 `AllowCodex`, `AllowReviewCodex`, `AllowCommit`, `AllowDirty` 전달 흐름은 유지된다.
- auto-goal이 생성한 task가 기본 설정으로 full-cycle 단계까지 진행 가능하다.

## 제약사항

- 변경 범위는 auto-goal과 full-cycle 호출부 확인 및 최소 수정으로 제한한다.
- 기존 플래그 전달 방식은 유지한다.
- 관련 PowerShell 스크립트의 현재 구조를 우선 따른다.

## 범위 제외

- AI Dev Loop 전체 구조 재설계는 하지 않는다.
- unrelated 스크립트 동작 변경은 하지 않는다.
- UI나 앱 런타임 코드는 변경하지 않는다.

## 수동 검증

- `ai-dev-auto-goal.ps1`의 MaxSteps 기본값과 full-cycle 호출 인자를 확인한다.
- 기본 MaxSteps가 full-cycle 최소 요구 단계 이상인지 확인한다.
- 사용자가 MaxSteps를 지정했을 때 해당 값이 full-cycle 호출에 반영되는지 확인한다.
- 기존 허용 플래그들이 기존 이름과 의미로 전달되는지 확인한다.


## Current Task

- Task ID: T001
- Title: auto-goal MaxSteps 전달 안정화
- Description: auto-goal 스크립트의 MaxSteps 기본값과 full-cycle 호출부를 확인하고, full-cycle 최소 요구 단계보다 작아 중단되지 않도록 최소 범위로 조정한다. 기존 허용 플래그 전달 흐름은 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- MaxSteps 기본값이 full-cycle 최소 요구 단계 이상인지 확인한다.
- 사용자 지정 MaxSteps가 full-cycle 호출에 전달되는지 확인한다.
- AllowCodex, AllowReviewCodex, AllowCommit, AllowDirty 전달 흐름이 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-31 11:35:02

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

[32m✓ built in 254ms[39m
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

2026-07-31 11:35:12

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
 M scripts/ai-dev-auto-goal.ps1
```

## App Change Files

- scripts/ai-dev-auto-goal.ps1

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
 scripts/ai-dev-auto-goal.ps1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index be59b8d..5869e33 100644
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -4,7 +4,7 @@
     [AllowEmptyString()]
     [string]$GoalDescription,
     [int]$MaxTasks = 1,
-    [int]$MaxSteps = 20,
+    [int]$MaxSteps = 40,
     [switch]$DryRun,
     [switch]$Json,
     [switch]$AllowRun,
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
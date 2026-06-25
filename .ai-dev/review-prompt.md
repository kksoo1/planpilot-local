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
PlanPilot Local의 자동 개발 루프가 여러 개의 작은 task를 연속으로 처리할 수 있는지 검증한다.

## 배경
이번 목표는 앱 자체를 크게 완성하는 것이 아니라, 작은 UI 문구 개선 작업을 순차적으로 처리하면서 구현, 검증, 리뷰, 수정, 완료 기록 흐름이 안정적으로 이어지는지 확인하는 데 있다.

## 성공 기준
- 빈 상태와 필터 결과 없음 안내가 더 명확해진다.
- 업무 카드의 상태 안내와 다음 행동 안내가 더 일관되게 정리된다.
- 로컬 저장 기반 앱이라는 점을 과하지 않은 작은 안내 문구로 보강한다.
- 각 task가 순서대로 완료 상태로 전환된다.
- 모든 task 완료 후 목표 상태가 completed로 기록된다.

## 제약사항
- 한 번에 하나의 작은 변경만 진행한다.
- 기존 React, Vite, TypeScript, Zustand, Dexie 구조를 유지한다.
- 사용자-facing UI 문자열은 한국어를 기본으로 한다.
- 화면 문구 개선 중심으로 작업하고 저장 구조 변경은 하지 않는다.
- 사용자가 관리하는 스타일 파일은 수정하지 않는다.

## 범위 제외
- 계정 기반 기능 추가
- 원격 연동 기능 추가
- 결제 기능 추가
- 외부 서비스 연결
- 대규모 화면 재작성

## 수동 검증
- 빈 데이터 상태에서 안내 문구가 자연스럽게 보이는지 확인한다.
- 필터 결과가 없을 때 사용자가 다음 행동을 이해할 수 있는지 확인한다.
- 업무 카드의 상태 및 다음 행동 안내가 서로 어색하지 않은지 확인한다.
- 로컬 저장 안내 문구가 과도하게 강조되지 않는지 확인한다.

## Current Task

- Task ID: T003
- Title: 로컬 저장 안내 문구 보강
- Description: 앱이 이 기기 안에 데이터를 저장한다는 점을 사용자가 부담 없이 이해할 수 있도록 작은 안내 문구를 보강한다.
- Type: implementation
- Status: pending
- Priority: P1
- Depends on:
- T002
- Verification:
- 로컬 저장 안내가 과하게 강조되지 않는지 확인한다.
- 기존 privacy-first 방향과 충돌하지 않는지 확인한다.
- 허용된 검증 명령이 있으면 실행 결과를 기록한다.

## Test Result

# AI Dev Test Result

## 2026-06-25 15:57:53

- Overall result: passed
- Current task: T003
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

[32m✓ built in 213ms[39m
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

2026-06-25 15:58:00

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M src/App.tsx
 M src/components/TaskCard.tsx
```

## App Change Files

- src/App.tsx
- src/components/TaskCard.tsx

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 src/App.tsx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/src/App.tsx b/src/App.tsx
index 5e76eb3..cf3bfb3 100644
--- a/src/App.tsx
+++ b/src/App.tsx
@@ -140,7 +140,7 @@ function App() {
       <header className="app-header">
         <p className="eyebrow">Privacy-first local planner</p>
         <h1>PlanPilot Local</h1>
-        <p>서버 없이 로컬에 저장되는 개인 일정·업무 관리 앱</p>
+        <p>서버 없이 이 기기 안에 저장되는 개인 일정·업무 관리 앱</p>
       </header>
 
       <main className="app-main">
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
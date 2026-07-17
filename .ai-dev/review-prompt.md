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
MaxTasks 1 기능이 현재 로컬 앱에서 끝까지 정상 동작하는지 가장 작은 범위로 검증한다.

## 배경
P0 백로그 항목인 "MaxTasks 1 end-to-end 검증"은 기능 추가보다 현재 구현의 실제 사용자 흐름 확인이 우선이다. 기존 저장 구조와 화면 흐름을 유지하면서, MaxTasks 1 설정 또는 제한이 업무 생성 및 표시 흐름에서 일관되게 적용되는지 확인한다.

## 성공 기준
- MaxTasks 1 관련 현재 구현 위치와 사용자 흐름을 확인한다.
- 업무가 1개로 제한되어야 하는 상황에서 추가 생성, 표시, 상태 변경 흐름이 일관되게 동작하는지 확인한다.
- 제한 초과 시 사용자에게 보이는 결과가 혼란스럽지 않은지 확인한다.
- 검증 결과와 발견된 문제를 간단히 기록한다.

## 제약사항
- 한 번에 하나의 작은 검증 작업만 수행한다.
- 기존 React, Vite, TypeScript, Zustand, Dexie 구조를 유지한다.
- 사용자-facing 문구는 한국어를 기준으로 확인한다.
- 기존 사용자 데이터를 깨뜨리는 방식은 사용하지 않는다.
- src/App.css는 수정하지 않는다.

## 범위 제외
- 새 기능 추가는 포함하지 않는다.
- 대규모 구조 변경은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.
- 저장소 스키마 변경은 포함하지 않는다.

## 수동 검증
- 현재 앱에서 MaxTasks 1 조건을 만들 수 있는지 확인한다.
- 업무 1개가 존재하는 상태에서 추가 업무 생성 시도를 확인한다.
- 업무 완료, 미완료 전환 후 제한 동작이 유지되는지 확인한다.
- 새로고침 후에도 동일한 제한 상태가 유지되는지 확인한다.

## Current Task

- Task ID: T001
- Title: MaxTasks 1 흐름 검증
- Description: 현재 구현에서 MaxTasks 1 조건이 업무 생성, 표시, 상태 변경, 새로고침 후 유지 흐름에서 일관되게 적용되는지 확인하고 결과를 정리한다.
- Type: verification
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- MaxTasks 1 조건에서 업무 1개 생성 흐름을 확인한다.
- 업무가 1개인 상태에서 추가 생성 시도를 확인한다.
- 업무 완료 또는 미완료 전환 후 제한 동작을 확인한다.
- 새로고침 후 제한 상태가 유지되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-17 18:46:19

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

[32m✓ built in 188ms[39m
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

2026-07-17 18:46:26

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/verification-evidence-prompt.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/verification-evidence-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
변경 없음
```

## Unstaged Diff

```text
변경 없음
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
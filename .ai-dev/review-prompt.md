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

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 기준 안내 문구 보강
- Description: AI Dev Loop 관련 문서 또는 기존 안내 문구에 완료 기준을 짧게 추가하고, 앱 기능 로직과 UI 동작은 변경하지 않는다.
- Type: documentation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 완료 기준에 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 정리 상태가 포함되는지 확인한다.
- 앱 기능 로직과 UI 동작 파일이 변경되지 않았는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-19 21:52:58

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
dist/index.html                   0.46 kB │ gzip:  0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-Bc7EYrNn.js   316.52 kB │ gzip: 99.88 kB

[32m✓ built in 232ms[39m
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

2026-06-19 21:53:02

## Git Status

```text
 M .ai-dev/README.md
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/README.md
- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

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
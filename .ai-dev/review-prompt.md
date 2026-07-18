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
GitHub PR 연동 검토를 현재 PlanPilot Local 구조에 맞춰 가장 작은 실행 가능한 개발 목표로 정리한다.

## 배경
P2 백로그 항목인 GitHub PR 연동 검토는 즉시 기능 구현보다 현재 React + Vite + TypeScript, Zustand, Dexie 기반 로컬 앱 구조에서 어떤 범위가 안전한지 먼저 확인하는 작업이다. 이번 목표는 실제 연동 구현이 아니라, 현재 저장소 상태에서 다음 작업으로 옮길 수 있는 최소 검토 결과를 남기는 것이다.

## 성공 기준
- 현재 코드 구조에서 PR 관련 정보를 표시하거나 관리할 수 있는 후보 위치를 확인한다.
- MVP에서 다룰 최소 사용자 흐름과 제외할 범위를 구분한다.
- 필요한 데이터 형태와 저장 위치 후보를 간단히 정리한다.
- 후속 구현 작업으로 바로 전환 가능한 작은 작업 단위를 제안한다.

## 제약사항
- privacy-first 방향을 유지한다.
- 로컬 앱 구조와 기존 상태 관리 방식을 우선한다.
- 기존 IndexedDB 데이터를 깨뜨리는 변경은 하지 않는다.
- App.tsx에 새 복잡도를 무리하게 추가하지 않는다.
- 이번 목표에서는 검토 문서 작성 범위로 제한한다.

## 범위 제외
- 실제 GitHub 연동 구현
- 인증 흐름 구현
- 원격 데이터 자동 수집
- 데이터베이스 schema 변경
- 대규모 화면 재구성

## 수동 검증
- 작성된 검토 내용이 현재 앱 구조와 충돌하지 않는지 확인한다.
- 후속 작업이 하나의 작은 구현 단위로 분리되어 있는지 확인한다.
- 사용자-facing 문구가 한국어 기준을 따르는지 확인한다.

## Current Task

- Task ID: T001
- Title: GitHub PR 연동 검토 문서 작성
- Description: 현재 저장소 구조를 기준으로 GitHub PR 정보를 어떤 방식으로 다룰 수 있는지 검토하고, MVP 범위와 후속 구현 단위를 한국어 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- 없음
- Verification:
- 검토 문서에 현재 구조 요약, 최소 범위, 제외 범위, 후속 작업이 포함되어 있는지 확인한다.
- 데이터 저장 또는 화면 변경이 필요한 경우 별도 후속 작업으로 분리되어 있는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-18 18:31:43

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

[32m✓ built in 197ms[39m
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

2026-07-18 18:31:52

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
?? .ai-dev/github-pr-integration-review.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md
- .ai-dev/github-pr-integration-review.md

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
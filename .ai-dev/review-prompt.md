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
Codex CLI 완전 자동화 정책을 현재 저장소의 로컬 AI Dev Loop 운영 문서로 작고 명확하게 정리한다.

## 배경
현재 프로젝트는 로컬 우선 React + Vite + TypeScript 앱이며, AI Dev Loop 상태 파일을 기준으로 작은 단위의 작업을 안전하게 진행해야 한다. Codex CLI 자동화가 어떤 조건에서 진행되고, 언제 멈추며, 어떤 검증 정보를 남겨야 하는지 문서화가 필요하다.

## 성공 기준
- Codex CLI 자동화 정책의 목적, 적용 범위, 중단 조건, 검증 기록 방식을 한국어로 문서화한다.
- 기존 프로젝트 제약을 해치지 않는 작은 문서 변경으로 제한한다.
- 자동화가 임의로 기능 범위를 넓히지 않도록 작업 단위와 상태 기록 기준을 명확히 한다.

## 제약사항
- 앱 런타임 코드와 저장 구조는 변경하지 않는다.
- 사용자-facing 문서는 한국어로 작성한다.
- 기존 AI Dev Loop 상태 파일 형식과 충돌하지 않게 작성한다.
- 한 번에 하나의 작은 문서 작업으로 진행한다.

## 범위 제외
- 새 기능 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조 개편은 포함하지 않는다.
- 자동화 실행 도구 자체의 구현 변경은 포함하지 않는다.

## 수동 검증
- 작성된 정책 문서가 현재 저장소 작업 규칙과 모순되지 않는지 확인한다.
- 정책 문서에 목표 진행, 검증, 중단 조건이 구체적으로 포함되어 있는지 확인한다.
- 변경 파일 수가 최소 범위인지 확인한다.


## Current Task

- Task ID: T001
- Title: Codex CLI 자동화 정책 문서 작성
- Description: 현재 저장소의 로컬 AI Dev Loop 운영 방식에 맞춰 Codex CLI 완전 자동화 정책을 한국어 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 정책 문서에 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건이 포함되어 있는지 확인한다.
- 문서 내용이 현재 저장소 작업 규칙과 충돌하지 않는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-09 22:39:10

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

[32m✓ built in 185ms[39m
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

2026-07-09 22:39:16

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
?? .ai-dev/codex-cli-automation-policy.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md
- .ai-dev/codex-cli-automation-policy.md

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
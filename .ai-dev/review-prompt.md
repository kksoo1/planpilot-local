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
full auto-cycle 초안을 추가한다.

## 배경
현재 저장소의 P0 백로그 항목인 full auto-cycle 초안 추가를 가장 작은 실행 가능한 단위로 진행한다. 자동 개발 루프의 흐름과 책임 범위를 문서 초안으로 정리해 이후 구현 또는 검토의 기준을 만든다.

## 성공 기준
- full auto-cycle의 목적, 입력, 처리 흐름, 종료 조건이 초안 문서에 정리된다.
- 기존 로컬 우선 구조와 현재 프로젝트 제약을 벗어나지 않는다.
- 후속 작업자가 바로 검토하거나 보완할 수 있을 만큼 항목이 구체적이다.

## 제약사항
- 한 번에 하나의 작은 문서 작업만 수행한다.
- 기존 앱 동작과 저장 구조는 변경하지 않는다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 기존 파일 구조와 현재 프로젝트 규칙을 따른다.

## 범위 제외
- 실제 자동 실행 로직 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조의 대규모 정리는 포함하지 않는다.
- 배포, 외부 연동, 계정 기반 기능은 포함하지 않는다.

## 수동 검증
- 추가된 초안 문서를 열어 섹션 구성이 자연스러운지 확인한다.
- 성공 기준과 범위 제외가 이번 목표에 맞게 좁게 유지되는지 확인한다.
- 후속 구현자가 다음 작업을 식별할 수 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: full auto-cycle 초안 문서 추가
- Description: full auto-cycle의 목적, 입력, 처리 흐름, 종료 조건을 작은 문서 초안으로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 문서에 목적, 입력, 처리 흐름, 종료 조건이 포함되어 있는지 확인한다.
- 이번 목표의 범위가 문서 초안 추가로 제한되어 있는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-12 23:27:16

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

[32m✓ built in 227ms[39m
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

2026-07-12 23:27:25

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
?? .ai-dev/full-auto-cycle-draft.md
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
- .ai-dev/full-auto-cycle-draft.md

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
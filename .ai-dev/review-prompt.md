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
PlanPilot Local MVP에서 사용자가 현재 진행 중인 업무, 완료된 업무, 남은 업무를 더 빠르게 이해할 수 있도록 업무 목록 또는 대시보드 영역의 안내 문구와 상태 표시를 개선한다.

## 배경
현재 MVP는 기존 업무 데이터를 기반으로 로컬에서 동작한다. 1차 사용성을 높이기 위해 기능 로직을 크게 바꾸기보다, 기존 화면에서 업무 상태를 더 명확하게 읽을 수 있는 작은 개선이 필요하다.

## 성공 기준
- 진행 중인 업무, 완료된 업무, 남은 업무의 의미가 화면에서 더 명확하게 드러난다.
- 기존 데이터 구조와 저장 방식은 유지한다.
- 사용자-facing 문구는 한국어로 제공한다.
- 변경 범위는 업무 목록 또는 대시보드 영역의 작은 UI 개선으로 제한한다.
- 허용된 검증을 통과하고 리뷰 결과가 통과 상태가 된다.
- 구현 변경과 AI Dev Loop 메타 변경이 각각 기록된다.
- 최종 상태에서 예상하지 못한 변경 파일이 남아 있지 않음을 확인한다.

## 제약사항
- 서버 연동이나 외부 전송 없이 로컬 앱 방향을 유지한다.
- 로그인, 동기화, 알림, 모바일 권한 요청은 추가하지 않는다.
- IndexedDB와 Dexie.js 기반 저장 구조를 유지한다.
- `src/App.css`, lock file, `node_modules`, `dist`, `.git`은 수정하지 않는다.
- 한 번에 하나의 기능만 작게 구현한다.

## 범위 제외
- 새 화면 추가
- 대규모 컴포넌트 재작성
- 데이터 schema 변경
- 새 상태 관리 구조 도입
- 알림 또는 반복 업무 기능

## 수동 검증
- 앱 화면에서 진행 중, 완료, 남은 업무 상태 안내가 자연스럽게 보이는지 확인한다.
- 빈 업무 목록 또는 완료 업무가 있는 상태에서 문구가 어색하지 않은지 확인한다.
- 기존 업무 생성, 완료 전환, 필터 흐름이 깨지지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 업무 상태 안내 개선 범위 확인
- Description: 현재 업무 목록 또는 대시보드 영역의 구조를 확인하고, 기존 데이터 구조를 유지하면서 문구와 상태 표시만 작게 개선할 위치를 정한다.
- Type: analysis
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 관련 화면 구조와 기존 상태 계산 방식을 확인한다.
- 수정 범위가 작은 UI 문구와 상태 표시 개선에 머무르는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-19 22:06:39

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

[32m✓ built in 169ms[39m
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

2026-06-19 22:06:43

## Git Status

```text
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
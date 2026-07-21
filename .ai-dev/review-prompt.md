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
병렬 task 실행 가능성 검토

## 배경
현재 PlanPilot Local의 task 처리 구조에서 여러 task를 동시에 진행하거나 표시할 수 있는지 확인하고, 실제 구현 전에 필요한 변경 범위와 위험 요소를 작게 정리한다.

## 성공 기준
- 현재 task 데이터 구조와 화면 흐름에서 병렬 task 개념을 수용할 수 있는 지점을 확인한다.
- 병렬 task 실행을 위해 변경이 필요한 파일과 상태 흐름을 최소 범위로 정리한다.
- 즉시 구현 가능한 작은 후속 작업과 보류해야 할 항목을 구분한다.

## 제약사항
- 기존 사용자 데이터를 깨뜨리지 않는다.
- 기존 타입, store 액션, DB 구조를 우선 확인한다.
- 한 번에 하나의 기능만 다룬다.
- 큰 구조 변경이 필요하면 구현보다 검토 결과 정리를 우선한다.

## 범위 제외
- 실제 병렬 실행 UI 구현은 제외한다.
- 데이터 구조 변경은 제외한다.
- 알림 기능 추가는 제외한다.
- 대규모 화면 재구성은 제외한다.

## 수동 검증
- 관련 task 타입과 상태 흐름을 읽고 병렬 task 요구사항과 충돌하는 부분이 있는지 확인한다.
- 검토 결과가 작은 후속 구현 작업으로 이어질 만큼 구체적인지 확인한다.

## T002 검토 결과

### 수정 파일과 이유
- `.ai-dev/goal.md`: 현재 작업의 결과물은 구현이 아니라 병렬 task 실행 가능성 검토 문서이므로 `src`가 아닌 AI Dev Loop 목표 문서에만 정리한다.

### 현재 구조에서 수용 가능한 지점
- `src/types.ts`의 `Task.status`는 이미 `"todo" | "in_progress" | "done"`을 허용한다.
- `src/db.ts`의 Dexie v1 schema는 `tasks: "id,projectId,status,sortOrder"`로 `status` 인덱스를 가지고 있어 여러 `in_progress` task 저장 자체를 막지 않는다.
- `src/store.ts`의 `addTask`와 `updateTask`는 단일 active task 제약을 두지 않는다. 따라서 같은 시점에 여러 task가 `in_progress`가 되는 데이터 상태는 현재 store/DB 흐름과 충돌하지 않는다.
- `src/views/TasksView.tsx`는 `in_progress` 개수를 요약에 포함한다. 병렬 진행 상태를 읽어서 표시하는 최소 기반은 이미 있다.
- `src/utils/taskLabels.ts`, `src/utils/importValidation.ts`는 `in_progress` 상태를 기존 enum 값으로 인식한다.

### 현재 흐름의 제한
- `src/hooks/useTaskActions.ts`의 `handleToggleTaskDone`은 `done`과 `todo` 사이만 전환한다. 사용자가 task를 `in_progress`로 시작하거나 되돌리는 액션은 없다.
- `src/components/TaskCard.tsx`는 완료/미완료 토글만 제공한다. 진행 시작/진행 해제/진행 중 여러 개 표시 같은 명시적 조작 UI는 없다.
- `src/components/TaskForm.tsx`는 생성/수정 폼에서 status를 편집하지 않는다. 새 task는 기본적으로 `todo`로 생성된다.
- `src/views/TodayView.tsx`의 추천 업무는 최대 3개를 보여주지만, 이것은 추천 표시 제한일 뿐 병렬 실행 상태 모델은 아니다.
- `src/utils/taskFilters.ts`는 완료 숨김만 지원한다. `in_progress`만 따로 보는 필터는 없다.

### 병렬 task 실행을 위한 최소 변경 범위
- 작은 구현 1: `TaskCard`에 `todo <-> in_progress` 전환 버튼을 추가하고, 기존 `done` 토글과 역할을 분리한다.
- 작은 구현 2: `useTaskActions`에 `handleToggleTaskInProgress` 같은 액션을 추가한다. 이 액션은 다른 `in_progress` task를 자동으로 `todo`로 되돌리지 않아야 병렬 실행을 유지할 수 있다.
- 작은 구현 3: `TasksView`에 진행 중 개수를 이미 계산하고 있으므로, 필요하면 진행 중 task를 시각적으로 구분하는 표시만 추가한다.
- 작은 구현 4: `TodayView`에서 진행 중 task 섹션을 별도로 보여줄지 검토한다. 단, 첫 후속 작업에서는 전체 업무 화면의 상태 전환만 다루는 편이 범위가 작다.

### 데이터와 마이그레이션 판단
- 새 필드나 schema version 증가는 필요하지 않다.
- 기존 `status` 값 중 `in_progress`를 더 적극적으로 사용하는 변경이므로 기존 사용자 데이터는 그대로 유지할 수 있다.
- import 검증은 이미 `in_progress`를 허용하므로 백업/복원 형식 변경도 필요하지 않다.

### 보류해야 할 항목
- 실제 병렬 실행 UI의 큰 재구성, 타이머, 칸반 보드, 드래그 앤 드롭은 보류한다.
- 알림 기능, Android notification 권한, 백그라운드 실행 추적은 범위 밖이다.
- task 간 의존성, 동시 실행 개수 제한, 자동 스케줄링은 현재 MVP 흐름보다 큰 정책 결정이 필요하므로 보류한다.
- DB schema 변경이나 migration은 현재 검토 기준에서는 불필요하므로 진행하지 않는다.

### 남은 위험
- 화면 문자열 일부가 깨져 보이는 파일이 있어 UI 문구를 함께 건드리면 범위가 커질 수 있다. 병렬 task 후속 작업은 상태 전환 로직과 최소 UI만 별도 task로 다루는 것이 안전하다.
- `in_progress`의 제품 의미가 아직 명확하지 않다. 예를 들어 "진행 중"을 여러 개 허용할지, 오늘 진행 목록인지, 실제 실행 세션인지에 따라 UI 명칭과 액션이 달라질 수 있다.
- 현재 `completedAt`만 store에서 자동 관리한다. `startedAt` 같은 실행 이력은 없으므로 실제 실행 시간 기록까지 요구하면 데이터 구조 변경 검토가 필요하다.

### 다음 task 제안
- 다음 task로 넘어가도 된다.
- 우선순위가 가장 낮은 위험의 후속 작업은 `TaskCard`와 `useTaskActions` 중심으로 "진행 중으로 표시/해제"를 추가하는 것이다.
- 이 후속 작업은 DB schema 변경 없이 가능하며, 다른 진행 중 task를 강제로 변경하지 않는 정책을 명시해야 한다.


## Current Task

- Task ID: T002
- Title: 검토 결과 정리
- Description: 병렬 task 실행 가능성, 필요한 후속 작업, 제외할 범위를 짧은 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- T001
- Verification:
- 성공 기준과 제약사항이 검토 결과에 반영되어 있는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-21 15:36:36

- Overall result: passed
- Current task: T002
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

[32m✓ built in 239ms[39m
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

2026-07-21 15:36:45

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/state.json
- .ai-dev/test-result.md

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
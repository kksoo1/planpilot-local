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

AI Dev Loop Autopilot에 durable goal history를 도입해 이미 선택되었거나 처리된 goal title이 다음 실행에서 다시 후보로 선택되지 않도록 한다.

## 배경

현재 Autopilot은 과거 prepared 로그와 현재 queue/state의 completed goalTitle만 제외하기 때문에, 실패 후 수동 완료된 backlog goal이나 prepared 로그에 남지 않은 goal이 다음 실행에서 다시 선택될 수 있다. 실제로 수동 완료한 backlog goal이 다음 Autopilot 실행에서 다시 선택된 사례가 있었다.

## 성공 기준

- `scripts/ai-dev-autopilot.ps1`에서 Autopilot이 선택/준비/완료한 goal title을 durable history로 보존한다.
- history에 저장된 정상적인 한국어 goal title이 깨지지 않는다.
- 기존 prepared 로그 기반 제외와 현재 completed queue/state goalTitle 제외는 유지한다.
- task title을 goal title로 잘못 취급하지 않는다.
- auto-goal 실패 후 해당 goal이 수동 완료되어도 다음 실행에서 같은 goal title이 다시 선택되지 않는다.
- DryRun 실행은 history, state, loop-log 등 어떤 파일도 수정하지 않는다.
- 모든 후보가 history 때문에 제외되면 `all_goal_candidates_excluded`로 중단하고 제외 title 목록과 후보 title 목록을 state, loop-log, output에 남긴다.
- 앱 `src` 파일은 수정하지 않는다.
- AllowCommit이 있는 성공 실행은 최종 작업 트리가 깨끗한 상태로 끝난다.

## 제약사항

- 변경 범위는 Autopilot 스크립트와 AI Dev Loop 상태/기록 파일 처리에 한정한다.
- 한국어 goal title 보존을 위해 파일 인코딩과 JSON 직렬화 방식을 안전하게 유지한다.
- 기존 로그 기반 제외 로직과 현재 완료 goal 제외 로직을 제거하지 않는다.
- DryRun 경로에서는 파일 쓰기 동작을 추가하지 않는다.

## 범위 제외

- 앱 화면, React 컴포넌트, Zustand 상태, Dexie 저장 구조 변경은 제외한다.
- 알림, 동기화, 인증 같은 제품 기능 추가는 제외한다.
- Autopilot 외 다른 개발 루프 정책의 대규모 재작성은 제외한다.

## 수동 검증

- history가 없는 상태에서 새 goal을 선택하면 durable history에 goal title이 기록되는지 확인한다.
- auto-goal 실패 후 같은 title이 다음 실행 후보에서 제외되는지 확인한다.
- DryRun 실행 전후 관련 파일의 변경이 없는지 확인한다.
- 모든 후보가 history로 제외되는 경우 state, loop-log, output에 후보 title과 제외 title이 남는지 확인한다.
- 한국어 goal title이 history 파일에서 깨지지 않는지 확인한다.

## Current Task

- Task ID: T002
- Title: 전체 후보 제외 상태 처리 검증
- Description: 모든 후보가 durable history 때문에 제외될 때 `all_goal_candidates_excluded`로 중단하고 후보 title과 제외 title이 state, loop-log, output에 남도록 확인한다.
- Type: verification
- Status: in_progress
- Priority: P1
- Depends on:
- T001
- Verification:
- 모든 후보가 제외되는 입력에서 stopReason이 `all_goal_candidates_excluded`인지 확인한다.
- state, loop-log, output에 후보 title 목록과 제외 title 목록이 남는지 확인한다.
- AllowCommit 성공 경로가 최종 작업 트리 정리 상태로 끝나는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-13 00:34:32

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

[32m✓ built in 226ms[39m
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
## 2026-07-13 00:45:00 - All candidates excluded verification

- Overall result: passed
- Current task: T002 전체 후보 제외 상태 처리 검증
- Mode: PowerShell targeted verification using actual functions extracted from scripts/ai-dev-autopilot.ps1

### Executed checks

- Actual candidate input: passed
  - Created two concrete backlog-like candidate objects.
  - Recorded both candidate titles into the temporary durable history file.

- All candidates excluded: passed
  - Executed Get-ExcludedGoalTitles with temporary history, queue/state, and loop-log inputs.
  - Applied the same candidate filtering expression used by Autopilot.
  - Verified remaining candidate count is 0.

- Exclusion sources: passed
  - Verified durable history titles exclude candidates.
  - Verified completed queue/state goalTitle is included.
  - Verified Autopilot goal prepared / - Goal title is included.

- Task title safety: passed
  - Temporary loop-log included Task completed / - Task: task title should not exclude.
  - Verified that task title was not included in excluded goal titles.

- Stop reason and reporting support: passed
  - Verified script contains all_goal_candidates_excluded.
  - Verified script reports Durable history goal titles.
  - Verified excluded, candidate, and durable history title summaries are non-empty.

### Build, test, lint

- npm run build: passed in the current BuildOnly verification.
- npm run lint: passed in the current BuildOnly verification.
- npm run test: skipped because package.json has no test script.

## 2026-07-13 00:55:00 - AllowCommit clean worktree verification

- Overall result: passed
- Current task: T002 전체 후보 제외 상태 처리 검증
- Mode: Temporary git repo verification using actual Invoke-AutopilotLoopLogMetaCommit from scripts/ai-dev-autopilot.ps1

### Executed checks

- AllowCommit success path: passed
  - Created a temporary git repository.
  - Created dirty .ai-dev/loop-log.md and .ai-dev/autopilot-goal-history.json files.
  - Executed Invoke-AutopilotLoopLogMetaCommit with AllowCommit enabled.
  - Verified the function committed loop-log/history changes.
  - Verified git status --short returned clean after the meta commit.
  - Last temporary commit: cf07ad1 chore(ai-dev): record autopilot progress

- Scope safety: passed
  - Verification ran in a temporary repository, not the working project repo.
  - No app src files were modified.

### Build, test, lint

- npm run build: passed in the current BuildOnly verification.
- npm run lint: passed in the current BuildOnly verification.
- npm run test: skipped because package.json has no test script.
- PowerShell targeted verification covers the T002 behavior that npm test cannot cover.


## Diff To Review

# AI Dev Diff

## Generated At

2026-07-13 15:06:19

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
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
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
AI Software Company 고객 포털과 자율 개발회사 운영 기반을 기존 PlanPilot AI Dev 자동화 엔진 위에 작고 안전한 단위로 설계하고 초기 상태 파일 계획을 준비한다.

## 배경
사용자는 개발팀 관리자가 아니라 고객/발주자 관점에서 제품을 의뢰하고, CEO Agent가 요구사항 분석부터 납품 검수까지 회사 운영 흐름을 조율하는 로컬 운영 플랫폼을 원한다. 기존 자동개발 스크립트와 회귀 테스트 안전장치는 재사용하며 약화하지 않는다.

## 성공 기준
- 고객 의뢰, CEO 검토, 내부 역할 흐름, 납품 준비 상태를 분리된 회사 상태 모델로 표현한다.
- 기존 AI Dev Goal/Task 흐름과 연결 가능한 어댑터 경계를 정의한다.
- 고객 포털과 회사 내부 보기를 PlanPilot 제품 UI와 섞지 않는 구조로 준비한다.
- 고객 의사결정이 필요한 상황과 회사가 자율 처리할 개발 세부사항의 경계를 명확히 한다.
- 이후 구현이 PowerShell 5.1, UTF-8, 로컬 파일 기반 상태 저장 정책을 유지하도록 한다.

## 제약사항
- 기존 PlanPilot 제품 UI와 회사 운영 GUI의 경계를 유지한다.
- 기존 테스트와 자동개발 안전장치를 약화하거나 중복 구현하지 않는다.
- 고객 baseline 변경을 보존한다.
- 상태 파일은 전용 회사 디렉터리에 분리하고 재시작 후 복원 가능해야 한다.
- 한 번에 하나의 기능 단위로 진행한다.

## 범위 제외
- 외부 서비스 연동은 포함하지 않는다.
- 대규모 기존 화면 재작성은 포함하지 않는다.
- 제품 요구사항과 무관한 리팩터링은 포함하지 않는다.
- 알림, 모바일 권한, 동기화 기능은 포함하지 않는다.

## 수동 검증
- 생성된 목표와 큐가 작고 순차적인지 확인한다.
- T001이 현재 진행 작업으로 설정되었는지 확인한다.
- 회사 상태와 기존 AI Dev 상태가 분리되는 방향인지 확인한다.
- 고객 의사결정 기준이 제품 수준 결정으로 제한되어 있는지 확인한다.

## T001 분석 결과: 회사 운영 상태 모델

### 상태 저장 경계
- 회사 운영 상태는 이후 `.ai-company/` 전용 디렉터리에 저장한다.
- 기존 `.ai-dev/` 파일은 자동 개발 목표, task 큐, 실행 상태, 검증/리뷰 기록만 담당한다.
- 회사 상태 파일은 고객 포털과 내부 회사 운영 GUI의 복원 가능한 원천 상태로 사용하며, PlanPilot 제품 데이터와 섞지 않는다.
- PowerShell 5.1 환경을 고려해 모든 회사 상태 파일은 UTF-8 JSON 또는 append-only JSONL로 유지한다.

### 프로젝트 생명주기
- `intake`: 고객 의뢰가 접수되었고 제품 수준 요구사항이 정리되기 전 상태.
- `ceo_review`: CEO Agent가 요구사항, 범위, 리스크, 고객 결정 필요 여부를 검토하는 상태.
- `planning`: 내부 역할들이 작업 단위, 검증 기준, 납품 기준을 작게 나누는 상태.
- `development`: 기존 AI Dev Goal/Task 흐름으로 전달 가능한 내부 개발 작업이 실행되는 상태.
- `qa_review`: 테스트, 회귀 안전장치, 리뷰 결과를 확인하는 상태.
- `delivery_preparation`: 고객에게 보여줄 요약, 변경 내역, 검수 기준을 준비하는 상태.
- `customer_acceptance`: 고객이 제품 수준 결과를 승인하거나 보완 요청을 남기는 상태.
- `closed`: 납품이 승인되어 회사 운영 관점에서 종료된 상태.
- `paused`: 고객 결정, 범위 충돌, 안전 규칙 충돌 등으로 진행을 멈춘 상태.

### 역할 상태
- `CEO`: 고객 의뢰 해석, 우선순위 판단, 고객 결정 필요 여부 판정, 납품 승인 준비를 담당한다.
- `Product`: 제품 수준 요구사항, 수용 기준, 고객-facing 변경 요약을 담당한다.
- `CTO`: 기술 범위, 기존 AI Dev 연결 가능성, 안전장치 유지 여부를 판단한다.
- `Developer`: 기존 AI Dev task 단위 구현을 수행한다.
- `QA`: build/test/lint/review 결과와 회귀 위험을 확인한다.
- 각 역할 상태는 `idle`, `assigned`, `working`, `blocked`, `done` 중 하나로 표현하고, 차단 사유는 회사 상태 파일에 기록한다.

### 고객 의사결정 경계
- 고객 결정이 필요한 항목은 목표 변경, 범위 확대/축소, 우선순위 변경, 납품 승인, 제품 동작 또는 UX 방향 선택으로 제한한다.
- 고객에게 내부 구현 방식, 파일 분리 방식, 테스트 명령 선택, 코드 스타일 같은 개발 세부사항을 묻지 않는다.
- 회사가 자율 처리할 항목은 task 분해, 기존 AI Dev 큐 생성, 검증 순서, 리뷰 대응, 작은 리팩터링 제안, 납품 요약 작성이다.
- 고객 결정 대기 상태에서는 개발 세부 task를 새로 시작하지 않고, 기존 진행 결과와 필요한 선택지를 요약한다.

### 납품 상태
- `not_ready`: 개발 또는 검증이 끝나지 않아 고객 검수가 불가능한 상태.
- `qa_pending`: 구현은 끝났지만 QA 또는 리뷰 확인이 남은 상태.
- `ready_for_customer`: QA와 리뷰가 통과되어 고객 검수 자료를 준비할 수 있는 상태.
- `changes_requested`: 고객이 제품 수준 보완을 요청한 상태.
- `accepted`: 고객이 납품을 승인한 상태.
- QA와 리뷰가 통과하기 전에는 `ready_for_customer`로 이동하지 않는다.

### 기존 AI Dev 어댑터 경계
- 회사 운영 모델은 내부 개발 작업을 기존 AI Dev Goal/Task 큐로 변환하는 계획까지만 담당한다.
- 실제 구현, 검증, 리뷰, 실패 복구는 기존 `.ai-dev/queue.json`, `.ai-dev/state.json`, 자동개발 스크립트의 책임으로 남긴다.
- 어댑터는 회사 프로젝트 ID, 내부 작업 목적, 성공 기준, 예상 변경 파일, 검증 방법을 AI Dev task 입력으로 전달한다.
- AI Dev 실행 결과는 고객에게 raw 로그가 아니라 상태 요약, 검증 결과, 남은 위험, 고객 결정 필요 여부로 변환해 보여준다.
- 기존 테스트와 자동개발 안전장치를 대체하거나 우회하는 별도 실행기를 만들지 않는다.

### 초기 회사 상태 파일 계획
- `.ai-company/company-state.json`: 회사 운영 런타임 상태, 현재 프로젝트, 역할별 상태, 차단 사유.
- `.ai-company/projects.json`: 고객 프로젝트 목록과 생명주기 상태.
- `.ai-company/customer-requests.json`: 고객 의뢰 원문과 정리된 제품 요구사항.
- `.ai-company/customer-decisions.json`: 고객 결정 대기/완료 항목과 선택지.
- `.ai-company/deliveries.json`: 납품 준비 상태, 검수 기준, 고객 승인 상태.
- `.ai-company/company-config.json`: 로컬 운영 정책과 역할 기본 설정.
- `.ai-company/events.jsonl`: 재시작 후 흐름 복원을 위한 append-only 회사 이벤트 로그.


## Current Task

- Task ID: T002
- Title: 초기 회사 상태 파일 구조 추가
- Description: 전용 회사 상태 디렉터리와 최소 JSON/JSONL 파일 구조를 작게 추가하고, Windows PowerShell 5.1 환경에서 한글 UTF-8을 유지하는 파일 형식을 사용한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T001
- Verification:
- 각 파일이 유효한 UTF-8 JSON 또는 JSONL 형식인지 확인
- 초기 회사 상태가 IDLE 또는 대기 상태로 복원 가능한지 확인
- events.jsonl이 append-only 이벤트 로그로 사용할 수 있는지 확인

## Test Result

# AI Dev Test Result

## 2026-08-10 15:01:09

- Overall result: passed
- Current task: T002
- Mode: standard
- Commands:
  - npm run build: passed
  - npm run test: passed
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

[32m✓ built in 240ms[39m
```
### npm run test

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 test
> powershell -ExecutionPolicy Bypass -File scripts/ai-dev-test.ps1

AI Dev automation tests
Repository: D:\ai-apps\planpilot-local

[PASS] auto-goal MaxSteps default is at least 40
       Detected=40
[PASS] maxsteps-forwarding forwards MaxSteps 57 to child script
       Expected=57 Actual=57 ExitCode=1 Args=-MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1
[PASS] maxsteps-forwarding forwards MaxTasks and allow switches
       ExpectedMaxTasks=3 ActualMaxTasks=3 MissingSwitches=
[PASS] maxsteps-forwarding fake child exited successfully
       AutoGoalExitCode=1
[PASS] maxsteps-forwarding child script was invoked
       ExitCode=1 OutputPreview=Step 1: validate-input    Command: check GoalTitle/GoalDescription    Executed: False    Skipped: False    Exit code: 0    Message: Input validation completed: MaxSteps forwarding test  Step 2: dirty-worktree-gate    Command: git status --porcelain    Executed: True    Skipped: False    Exit code: 0    Message: AllowDirty is set. Baseline dirty count: 2  Step 3: plan-goal    Command: codex exec <auto-goal planning prompt>    Executed: True    Skipped: False    Exit code: 0    Message: Codex goal planning completed. Result: .ai-dev/codex-result.md  Step 4: validate-generated-json    Command: goal/queue/state JSON validation    Executed: False    Skipped: False    Exit code: 0    Message: goalMarkdown, queue, and state JSON validation completed. currentTaskId: T001  Step 5: write-state-files    Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json    Executed: True    Skipped: False    Exit code: 0    Message: New goal, queue, and state files were written.  Step 6: make-prompt    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1    Executed: True    Skipped: False    Exit code: 0    Message: 생성된 프롬프트 파일: .ai-dev/current-task-prompt.md  Current task id: T001  Current task title: Forwarding test  Step 7: auto-cycle-full    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1    Executed: True    Skipped: False    Exit code: 0    Message: completed  Step 8: verify-goal-status    Command: .ai-dev/state.json goalStatus 확인    Executed: False    Skipped: False    Exit code: 0    Message: auto-cycle-full 성공 후 goalStatus completed 확인.  Step 9: final-change-gate    Command: cleanup auto-goal temp artifacts, git status --short    Executed: True    Skipped: False    Exit code: 1    Message: Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.  Baseline dirty count: 2  Final dirty count: 8  Final .ai-dev meta commit created: skipped (baseline dirty remains).  Remaining baseline dirty paths:  scripts/ai-dev-auto-cycle-full.ps1  scripts/ai-dev-auto-goal.ps1   D .ai-dev/auto-goal-planning-prompt.md   M .ai-dev/codex-result.md   M .ai-dev/current-task-prompt.md   M .ai-dev/goal.md   M .ai-dev/queue.json   M .ai-dev/state.json   M scripts/ai-dev-auto-cycle-full.ps1   M scripts/ai-dev-auto-goal.ps1  Plan preview:    Goal title: Forwarding test    Current task id: T001    Task T001: Forwarding test      Type: implementation      Status: in_progress      Priority: P0      Likely files: scripts/ai-dev-test.ps1      Verification: Verify MaxSteps forwarding.  Stopped reason: final_baseline_dirty_remains  Outcome category: actual_failure  Completed: False  Exit code: 1
[PASS] all-goal-candidates-excluded stopped reason
       Expected=all_goal_candidates_excluded ExitCode=1
[PASS] all-goal-candidates-excluded expected_non_work classification
[PASS] all-goal-candidates-excluded baseline marker preservation
[PASS] all-goal-candidates-excluded no new dirty paths
       NewDirtyPaths=
[PASS] all-goal-candidates-excluded no staged paths
       StagedPaths=
[PASS] dirty-worktree stopped reason
       Expected=dirty_worktree ExitCode=1
[PASS] dirty-worktree expected_non_work classification
[PASS] dirty-worktree baseline marker preservation
[PASS] dirty-worktree no new dirty paths
       NewDirtyPaths=
[PASS] dirty-worktree no staged paths
       StagedPaths=
[PASS] baseline-output-conflict stopped reason
       Expected=baseline_output_conflict ExitCode=1
[PASS] baseline-output-conflict expected_non_work classification
[PASS] baseline-output-conflict baseline marker preservation
[PASS] baseline-output-conflict no new dirty paths
       NewDirtyPaths=
[PASS] baseline-output-conflict no staged paths
       StagedPaths=
[PASS] review-required-files-partial-diff recovery prompt expectation
       ExpectedRecoveryPrompt=True ExitCode=1
[PASS] review-required-files-partial-diff missing files section includes only expected targets
       MissingSection=B.ps1
[PASS] review-required-files-partial-diff does not stop as stale required file missing
       ExitCode=1
[PASS] review-required-files-all-changed recovery prompt expectation
       ExpectedRecoveryPrompt=False ExitCode=1
[PASS] review-required-files-all-changed missing files section includes only expected targets
       MissingSection=
[PASS] review-required-files-all-changed does not stop as stale required file missing
       ExitCode=1
[PASS] review-required-files-recovery-limit recovery prompt expectation
       ExpectedRecoveryPrompt=False ExitCode=1
[PASS] review-required-files-recovery-limit missing files section includes only expected targets
       MissingSection=
[PASS] review-required-files-recovery-limit does not stop as stale required file missing
       ExitCode=1
[PASS] missing-implementation-no-diff-no-commit stopped reason expectation
       Expected=missing_implementation ExitCode=1
[PASS] missing-implementation-no-diff-no-commit run-codex expectation
       Expected=True Actual=True
[PASS] missing-implementation-no-diff-no-commit run-review-codex expectation
       Expected=True Actual=True
[PASS] missing-implementation-no-diff-no-commit complete-task expectation
       Expected=False Actual=False
[PASS] missing-implementation-no-diff-no-commit missing_implementation expectation
       Expected=True Actual=True
[PASS] saved-review-current-commit-resumes stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-current-commit-resumes run-codex expectation
       Expected=False Actual=False
[PASS] saved-review-current-commit-resumes run-review-codex expectation
       Expected=False Actual=False
[PASS] saved-review-current-commit-resumes complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-current-commit-resumes missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-pass-current-skips-review-codex run-codex expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex run-review-codex expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-previous-task-head-reruns-codex stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-previous-task-head-reruns-codex run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-previous-task-head-reruns-codex run-review-codex expectation
       Expected=True Actual=True
[PASS] saved-review-previous-task-head-reruns-codex complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-previous-task-head-reruns-codex missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-different-task-reruns-review stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-different-task-reruns-review run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-different-task-reruns-review run-review-codex expectation
       Expected=True Actual=True
[PASS] saved-review-different-task-reruns-review complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-different-task-reruns-review missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-stale-fingerprint-reruns-review stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-stale-fingerprint-reruns-review run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-stale-fingerprint-reruns-review run-review-codex expectation
       Expected=True Actual=True
[PASS] saved-review-stale-fingerprint-reruns-review complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-stale-fingerprint-reruns-review missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-pass-test-failed-does-not-complete stopped reason expectation
       Expected=test_failed ExitCode=1
[PASS] saved-review-pass-test-failed-does-not-complete run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-pass-test-failed-does-not-complete run-review-codex expectation
       Expected=False Actual=False
[PASS] saved-review-pass-test-failed-does-not-complete complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-pass-test-failed-does-not-complete missing_implementation expectation
       Expected=False Actual=False
[PASS] previous-task-head-commit-not-implementation stopped reason expectation
       Expected=missing_implementation ExitCode=1
[PASS] previous-task-head-commit-not-implementation run-codex expectation
       Expected=True Actual=True
[PASS] previous-task-head-commit-not-implementation run-review-codex expectation
       Expected=True Actual=True
[PASS] previous-task-head-commit-not-implementation complete-task expectation
       Expected=False Actual=False
[PASS] previous-task-head-commit-not-implementation missing_implementation expectation
       Expected=True Actual=True
[PASS] previous-task-commit-not-implementation stopped reason expectation
       Expected=missing_implementation ExitCode=1
[PASS] previous-task-commit-not-implementation run-codex expectation
       Expected=True Actual=True
[PASS] previous-task-commit-not-implementation run-review-codex expectation
       Expected=True Actual=True
[PASS] previous-task-commit-not-implementation complete-task expectation
       Expected=False Actual=False
[PASS] previous-task-commit-not-implementation missing_implementation expectation
       Expected=True Actual=True
[PASS] test-failed-recovers-once-then-passes stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] test-failed-recovers-once-then-passes run-codex count
       Expected=2 Actual=2
[PASS] test-failed-recovers-once-then-passes check count
       Expected=2 Actual=2
[PASS] test-failed-recovers-once-then-passes review-codex count
       Expected=1 Actual=1
[PASS] test-failed-recovers-once-then-passes recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] test-failed-recovers-once-then-passes raw review preservation
       Expected=False RawFiles=0
[PASS] test-failed-recovers-once-then-passes revise prompt test-result content
       Expected=True Actual=True
[PASS] test-failed-recovers-once-then-passes seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] test-failed-twice-stops-without-extra-codex stopped reason expectation
       Expected=test_failed ExitCode=1
[PASS] test-failed-twice-stops-without-extra-codex run-codex count
       Expected=2 Actual=2
[PASS] test-failed-twice-stops-without-extra-codex check count
       Expected=2 Actual=2
[PASS] test-failed-twice-stops-without-extra-codex review-codex count
       Expected=0 Actual=0
[PASS] test-failed-twice-stops-without-extra-codex recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] test-failed-twice-stops-without-extra-codex raw review preservation
       Expected=False RawFiles=0
[PASS] test-failed-twice-stops-without-extra-codex revise prompt test-result content
       Expected=True Actual=True
[PASS] test-failed-twice-stops-without-extra-codex seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] review-json-extraction-recovers-once stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] review-json-extraction-recovers-once run-codex count
       Expected=1 Actual=1
[PASS] review-json-extraction-recovers-once check count
       Expected=1 Actual=1
[PASS] review-json-extraction-recovers-once review-codex count
       Expected=2 Actual=2
[PASS] review-json-extraction-recovers-once recovery count
       Type=review_json_extraction_failed Expected=1 Actual=1
[PASS] review-json-extraction-recovers-once raw review preservation
       Expected=True RawFiles=1
[PASS] review-json-extraction-recovers-once revise prompt test-result content
       Expected=False Actual=False
[PASS] review-json-extraction-recovers-once seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] review-json-extraction-twice-stops stopped reason expectation
       Expected=review_json_extraction_failed ExitCode=1
[PASS] review-json-extraction-twice-stops run-codex count
       Expected=1 Actual=1
[PASS] review-json-extraction-twice-stops check count
       Expected=1 Actual=1
[PASS] review-json-extraction-twice-stops review-codex count
       Expected=2 Actual=2
[PASS] review-json-extraction-twice-stops recovery count
       Type=review_json_extraction_failed Expected=1 Actual=1
[PASS] review-json-extraction-twice-stops raw review preservation
       Expected=True RawFiles=1
[PASS] review-json-extraction-twice-stops revise prompt test-result content
       Expected=False Actual=False
[PASS] review-json-extraction-twice-stops seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] stale-review-json-stop-reason-does-not-recover stopped reason expectation
       Expected=run-review-codex_failed ExitCode=1
[PASS] stale-review-json-stop-reason-does-not-recover run-codex count
       Expected=1 Actual=1
[PASS] stale-review-json-stop-reason-does-not-recover check count
       Expected=1 Actual=1
[PASS] stale-review-json-stop-reason-does-not-recover review-codex count
       Expected=1 Actual=1
[PASS] stale-review-json-stop-reason-does-not-recover recovery count
       Type=review_json_extraction_failed Expected=0 Actual=0
[PASS] stale-review-json-stop-reason-does-not-recover raw review preservation
       Expected=False RawFiles=0
[PASS] stale-review-json-stop-reason-does-not-recover revise prompt test-result content
       Expected=False Actual=False
[PASS] stale-review-json-stop-reason-does-not-recover seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] package-scripts-only-allowed stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] package-scripts-only-allowed run-codex count
       Expected=1 Actual=1
[PASS] package-scripts-only-allowed check count
       Expected=1 Actual=1
[PASS] package-scripts-only-allowed review-codex count
       Expected=1 Actual=1
[PASS] package-scripts-only-allowed raw review preservation
       Expected=False RawFiles=0
[PASS] package-scripts-only-allowed revise prompt test-result content
       Expected=False Actual=False
[PASS] package-scripts-only-allowed seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] package-dependencies-blocked stopped reason expectation
       Expected=package_files_changed ExitCode=1
[PASS] package-dependencies-blocked run-codex count
       Expected=1 Actual=1
[PASS] package-dependencies-blocked check count
       Expected=1 Actual=1
[PASS] package-dependencies-blocked review-codex count
       Expected=1 Actual=1
[PASS] package-dependencies-blocked raw review preservation
       Expected=False RawFiles=0
[PASS] package-dependencies-blocked revise prompt test-result content
       Expected=False Actual=False
[PASS] package-dependencies-blocked seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] package-lock-blocked stopped reason expectation
       Expected=package_files_changed ExitCode=1
[PASS] package-lock-blocked run-codex count
       Expected=1 Actual=1
[PASS] package-lock-blocked check count
       Expected=1 Actual=1
[PASS] package-lock-blocked review-codex count
       Expected=1 Actual=1
[PASS] package-lock-blocked raw review preservation
       Expected=False RawFiles=0
[PASS] package-lock-blocked revise prompt test-result content
       Expected=False Actual=False
[PASS] package-lock-blocked seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] same-task-used-test-recovery-does-not-repeat stopped reason expectation
       Expected=test_failed ExitCode=1
[PASS] same-task-used-test-recovery-does-not-repeat run-codex count
       Expected=1 Actual=1
[PASS] same-task-used-test-recovery-does-not-repeat check count
       Expected=1 Actual=1
[PASS] same-task-used-test-recovery-does-not-repeat review-codex count
       Expected=0 Actual=0
[PASS] same-task-used-test-recovery-does-not-repeat recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] same-task-used-test-recovery-does-not-repeat raw review preservation
       Expected=False RawFiles=0
[PASS] same-task-used-test-recovery-does-not-repeat revise prompt test-result content
       Expected=False Actual=False
[PASS] same-task-used-test-recovery-does-not-repeat seeded recovery isolation
       SeedTask=T001 CurrentTask=T001
[PASS] new-task-test-recovery-count-is-independent stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] new-task-test-recovery-count-is-independent run-codex count
       Expected=2 Actual=2
[PASS] new-task-test-recovery-count-is-independent check count
       Expected=2 Actual=2
[PASS] new-task-test-recovery-count-is-independent review-codex count
       Expected=1 Actual=1
[PASS] new-task-test-recovery-count-is-independent recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] new-task-test-recovery-count-is-independent raw review preservation
       Expected=False RawFiles=0
[PASS] new-task-test-recovery-count-is-independent revise prompt test-result content
       Expected=True Actual=True
[PASS] new-task-test-recovery-count-is-independent seeded recovery isolation
       SeedTask=T001 CurrentTask=T002

Test summary: Passed=151, Failed=0
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

2026-08-10 15:01:23

## Git Status

```text
 M .ai-company/company-config.json
 M .ai-company/company-state.json
 M .ai-company/customer-decisions.json
 M .ai-company/customer-requests.json
 M .ai-company/deliveries.json
 M .ai-company/events.jsonl
 M .ai-company/projects.json
 D .ai-dev/auto-goal-planning-prompt.md
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/loop-log.md
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
```

## App Change Files

- .ai-company/company-config.json
- .ai-company/company-state.json
- .ai-company/customer-decisions.json
- .ai-company/customer-requests.json
- .ai-company/deliveries.json
- .ai-company/events.jsonl
- .ai-company/projects.json

## AI Dev Operational Artifact Files

- .ai-dev/auto-goal-planning-prompt.md
- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/loop-log.md
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
 .ai-company/company-config.json     | 2 +-
 .ai-company/company-state.json      | 2 +-
 .ai-company/customer-decisions.json | 2 +-
 .ai-company/customer-requests.json  | 2 +-
 .ai-company/deliveries.json         | 2 +-
 .ai-company/events.jsonl            | 2 +-
 .ai-company/projects.json           | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
```

## Unstaged Diff

```text
diff --git a/.ai-company/company-config.json b/.ai-company/company-config.json
index c337720..58a3484 100644
--- a/.ai-company/company-config.json
+++ b/.ai-company/company-config.json
@@ -1,4 +1,4 @@
-{
+﻿{
   "schemaVersion": 1,
   "storage": {
     "directory": ".ai-company",
diff --git a/.ai-company/company-state.json b/.ai-company/company-state.json
index 0977f1f..702e4f2 100644
--- a/.ai-company/company-state.json
+++ b/.ai-company/company-state.json
@@ -1,4 +1,4 @@
-{
+﻿{
   "schemaVersion": 1,
   "status": "idle",
   "currentProjectId": null,
diff --git a/.ai-company/customer-decisions.json b/.ai-company/customer-decisions.json
index 9c622d6..7d79b9e 100644
--- a/.ai-company/customer-decisions.json
+++ b/.ai-company/customer-decisions.json
@@ -1,4 +1,4 @@
-{
+﻿{
   "schemaVersion": 1,
   "decisions": [],
   "decisionBoundary": {
diff --git a/.ai-company/customer-requests.json b/.ai-company/customer-requests.json
index 3c08053..0372b08 100644
--- a/.ai-company/customer-requests.json
+++ b/.ai-company/customer-requests.json
@@ -1,4 +1,4 @@
-{
+﻿{
   "schemaVersion": 1,
   "requests": [],
   "intakePolicy": {
diff --git a/.ai-company/deliveries.json b/.ai-company/deliveries.json
index e949079..089cdef 100644
--- a/.ai-company/deliveries.json
+++ b/.ai-company/deliveries.json
@@ -1,4 +1,4 @@
-{
+﻿{
   "schemaVersion": 1,
   "deliveries": [],
   "deliveryStatusValues": [
diff --git a/.ai-company/events.jsonl b/.ai-company/events.jsonl
index e2498ba..5fe6c71 100644
--- a/.ai-company/events.jsonl
+++ b/.ai-company/events.jsonl
@@ -1 +1 @@
-{"schemaVersion":1,"eventId":"evt-company-bootstrap-20260810","type":"company_state_initialized","projectId":null,"message":"초기 회사 운영 상태 파일 구조를 생성했다.","createdAt":"2026-08-10T00:00:00+09:00"}
+﻿{"schemaVersion":1,"eventId":"evt-company-bootstrap-20260810","type":"company_state_initialized","projectId":null,"message":"초기 회사 운영 상태 파일 구조를 생성했다.","createdAt":"2026-08-10T00:00:00+09:00"}
diff --git a/.ai-company/projects.json b/.ai-company/projects.json
index d8a50dd..bad1b52 100644
--- a/.ai-company/projects.json
+++ b/.ai-company/projects.json
@@ -1,4 +1,4 @@
-{
+﻿{
   "schemaVersion": 1,
   "projects": [],
   "queue": {
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
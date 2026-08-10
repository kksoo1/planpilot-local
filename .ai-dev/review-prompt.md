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
AI Dev 자동화의 반복 실패 유형을 분류하고, 안전하게 자동 복구 가능한 경우 task별 최대 1회 재시도하도록 강화한다.

## 배경
현재 AI Dev 흐름에서는 test_failed, review_json_extraction_failed, review_revise_repeated, stale_review_required_file_missing, missing_implementation, package_files_changed 같은 실패가 반복될 수 있다. 각 실패 유형을 명확히 구분하고, 이미 구현 커밋과 최신 검증 결과가 있는 재개 흐름은 불필요하게 Codex를 다시 실행하지 않도록 한다.

## 성공 기준
- test_failed 발생 시 실패 항목과 test-result를 포함한 수정 프롬프트로 Codex 재수정을 최대 1회 수행한다.
- review_json_extraction_failed 발생 시 원본 리뷰 응답을 보존하고 JSON 추출 또는 리뷰 생성을 최대 1회 재시도한다.
- review_revise_repeated와 stale_review_required_file_missing 발생 시 최신 required_changes와 실제 changedFiles를 비교해 누락 파일만 대상으로 재시도한다.
- 최신 review가 pass이고 검증 결과가 current이며 task 구현 커밋이 존재하면 Codex 재실행 없이 다음 흐름으로 진행한다.
- package.json의 scripts 필드만 변경되고 dependencies, devDependencies, package-lock.json이 변경되지 않은 경우에만 안전한 변경으로 허용한다.
- missing_implementation은 Codex 결과와 실제 diff가 모두 없을 때만 발생한다.
- task별 복구 횟수와 최종 stopped reason을 기록해 무한 반복을 방지한다.
- 기존 영어 판정 토큰, expected_non_work 처리, baseline 사용자 변경 보존, PowerShell 5.1 호환성을 유지한다.
- npm run build, npm test 20개 이상, npm run lint가 모두 통과한다.

## 제약사항
- 한 번에 하나의 복구 흐름만 작게 구현한다.
- 기존 AI Dev 상태 파일과 queue/state 형식을 유지한다.
- 사용자 변경 사항과 baseline 변경 사항을 보존한다.
- package 의존성 및 lock file 변경은 안전 복구 대상으로 보지 않는다.
- PowerShell 5.1에서 동작하는 명령 형식을 유지한다.

## 범위 제외
- 새로운 실행 환경 도입은 제외한다.
- 대규모 구조 재작성은 제외한다.
- 알림 기능 추가는 제외한다.
- UI 화면 변경은 제외한다.

## 수동 검증
- 실패 유형별 샘플 상태를 사용해 자동 복구 횟수가 task별 최대 1회로 제한되는지 확인한다.
- 최신 review pass, current 검증, 구현 커밋 존재 조건에서 Codex 재실행 없이 이어지는지 확인한다.
- package.json scripts 단독 변경과 의존성 변경 케이스가 각각 허용/차단되는지 확인한다.

## Current Task

- Task ID: T002
- Title: 재개 흐름과 package 변경 판정 검증
- Description: 최신 review pass와 current 검증 및 구현 커밋이 있는 경우 Codex 재실행을 건너뛰는 흐름과 package.json scripts 단독 변경 허용 조건을 검증한다.
- Type: verification
- Status: in_progress
- Priority: P1
- Depends on:
- T001
- Verification:
- 구현 커밋이 있는 재개 흐름에서 missing_implementation이 발생하지 않는지 확인한다.
- package.json scripts 단독 변경만 안전 변경으로 분류되는지 확인한다.
- dependencies, devDependencies, package-lock.json 변경은 차단되는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-08-10 11:10:19

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
       ExitCode=1 OutputPreview=Step 1: validate-input    Command: check GoalTitle/GoalDescription    Executed: False    Skipped: False    Exit code: 0    Message: Input validation completed: MaxSteps forwarding test  Step 2: dirty-worktree-gate    Command: git status --porcelain    Executed: True    Skipped: False    Exit code: 0    Message: AllowDirty is set. Baseline dirty count: 2  Step 3: plan-goal    Command: codex exec <auto-goal planning prompt>    Executed: True    Skipped: False    Exit code: 0    Message: Codex goal planning completed. Result: .ai-dev/codex-result.md  Step 4: validate-generated-json    Command: goal/queue/state JSON validation    Executed: False    Skipped: False    Exit code: 0    Message: goalMarkdown, queue, and state JSON validation completed. currentTaskId: T001  Step 5: write-state-files    Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json    Executed: True    Skipped: False    Exit code: 0    Message: New goal, queue, and state files were written.  Step 6: make-prompt    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1    Executed: True    Skipped: False    Exit code: 0    Message: 생성된 프롬프트 파일: .ai-dev/current-task-prompt.md  Current task id: T001  Current task title: Forwarding test  Step 7: auto-cycle-full    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1    Executed: True    Skipped: False    Exit code: 0    Message: completed  Step 8: verify-goal-status    Command: .ai-dev/state.json goalStatus 확인    Executed: False    Skipped: False    Exit code: 0    Message: auto-cycle-full 성공 후 goalStatus completed 확인.  Step 9: final-change-gate    Command: cleanup auto-goal temp artifacts, git status --short    Executed: True    Skipped: False    Exit code: 1    Message: Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.  Baseline dirty count: 2  Final dirty count: 7  Final .ai-dev meta commit created: skipped (baseline dirty remains).  Remaining baseline dirty paths:  scripts/ai-dev-auto-cycle-full.ps1  scripts/ai-dev-auto-goal.ps1   M .ai-dev/codex-result.md   M .ai-dev/current-task-prompt.md   M .ai-dev/goal.md   M .ai-dev/queue.json   M .ai-dev/state.json   M scripts/ai-dev-auto-cycle-full.ps1   M scripts/ai-dev-auto-goal.ps1  Plan preview:    Goal title: Forwarding test    Current task id: T001    Task T001: Forwarding test      Type: implementation      Status: in_progress      Priority: P0      Likely files: scripts/ai-dev-test.ps1      Verification: Verify MaxSteps forwarding.  Stopped reason: final_baseline_dirty_remains  Outcome category: actual_failure  Completed: False  Exit code: 1
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

2026-08-10 11:10:32

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
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
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

- Task ID: T001
- Title: 실패 유형별 자동 복구 흐름 구현
- Description: AI Dev 자동화의 반복 실패 유형을 분류하고, 안전한 유형에 대해 task별 최대 1회만 복구 프롬프트 또는 재시도 흐름을 실행하도록 구현한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- PowerShell 5.1 호환 문법을 유지한다.
- test_failed, review_json_extraction_failed, review_revise_repeated, stale_review_required_file_missing, missing_implementation, package_files_changed 분기 조건을 확인한다.
- 복구 횟수와 stopped reason 기록 경로를 확인한다.

## Test Result

# AI Dev Test Result

## 2026-08-10 10:54:27

- Overall result: passed
- Current task: T001
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

[32m✓ built in 299ms[39m
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

2026-08-10 10:54:40

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
 M scripts/ai-dev-test.ps1
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1
- scripts/ai-dev-test.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-auto-cycle-full.ps1 |  942 ++++++++++++++++++++--
 scripts/ai-dev-test.ps1            | 1508 +++++++++++++++++++++++++++++++++++-
 2 files changed, 2375 insertions(+), 75 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index c116e2b..b00251a 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -80,7 +80,8 @@ function Save-CycleFailureState {
     param(
         [string]$Command,
         [string]$ErrorSummary,
-        [object]$ReviewGate = $null
+        [object]$ReviewGate = $null,
+        [string]$StopReason = $null
     )
 
     try {
@@ -109,6 +110,9 @@ function Save-CycleFailureState {
         Set-ObjectProperty $state "lastCommand" $Command
         Set-ObjectProperty $state "lastCommandStatus" "failed"
         Set-ObjectProperty $state "lastErrorSummary" $ErrorSummary
+        if (Test-HasValue $StopReason) {
+            Set-ObjectProperty $state "stopReason" $StopReason
+        }
         Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
         Write-JsonFile $statePath $state
     } catch {
@@ -116,6 +120,115 @@ function Save-CycleFailureState {
     }
 }
 
+function Get-CurrentTaskIdForRecovery {
+    $state = Read-JsonFile $statePath $stateRelativePath
+
+    if (Test-HasValue $state.currentTaskId) {
+        return [string]$state.currentTaskId
+    }
+
+    if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.id)) {
+        return [string]$script:currentTask.id
+    }
+
+    return "unknown"
+}
+
+function Ensure-RecoveryState {
+    param(
+        [object]$State
+    )
+
+    if (-not ($State.PSObject.Properties.Name -contains "autoRecovery") -or $null -eq $State.autoRecovery) {
+        Set-ObjectProperty $State "autoRecovery" ([PSCustomObject][ordered]@{})
+    }
+
+    return $State.autoRecovery
+}
+
+function Ensure-RecoveryTaskState {
+    param(
+        [object]$RecoveryState,
+        [string]$TaskId
+    )
+
+    if (-not ($RecoveryState.PSObject.Properties.Name -contains $TaskId) -or $null -eq $RecoveryState.$TaskId) {
+        $RecoveryState | Add-Member -NotePropertyName $TaskId -NotePropertyValue ([PSCustomObject][ordered]@{
+            counts = [PSCustomObject][ordered]@{}
+            lastStoppedReason = $null
+        })
+    }
+
+    if (-not ($RecoveryState.$TaskId.PSObject.Properties.Name -contains "counts") -or $null -eq $RecoveryState.$TaskId.counts) {
+        Set-ObjectProperty $RecoveryState.$TaskId "counts" ([PSCustomObject][ordered]@{})
+    }
+
+    return $RecoveryState.$TaskId
+}
+
+function Get-RecoveryCount {
+    param(
+        [string]$Reason
+    )
+
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $taskId = Get-CurrentTaskIdForRecovery
+    $recoveryState = Ensure-RecoveryState $state
+    $taskState = Ensure-RecoveryTaskState $recoveryState $taskId
+
+    if ($taskState.counts.PSObject.Properties.Name -contains $Reason) {
+        return [int]$taskState.counts.$Reason
+    }
+
+    return 0
+}
+
+function Add-RecoveryAttempt {
+    param(
+        [string]$Reason
+    )
+
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $taskId = Get-CurrentTaskIdForRecovery
+    $recoveryState = Ensure-RecoveryState $state
+    $taskState = Ensure-RecoveryTaskState $recoveryState $taskId
+    $currentCount = 0
+
+    if ($taskState.counts.PSObject.Properties.Name -contains $Reason) {
+        $currentCount = [int]$taskState.counts.$Reason
+        $taskState.counts.$Reason = $currentCount + 1
+    } else {
+        $taskState.counts | Add-Member -NotePropertyName $Reason -NotePropertyValue 1
+    }
+
+    Set-ObjectProperty $taskState "lastStoppedReason" $Reason
+    Set-ObjectProperty $state "stopReason" $Reason
+    Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+    Write-JsonFile $statePath $state
+
+    return ($currentCount + 1)
+}
+
+function Save-StoppedReason {
+    param(
+        [string]$StoppedReason
+    )
+
+    try {
+        $state = Read-JsonFile $statePath $stateRelativePath
+        $taskId = if (Test-HasValue $state.currentTaskId) { [string]$state.currentTaskId } else { "unknown" }
+        $recoveryState = Ensure-RecoveryState $state
+        $taskState = Ensure-RecoveryTaskState $recoveryState $taskId
+
+        Set-ObjectProperty $taskState "lastStoppedReason" $StoppedReason
+        Set-ObjectProperty $state "stopReason" $StoppedReason
+        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+        Write-JsonFile $statePath $state
+    } catch {
+        Write-Warning "상태 파일에 stopped reason을 기록하지 못했습니다: $($_.Exception.Message)"
+    }
+}
+
 function Get-CurrentTask {
     param(
         [object]$Queue,
@@ -370,6 +483,10 @@ function Stop-Cycle {
         [int]$ExitCode
     )
 
+    if (-not $Completed -and -not $DryRun) {
+        Save-StoppedReason $StoppedReason
+    }
+
     $result = New-CycleResult $Steps $StoppedReason $Completed $ExitCode
     Write-CycleResult $result
     exit $ExitCode
@@ -489,6 +606,326 @@ function Invoke-CycleCommand {
     }
 }
 
+function Invoke-CycleCommandCapture {
+    param(
+        [int]$StepNumber,
+        [string]$Name,
+        [string]$Command,
+        [string]$ScriptPath,
+        [string[]]$Arguments
+    )
+
+    if ($DryRun) {
+        $step = New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트를 실행하지 않았습니다."
+        $script:steps += $step
+        return $step
+    }
+
+    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
+    $exitCode = $LASTEXITCODE
+    $message = $output.Trim()
+
+    if ([string]::IsNullOrWhiteSpace($message)) {
+        $message = "완료"
+    }
+
+    $step = New-StepResult $StepNumber $Name $Command $true $false $exitCode $message
+    $script:steps += $step
+    return $step
+}
+
+function Get-TextFileOrEmpty {
+    param(
+        [string]$Path
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return ""
+    }
+
+    return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
+}
+
+function Write-TestFailureRevisePrompt {
+    param(
+        [string]$CheckMessage
+    )
+
+    $testResultPath = Join-Path $repoRoot ".ai-dev/test-result.md"
+    $promptPath = Join-Path $repoRoot ".ai-dev/revise-prompt.md"
+    $testResult = Get-TextFileOrEmpty $testResultPath
+    $taskTitle = if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.title)) { [string]$script:currentTask.title } else { "" }
+
+    $content = @"
+# Test Failure Recovery Prompt
+
+현재 task 검증이 실패했습니다. 실패 항목과 test-result를 기준으로 필요한 최소 수정만 수행하세요.
+
+## Task
+
+$taskTitle
+
+## Failure Summary
+
+```text
+$CheckMessage
+```
+
+## Test Result
+
+$testResult
+
+## Rules
+
+- 현재 task 범위 밖 수정은 하지 않습니다.
+- package.json, package-lock.json, node_modules, dist, .git은 수정하지 않습니다.
+- PowerShell 5.1 호환성을 유지합니다.
+- 수정 후 실패한 검증이 통과하도록 필요한 코드만 조정합니다.
+"@
+
+    [System.IO.File]::WriteAllText($promptPath, $content, $utf8WithBom)
+}
+
+function Write-MissingRequiredFilesRevisePrompt {
+    param(
+        [object]$ReviewGate,
+        [string[]]$MissingRequiredFiles,
+        [string]$ReasonMessage
+    )
+
+    $promptPath = Join-Path $repoRoot ".ai-dev/revise-prompt.md"
+    $requiredChangesJson = @($ReviewGate.requiredChanges) | ConvertTo-Json -Depth 20
+    $missingText = if ($MissingRequiredFiles.Count -gt 0) { $MissingRequiredFiles -join "`r`n" } else { "없음" }
+
+    $content = @"
+# Required Files Recovery Prompt
+
+리뷰 required_changes와 실제 changedFiles 비교에서 누락 파일이 확인되었습니다. 아래 누락 파일만 대상으로 현재 task 범위 안에서 최소 수정하세요.
+
+## Reason
+
+```text
+$ReasonMessage
+```
+
+## Missing Required Files
+
+```text
+$missingText
+```
+
+## Latest required_changes
+
+```json
+$requiredChangesJson
+```
+
+## Rules
+
+- 위 누락 파일과 직접 관련된 변경만 수행합니다.
+- 기존 사용자 변경과 baseline 변경을 되돌리지 않습니다.
+- package.json, package-lock.json, node_modules, dist, .git은 수정하지 않습니다.
+"@
+
+    [System.IO.File]::WriteAllText($promptPath, $content, $utf8WithBom)
+}
+
+function Preserve-ReviewJsonFailureResponse {
+    $sourcePath = Join-Path $repoRoot ".ai-dev/codex-review-result.md"
+
+    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
+        return
+    }
+
+    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
+    $targetPath = Join-Path $repoRoot ".ai-dev/codex-review-result.review_json_extraction_failed.$timestamp.raw.md"
+    [System.IO.File]::Copy($sourcePath, $targetPath, $true)
+}
+
+function Invoke-CheckWithTestRecovery {
+    param(
+        [int]$StepNumber,
+        [string]$Name,
+        [string]$Command,
+        [string]$ScriptPath,
+        [string[]]$Arguments
+    )
+
+    $step = Invoke-CycleCommandCapture $StepNumber $Name $Command $ScriptPath $Arguments
+
+    if ($step.exitCode -eq 0) {
+        return $StepNumber + 1
+    }
+
+    Save-CycleFailureState $Name $step.message $null "test_failed"
+
+    if ((Get-RecoveryCount "test_failed") -ge 1) {
+        Stop-Cycle $script:steps "test_failed" $false 1
+    }
+
+    if (-not $AllowCodex) {
+        $script:steps += New-StepResult ($StepNumber + 1) "test-failure-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "test_failed 자동 복구에는 -AllowCodex가 필요합니다."
+        Stop-Cycle $script:steps "test_failed" $false 1
+    }
+
+    Add-RecoveryAttempt "test_failed" | Out-Null
+    Write-TestFailureRevisePrompt $step.message
+    $script:steps += New-StepResult ($StepNumber + 1) "test-failure-recovery" ".ai-dev/revise-prompt.md 생성" $false $false 0 "test_failed 복구 프롬프트를 생성했습니다. task별 자동 복구 1회로 기록했습니다."
+
+    $runStepNumber = $StepNumber + 2
+    Invoke-CycleCommand $runStepNumber "run-codex-test-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
+
+    $retryStepNumber = $StepNumber + 3
+    $retryStep = Invoke-CycleCommandCapture $retryStepNumber "$Name-retry" $Command $ScriptPath $Arguments
+
+    if ($retryStep.exitCode -ne 0) {
+        Save-CycleFailureState "$Name-retry" $retryStep.message $null "test_failed"
+        Stop-Cycle $script:steps "test_failed" $false 1
+    }
+
+    return $StepNumber + 4
+}
+
+function Invoke-ReviewCodexWithJsonRecovery {
+    param(
+        [int]$StepNumber,
+        [string]$Name,
+        [string]$Command,
+        [string]$ScriptPath,
+        [string[]]$Arguments
+    )
+
+    $stateBeforeStep = Read-JsonFile $statePath $stateRelativePath
+    $step = Invoke-CycleCommandCapture $StepNumber $Name $Command $ScriptPath $Arguments
+
+    if ($step.exitCode -eq 0) {
+        return $StepNumber + 1
+    }
+
+    $stateAfterFailure = Read-JsonFile $statePath $stateRelativePath
+    $currentTaskId = if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.id)) { [string]$script:currentTask.id } else { $null }
+    $stateTaskId = if (Test-HasValue $stateAfterFailure.currentTaskId) { [string]$stateAfterFailure.currentTaskId } else { $null }
+    $sameTask = (Test-HasValue $currentTaskId) -and $stateTaskId -eq $currentTaskId
+    $isReviewCommand = ($Name -like "*run-review-codex*") -or ($Command -like "*ai-dev-run-review-codex.ps1*")
+    $isSaveReviewFailure = $stateAfterFailure.lastCommand -eq "save-review" -and $stateAfterFailure.lastCommandStatus -eq "failed"
+    $isJsonStopReason = $stateAfterFailure.stopReason -eq "review_json_extraction_failed"
+    $wasAlreadyJsonFailure = (
+        $stateBeforeStep.lastCommand -eq "save-review" -and
+        $stateBeforeStep.lastCommandStatus -eq "failed" -and
+        $stateBeforeStep.stopReason -eq "review_json_extraction_failed" -and
+        $stateBeforeStep.currentTaskId -eq $stateAfterFailure.currentTaskId
+    )
+    $isReviewJsonFailure = $isReviewCommand -and $sameTask -and $isSaveReviewFailure -and $isJsonStopReason -and (-not $wasAlreadyJsonFailure)
+
+    if (-not $isReviewJsonFailure) {
+        Stop-Cycle $script:steps "$Name`_failed" $false 1
+    }
+
+    if ((Get-RecoveryCount "review_json_extraction_failed") -ge 1) {
+        Stop-Cycle $script:steps "review_json_extraction_failed" $false 1
+    }
+
+    if (-not $AllowReviewCodex) {
+        $script:steps += New-StepResult ($StepNumber + 1) "review-json-recovery" $Command $false $true 1 "review_json_extraction_failed 자동 복구에는 -AllowReviewCodex가 필요합니다."
+        Stop-Cycle $script:steps "review_json_extraction_failed" $false 1
+    }
+
+    Add-RecoveryAttempt "review_json_extraction_failed" | Out-Null
+    Preserve-ReviewJsonFailureResponse
+    $script:steps += New-StepResult ($StepNumber + 1) "review-json-recovery" ".ai-dev/codex-review-result.md 보존 후 리뷰 재시도" $false $false 0 "원본 리뷰 응답을 raw 파일로 보존하고 JSON 추출/리뷰 생성을 task별 1회 재시도합니다."
+
+    $retryStepNumber = $StepNumber + 2
+    $retryStep = Invoke-CycleCommandCapture $retryStepNumber "$Name-retry" $Command $ScriptPath $Arguments
+
+    if ($retryStep.exitCode -ne 0) {
+        Stop-Cycle $script:steps "review_json_extraction_failed" $false 1
+    }
+
+    return $StepNumber + 3
+}
+
+function Invoke-RequiredFilesRecovery {
+    param(
+        [int]$StepNumber,
+        [string]$Reason,
+        [object]$ReviewGate,
+        [object]$ImplementationGate
+    )
+
+    if ($Reason -notin @("stale_review_required_file_missing", "review_revise_repeated")) {
+        return [PSCustomObject][ordered]@{
+            recovered = $false
+            stepNumber = $StepNumber
+            reviewGate = $ReviewGate
+        }
+    }
+
+    if ((Get-RecoveryCount $Reason) -ge 1) {
+        return [PSCustomObject][ordered]@{
+            recovered = $false
+            stepNumber = $StepNumber
+            reviewGate = $ReviewGate
+        }
+    }
+
+    if (-not $AllowCodex) {
+        $script:steps += New-StepResult $StepNumber "$Reason-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "$Reason 자동 복구에는 -AllowCodex가 필요합니다."
+        Stop-Cycle $script:steps $Reason $false 1
+    }
+
+    if (-not $AllowReviewCodex) {
+        $script:steps += New-StepResult $StepNumber "$Reason-recovery" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "$Reason 자동 복구에는 -AllowReviewCodex가 필요합니다."
+        Stop-Cycle $script:steps $Reason $false 1
+    }
+
+    $missingRequiredFiles = @()
+
+    if ($null -ne $ImplementationGate -and ($ImplementationGate.PSObject.Properties.Name -contains "missingRequiredFiles")) {
+        $missingRequiredFiles = @($ImplementationGate.missingRequiredFiles)
+    } elseif ($null -ne $ReviewGate -and ($ReviewGate.PSObject.Properties.Name -contains "requiredChangeFiles")) {
+        $changedFiles = @(Get-ChangedNonAiDevFiles)
+        $missingRequiredFiles = @(
+            @($ReviewGate.requiredChangeFiles) |
+                Where-Object { -not (Test-ReviewRequiredFileIsChanged $_ $changedFiles) }
+        )
+    }
+
+    if ($missingRequiredFiles.Count -eq 0) {
+        return [PSCustomObject][ordered]@{
+            recovered = $false
+            stepNumber = $StepNumber
+            reviewGate = $ReviewGate
+        }
+    }
+
+    Add-RecoveryAttempt $Reason | Out-Null
+    Write-MissingRequiredFilesRevisePrompt $ReviewGate $missingRequiredFiles $ImplementationGate.message
+    $script:steps += New-StepResult $StepNumber "$Reason-recovery" ".ai-dev/revise-prompt.md 생성" $false $false 0 "$Reason 복구 프롬프트를 생성했습니다. 누락 파일: $($missingRequiredFiles -join ', ')"
+    $StepNumber++
+
+    Invoke-CycleCommand $StepNumber "$Reason-run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
+    $StepNumber++
+
+    $checkSpec = Get-CheckCommandSpec $script:currentTask
+    $StepNumber = Invoke-CheckWithTestRecovery $StepNumber "$Reason-check" $checkSpec.command $scriptPaths.check $checkSpec.arguments
+
+    Invoke-CycleCommand $StepNumber "$Reason-save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
+    $StepNumber++
+
+    Invoke-CycleCommand $StepNumber "$Reason-make-review-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
+    $StepNumber++
+
+    $StepNumber = Invoke-ReviewCodexWithJsonRecovery $StepNumber "$Reason-run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
+
+    $newReviewGate = Get-ReviewGate
+
+    return [PSCustomObject][ordered]@{
+        recovered = $true
+        stepNumber = $StepNumber
+        reviewGate = $newReviewGate
+    }
+}
+
 function Get-ScriptPath {
     param(
         [string]$Name
@@ -519,9 +956,80 @@ function Invoke-GitCapture {
     return $output.TrimEnd()
 }
 
-function Test-PackageFileChanged {
+function ConvertTo-CanonicalJson {
+    param(
+        [object]$Value
+    )
+
+    if ($null -eq $Value) {
+        return ""
+    }
+
+    return ($Value | ConvertTo-Json -Depth 50 -Compress)
+}
+
+function Test-PackageJsonScriptsOnlyChanged {
+    $headJson = Invoke-GitCapture @("show", "HEAD:package.json") "git show HEAD:package.json"
+    $currentJson = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $repoRoot "package.json")
+    $headPackage = $headJson | ConvertFrom-Json
+    $currentPackage = $currentJson | ConvertFrom-Json
+    $blockedFields = @("dependencies", "devDependencies")
+
+    foreach ($field in $blockedFields) {
+        $headValue = if ($headPackage.PSObject.Properties.Name -contains $field) { $headPackage.$field } else { $null }
+        $currentValue = if ($currentPackage.PSObject.Properties.Name -contains $field) { $currentPackage.$field } else { $null }
+
+        if ((ConvertTo-CanonicalJson $headValue) -ne (ConvertTo-CanonicalJson $currentValue)) {
+            return $false
+        }
+    }
+
+    $headPackage.PSObject.Properties.Remove("scripts")
+    $currentPackage.PSObject.Properties.Remove("scripts")
+
+    return (ConvertTo-CanonicalJson $headPackage) -eq (ConvertTo-CanonicalJson $currentPackage)
+}
+
+function Get-PackageChangeGate {
     $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json") "git status --porcelain -- package.json package-lock.json"
-    return -not [string]::IsNullOrWhiteSpace($status)
+    $packageLockChanged = $false
+    $packageJsonChanged = $false
+
+    foreach ($line in @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })) {
+        $paths = @(Convert-ToChangedPath $line | ForEach-Object { ConvertTo-NormalizedChangedPath $_ })
+
+        if (@($paths | Where-Object { $_ -eq "package-lock.json" }).Count -gt 0) {
+            $packageLockChanged = $true
+        }
+
+        if (@($paths | Where-Object { $_ -eq "package.json" }).Count -gt 0) {
+            $packageJsonChanged = $true
+        }
+    }
+
+    if ($packageLockChanged) {
+        return [PSCustomObject][ordered]@{
+            passed = $false
+            safeScriptsOnly = $false
+            message = "package-lock.json 변경이 감지되어 자동 커밋을 중단합니다."
+        }
+    }
+
+    if ($packageJsonChanged) {
+        $scriptsOnly = Test-PackageJsonScriptsOnlyChanged
+
+        return [PSCustomObject][ordered]@{
+            passed = $scriptsOnly
+            safeScriptsOnly = $scriptsOnly
+            message = if ($scriptsOnly) { "package.json scripts 필드만 변경되어 안전한 package 변경으로 허용합니다." } else { "package.json 변경이 scripts 필드 단독 변경이 아니거나 dependencies/devDependencies 변경을 포함해 자동 커밋을 중단합니다." }
+        }
+    }
+
+    return [PSCustomObject][ordered]@{
+        passed = $true
+        safeScriptsOnly = $false
+        message = "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+    }
 }
 
 function Convert-ToChangedPath {
@@ -603,6 +1111,217 @@ function Get-ChangedNonAiDevFiles {
     )
 }
 
+function Test-HasCodexResultContent {
+    $codexResultPath = Join-Path $repoRoot ".ai-dev/codex-result.md"
+
+    if (-not (Test-Path -LiteralPath $codexResultPath -PathType Leaf)) {
+        return $false
+    }
+
+    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $codexResultPath
+    if ($null -eq $content) {
+        return $false
+    }
+
+    $content = $content.Trim([char]0xFEFF)
+    return -not [string]::IsNullOrWhiteSpace($content)
+}
+
+function Get-CurrentTaskId {
+    if ($null -ne $script:currentTask -and (Test-HasValue $script:currentTask.id)) {
+        return [string]$script:currentTask.id
+    }
+
+    $state = Read-JsonFile $statePath $stateRelativePath
+
+    if (Test-HasValue $state.currentTaskId) {
+        return [string]$state.currentTaskId
+    }
+
+    return ""
+}
+
+function Test-TextFileContainsLine {
+    param(
+        [string]$Path,
+        [string]$Pattern
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        return $false
+    }
+
+    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
+    return [regex]::IsMatch($content, $Pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
+}
+
+function Test-CurrentValidationPassed {
+    $testResultPath = Join-Path $repoRoot ".ai-dev/test-result.md"
+    $currentTaskId = Get-CurrentTaskId
+
+    if (-not (Test-HasValue $currentTaskId)) {
+        return $false
+    }
+
+    if (-not (Test-Path -LiteralPath $testResultPath -PathType Leaf)) {
+        return $false
+    }
+
+    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $testResultPath
+    $escapedTaskId = [regex]::Escape($currentTaskId)
+
+    return [regex]::IsMatch($content, "^- Overall result:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
+        -and [regex]::IsMatch($content, "^- Current task:\s*$escapedTaskId\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
+        -and [regex]::IsMatch($content, "^\s*-\s*npm run build:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
+        -and [regex]::IsMatch($content, "^\s*-\s*npm run test:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline) `
+        -and [regex]::IsMatch($content, "^\s*-\s*npm run lint:\s*passed\s*$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
+}
+
+function Test-ReviewPromptReferencesCurrentTask {
+    $reviewPromptPath = Join-Path $repoRoot ".ai-dev/review-prompt.md"
+    $currentTaskId = Get-CurrentTaskId
+
+    if (-not (Test-HasValue $currentTaskId)) {
+        return $false
+    }
+
+    $escapedTaskId = [regex]::Escape($currentTaskId)
+    return Test-TextFileContainsLine $reviewPromptPath "^\s*-\s*Task ID:\s*$escapedTaskId\s*$"
+}
+
+function Get-SavedDiffAppChangeFiles {
+    $diffPath = Join-Path $repoRoot ".ai-dev/diff.md"
+
+    if (-not (Test-Path -LiteralPath $diffPath -PathType Leaf)) {
+        return @()
+    }
+
+    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $diffPath
+    $startMarker = "## App Change Files"
+    $startIndex = $content.IndexOf($startMarker, [System.StringComparison]::Ordinal)
+
+    if ($startIndex -lt 0) {
+        return @()
+    }
+
+    $sectionStart = $startIndex + $startMarker.Length
+    $endIndex = $content.IndexOf("## ", $sectionStart, [System.StringComparison]::Ordinal)
+    $section = if ($endIndex -lt 0) {
+        $content.Substring($sectionStart)
+    } else {
+        $content.Substring($sectionStart, $endIndex - $sectionStart)
+    }
+
+    return @(
+        $section -split "`r?`n" |
+            ForEach-Object { $_.Trim() } |
+            Where-Object { $_.StartsWith("- ") } |
+            ForEach-Object { $_.Substring(2).Trim() } |
+            Where-Object { (Test-HasValue $_) -and $_ -ne "없음" } |
+            ForEach-Object { ConvertTo-NormalizedChangedPath $_ } |
+            Select-Object -Unique
+    )
+}
+
+function Test-PathSetsEqual {
+    param(
+        [string[]]$Left,
+        [string[]]$Right
+    )
+
+    $leftSet = @($Left | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Sort-Object -Unique)
+    $rightSet = @($Right | ForEach-Object { ConvertTo-NormalizedChangedPath $_ } | Sort-Object -Unique)
+
+    if ($leftSet.Count -ne $rightSet.Count) {
+        return $false
+    }
+
+    for ($index = 0; $index -lt $leftSet.Count; $index++) {
+        if (-not $leftSet[$index].Equals($rightSet[$index], [System.StringComparison]::OrdinalIgnoreCase)) {
+            return $false
+        }
+    }
+
+    return $true
+}
+
+function Test-SavedDiffMatchesCurrentChangedFiles {
+    $changedFiles = @(Get-ChangedNonAiDevFiles)
+    $savedDiffAppFiles = @(Get-SavedDiffAppChangeFiles)
+
+    return Test-PathSetsEqual $changedFiles $savedDiffAppFiles
+}
+
+function Test-ReviewRequiredChangesEmpty {
+    param(
+        [object]$ReviewGate
+    )
+
+    $requiredChanges = if ($null -eq $ReviewGate.requiredChanges) { @() } else { @($ReviewGate.requiredChanges) }
+    $requiredChangeFiles = if ($null -eq $ReviewGate.requiredChangeFiles) { @() } else { @($ReviewGate.requiredChangeFiles) }
+
+    return $requiredChanges.Count -eq 0 -and $requiredChangeFiles.Count -eq 0
+}
+
+function Test-HasCurrentTaskImplementationCommit {
+    $state = Read-JsonFile $statePath $stateRelativePath
+    $stateCommitHash = $null
+    $taskCommitHash = $null
+
+    if (Test-HasValue $state.lastCommitHash) {
+        $stateCommitHash = [string]$state.lastCommitHash
+    }
+
+    if ($null -ne $script:currentTask -and ($script:currentTask.PSObject.Properties.Name -contains "commitHash") -and (Test-HasValue $script:currentTask.commitHash)) {
+        $taskCommitHash = [string]$script:currentTask.commitHash
+    }
+
+    if (-not (Test-HasValue $stateCommitHash) -or -not (Test-HasValue $taskCommitHash)) {
+        return $false
+    }
+
+    if ($stateCommitHash -ne $taskCommitHash) {
+        return $false
+    }
+
+    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-parse HEAD"
+
+    if ($stateCommitHash -ne $headCommitHash) {
+        return $false
+    }
+
+    return (Test-CurrentValidationPassed) -and (Test-ReviewPromptReferencesCurrentTask)
+}
+
+function Set-CurrentTaskImplementationCommitHash {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$CommitHash
+    )
+
+    $currentTaskId = Get-CurrentTaskId
+
+    if (-not (Test-HasValue $currentTaskId)) {
+        throw "현재 task id가 없어 구현 커밋 메타데이터를 저장할 수 없습니다."
+    }
+
+    $queue = Read-JsonFile $queuePath $queueRelativePath
+    $tasks = @($queue.tasks)
+    $task = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
+
+    if ($null -eq $task) {
+        throw "현재 task를 queue에서 찾을 수 없어 구현 커밋 메타데이터를 저장할 수 없습니다: $currentTaskId"
+    }
+
+    Set-ObjectProperty $task "commitHash" $CommitHash
+    Set-ObjectProperty $queue "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
+    Write-JsonFile $queuePath $queue
+
+    if ($null -ne $script:currentTask -and $script:currentTask.id -eq $currentTaskId) {
+        Set-ObjectProperty $script:currentTask "commitHash" $CommitHash
+    }
+}
+
 function Get-RequiredReviewChangeFiles {
     param(
         [object]$ReviewResponse
@@ -667,19 +1386,25 @@ function Get-ReviewImplementationGate {
         }
     }
 
-    if ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0) {
+    $hasCodexResultContent = Test-HasCodexResultContent
+    $hasCurrentTaskImplementationCommit = Test-HasCurrentTaskImplementationCommit
+
+    if ($taskType -eq "implementation" -and $changedFiles.Count -eq 0 -and -not $hasCodexResultContent -and -not $hasCurrentTaskImplementationCommit) {
         return [PSCustomObject][ordered]@{
             passed = $false
             reason = "missing_implementation"
-            message = "review-response.json이 구현 파일 변경을 요구했지만 현재 diff에 구현 변경 파일이 없습니다. requiredFiles=$($requiredFiles -join ', ')"
+            message = "Codex 결과와 현재 diff에 구현 변경이 없고 현재 task 구현 커밋도 없어 missing_implementation으로 중단합니다. requiredFiles=$($requiredFiles -join ', ')"
+            missingRequiredFiles = @($requiredFiles)
         }
     }
 
-    if ($missingRequiredFiles.Count -gt 0) {
+    if ($missingRequiredFiles.Count -gt 0 -or ($requiredFiles.Count -gt 0 -and $changedFiles.Count -eq 0)) {
+        $missingFilesForMessage = if ($missingRequiredFiles.Count -gt 0) { @($missingRequiredFiles) } else { @($requiredFiles) }
         return [PSCustomObject][ordered]@{
             passed = $false
             reason = "stale_review_required_file_missing"
-            message = "review-response.json이 요구한 구현 파일 변경이 현재 diff에 없습니다. stale review 또는 missing implementation으로 보고 완료 흐름을 차단합니다. missingRequiredFiles=$($missingRequiredFiles -join ', '), changedFiles=$($changedFiles -join ', ')"
+            message = "review-response.json이 요구한 구현 파일 변경이 현재 diff에 없습니다. stale review 또는 missing implementation으로 보고 완료 흐름을 차단합니다. missingRequiredFiles=$($missingFilesForMessage -join ', '), changedFiles=$($changedFiles -join ', ')"
+            missingRequiredFiles = @($missingFilesForMessage)
         }
     }
 
@@ -810,10 +1535,41 @@ function Test-IsSavedReviewPassReady {
     return $ReviewGate.lastCommand -eq "save-review" `
         -and $ReviewGate.lastCommandStatus -eq "passed" `
         -and $ReviewGate.decision -eq "pass" `
+        -and $ReviewGate.severity -eq "none" `
         -and $ReviewGate.stateDecision -eq "pass" `
         -and (Test-IsAcceptableReviewNextStep $ReviewGate)
 }
 
+function Test-IsSavedReviewResumeReady {
+    param(
+        [object]$ReviewGate
+    )
+
+    if (-not (Test-IsSavedReviewPassReady $ReviewGate)) {
+        return $false
+    }
+
+    if (-not (Test-ReviewRequiredChangesEmpty $ReviewGate)) {
+        return $false
+    }
+
+    if (-not (Test-CurrentValidationPassed)) {
+        return $false
+    }
+
+    if (-not (Test-ReviewPromptReferencesCurrentTask)) {
+        return $false
+    }
+
+    $changedFiles = @(Get-ChangedNonAiDevFiles)
+
+    if ($changedFiles.Count -gt 0) {
+        return Test-SavedDiffMatchesCurrentChangedFiles
+    }
+
+    return Test-HasCurrentTaskImplementationCommit
+}
+
 function Get-CommitArguments {
     $arguments = @()
 
@@ -1055,11 +1811,11 @@ while ($script:completedTaskCount -lt $MaxTasks) {
             Stop-Cycle $script:steps "resume_review_gate_failed" $false 1
         }
 
-        if (Test-IsSavedReviewPassReady $resumeReviewGate) {
+        if (Test-IsSavedReviewResumeReady $resumeReviewGate) {
             $resumeImplementationGate = Get-ReviewImplementationGate $script:currentTask $resumeReviewGate
 
             if (-not $resumeImplementationGate.passed) {
-                Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.message $resumeReviewGate
+                Save-CycleFailureState "resume-review-gate" $resumeImplementationGate.message $resumeReviewGate ([string]$resumeImplementationGate.reason)
                 $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response required_changes 및 현재 diff 확인" $false $true 1 $resumeImplementationGate.message
                 Stop-Cycle $script:steps $resumeImplementationGate.reason $false 1
             }
@@ -1072,6 +1828,9 @@ while ($script:completedTaskCount -lt $MaxTasks) {
                 $resumeFromSavedReview = $true
                 $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response 재확인" $false $false 0 "저장된 리뷰가 revise + revise_with_codex이므로 구현/초기 리뷰 재실행 없이 revise 자동 재시도 단계로 계속 진행합니다."
                 $stepNumber++
+            } elseif ($resumeReviewGate.decision -eq "pass") {
+                $script:steps += New-StepResult $stepNumber "resume-review-gate" "state/review-response current 조건 확인" $false $false 0 "저장된 리뷰 pass가 current 재개 조건을 충족하지 않아 구현/검증/리뷰 흐름을 다시 실행합니다."
+                $stepNumber++
             } else {
                 $message = "save-review 이후 계속 진행할 수 없습니다. review.decision=$($resumeReviewGate.decision), state.lastReviewDecision=$($resumeReviewGate.stateDecision), next_step=$($resumeReviewGate.nextStep)"
                 Save-CycleFailureState "resume-review-gate" $message $resumeReviewGate
@@ -1109,8 +1868,7 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         $stepNumber++
 
         $checkSpec = Get-CheckCommandSpec $script:currentTask
-        Invoke-CycleCommand $stepNumber "check" $checkSpec.command $scriptPaths.check $checkSpec.arguments
-        $stepNumber++
+        $stepNumber = Invoke-CheckWithTestRecovery $stepNumber "check" $checkSpec.command $scriptPaths.check $checkSpec.arguments
 
         Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
         $stepNumber++
@@ -1136,8 +1894,7 @@ while ($script:completedTaskCount -lt $MaxTasks) {
             Stop-Cycle $script:steps "allow_review_codex_required" $false 1
         }
 
-        Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
-        $stepNumber++
+        $stepNumber = Invoke-ReviewCodexWithJsonRecovery $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
     }
 
     if ($DryRun) {
@@ -1187,69 +1944,79 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
 
         if (-not $implementationGate.passed) {
-            Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
-            $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
-            Stop-Cycle $script:steps $implementationGate.reason $false 1
+            $recoveryResult = Invoke-RequiredFilesRecovery $stepNumber ([string]$implementationGate.reason) $reviewGate $implementationGate
+
+            if ($recoveryResult.recovered) {
+                $stepNumber = $recoveryResult.stepNumber
+                $reviewGate = $recoveryResult.reviewGate
+            } else {
+                Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate ([string]$implementationGate.reason)
+                $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
+                Stop-Cycle $script:steps $implementationGate.reason $false 1
+            }
         }
 
-        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $false 0 "리뷰 결과가 revise + revise_with_codex입니다. 자동 revise 재시도를 시작합니다. severity=$($reviewGate.severity), summary=$($reviewGate.summary)"
-        $stepNumber++
+        if (-not (Test-IsReviewReviseWithCodex $reviewGate)) {
+            $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 재확인" $false $false 0 "required files 복구 이후 리뷰 상태가 변경되어 일반 review-gate 흐름으로 계속 진행합니다. decision=$($reviewGate.decision), next_step=$($reviewGate.nextStep)"
+            $stepNumber++
+        } else {
+            $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath decision/next_step 확인" $false $false 0 "리뷰 결과가 revise + revise_with_codex입니다. 자동 revise 재시도를 시작합니다. severity=$($reviewGate.severity), summary=$($reviewGate.summary)"
+            $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $scriptPaths.makeRevisePrompt @()
-        $stepNumber++
+            Invoke-CycleCommand $stepNumber "make-revise-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1" $scriptPaths.makeRevisePrompt @()
+            $stepNumber++
 
-        if (-not $AllowCodex) {
-            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
-            if ($AllowDirty) {
-                $command = "$command -AllowDirty"
-            }
+            if (-not $AllowCodex) {
+                $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
+                if ($AllowDirty) {
+                    $command = "$command -AllowDirty"
+                }
 
-            if ($AllowCommit) {
-                $command = "$command -AllowCommit"
-            }
+                if ($AllowCommit) {
+                    $command = "$command -AllowCommit"
+                }
 
-            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
-                $command = "$command -CommitFiles $($CommitFiles -join ',')"
+                if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+                    $command = "$command -CommitFiles $($CommitFiles -join ',')"
+                }
+
+                $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "Codex 재수정 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
+                Stop-Cycle $script:steps "allow_codex_required" $false 1
             }
 
-            $script:steps += New-StepResult $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $false $true 1 "Codex 재수정 실행에는 -AllowCodex가 필요합니다. 추천 명령: $command"
-            Stop-Cycle $script:steps "allow_codex_required" $false 1
-        }
+            Invoke-CycleCommand $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
+            $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "run-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md" $scriptPaths.runCodex @("-AllowDirty", "-PromptPath", ".ai-dev/revise-prompt.md")
-        $stepNumber++
+            $checkSpec = Get-CheckCommandSpec $script:currentTask
+            $stepNumber = Invoke-CheckWithTestRecovery $stepNumber "check-revise" $checkSpec.command $scriptPaths.check $checkSpec.arguments
 
-        $checkSpec = Get-CheckCommandSpec $script:currentTask
-        Invoke-CycleCommand $stepNumber "check-revise" $checkSpec.command $scriptPaths.check $checkSpec.arguments
-        $stepNumber++
+            Invoke-CycleCommand $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
+            $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "save-diff-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1" $scriptPaths.saveDiff @()
-        $stepNumber++
+            Invoke-CycleCommand $stepNumber "make-review-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
+            $stepNumber++
 
-        Invoke-CycleCommand $stepNumber "make-review-prompt-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
-        $stepNumber++
+            if (-not $AllowReviewCodex) {
+                $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
+                if ($AllowDirty) {
+                    $command = "$command -AllowDirty"
+                }
 
-        if (-not $AllowReviewCodex) {
-            $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
-            if ($AllowDirty) {
-                $command = "$command -AllowDirty"
-            }
+                if ($AllowCommit) {
+                    $command = "$command -AllowCommit"
+                }
 
-            if ($AllowCommit) {
-                $command = "$command -AllowCommit"
-            }
+                if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
+                    $command = "$command -CommitFiles $($CommitFiles -join ',')"
+                }
 
-            if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
-                $command = "$command -CommitFiles $($CommitFiles -join ',')"
+                $script:steps += New-StepResult $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 재리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
+                Stop-Cycle $script:steps "allow_review_codex_required" $false 1
             }
 
-            $script:steps += New-StepResult $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 재리뷰 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
-            Stop-Cycle $script:steps "allow_review_codex_required" $false 1
+            $stepNumber = Invoke-ReviewCodexWithJsonRecovery $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
         }
 
-        Invoke-CycleCommand $stepNumber "run-review-codex-revise" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty", "-SaveReview")
-        $stepNumber++
-
         try {
             $reviewGate = Get-ReviewGate
         } catch {
@@ -1266,15 +2033,29 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         if ($reviewGate.decision -eq "revise") {
             if (Test-IsReviewReviseWithCodex $reviewGate) {
                 $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰도 revise + revise_with_codex를 반환해 자동 revise 재시도를 중단합니다."
-                Save-CycleFailureState "review-gate" $message $reviewGate
-                $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
-                Stop-Cycle $script:steps "review_revise_repeated" $false 1
+                $recoveryGate = [PSCustomObject][ordered]@{
+                    passed = $false
+                    reason = "review_revise_repeated"
+                    message = $message
+                }
+                $recoveryResult = Invoke-RequiredFilesRecovery $stepNumber "review_revise_repeated" $reviewGate $recoveryGate
+
+                if ($recoveryResult.recovered) {
+                    $stepNumber = $recoveryResult.stepNumber
+                    $reviewGate = $recoveryResult.reviewGate
+                } else {
+                    Save-CycleFailureState "review-gate" $message $reviewGate "review_revise_repeated"
+                    $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
+                    Stop-Cycle $script:steps "review_revise_repeated" $false 1
+                }
             }
 
-            $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰가 revise를 반환해 자동 커밋과 complete-task를 실행하지 않습니다."
-            Save-CycleFailureState "review-gate" $message $reviewGate
-            $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
-            Stop-Cycle $script:steps "revise_review_not_pass" $false 1
+            if ($reviewGate.decision -eq "revise") {
+                $message = New-ReviewReviseFailureMessage $reviewGate "재리뷰가 revise를 반환해 자동 커밋과 complete-task를 실행하지 않습니다."
+                Save-CycleFailureState "review-gate" $message $reviewGate "revise_review_not_pass"
+                $script:steps += New-StepResult $stepNumber "review-gate" "재리뷰 decision/next_step/required_changes 확인" $false $true 1 $message
+                Stop-Cycle $script:steps "revise_review_not_pass" $false 1
+            }
         }
     }
 
@@ -1298,17 +2079,29 @@ while ($script:completedTaskCount -lt $MaxTasks) {
     $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
 
     if (-not $implementationGate.passed) {
-        Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate
-        $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
-        Stop-Cycle $script:steps $implementationGate.reason $false 1
+        $recoveryResult = Invoke-RequiredFilesRecovery $stepNumber ([string]$implementationGate.reason) $reviewGate $implementationGate
+
+        if ($recoveryResult.recovered) {
+            $stepNumber = $recoveryResult.stepNumber
+            $reviewGate = $recoveryResult.reviewGate
+            $implementationGate = Get-ReviewImplementationGate $script:currentTask $reviewGate
+        }
+
+        if (-not $implementationGate.passed) {
+            Save-CycleFailureState "review-gate" $implementationGate.message $reviewGate ([string]$implementationGate.reason)
+            $script:steps += New-StepResult $stepNumber "review-gate" "task type, $reviewResponseRelativePath required_changes, 현재 diff 확인" $false $true 1 $implementationGate.message
+            Stop-Cycle $script:steps $implementationGate.reason $false 1
+        }
     }
 
     $script:steps += New-StepResult $stepNumber "review-gate" "최신 state 및 $reviewResponseRelativePath 재확인" $false $false 0 "리뷰 pass 및 허용 가능한 next_step 상태 수락: 존재=$($reviewGate.hasNextStep), 원본='$($reviewGate.nextStep)', 정규화='$($reviewGate.normalizedNextStep)'. commit/commit-result-gate/complete-task/meta-commit으로 계속 진행합니다."
     $stepNumber++
 
     try {
-        if (Test-PackageFileChanged) {
-            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커밋을 중단합니다. 의도한 패키지 변경인지, lock file 변경이 필요한지 확인한 뒤 별도 작업으로 처리하세요."
+        $packageGate = Get-PackageChangeGate
+
+        if (-not $packageGate.passed) {
+            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 1 $packageGate.message
             Stop-Cycle $script:steps "package_files_changed" $false 1
         }
     } catch {
@@ -1316,7 +2109,7 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         Stop-Cycle $script:steps "package_change_gate_failed" $false 1
     }
 
-    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
+    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $false 0 $packageGate.message
     $stepNumber++
 
     if (-not $AllowCommit) {
@@ -1353,14 +2146,14 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         if (Test-HasValue $stateBeforeComplete.lastCommitHash) {
             $savedLastCommitHash = [string]$stateBeforeComplete.lastCommitHash
 
-            if ($savedLastCommitHash -eq $currentHeadCommitHash) {
+            if ($savedLastCommitHash -eq $currentHeadCommitHash -and (Test-HasCurrentTaskImplementationCommit)) {
                 $commitHashForComplete = $savedLastCommitHash
-                $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. state.lastCommitHash가 현재 HEAD와 일치하여 complete-task에 CommitHash를 전달합니다: $commitHashForComplete"
+                $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash/current task commitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. state.lastCommitHash와 현재 task commitHash가 현재 HEAD와 일치하여 complete-task에 CommitHash를 전달합니다: $commitHashForComplete"
             } else {
-                $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. stale state.lastCommitHash를 무시하고 CommitHash 없이 complete-task를 실행합니다. state.lastCommitHash=$savedLastCommitHash, currentHead=$currentHeadCommitHash"
+                $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash/current task commitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. stale 또는 다른 task의 state.lastCommitHash를 무시하고 CommitHash 없이 complete-task를 실행합니다. state.lastCommitHash=$savedLastCommitHash, currentHead=$currentHeadCommitHash"
             }
         } else {
-            $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. state.lastCommitHash가 없어 CommitHash 없이 complete-task를 실행합니다. currentHead=$currentHeadCommitHash"
+            $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommitHash/current task commitHash 및 git rev-parse HEAD 확인" $false $true 0 "새 구현 커밋이 없습니다. state.lastCommitHash가 없어 CommitHash 없이 complete-task를 실행합니다. currentHead=$currentHeadCommitHash"
         }
         $stepNumber++
 
@@ -1398,6 +2191,7 @@ while ($script:completedTaskCount -lt $MaxTasks) {
         $stepNumber++
 
         $commitHashForComplete = $commitGate.lastCommitHash
+        Set-CurrentTaskImplementationCommitHash $commitHashForComplete
         $resultSummary = "$resultSummary, 자동 커밋 완료"
     }
 
diff --git a/scripts/ai-dev-test.ps1 b/scripts/ai-dev-test.ps1
index c789156..78447f6 100644
--- a/scripts/ai-dev-test.ps1
+++ b/scripts/ai-dev-test.ps1
@@ -345,7 +345,7 @@ exit 0
         Write-TestResult `
             -Name "$Name execution" `
             -Passed $false `
-            -Detail $_.Exception.Message
+            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
     }
     finally {
         Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
@@ -579,6 +579,1244 @@ function Invoke-IsolatedScenario {
     }
 }
 
+function Set-JsonFile {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$Path,
+
+        [Parameter(Mandatory = $true)]
+        [object]$Value
+    )
+
+    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+    [System.IO.File]::WriteAllText(
+        $Path,
+        ($Value | ConvertTo-Json -Depth 30),
+        $utf8WithBom
+    )
+}
+
+function Get-MissingRequiredFilesSection {
+    param(
+        [string]$PromptText
+    )
+
+    $startMarker = "## Missing Required Files"
+    $endMarker = "## Latest required_changes"
+    $startIndex = $PromptText.IndexOf($startMarker, [System.StringComparison]::Ordinal)
+
+    if ($startIndex -lt 0) {
+        return ""
+    }
+
+    $endIndex = $PromptText.IndexOf($endMarker, $startIndex, [System.StringComparison]::Ordinal)
+
+    if ($endIndex -lt 0) {
+        return ""
+    }
+
+    $section = $PromptText.Substring(
+        $startIndex + $startMarker.Length,
+        $endIndex - ($startIndex + $startMarker.Length)
+    )
+
+    $lines = @(
+        $section -split "`r?`n" |
+            ForEach-Object { $_.Trim() } |
+            Where-Object {
+                -not [string]::IsNullOrWhiteSpace($_) -and
+                -not $_.StartsWith('```') -and
+                -not $_.StartsWith('`')
+            }
+    )
+
+    $joinedLines = $lines -join "`n"
+    return $joinedLines.Trim()
+}
+
+function Invoke-ReviewRequiredFilesRecoveryScenario {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$Name,
+
+        [Parameter(Mandatory = $true)]
+        [string[]]$RequiredFiles,
+
+        [Parameter(Mandatory = $true)]
+        [string[]]$ChangedFiles,
+
+        [string[]]$ExpectedMissingFiles = @(),
+
+        [string[]]$ExpectedExcludedFiles = @(),
+
+        [int]$ExistingRecoveryCount = 0,
+
+        [bool]$ExpectRecoveryPrompt = $true
+    )
+
+    $tmpRoot = Join-Path $env:TEMP (
+        "planpilot-test-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    $scenarioRoot = New-IsolatedScenarioRoot -Name $Name -Root $tmpRoot
+
+    if ($scenarioRoot.Cleanup -eq "none") {
+        Write-TestResult `
+            -Name "$Name isolated repository creation" `
+            -Passed $false `
+            -Detail $scenarioRoot.Error
+
+        return
+    }
+
+    try {
+        Copy-Item `
+            -LiteralPath (
+                Join-Path $repoRoot "scripts\ai-dev-auto-cycle-full.ps1"
+            ) `
+            -Destination (
+                Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
+            ) `
+            -Force
+
+        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+
+        foreach ($changedFile in @($ChangedFiles)) {
+            $changedPath = Join-Path $tmpRoot $changedFile
+            $changedDirectory = Split-Path -Parent $changedPath
+
+            if (-not [string]::IsNullOrWhiteSpace($changedDirectory)) {
+                [System.IO.Directory]::CreateDirectory($changedDirectory) | Out-Null
+            }
+
+            [System.IO.File]::WriteAllText(
+                $changedPath,
+                "changed by test",
+                $utf8WithBom
+            )
+        }
+
+        $fakeScripts = @(
+            "ai-dev-check.ps1",
+            "ai-dev-save-diff.ps1",
+            "ai-dev-make-review-prompt.ps1"
+        )
+
+        foreach ($fakeScript in $fakeScripts) {
+            [System.IO.File]::WriteAllText(
+                (Join-Path $tmpRoot "scripts\$fakeScript"),
+                "exit 0`r`n",
+                $utf8WithBom
+            )
+        }
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-make-revise-prompt.ps1"),
+            @'
+$promptPath = Join-Path (Get-Location) ".ai-dev\revise-prompt.md"
+[System.IO.File]::WriteAllText($promptPath, "GENERAL REVISE PROMPT", (New-Object System.Text.UTF8Encoding($true)))
+exit 0
+'@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-run-codex.ps1"),
+            "exit 0`r`n",
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-run-review-codex.ps1"),
+            @'
+$repoRoot = Get-Location
+$statePath = Join-Path $repoRoot ".ai-dev\state.json"
+$reviewPath = Join-Path $repoRoot ".ai-dev\review-response.json"
+$state = Get-Content -LiteralPath $statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+$review = Get-Content -LiteralPath $reviewPath -Raw -Encoding UTF8 | ConvertFrom-Json
+$state.lastCommand = "save-review"
+$state.lastCommandStatus = "passed"
+$state.lastReviewDecision = "revise"
+$state.updatedAt = "2026-01-01T00:00:00Z"
+$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+[System.IO.File]::WriteAllText($statePath, ($state | ConvertTo-Json -Depth 30), $utf8WithBom)
+[System.IO.File]::WriteAllText($reviewPath, ($review | ConvertTo-Json -Depth 30), $utf8WithBom)
+exit 0
+'@,
+            $utf8WithBom
+        )
+
+        $queue = [PSCustomObject][ordered]@{
+            goalTitle = "Review recovery test"
+            goalSource = ".ai-dev/goal.md"
+            currentTaskId = "T001"
+            tasks = @(
+                [PSCustomObject][ordered]@{
+                    id = "T001"
+                    title = "Review recovery test"
+                    description = "Verify required_changes recovery compares actual changedFiles."
+                    type = "verification"
+                    status = "in_progress"
+                    priority = "P0"
+                    dependsOn = @()
+                    filesLikelyToChange = @($RequiredFiles)
+                    verification = @("Run behavior test.")
+                    commitMessage = $null
+                }
+            )
+        }
+
+        $counts = [PSCustomObject][ordered]@{}
+
+        if ($ExistingRecoveryCount -gt 0) {
+            $counts | Add-Member `
+                -NotePropertyName "review_revise_repeated" `
+                -NotePropertyValue $ExistingRecoveryCount
+        }
+
+        $state = [PSCustomObject][ordered]@{
+            goalStatus = "in_progress"
+            currentTaskId = "T001"
+            currentLoop = 0
+            maxLoopsPerTask = 2
+            repeatedFailureCount = 0
+            lastCommand = "save-review"
+            lastCommandStatus = "passed"
+            lastErrorSummary = $null
+            lastReviewDecision = "revise"
+            lastReviewSeverity = "medium"
+            lastReviewNextStep = "revise_with_codex"
+            lastCommitHash = $null
+            startedAt = "2026-01-01T00:00:00Z"
+            updatedAt = "2026-01-01T00:00:00Z"
+            stopReason = $null
+            autoRecovery = [PSCustomObject][ordered]@{
+                T001 = [PSCustomObject][ordered]@{
+                    counts = $counts
+                    lastStoppedReason = $null
+                }
+            }
+        }
+
+        $requiredChanges = @(
+            @($RequiredFiles) |
+                ForEach-Object {
+                    [PSCustomObject][ordered]@{
+                        file = $_
+                        reason = "required by test"
+                        suggestion = "change only if missing"
+                    }
+                }
+        )
+
+        $reviewResponse = [PSCustomObject][ordered]@{
+            decision = "revise"
+            severity = "medium"
+            summary = "Review repeated with required files."
+            required_changes = @($requiredChanges)
+            next_step = "revise_with_codex"
+        }
+
+        Set-JsonFile `
+            -Path (Join-Path $tmpRoot ".ai-dev\queue.json") `
+            -Value $queue
+
+        Set-JsonFile `
+            -Path (Join-Path $tmpRoot ".ai-dev\state.json") `
+            -Value $state
+
+        Set-JsonFile `
+            -Path (Join-Path $tmpRoot ".ai-dev\review-response.json") `
+            -Value $reviewResponse
+
+        Push-Location $tmpRoot
+
+        try {
+            $protectedPaths = @(
+                "scripts/ai-dev-auto-cycle-full.ps1",
+                "scripts/ai-dev-make-prompt.ps1",
+                "scripts/ai-dev-run-codex.ps1",
+                "scripts/ai-dev-check.ps1",
+                "scripts/ai-dev-save-diff.ps1",
+                "scripts/ai-dev-make-review-prompt.ps1",
+                "scripts/ai-dev-run-review-codex.ps1",
+                "scripts/ai-dev-complete-task.ps1"
+            )
+            $protectedPathArgument = $protectedPaths -join ","
+
+            $output = & powershell `
+                -NoProfile `
+                -ExecutionPolicy Bypass `
+                -File ".\scripts\ai-dev-auto-cycle-full.ps1" `
+                -AllowCodex `
+                -AllowReviewCodex `
+                -AllowDirty `
+                -ProtectedBaselineDirtyPaths $protectedPathArgument `
+                -MaxTasks 1 `
+                -MaxSteps 40 2>&1
+            $scenarioExitCode = $LASTEXITCODE
+            $outputText = $output | Out-String
+        }
+        finally {
+            Pop-Location
+        }
+
+        $promptPath = Join-Path $tmpRoot ".ai-dev\revise-prompt.md"
+        $promptText = ""
+
+        if ([System.IO.File]::Exists($promptPath)) {
+            $promptText = Get-Content -LiteralPath $promptPath -Raw -Encoding UTF8
+        }
+
+        $isRecoveryPrompt = $promptText.Contains("# Required Files Recovery Prompt")
+        $missingSection = Get-MissingRequiredFilesSection $promptText
+        $missingFilesPresent = $true
+
+        foreach ($expectedMissingFile in @($ExpectedMissingFiles)) {
+            if (-not $missingSection.Contains($expectedMissingFile)) {
+                $missingFilesPresent = $false
+            }
+        }
+
+        $excludedFilesAbsent = $true
+
+        foreach ($expectedExcludedFile in @($ExpectedExcludedFiles)) {
+            if ($missingSection.Contains($expectedExcludedFile)) {
+                $excludedFilesAbsent = $false
+            }
+        }
+
+        $unexpectedRecovery = (-not $ExpectRecoveryPrompt) -and $isRecoveryPrompt
+        $staleStopped = $outputText.Contains("Stopped reason: stale_review_required_file_missing")
+
+        Write-TestResult `
+            -Name "$Name recovery prompt expectation" `
+            -Passed (($ExpectRecoveryPrompt -and $isRecoveryPrompt) -or (-not $ExpectRecoveryPrompt -and -not $isRecoveryPrompt)) `
+            -Detail "ExpectedRecoveryPrompt=$ExpectRecoveryPrompt ExitCode=$scenarioExitCode"
+
+        Write-TestResult `
+            -Name "$Name missing files section includes only expected targets" `
+            -Passed (
+                (-not $unexpectedRecovery) -and
+                $missingFilesPresent -and
+                $excludedFilesAbsent
+            ) `
+            -Detail "MissingSection=$missingSection"
+
+        Write-TestResult `
+            -Name "$Name does not stop as stale required file missing" `
+            -Passed (-not $staleStopped) `
+            -Detail "ExitCode=$scenarioExitCode"
+    }
+    catch {
+        Write-TestResult `
+            -Name "$Name execution" `
+            -Passed $false `
+            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
+    }
+    finally {
+        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
+    }
+}
+
+function New-TestResultContent {
+    param(
+        [string]$TaskId,
+        [string]$OverallResult = "passed"
+    )
+
+    $commandStatus = if ($OverallResult -eq "passed") { "passed" } else { "failed" }
+
+    return @"
+# AI Dev Test Result
+
+## 2026-01-01 00:00:00
+
+- Overall result: $OverallResult
+- Current task: $TaskId
+- Mode: standard
+- Commands:
+  - npm run build: $commandStatus
+  - npm run test: $commandStatus
+  - npm run lint: $commandStatus
+"@
+}
+
+function New-ReviewPromptContent {
+    param(
+        [string]$TaskId
+    )
+
+    return @"
+# AI Dev Review Prompt
+
+## Current Task
+
+- Task ID: $TaskId
+- Title: Resume review test
+- Type: implementation
+"@
+}
+
+function New-DiffContent {
+    param(
+        [string[]]$AppChangeFiles
+    )
+
+    $appFilesText = if ($AppChangeFiles.Count -gt 0) {
+        (@($AppChangeFiles) | ForEach-Object { "- $_" }) -join "`r`n"
+    } else {
+        "- 없음"
+    }
+
+    return @"
+# AI Dev Diff
+
+## Generated At
+
+2026-01-01 00:00:00
+
+## App Change Files
+
+$appFilesText
+
+## Unstaged Diff
+
+~~~text
+변경 없음
+~~~
+"@
+}
+
+function New-PassReviewResponse {
+    return [PSCustomObject][ordered]@{
+        decision = "pass"
+        severity = "none"
+        summary = "Saved pass review."
+        required_changes = @()
+        optional_suggestions = @()
+        next_step = "complete_task"
+    }
+}
+
+function Invoke-AutoCycleResumeScenario {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$Name,
+
+        [bool]$InitialSavedReview = $false,
+
+        [string]$InitialReviewTaskId = "T001",
+
+        [string]$InitialTestTaskId = "T001",
+
+        [string]$InitialTestResult = "passed",
+
+        [string[]]$InitialDiffAppFiles = @(),
+
+        [string]$InitialLastCommitHash = "",
+
+        [string]$InitialTaskCommitHash = "",
+
+        [string]$CodexResultAfterRun = "",
+
+        [bool]$FakeCheckPasses = $true,
+
+        [string]$ExpectedStoppedReason = "",
+
+        [bool]$ExpectRunCodex = $false,
+
+        [bool]$ExpectRunReviewCodex = $false,
+
+        [bool]$ExpectCompleteTask = $false,
+
+        [bool]$ExpectMissingImplementation = $false
+    )
+
+    $tmpRoot = Join-Path $env:TEMP (
+        "planpilot-test-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    $scenarioRoot = New-IsolatedScenarioRoot -Name $Name -Root $tmpRoot
+
+    if ($scenarioRoot.Cleanup -eq "none") {
+        Write-TestResult `
+            -Name "$Name isolated repository creation" `
+            -Passed $false `
+            -Detail $scenarioRoot.Error
+
+        return
+    }
+
+    $markerRoot = Join-Path $env:TEMP (
+        "planpilot-marker-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    try {
+        [System.IO.Directory]::CreateDirectory($markerRoot) | Out-Null
+
+        Copy-Item `
+            -LiteralPath (
+                Join-Path $repoRoot "scripts\ai-dev-auto-cycle-full.ps1"
+            ) `
+            -Destination (
+                Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
+            ) `
+            -Force
+
+        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+        $headCommitHash = (& git -C $tmpRoot rev-parse HEAD 2>&1 | Out-String).Trim()
+        $lastCommitHash = if ($InitialLastCommitHash -eq "HEAD") {
+            $headCommitHash
+        } elseif ($InitialLastCommitHash -eq "NOT_HEAD") {
+            "0000000000000000000000000000000000000000"
+        } else {
+            $InitialLastCommitHash
+        }
+        $taskCommitHash = if ($InitialTaskCommitHash -eq "HEAD") {
+            $headCommitHash
+        } elseif ($InitialTaskCommitHash -eq "NOT_HEAD") {
+            "0000000000000000000000000000000000000000"
+        } else {
+            $InitialTaskCommitHash
+        }
+
+        $queue = [PSCustomObject][ordered]@{
+            goalTitle = "Resume review test"
+            goalSource = ".ai-dev/goal.md"
+            currentTaskId = "T001"
+            tasks = @(
+                [PSCustomObject][ordered]@{
+                    id = "T001"
+                    title = "Resume review test"
+                    description = "Verify saved review resume behavior."
+                    type = "implementation"
+                    status = "in_progress"
+                    priority = "P0"
+                    dependsOn = @()
+                    filesLikelyToChange = @("scripts/ai-dev-auto-cycle-full.ps1")
+                    verification = @("Run behavior test.")
+                    commitMessage = $null
+                }
+            )
+        }
+
+        if (-not [string]::IsNullOrWhiteSpace($taskCommitHash)) {
+            $queue.tasks[0] | Add-Member -NotePropertyName "commitHash" -NotePropertyValue $taskCommitHash -Force
+        }
+
+        $state = [PSCustomObject][ordered]@{
+            goalStatus = "in_progress"
+            currentTaskId = "T001"
+            currentLoop = 0
+            maxLoopsPerTask = 2
+            repeatedFailureCount = 0
+            lastCommand = if ($InitialSavedReview) { "save-review" } else { $null }
+            lastCommandStatus = if ($InitialSavedReview) { "passed" } else { "not_started" }
+            lastErrorSummary = $null
+            lastReviewDecision = if ($InitialSavedReview) { "pass" } else { "not_started" }
+            lastReviewSeverity = if ($InitialSavedReview) { "none" } else { $null }
+            lastReviewNextStep = if ($InitialSavedReview) { "complete_task" } else { $null }
+            lastCommitHash = if ([string]::IsNullOrWhiteSpace($lastCommitHash)) { $null } else { $lastCommitHash }
+            startedAt = "2026-01-01T00:00:00Z"
+            updatedAt = "2026-01-01T00:00:00Z"
+            stopReason = $null
+        }
+
+        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\queue.json") -Value $queue
+        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\state.json") -Value $state
+        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\review-response.json") -Value (New-PassReviewResponse)
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot ".ai-dev\test-result.md"),
+            (New-TestResultContent -TaskId $InitialTestTaskId -OverallResult $InitialTestResult),
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot ".ai-dev\review-prompt.md"),
+            (New-ReviewPromptContent -TaskId $InitialReviewTaskId),
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot ".ai-dev\diff.md"),
+            (New-DiffContent -AppChangeFiles $InitialDiffAppFiles),
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot ".ai-dev\codex-result.md"),
+            "",
+            $utf8WithBom
+        )
+
+        $escapedMarkerRoot = ([string]$markerRoot).Replace("'", "''")
+        $escapedCodexResult = ([string]$CodexResultAfterRun).Replace("'", "''")
+        $checkExitCode = if ($FakeCheckPasses) { 0 } else { 1 }
+        $checkOverallResult = if ($FakeCheckPasses) { "passed" } else { "failed" }
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-make-prompt.ps1"),
+            "exit 0`r`n",
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-run-codex.ps1"),
+            @"
+[System.IO.File]::WriteAllText('$escapedMarkerRoot\run-codex.txt', 'called', [System.Text.Encoding]::ASCII)
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\codex-result.md'), '$escapedCodexResult', (New-Object System.Text.UTF8Encoding(`$true)))
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-check.ps1"),
+            @"
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+`$state.lastCommand = 'npm run lint'
+`$state.lastCommandStatus = '$checkOverallResult'
+`$state.updatedAt = '2026-01-01T00:00:00Z'
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\test-result.md'), @'
+$(New-TestResultContent -TaskId "T001" -OverallResult $checkOverallResult)
+'@, `$utf8WithBom)
+exit $checkExitCode
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-save-diff.ps1"),
+            @"
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+`$state.lastCommand = 'save-diff'
+`$state.lastCommandStatus = 'passed'
+`$state.updatedAt = '2026-01-01T00:00:00Z'
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\diff.md'), @'
+$(New-DiffContent -AppChangeFiles @())
+'@, `$utf8WithBom)
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-make-review-prompt.ps1"),
+            @"
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\review-prompt.md'), @'
+$(New-ReviewPromptContent -TaskId "T001")
+'@, (New-Object System.Text.UTF8Encoding(`$true)))
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-run-review-codex.ps1"),
+            @"
+[System.IO.File]::WriteAllText('$escapedMarkerRoot\run-review-codex.txt', 'called', [System.Text.Encoding]::ASCII)
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$reviewPath = Join-Path (Get-Location) '.ai-dev\review-response.json'
+`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+`$state.lastCommand = 'save-review'
+`$state.lastCommandStatus = 'passed'
+`$state.lastReviewDecision = 'pass'
+`$state.lastReviewSeverity = 'none'
+`$state.lastReviewNextStep = 'complete_task'
+`$state.updatedAt = '2026-01-01T00:00:00Z'
+`$review = [PSCustomObject][ordered]@{
+    decision = 'pass'
+    severity = 'none'
+    summary = 'Fresh pass review.'
+    required_changes = @()
+    optional_suggestions = @()
+    next_step = 'complete_task'
+}
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+[System.IO.File]::WriteAllText(`$reviewPath, (`$review | ConvertTo-Json -Depth 30), `$utf8WithBom)
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-complete-task.ps1"),
+            @"
+[System.IO.File]::WriteAllText('$escapedMarkerRoot\complete-task.txt', 'called', [System.Text.Encoding]::ASCII)
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        $fixtureScriptPaths = @(
+            "scripts/ai-dev-auto-cycle-full.ps1",
+            "scripts/ai-dev-make-prompt.ps1",
+            "scripts/ai-dev-run-codex.ps1",
+            "scripts/ai-dev-check.ps1",
+            "scripts/ai-dev-save-diff.ps1",
+            "scripts/ai-dev-make-review-prompt.ps1",
+            "scripts/ai-dev-run-review-codex.ps1",
+            "scripts/ai-dev-complete-task.ps1"
+        )
+        $protectedPathArgument = $fixtureScriptPaths -join ","
+
+        & git -C $tmpRoot update-index --assume-unchanged -- $fixtureScriptPaths |
+            Out-Null
+
+        Push-Location $tmpRoot
+
+        try {
+            $previousErrorActionPreference = $ErrorActionPreference
+            $ErrorActionPreference = "Continue"
+            $output = & powershell `
+                -NoProfile `
+                -ExecutionPolicy Bypass `
+                -File ".\scripts\ai-dev-auto-cycle-full.ps1" `
+                -AllowCodex `
+                -AllowReviewCodex `
+                -AllowDirty `
+                -ProtectedBaselineDirtyPaths $protectedPathArgument `
+                -MaxTasks 1 `
+                -MaxSteps 40 2>&1
+            $scenarioExitCode = $LASTEXITCODE
+            $outputText = $output | Out-String
+        }
+        finally {
+            $ErrorActionPreference = $previousErrorActionPreference
+            Pop-Location
+        }
+
+        $runCodexCalled = [System.IO.File]::Exists((Join-Path $markerRoot "run-codex.txt"))
+        $runReviewCalled = [System.IO.File]::Exists((Join-Path $markerRoot "run-review-codex.txt"))
+        $completeTaskCalled = [System.IO.File]::Exists((Join-Path $markerRoot "complete-task.txt"))
+        $stoppedReasonMatched = if ([string]::IsNullOrWhiteSpace($ExpectedStoppedReason)) {
+            $true
+        } else {
+            $outputText.Contains("Stopped reason: $ExpectedStoppedReason")
+        }
+        $missingImplementationDetected = $outputText.Contains("Stopped reason: missing_implementation")
+        $stoppedReasonDetail = if ($stoppedReasonMatched) {
+            "Expected=$ExpectedStoppedReason ExitCode=$scenarioExitCode"
+        } else {
+            "Expected=$ExpectedStoppedReason ExitCode=$scenarioExitCode OutputPreview=" +
+                (($outputText.Replace("`r", " ").Replace("`n", " ")).Trim())
+        }
+
+        Write-TestResult `
+            -Name "$Name stopped reason expectation" `
+            -Passed $stoppedReasonMatched `
+            -Detail $stoppedReasonDetail
+
+        Write-TestResult `
+            -Name "$Name run-codex expectation" `
+            -Passed ($runCodexCalled -eq $ExpectRunCodex) `
+            -Detail "Expected=$ExpectRunCodex Actual=$runCodexCalled"
+
+        Write-TestResult `
+            -Name "$Name run-review-codex expectation" `
+            -Passed ($runReviewCalled -eq $ExpectRunReviewCodex) `
+            -Detail "Expected=$ExpectRunReviewCodex Actual=$runReviewCalled"
+
+        Write-TestResult `
+            -Name "$Name complete-task expectation" `
+            -Passed ($completeTaskCalled -eq $ExpectCompleteTask) `
+            -Detail "Expected=$ExpectCompleteTask Actual=$completeTaskCalled"
+
+        Write-TestResult `
+            -Name "$Name missing_implementation expectation" `
+            -Passed ($missingImplementationDetected -eq $ExpectMissingImplementation) `
+            -Detail "Expected=$ExpectMissingImplementation Actual=$missingImplementationDetected"
+    }
+    catch {
+        Write-TestResult `
+            -Name "$Name execution" `
+            -Passed $false `
+            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
+    }
+    finally {
+        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
+
+        if ([System.IO.Directory]::Exists($markerRoot)) {
+            [System.IO.Directory]::Delete($markerRoot, $true)
+        }
+    }
+}
+
+function Invoke-RecoveryCoverageScenario {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$Name,
+
+        [int]$CheckFailuresBeforeSuccess = 0,
+
+        [int]$ReviewJsonFailuresBeforeSuccess = 0,
+
+        [bool]$StaleReviewJsonFailureState = $false,
+
+        [ValidateSet("none", "scripts", "dependencies", "packageLock")]
+        [string]$PackageMutation = "none",
+
+        [string]$CurrentTaskId = "T001",
+
+        [string]$SeedRecoveryTaskId = "",
+
+        [string]$SeedRecoveryType = "",
+
+        [int]$SeedRecoveryCount = 0,
+
+        [string]$ExpectedStoppedReason = "allow_commit_required",
+
+        [int]$ExpectedRunCodexCount = 1,
+
+        [int]$ExpectedCheckCount = 1,
+
+        [int]$ExpectedReviewCodexCount = 1,
+
+        [string]$ExpectedRecoveryType = "",
+
+        [int]$ExpectedRecoveryCount = 0,
+
+        [bool]$ExpectRawPreserved = $false,
+
+        [bool]$ExpectRevisePromptHasTestResult = $false
+    )
+
+    $tmpRoot = Join-Path $env:TEMP (
+        "planpilot-recovery-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    $scenarioRoot = New-IsolatedScenarioRoot -Name $Name -Root $tmpRoot
+
+    if ($scenarioRoot.Cleanup -eq "none") {
+        Write-TestResult `
+            -Name "$Name isolated repository creation" `
+            -Passed $false `
+            -Detail $scenarioRoot.Error
+
+        return
+    }
+
+    $markerRoot = Join-Path $env:TEMP (
+        "planpilot-recovery-marker-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    try {
+        [System.IO.Directory]::CreateDirectory($markerRoot) | Out-Null
+
+        Copy-Item `
+            -LiteralPath (
+                Join-Path $repoRoot "scripts\ai-dev-auto-cycle-full.ps1"
+            ) `
+            -Destination (
+                Join-Path $tmpRoot "scripts\ai-dev-auto-cycle-full.ps1"
+            ) `
+            -Force
+
+        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+        $escapedMarkerRoot = ([string]$markerRoot).Replace("'", "''")
+        $escapedCheckFailures = [int]$CheckFailuresBeforeSuccess
+        $escapedReviewFailures = [int]$ReviewJsonFailuresBeforeSuccess
+        $escapedCurrentTaskId = ([string]$CurrentTaskId).Replace("'", "''")
+        $escapedStaleReviewJsonFailureState = if ($StaleReviewJsonFailureState) { '$true' } else { '$false' }
+
+        $queue = [PSCustomObject][ordered]@{
+            goalTitle = "Recovery coverage test"
+            goalSource = ".ai-dev/goal.md"
+            currentTaskId = $CurrentTaskId
+            tasks = @(
+                [PSCustomObject][ordered]@{
+                    id = $CurrentTaskId
+                    title = "Recovery coverage test"
+                    description = "Verify automatic recovery branches."
+                    type = "implementation"
+                    status = "in_progress"
+                    priority = "P0"
+                    dependsOn = @()
+                    filesLikelyToChange = @("scripts/ai-dev-auto-cycle-full.ps1")
+                    verification = @("Run behavior test.")
+                    commitMessage = $null
+                }
+            )
+        }
+
+        $state = [PSCustomObject][ordered]@{
+            goalStatus = "in_progress"
+            currentTaskId = $CurrentTaskId
+            currentLoop = 0
+            maxLoopsPerTask = 2
+            repeatedFailureCount = 0
+            lastCommand = $null
+            lastCommandStatus = "not_started"
+            lastErrorSummary = $null
+            lastReviewDecision = "not_started"
+            lastReviewSeverity = $null
+            lastReviewNextStep = $null
+            lastCommitHash = $null
+            startedAt = "2026-01-01T00:00:00Z"
+            updatedAt = "2026-01-01T00:00:00Z"
+            stopReason = $null
+        }
+
+        if ($StaleReviewJsonFailureState) {
+            $state.lastCommand = "save-review"
+            $state.lastCommandStatus = "failed"
+            $state.stopReason = "review_json_extraction_failed"
+        }
+
+        if (
+            -not [string]::IsNullOrWhiteSpace($SeedRecoveryTaskId) -and
+            -not [string]::IsNullOrWhiteSpace($SeedRecoveryType) -and
+            $SeedRecoveryCount -gt 0
+        ) {
+            $seedCounts = [PSCustomObject][ordered]@{}
+            $seedCounts | Add-Member -NotePropertyName $SeedRecoveryType -NotePropertyValue $SeedRecoveryCount
+            $seedTaskState = [PSCustomObject][ordered]@{
+                counts = $seedCounts
+                lastStoppedReason = $null
+            }
+            $seedRecovery = [PSCustomObject][ordered]@{}
+            $seedRecovery | Add-Member -NotePropertyName $SeedRecoveryTaskId -NotePropertyValue $seedTaskState
+            $state | Add-Member -NotePropertyName "autoRecovery" -NotePropertyValue $seedRecovery
+        }
+
+        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\queue.json") -Value $queue
+        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\state.json") -Value $state
+        Set-JsonFile -Path (Join-Path $tmpRoot ".ai-dev\review-response.json") -Value (New-PassReviewResponse)
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot ".ai-dev\codex-result.md"),
+            "",
+            $utf8WithBom
+        )
+
+        switch ($PackageMutation) {
+            "scripts" {
+                $packagePath = Join-Path $tmpRoot "package.json"
+                $package = Get-Content -LiteralPath $packagePath -Raw -Encoding UTF8 | ConvertFrom-Json
+                if (-not ($package.PSObject.Properties.Name -contains "scripts") -or $null -eq $package.scripts) {
+                    $package | Add-Member -NotePropertyName "scripts" -NotePropertyValue ([PSCustomObject][ordered]@{})
+                }
+                $package.scripts | Add-Member -NotePropertyName "ai-dev-safe-script" -NotePropertyValue "echo safe" -Force
+                [System.IO.File]::WriteAllText($packagePath, ($package | ConvertTo-Json -Depth 50), $utf8WithBom)
+            }
+            "dependencies" {
+                $packagePath = Join-Path $tmpRoot "package.json"
+                $package = Get-Content -LiteralPath $packagePath -Raw -Encoding UTF8 | ConvertFrom-Json
+                if (-not ($package.PSObject.Properties.Name -contains "dependencies") -or $null -eq $package.dependencies) {
+                    $package | Add-Member -NotePropertyName "dependencies" -NotePropertyValue ([PSCustomObject][ordered]@{})
+                }
+                $package.dependencies | Add-Member -NotePropertyName "ai-dev-blocked-dep" -NotePropertyValue "1.0.0" -Force
+                [System.IO.File]::WriteAllText($packagePath, ($package | ConvertTo-Json -Depth 50), $utf8WithBom)
+            }
+            "packageLock" {
+                $lockPath = Join-Path $tmpRoot "package-lock.json"
+                [System.IO.File]::AppendAllText($lockPath, "`r`n", $utf8WithBom)
+            }
+        }
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-make-prompt.ps1"),
+            "exit 0`r`n",
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-run-codex.ps1"),
+            @"
+`$countPath = '$escapedMarkerRoot\run-codex-count.txt'
+`$argsPath = '$escapedMarkerRoot\run-codex-args.txt'
+`$count = if ([System.IO.File]::Exists(`$countPath)) { [int]([System.IO.File]::ReadAllText(`$countPath).Trim()) } else { 0 }
+`$count++
+[System.IO.File]::WriteAllText(`$countPath, [string]`$count, [System.Text.Encoding]::ASCII)
+[System.IO.File]::AppendAllText(`$argsPath, ((`$args -join ' ') + "`r`n"), [System.Text.Encoding]::ASCII)
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\codex-result.md'), 'fake implementation', (New-Object System.Text.UTF8Encoding(`$true)))
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-check.ps1"),
+            @"
+`$countPath = '$escapedMarkerRoot\check-count.txt'
+`$count = if ([System.IO.File]::Exists(`$countPath)) { [int]([System.IO.File]::ReadAllText(`$countPath).Trim()) } else { 0 }
+`$count++
+[System.IO.File]::WriteAllText(`$countPath, [string]`$count, [System.Text.Encoding]::ASCII)
+`$failed = `$count -le $escapedCheckFailures
+`$overall = if (`$failed) { 'failed' } else { 'passed' }
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+`$state.lastCommand = 'npm run lint'
+`$state.lastCommandStatus = `$overall
+`$state.updatedAt = '2026-01-01T00:00:00Z'
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+`$testLines = @(
+    '# Test Result',
+    '',
+    '- Task ID: $escapedCurrentTaskId',
+    ('- Overall Result: ' + `$overall),
+    '',
+    'Failure detail marker from fake check.'
+)
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\test-result.md'), (`$testLines -join "`r`n"), `$utf8WithBom)
+if (`$failed) { exit 1 }
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-save-diff.ps1"),
+            @"
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+`$state.lastCommand = 'save-diff'
+`$state.lastCommandStatus = 'passed'
+`$state.updatedAt = '2026-01-01T00:00:00Z'
+`$changedFiles = @('scripts/ai-dev-auto-cycle-full.ps1')
+if ('$PackageMutation' -eq 'scripts' -or '$PackageMutation' -eq 'dependencies') { `$changedFiles += 'package.json' }
+if ('$PackageMutation' -eq 'packageLock') { `$changedFiles += 'package-lock.json' }
+`$diffLines = @('# Diff Summary', '', '## App Change Files') + (`$changedFiles | ForEach-Object { '- ' + `$_ })
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\diff.md'), (`$diffLines -join "`r`n"), `$utf8WithBom)
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-make-review-prompt.ps1"),
+            @"
+[System.IO.File]::WriteAllText((Join-Path (Get-Location) '.ai-dev\review-prompt.md'), @'
+$(New-ReviewPromptContent -TaskId $CurrentTaskId)
+'@, (New-Object System.Text.UTF8Encoding(`$true)))
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-run-review-codex.ps1"),
+            @"
+`$countPath = '$escapedMarkerRoot\run-review-count.txt'
+`$count = if ([System.IO.File]::Exists(`$countPath)) { [int]([System.IO.File]::ReadAllText(`$countPath).Trim()) } else { 0 }
+`$count++
+[System.IO.File]::WriteAllText(`$countPath, [string]`$count, [System.Text.Encoding]::ASCII)
+`$statePath = Join-Path (Get-Location) '.ai-dev\state.json'
+`$reviewPath = Join-Path (Get-Location) '.ai-dev\review-response.json'
+`$rawPath = Join-Path (Get-Location) '.ai-dev\codex-review-result.md'
+`$state = Get-Content -LiteralPath `$statePath -Raw -Encoding UTF8 | ConvertFrom-Json
+`$utf8WithBom = New-Object System.Text.UTF8Encoding(`$true)
+if ($escapedStaleReviewJsonFailureState) {
+    [System.IO.File]::WriteAllText(`$rawPath, "NON JSON FAILURE WITH STALE STATE", `$utf8WithBom)
+    exit 1
+}
+if (`$count -le $escapedReviewFailures) {
+    `$state.lastCommand = 'save-review'
+    `$state.lastCommandStatus = 'failed'
+    `$state.stopReason = 'review_json_extraction_failed'
+    `$state.updatedAt = '2026-01-01T00:00:00Z'
+    [System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+    [System.IO.File]::WriteAllText(`$rawPath, "RAW REVIEW RESPONSE `$count", `$utf8WithBom)
+    exit 1
+}
+`$state.lastCommand = 'save-review'
+`$state.lastCommandStatus = 'passed'
+`$state.lastReviewDecision = 'pass'
+`$state.lastReviewSeverity = 'none'
+`$state.lastReviewNextStep = 'complete_task'
+`$state.stopReason = `$null
+`$state.updatedAt = '2026-01-01T00:00:00Z'
+`$review = [PSCustomObject][ordered]@{
+    decision = 'pass'
+    severity = 'none'
+    summary = 'Fresh pass review.'
+    required_changes = @()
+    optional_suggestions = @()
+    next_step = 'complete_task'
+}
+[System.IO.File]::WriteAllText(`$statePath, (`$state | ConvertTo-Json -Depth 30), `$utf8WithBom)
+[System.IO.File]::WriteAllText(`$reviewPath, (`$review | ConvertTo-Json -Depth 30), `$utf8WithBom)
+exit 0
+"@,
+            $utf8WithBom
+        )
+
+        [System.IO.File]::WriteAllText(
+            (Join-Path $tmpRoot "scripts\ai-dev-complete-task.ps1"),
+            "exit 0`r`n",
+            $utf8WithBom
+        )
+
+        $fixtureScriptPaths = @(
+            "scripts/ai-dev-auto-cycle-full.ps1",
+            "scripts/ai-dev-make-prompt.ps1",
+            "scripts/ai-dev-run-codex.ps1",
+            "scripts/ai-dev-check.ps1",
+            "scripts/ai-dev-save-diff.ps1",
+            "scripts/ai-dev-make-review-prompt.ps1",
+            "scripts/ai-dev-run-review-codex.ps1",
+            "scripts/ai-dev-complete-task.ps1"
+        )
+        $protectedPathArgument = $fixtureScriptPaths -join ","
+
+        & git -C $tmpRoot update-index --assume-unchanged -- $fixtureScriptPaths |
+            Out-Null
+
+        Push-Location $tmpRoot
+
+        try {
+            $previousErrorActionPreference = $ErrorActionPreference
+            $ErrorActionPreference = "Continue"
+            $output = & powershell `
+                -NoProfile `
+                -ExecutionPolicy Bypass `
+                -File ".\scripts\ai-dev-auto-cycle-full.ps1" `
+                -AllowCodex `
+                -AllowReviewCodex `
+                -AllowDirty `
+                -ProtectedBaselineDirtyPaths $protectedPathArgument `
+                -MaxTasks 1 `
+                -MaxSteps 40 2>&1
+            $scenarioExitCode = $LASTEXITCODE
+            $outputText = $output | Out-String
+        }
+        finally {
+            $ErrorActionPreference = $previousErrorActionPreference
+            Pop-Location
+        }
+
+        $runCodexCountPath = Join-Path $markerRoot "run-codex-count.txt"
+        $checkCountPath = Join-Path $markerRoot "check-count.txt"
+        $runReviewCountPath = Join-Path $markerRoot "run-review-count.txt"
+        $runCodexCount = if ([System.IO.File]::Exists($runCodexCountPath)) { [int]([System.IO.File]::ReadAllText($runCodexCountPath).Trim()) } else { 0 }
+        $checkCount = if ([System.IO.File]::Exists($checkCountPath)) { [int]([System.IO.File]::ReadAllText($checkCountPath).Trim()) } else { 0 }
+        $runReviewCount = if ([System.IO.File]::Exists($runReviewCountPath)) { [int]([System.IO.File]::ReadAllText($runReviewCountPath).Trim()) } else { 0 }
+        $stateAfter = Get-Content -LiteralPath (Join-Path $tmpRoot ".ai-dev\state.json") -Raw -Encoding UTF8 | ConvertFrom-Json
+        $rawFiles = @(Get-ChildItem -LiteralPath (Join-Path $tmpRoot ".ai-dev") -Filter "codex-review-result.review_json_extraction_failed.*.raw.md" -File)
+        $rawTextMatched = $false
+
+        if ($rawFiles.Count -gt 0) {
+            $rawTextMatched = ((Get-Content -LiteralPath $rawFiles[0].FullName -Raw -Encoding UTF8).Contains("RAW REVIEW RESPONSE 1"))
+        }
+
+        $actualRecoveryCount = 0
+
+        if (
+            -not [string]::IsNullOrWhiteSpace($ExpectedRecoveryType) -and
+            ($stateAfter.PSObject.Properties.Name -contains "autoRecovery") -and
+            $null -ne $stateAfter.autoRecovery -and
+            ($stateAfter.autoRecovery.PSObject.Properties.Name -contains $CurrentTaskId) -and
+            $null -ne $stateAfter.autoRecovery.$CurrentTaskId.counts -and
+            ($stateAfter.autoRecovery.$CurrentTaskId.counts.PSObject.Properties.Name -contains $ExpectedRecoveryType)
+        ) {
+            $actualRecoveryCount = [int]$stateAfter.autoRecovery.$CurrentTaskId.counts.$ExpectedRecoveryType
+        }
+
+        $sameTaskSeedStillPresent = $true
+
+        if (
+            -not [string]::IsNullOrWhiteSpace($SeedRecoveryTaskId) -and
+            $SeedRecoveryTaskId -ne $CurrentTaskId
+        ) {
+            $sameTaskSeedStillPresent = (
+                ($stateAfter.autoRecovery.PSObject.Properties.Name -contains $SeedRecoveryTaskId) -and
+                ($stateAfter.autoRecovery.$SeedRecoveryTaskId.counts.PSObject.Properties.Name -contains $SeedRecoveryType) -and
+                ([int]$stateAfter.autoRecovery.$SeedRecoveryTaskId.counts.$SeedRecoveryType -eq $SeedRecoveryCount)
+            )
+        }
+
+        $revisePromptHasTestResult = $false
+        $revisePromptPath = Join-Path $tmpRoot ".ai-dev\revise-prompt.md"
+
+        if ([System.IO.File]::Exists($revisePromptPath)) {
+            $revisePrompt = Get-Content -LiteralPath $revisePromptPath -Raw -Encoding UTF8
+            $revisePromptHasTestResult = $revisePrompt.Contains("Failure detail marker from fake check.")
+        }
+
+        Write-TestResult `
+            -Name "$Name stopped reason expectation" `
+            -Passed ($outputText.Contains("Stopped reason: $ExpectedStoppedReason")) `
+            -Detail "Expected=$ExpectedStoppedReason ExitCode=$scenarioExitCode"
+
+        Write-TestResult `
+            -Name "$Name run-codex count" `
+            -Passed ($runCodexCount -eq $ExpectedRunCodexCount) `
+            -Detail "Expected=$ExpectedRunCodexCount Actual=$runCodexCount"
+
+        Write-TestResult `
+            -Name "$Name check count" `
+            -Passed ($checkCount -eq $ExpectedCheckCount) `
+            -Detail "Expected=$ExpectedCheckCount Actual=$checkCount"
+
+        Write-TestResult `
+            -Name "$Name review-codex count" `
+            -Passed ($runReviewCount -eq $ExpectedReviewCodexCount) `
+            -Detail "Expected=$ExpectedReviewCodexCount Actual=$runReviewCount"
+
+        if (-not [string]::IsNullOrWhiteSpace($ExpectedRecoveryType)) {
+            Write-TestResult `
+                -Name "$Name recovery count" `
+                -Passed ($actualRecoveryCount -eq $ExpectedRecoveryCount) `
+                -Detail "Type=$ExpectedRecoveryType Expected=$ExpectedRecoveryCount Actual=$actualRecoveryCount"
+        }
+
+        Write-TestResult `
+            -Name "$Name raw review preservation" `
+            -Passed (($rawFiles.Count -gt 0 -and $rawTextMatched) -eq $ExpectRawPreserved) `
+            -Detail "Expected=$ExpectRawPreserved RawFiles=$($rawFiles.Count)"
+
+        Write-TestResult `
+            -Name "$Name revise prompt test-result content" `
+            -Passed ($revisePromptHasTestResult -eq $ExpectRevisePromptHasTestResult) `
+            -Detail "Expected=$ExpectRevisePromptHasTestResult Actual=$revisePromptHasTestResult"
+
+        Write-TestResult `
+            -Name "$Name seeded recovery isolation" `
+            -Passed $sameTaskSeedStillPresent `
+            -Detail "SeedTask=$SeedRecoveryTaskId CurrentTask=$CurrentTaskId"
+    }
+    catch {
+        Write-TestResult `
+            -Name "$Name execution" `
+            -Passed $false `
+            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
+    }
+    finally {
+        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
+
+        if ([System.IO.Directory]::Exists($markerRoot)) {
+            [System.IO.Directory]::Delete($markerRoot, $true)
+        }
+    }
+}
+
 Write-Host "AI Dev automation tests"
 Write-Host "Repository: $repoRoot"
 Write-Host ""
@@ -648,6 +1886,274 @@ Invoke-IsolatedScenario `
         "-MaxSteps", "40"
     )
 
+Invoke-ReviewRequiredFilesRecoveryScenario `
+    -Name "review-required-files-partial-diff" `
+    -RequiredFiles @("A.ps1", "B.ps1") `
+    -ChangedFiles @("A.ps1") `
+    -ExpectedMissingFiles @("B.ps1") `
+    -ExpectedExcludedFiles @("A.ps1") `
+    -ExpectRecoveryPrompt $true
+
+Invoke-ReviewRequiredFilesRecoveryScenario `
+    -Name "review-required-files-all-changed" `
+    -RequiredFiles @("A.ps1", "B.ps1") `
+    -ChangedFiles @("A.ps1", "B.ps1") `
+    -ExpectedMissingFiles @() `
+    -ExpectedExcludedFiles @("A.ps1", "B.ps1") `
+    -ExpectRecoveryPrompt $false
+
+Invoke-ReviewRequiredFilesRecoveryScenario `
+    -Name "review-required-files-recovery-limit" `
+    -RequiredFiles @("A.ps1", "B.ps1") `
+    -ChangedFiles @("A.ps1") `
+    -ExpectedMissingFiles @() `
+    -ExpectedExcludedFiles @("A.ps1", "B.ps1") `
+    -ExistingRecoveryCount 1 `
+    -ExpectRecoveryPrompt $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "missing-implementation-no-diff-no-commit" `
+    -InitialSavedReview $false `
+    -CodexResultAfterRun "" `
+    -ExpectedStoppedReason "missing_implementation" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $true `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $true
+
+Invoke-AutoCycleResumeScenario `
+    -Name "saved-review-current-commit-resumes" `
+    -InitialSavedReview $true `
+    -InitialReviewTaskId "T001" `
+    -InitialTestTaskId "T001" `
+    -InitialTestResult "passed" `
+    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
+    -InitialLastCommitHash "HEAD" `
+    -InitialTaskCommitHash "HEAD" `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectRunCodex $false `
+    -ExpectRunReviewCodex $false `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "saved-review-pass-current-skips-review-codex" `
+    -InitialSavedReview $true `
+    -InitialReviewTaskId "T001" `
+    -InitialTestTaskId "T001" `
+    -InitialTestResult "passed" `
+    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
+    -InitialLastCommitHash "HEAD" `
+    -InitialTaskCommitHash "HEAD" `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectRunCodex $false `
+    -ExpectRunReviewCodex $false `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "saved-review-previous-task-head-reruns-codex" `
+    -InitialSavedReview $true `
+    -InitialReviewTaskId "T001" `
+    -InitialTestTaskId "T001" `
+    -InitialTestResult "passed" `
+    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
+    -InitialLastCommitHash "HEAD" `
+    -CodexResultAfterRun "fresh implementation" `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $true `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "saved-review-different-task-reruns-review" `
+    -InitialSavedReview $true `
+    -InitialReviewTaskId "T999" `
+    -InitialTestTaskId "T001" `
+    -InitialTestResult "passed" `
+    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
+    -InitialLastCommitHash "HEAD" `
+    -CodexResultAfterRun "fresh implementation" `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $true `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "saved-review-stale-fingerprint-reruns-review" `
+    -InitialSavedReview $true `
+    -InitialReviewTaskId "T001" `
+    -InitialTestTaskId "T999" `
+    -InitialTestResult "passed" `
+    -InitialDiffAppFiles @("stale-file.ps1") `
+    -InitialLastCommitHash "HEAD" `
+    -CodexResultAfterRun "fresh implementation" `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $true `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "saved-review-pass-test-failed-does-not-complete" `
+    -InitialSavedReview $true `
+    -InitialReviewTaskId "T001" `
+    -InitialTestTaskId "T001" `
+    -InitialTestResult "failed" `
+    -InitialDiffAppFiles @("scripts/ai-dev-auto-cycle-full.ps1") `
+    -InitialLastCommitHash "HEAD" `
+    -FakeCheckPasses $false `
+    -ExpectedStoppedReason "test_failed" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $false `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $false
+
+Invoke-AutoCycleResumeScenario `
+    -Name "previous-task-head-commit-not-implementation" `
+    -InitialSavedReview $false `
+    -InitialLastCommitHash "HEAD" `
+    -CodexResultAfterRun "" `
+    -ExpectedStoppedReason "missing_implementation" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $true `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $true
+
+Invoke-AutoCycleResumeScenario `
+    -Name "previous-task-commit-not-implementation" `
+    -InitialSavedReview $false `
+    -InitialLastCommitHash "NOT_HEAD" `
+    -CodexResultAfterRun "" `
+    -ExpectedStoppedReason "missing_implementation" `
+    -ExpectRunCodex $true `
+    -ExpectRunReviewCodex $true `
+    -ExpectCompleteTask $false `
+    -ExpectMissingImplementation $true
+
+Invoke-RecoveryCoverageScenario `
+    -Name "test-failed-recovers-once-then-passes" `
+    -CheckFailuresBeforeSuccess 1 `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectedRunCodexCount 2 `
+    -ExpectedCheckCount 2 `
+    -ExpectedReviewCodexCount 1 `
+    -ExpectedRecoveryType "test_failed" `
+    -ExpectedRecoveryCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $true
+
+Invoke-RecoveryCoverageScenario `
+    -Name "test-failed-twice-stops-without-extra-codex" `
+    -CheckFailuresBeforeSuccess 2 `
+    -ExpectedStoppedReason "test_failed" `
+    -ExpectedRunCodexCount 2 `
+    -ExpectedCheckCount 2 `
+    -ExpectedReviewCodexCount 0 `
+    -ExpectedRecoveryType "test_failed" `
+    -ExpectedRecoveryCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $true
+
+Invoke-RecoveryCoverageScenario `
+    -Name "review-json-extraction-recovers-once" `
+    -ReviewJsonFailuresBeforeSuccess 1 `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 2 `
+    -ExpectedRecoveryType "review_json_extraction_failed" `
+    -ExpectedRecoveryCount 1 `
+    -ExpectRawPreserved $true `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "review-json-extraction-twice-stops" `
+    -ReviewJsonFailuresBeforeSuccess 2 `
+    -ExpectedStoppedReason "review_json_extraction_failed" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 2 `
+    -ExpectedRecoveryType "review_json_extraction_failed" `
+    -ExpectedRecoveryCount 1 `
+    -ExpectRawPreserved $true `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "stale-review-json-stop-reason-does-not-recover" `
+    -StaleReviewJsonFailureState $true `
+    -ExpectedStoppedReason "run-review-codex_failed" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 1 `
+    -ExpectedRecoveryType "review_json_extraction_failed" `
+    -ExpectedRecoveryCount 0 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "package-scripts-only-allowed" `
+    -PackageMutation "scripts" `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "package-dependencies-blocked" `
+    -PackageMutation "dependencies" `
+    -ExpectedStoppedReason "package_files_changed" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "package-lock-blocked" `
+    -PackageMutation "packageLock" `
+    -ExpectedStoppedReason "package_files_changed" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "same-task-used-test-recovery-does-not-repeat" `
+    -CheckFailuresBeforeSuccess 1 `
+    -SeedRecoveryTaskId "T001" `
+    -SeedRecoveryType "test_failed" `
+    -SeedRecoveryCount 1 `
+    -ExpectedStoppedReason "test_failed" `
+    -ExpectedRunCodexCount 1 `
+    -ExpectedCheckCount 1 `
+    -ExpectedReviewCodexCount 0 `
+    -ExpectedRecoveryType "test_failed" `
+    -ExpectedRecoveryCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $false
+
+Invoke-RecoveryCoverageScenario `
+    -Name "new-task-test-recovery-count-is-independent" `
+    -CurrentTaskId "T002" `
+    -CheckFailuresBeforeSuccess 1 `
+    -SeedRecoveryTaskId "T001" `
+    -SeedRecoveryType "test_failed" `
+    -SeedRecoveryCount 1 `
+    -ExpectedStoppedReason "allow_commit_required" `
+    -ExpectedRunCodexCount 2 `
+    -ExpectedCheckCount 2 `
+    -ExpectedReviewCodexCount 1 `
+    -ExpectedRecoveryType "test_failed" `
+    -ExpectedRecoveryCount 1 `
+    -ExpectRawPreserved $false `
+    -ExpectRevisePromptHasTestResult $true
+
 Write-Host ""
 Write-Host (
     "Test summary: Passed={0}, Failed={1}" -f `
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.

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
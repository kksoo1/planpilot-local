# AI Dev Test Result

## 2026-08-02 23:58:55

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

[32m✓ built in 211ms[39m
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

Test summary: Passed=20, Failed=0
```
### npm run lint

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 lint
> eslint .
```
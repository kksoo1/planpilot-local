# AI Dev Test Result

## 2026-07-31 15:26:27

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

[32m✓ built in 327ms[39m
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
## Expected non-work cleanup verification

- Environment: isolated real Git worktrees
- Scripts under verification: scripts/ai-dev-auto-goal.ps1 and scripts/ai-dev-autopilot.ps1
- Verified scenarios: dirty_worktree, baseline_output_conflict, all_goal_candidates_excluded

### Scenario: dirty-worktree

- Expected stopped reason: dirty_worktree
- Exit code: 1
- Original stopped reason preserved: True
- expected_non_work classification preserved: True
- Baseline user marker preserved: True
- New dirty paths created: 0
- No new dirty paths: True
- Staged paths left behind: 0
- No staged paths left behind: True
- Manual git restore required for run-owned files: False

Baseline status:
```text
 M .ai-dev/loop-log.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

Status after execution:
```text
 M .ai-dev/loop-log.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

New dirty paths:
```text

```

Captured output:
```text
Step 1: validate-input
  Command: check GoalTitle/GoalDescription
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Input validation completed: Expected non-work verification
Step 2: dirty-worktree-gate
  Command: git status --porcelain
  Executed: False
  Skipped: True
  Exit code: 1
  Message: Baseline dirty count: 3
Worktree is dirty. Use -AllowDirty only when this is intentional.
 M .ai-dev/loop-log.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
Step 3: expected-non-work-cleanup
  Command: restore current-run .ai-dev operational file snapshots
  Executed: True
  Skipped: False
  Exit code: 0
  Message: Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: .ai-dev/queue.json, .ai-dev/current-task-prompt.md, .ai-dev/codex-result.md, .ai-dev/auto-goal-planning-prompt.md, .ai-dev/goal.md, .ai-dev/auto-goal-codex-result.md, .ai-dev/state.json
Step 4: expected-non-work-meta-record
  Command: write expected non-work final result
  Executed: False
  Skipped: True
  Exit code: 0
  Message: Expected pre-implementation stop is reported in console output only. -AllowCommit is not set, so no result file or other .ai-dev operational change is left behind.
Stopped reason: dirty_worktree
Outcome category: expected_non_work
Completed: False
Exit code: 1
```

### Scenario: baseline-output-conflict

- Expected stopped reason: baseline_output_conflict
- Exit code: 1
- Original stopped reason preserved: True
- expected_non_work classification preserved: True
- Baseline user marker preserved: True
- New dirty paths created: 0
- No new dirty paths: True
- Staged paths left behind: 0
- No staged paths left behind: True
- Manual git restore required for run-owned files: False

Baseline status:
```text
 M .ai-dev/codex-result.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

Status after execution:
```text
 M .ai-dev/codex-result.md
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

New dirty paths:
```text

```

Captured output:
```text
Step 1: validate-input
  Command: check GoalTitle/GoalDescription
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Input validation completed: Expected non-work verification
Step 2: baseline-output-conflict-gate
  Command: compare baseline dirty paths with planned auto-goal outputs
  Executed: True
  Skipped: False
  Exit code: 1
  Message: Baseline dirty paths conflict with planned auto-goal output paths. Auto-goal stopped before writing or deleting protected output files.
Conflicting paths:
.ai-dev/codex-result.md
Step 3: expected-non-work-cleanup
  Command: restore current-run .ai-dev operational file snapshots
  Executed: True
  Skipped: False
  Exit code: 0
  Message: Expected pre-implementation stop. Restored only auto-goal operational files captured at run start; baseline user changes were preserved. Cleaned run-owned files: .ai-dev/queue.json, .ai-dev/current-task-prompt.md, .ai-dev/auto-goal-planning-prompt.md, .ai-dev/goal.md, .ai-dev/auto-goal-codex-result.md, .ai-dev/state.json
Stopped reason: baseline_output_conflict
Outcome category: expected_non_work
Completed: False
Exit code: 1
```

### Scenario: all-goal-candidates-excluded

- Expected stopped reason: all_goal_candidates_excluded
- Exit code: 1
- Original stopped reason preserved: True
- expected_non_work classification preserved: True
- Baseline user marker preserved: True
- New dirty paths created: 0
- No new dirty paths: True
- Staged paths left behind: 0
- No staged paths left behind: True
- Manual git restore required for run-owned files: False

Baseline status:
```text
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

Status after execution:
```text
 M scripts/ai-dev-auto-goal.ps1
 M scripts/ai-dev-autopilot.ps1
```

New dirty paths:
```text

```

Captured output:
```text
Step 1: validate-input
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Autopilot input validation completed. MaxGoals=1, MaxTasks=1, MaxSteps=40
Step 2: current-goal-gate
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Current goal is completed. Previous goal: auto-goal MaxSteps 湲곕낯媛??덉젙??Step 3: generate-goal-candidate
  Executed: False
  Skipped: True
  Exit code: 1
  Message: Autopilot ?꾨낫媛 紐⑤몢 ?뚯쭊?섏뿀?듬땲?? ?꾩옱 ?곹깭: goalStatus=completed, currentTaskId=, openTaskCount=0, currentGoal=auto-goal MaxSteps 湲곕낯媛??덉젙?? ?쒖쇅??backlog ?꾨낫 ?? 14/14. 紐⑤뱺 ?꾨낫媛 ?꾩옱 goal, 以鍮??대젰, ?꾨즺 ?대젰 ?먮뒗 durable history? 以묐났?섏뼱 ?좉퇋 goal???먮룞 ?앹꽦?섏? ?딆뒿?덈떎. ?ㅼ쓬 ?됰룞: 1. .ai-dev/backlog.md???덈줈??backlog ??ぉ??異붽??⑸땲?? 2. ?대? ?꾨즺???꾨낫瑜??ㅼ떆 吏꾪뻾?댁빞 ?쒕떎硫?durable history? ?꾨즺 ?대젰???щ엺??癒쇱? 寃?좏빀?덈떎. 3. 吏湲덉? ?먮룞 吏꾪뻾??硫덉텛怨??꾩옱 ?곹깭瑜??좎??⑸땲?? 怨꾩냽 吏꾪뻾?섎젮硫???backlog ??ぉ???꾩슂?⑸땲?? ?쒖쇅???꾨낫: Codex CLI ?꾩쟾 ?먮룞???뺤콉 臾몄꽌?? Codex 援ы쁽 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; full auto-cycle 珥덉븞 異붽?; ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐; MaxTasks 1 end-to-end 寃利? full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑; package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑; build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡; Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯; GitHub PR ?곕룞 寃?? Copilot CLI ?먮뒗 gh ?곕룞 ?ш??? ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉; 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃?? ?쒖쇅 湲곗? title: auto-goal MaxSteps 湲곕낯媛??덉젙?? Codex 援ы쁽 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; Codex CLI ?꾩쟾 ?먮룞???뺤콉 臾몄꽌?? full auto-cycle 珥덉븞 異붽?; Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?; package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑; GitHub PR ?곕룞 寃?? ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉; 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃?? Autopilot DryRun codex-result dirty 諛⑹?; ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐; Autopilot history dirty gate 異⑸룎 ?섏젙; MaxTasks 1 end-to-end 寃利? Verification task revise ?먮룞 泥섎━; full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑; build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡; Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯; Copilot CLI ?먮뒗 gh ?곕룞 ?ш??? Durable history title: Autopilot DryRun codex-result dirty 諛⑹?; ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐; Autopilot history dirty gate 異⑸룎 ?섏젙; MaxTasks 1 end-to-end 寃利? Verification task revise ?먮룞 泥섎━; full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑; package 蹂寃?媛먯? 硫붿떆吏 媛쒖꽑; build/check ?ㅽ뙣 ??revise ?먮쫫 ?먮룞 ?덈궡; Codex 由щ럭 JSON 異붿텧 ?ㅽ뙣 泥섎━ 蹂닿컯; GitHub PR ?곕룞 寃?? Copilot CLI ?먮뒗 gh ?곕룞 ?ш??? ?κ린 ?ㅽ뻾 ?먮룞??紐⑤땲?곕쭅 ?뺤콉; 蹂묐젹 task ?ㅽ뻾 媛?μ꽦 寃?? auto-goal MaxSteps 湲곕낯媛??덉젙??
Step 4: expected-non-work-cleanup
  Executed: True
  Skipped: False
  Exit code: 0
  Message: Classification: expected_non_work. Original stopped reason: all_goal_candidates_excluded. Baseline dirty files skipped: . Cleaned run-owned files: .ai-dev/loop-log.md, .ai-dev/autopilot-goal-history.json, .ai-dev/state.json. Meta commit created: False (skipped (-AllowCommit not set)). Next run without manual git restore: True. Restored only autopilot operational files captured at run start; baseline user changes were preserved.
Stopped reason: all_goal_candidates_excluded
Outcome category: expected_non_work
Operational cleanup performed: True
Meta commit created: False
Next run without manual restore: True
Completed: False
Prepared goals: 0/1
Exit code: 1
```

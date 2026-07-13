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

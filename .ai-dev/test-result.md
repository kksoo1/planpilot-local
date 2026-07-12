# AI Dev Test Result

## 2026-07-12 23:59:04

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

[32m✓ built in 273ms[39m
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
## 2026-07-13 00:10:00 - Durable autopilot goal history targeted verification

- Overall result: passed
- Current task: T001 Autopilot durable history 구현
- Scope:
  - scripts/ai-dev-autopilot.ps1
  - .ai-dev/test-result.md

### Durable history behavior

- History file path: passed
  - The script defines `.ai-dev/autopilot-goal-history.json` as the durable Autopilot goal history file.

- History creation and recording: passed
  - `New-EmptyGoalHistory`, `Read-AutopilotGoalHistory`, `Get-AutopilotGoalHistoryTitles`, and `Add-AutopilotGoalHistoryTitle` are implemented.
  - Goal titles are recorded with `title`, `firstSeenAt`, `lastSeenAt`, `lastEvent`, and `events`.

- History event coverage: passed
  - The current completed gate goal is recorded with event `completed`.
  - The selected backlog candidate is recorded with event `selected`.
  - The prepared Autopilot goal is recorded with event `prepared`.

- History-based candidate exclusion: passed
  - `Get-HistoricalGoalTitles` includes titles from `Get-AutopilotGoalHistoryTitles`.
  - `Get-ExcludedGoalTitles` uses historical titles when filtering backlog candidates.

- All-candidates-excluded reporting: passed
  - When all backlog candidates are excluded, the message includes:
    - `Excluded goal titles:`
    - `Candidate goal titles:`
    - `Durable history goal titles:`
  - The stop reason remains `all_goal_candidates_excluded`.

### Safety checks

- DryRun non-mutating behavior: passed by code inspection
  - `Add-AutopilotGoalHistoryTitle` returns immediately when `$DryRun` is set.
  - `Add-LoopLogEntry`, `Save-AutopilotFailureState`, and `Invoke-AutopilotLoopLogMetaCommit` keep DryRun write guards.
  - Therefore DryRun does not write history, state, or loop-log.

- Korean goal title preservation: passed by code inspection
  - Goal titles are stored as trimmed strings without encoding conversion or romanization.
  - Normal Korean backlog titles remain valid candidates unless already recorded in history.

- Task title not mixed into goal history: passed by code inspection
  - The durable history path records `[string]$gate.goalTitle` and `[string]$candidate.title`.
  - `Task completed` / `- Task:` log entries are not parsed as durable goal history sources.

- Existing fallback/mojibake handling: passed by code inspection
  - Backlog parsing, suspicious title detection, and fallback candidate creation logic were not changed.

### Build, test, lint

- npm run build: passed in the current BuildOnly verification.
- npm run lint: passed in the current BuildOnly verification.
- npm run test: skipped because package.json has no test script.

## 2026-07-13 00:30:00 - Durable autopilot goal history executed verification

- Overall result: passed
- Current task: T001 Autopilot durable history 구현
- Mode: PowerShell targeted verification using actual functions extracted from scripts/ai-dev-autopilot.ps1

### Executed checks

- History creation and recording: passed
  - Executed Add-AutopilotGoalHistoryTitle against a temporary history file.
  - Verified JSON contains title, firstSeenAt, lastSeenAt, lastEvent, and events fields.
  - Verified selected, prepared, and completed events can be recorded.
  - Verified repeated updates accumulate events without PSObject op_Addition failure.

- History-based candidate exclusion: passed
  - Executed Get-ExcludedGoalTitles against temporary queue/state/loop-log/history files.
  - Verified durable history title is included in excluded titles.
  - Verified Autopilot goal prepared / - Goal value is included in excluded titles.
  - Verified completed queue/state goalTitle is included in excluded titles.

- DryRun non-mutating behavior: passed
  - Executed Add-AutopilotGoalHistoryTitle with DryRun enabled.
  - Verified SHA256 before/after history file hash remained unchanged.
  - Verified DryRun-only title was not recorded.

- Korean goal title preservation: passed
  - Verified Korean goal title 한국어 goal 보존 검증 round-trips through durable history JSON and Get-AutopilotGoalHistoryTitles.

- Task title not mixed into goal history: passed
  - Temporary loop-log included Task completed / - Task: task title should not mix.
  - Verified that value was not included in excluded goal titles.

- All-candidates-excluded reporting support: passed
  - Verified script contains all_goal_candidates_excluded stop reason.
  - Verified script reports Durable history goal titles in the all-candidates-excluded message.

### Build, test, lint

- npm run build: passed in the current BuildOnly verification.
- npm run lint: passed in the current BuildOnly verification.
- npm run test: skipped because package.json has no test script.

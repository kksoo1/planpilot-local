# AI Dev Test Result

## 2026-07-01 21:13:03

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

[32m✓ built in 676ms[39m
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

## 2026-07-01 T002 review-required revise verification

- Overall result: passed
- Scope: scripts/ai-dev-autopilot.ps1, .ai-dev/test-result.md only
- npm run test: skipped because package.json has no test script.
- scripts/ai-dev-auto-goal.ps1: not modified, so the existing single-goal flow remains unchanged.

### PowerShell parse check

- Command: PowerShell parser check for scripts/ai-dev-autopilot.ps1
- Status: passed
- Evidence: `parse: passed`

### Safe DryRun/Json MaxGoals limit check

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -MaxGoals 0 -DryRun -Json`
- Status: passed as a safe rejection
- Evidence:
  - stoppedReason: `max_goals_must_be_at_least_1`
  - exitCode: `1`
  - maxGoals: `0`
  - preparedGoals: `0`

### Safe current_goal_not_completed gate check

- Command: `powershell -ExecutionPolicy Bypass -File scripts/ai-dev-autopilot.ps1 -DryRun -Json`
- Status: passed as a safe gate stop
- Evidence:
  - stoppedReason: `current_goal_not_completed`
  - goalStatus: `in_progress`
  - currentTaskId: `T002`
  - openTaskCount: `2`
  - maxGoals default: `1`
  - preparedGoals: `0`

### Mojibake backlog title handling

- Method: loaded only function definitions from scripts/ai-dev-autopilot.ps1 with PowerShell AST, then used an in-process mocked backlog reader. No project files were created for this check.
- Mojibake-looking title sample: `full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑`
- Status: passed
- Evidence:
  - mojibakeCandidateKind: `fallback`
  - mojibakeGoalTitle: `Prepare the next local autopilot development task`
  - backlogPath: `.ai-dev/backlog.md`
  - readItemCount: `1`
  - filteredItemCount: `1`
  - usableItemCount: `1`
  - readableItemCount: `0`
  - suspiciousTitleReason: `mixed_cjk_ideographs_and_hangul_in_short_title`
- Result: the mojibake-looking Korean title was not passed as a real GoalTitle or GoalDescription; fallback was used instead.

### Normal Korean backlog title handling

- Normal Korean title sample: `Codex CLI 완전 자동화 정책 문서화`
- Status: passed
- Evidence:
  - normalCandidateKind: `backlog`
  - normalGoalTitle: `Codex CLI 완전 자동화 정책 문서화`
  - normalSuspiciousTitleReason: empty
- Result: normal Korean backlog titles remain valid readable backlog candidates.

## 2026-07-08 T002 review-required mojibake pattern revise verification

- Overall result: passed
- Scope: scripts/ai-dev-autopilot.ps1, .ai-dev/test-result.md only
- npm run test: skipped because package.json has no test script.
- scripts/ai-dev-auto-goal.ps1: not modified; this revision only patched scripts/ai-dev-autopilot.ps1 and updated this verification record.
- Build/lint: not run for this review-required patch.

### PowerShell function check

- Method: parsed scripts/ai-dev-autopilot.ps1 with PowerShell AST, loaded only function definitions in-process, and evaluated backlog title candidate handling without creating project files.
- Status: passed
- Evidence:
  - `자동화의 다음 단계 정리`
    - candidateKind: `backlog`
    - suspiciousTitleReason: empty
    - result: normal Korean title containing `의` remains a readable backlog candidate.
  - `Codex CLI 완전 자동화 정책 문서화`
    - candidateKind: `backlog`
    - suspiciousTitleReason: empty
    - result: normal Korean backlog title remains valid.
  - `full auto-cycle 濡쒓렇 援ъ“ 媛쒖꽑`
    - candidateKind: `fallback`
    - fallback title: `Prepare the next local autopilot development task`
    - suspiciousTitleReason: `mixed_cjk_ideographs_and_hangul_in_short_title`
    - result: mixed CJK ideographs plus Hangul mojibake-looking title is not used directly as a real goal title.

# AI Dev Test Result

## 2026-06-19 21:30:34

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
dist/index.html                   0.46 kB │ gzip:  0.30 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:  1.93 kB
dist/assets/index-CJKmMJEA.js   316.50 kB │ gzip: 99.87 kB

[32m✓ built in 173ms[39m
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
## Executable verification: auto-goal final clean gate regression scenarios

- Verification type: isolated temporary git repositories with real git status/add/commit/status commands.
- Temporary root: C:\Users\SECUI\AppData\Local\Temp\planpilot-final-gate-test-d8ec78a422d64575800d8ec76eed8be9
- Important note: this verification was appended after ai-dev-check because ai-dev-check rewrites test-result.md.
- Therefore ai-dev-check must not be rerun before review, or this evidence will be overwritten.

### Actual executed results
- Scenario 1 new .ai-dev operational output => PASS_COMMITTED_AND_CLEAN / final git status: ''
- Scenario 2 non-.ai-dev dirty remains => FAIL_NON_AI_DEV_DIRTY / final git status: ' M src/TaskCard.tsx'
- Scenario 3 baseline dirty .ai-dev/goal.md conflicts with planned output => FAIL_BASELINE_OUTPUT_CONFLICT_BEFORE_WRITE / final git status: '?? .ai-dev/goal.md'
- Scenario 4 baseline dirty ResultPath is protected before failure write => FAIL_BASELINE_OUTPUT_CONFLICT_BEFORE_WRITE / final git status: '?? .ai-dev/codex-result.md'
- Scenario 5 prepared_without_full_cycle .ai-dev outputs => PASS_COMMITTED_AND_CLEAN / final git status: ''
- Scenario 6 .ai-dev output remains but AllowCommit is false => FAIL_ALLOW_COMMIT_REQUIRED / final git status: '?? .ai-dev/codex-result.md'

### Pass/fail interpretation
- Scenario 1 proves new .ai-dev operational output is committed into final meta commit and ends with clean git status.
- Scenario 2 proves remaining non-.ai-dev dirty worktree is rejected and cannot be reported as completed.
- Scenario 3 proves baseline dirty .ai-dev/goal.md is detected as a planned-output conflict before auto-goal writes goal.md.
- Scenario 4 proves baseline dirty ResultPath .ai-dev/codex-result.md is protected before failure-result writing can overwrite it.
- Scenario 5 proves prepared_without_full_cycle-style .ai-dev outputs can use the same final meta commit and end clean.
- Scenario 6 proves .ai-dev output requiring a commit fails when AllowCommit is false instead of reporting completed.

### Final conclusion
- completed=true is valid only after final git status --short is clean.
- New .ai-dev operational changes are eligible for final meta commit only when they were not baseline dirty conflicts.
- Baseline dirty planned-output files are blocked before write/delete operations.
- ResultPath is protected when it is baseline dirty, so failure reporting does not overwrite a user-dirty codex-result.md.
- Non-.ai-dev dirty and missing AllowCommit paths fail instead of completed.

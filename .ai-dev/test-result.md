# AI Dev Test Result

## 2026-07-17 17:12:42

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

[32m✓ built in 221ms[39m
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
## 2026-07-17 17:20:00 - T002 DryRun no-change verification

- Overall result: passed
- Current task: T002 DryRun 무변경 상태 검증
- Mode: Temporary repository verification using current working copy scripts

### Executed command

`powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRun -Json -MaxGoals 2 -MaxTasks 3
`",
  ",
  

- Temporary queue/state were set to a completed-goal baseline before the baseline commit.
- DryRun output was captured in memory only.
- git status was captured in memory only.
- git status --short entry count after DryRun: 0
- git diff --exit-code --quiet exit code after DryRun: 0
- git status --short after DryRun:

`	ext
`",
  ",
  

`	ext
{
    "steps":  [
                  {
                      "step":  1,
                      "name":  "validate-input",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  0,
                      "message":  "Autopilot input validation completed. MaxGoals=2, MaxTasks=3, MaxSteps=22",
                      "goalCandidate":  null
                  },
                  {
                      "step":  2,
                      "name":  "current-goal-gate",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  0,
                      "message":  "Current goal is completed. Previous goal: DryRun clean verification completed baseline",
                      "goalCandidate":  null
                  },
                  {
                      "step":  3,
                      "name":  "generate-goal-candidate",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  0,
                      "message":  "Next goal candidate generated from .ai-dev/backlog.md priority P0.",
                      "goalCandidate":  {
                                            "title":  "?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐",
                                            "description":  "Prepare the smallest actionable development goal from the P0 backlog item for the current repository state: ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐",
                                            "priority":  "P0",
                                            "source":  ".ai-dev/backlog.md",
                                            "candidateKind":  "backlog",
                                            "suspiciousTitleReason":  ""
                                        }
                  },
                  {
                      "step":  4,
                      "name":  "auto-goal",
                      "executed":  true,
                      "skipped":  false,
                      "exitCode":  0,
                      "message":  "{\r\n    \"steps\":  [\r\n                  {\r\n                      \"step\":  1,\r\n                      \"name\":  \"validate-input\",\r\n                      \"command\":  \"check GoalTitle/GoalDescription\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  false,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"Input validation completed: ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\"\r\n                  },\r\n                  {\r\n                      \"step\":  2,\r\n                      \"name\":  \"dirty-worktree-gate\",\r\n                      \"command\":  \"git status --porcelain; compare baseline dirty paths with planned auto-goal outputs\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  true,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"DryRun: baseline dirty capture, dirty worktree gate, and baseline output conflict gate were not executed. Would check planned output paths: .ai-dev/codex-result.md, .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json, .ai-dev/current-task-prompt.md, .ai-dev/auto-goal-planning-prompt.md, .ai-dev/auto-goal-codex-result.md\"\r\n                  },\r\n                  {\r\n                      \"step\":  3,\r\n                      \"name\":  \"plan-goal\",\r\n                      \"command\":  \"codex exec \\u003cauto-goal planning prompt\\u003e\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  true,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\"\r\n                  },\r\n                  {\r\n                      \"step\":  4,\r\n                      \"name\":  \"validate-generated-json\",\r\n                      \"command\":  \"goal/queue/state JSON validation\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  true,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"DryRun: preview goal/queue/state plan passed local schema validation.\"\r\n                  },\r\n                  {\r\n                      \"step\":  5,\r\n                      \"name\":  \"write-state-files\",\r\n                      \"command\":  \".ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  true,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"DryRun: state files were not written.\"\r\n                  },\r\n                  {\r\n                      \"step\":  6,\r\n                      \"name\":  \"make-prompt\",\r\n                      \"command\":  \"powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  true,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"DryRun: current-task-prompt.md was not generated.\"\r\n                  },\r\n                  {\r\n                      \"step\":  7,\r\n                      \"name\":  \"auto-cycle-full\",\r\n                      \"command\":  \"powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -MaxSteps 22 -AllowDirty\",\r\n                      \"executed\":  false,\r\n                      \"skipped\":  true,\r\n                      \"exitCode\":  0,\r\n                      \"message\":  \"DryRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex.\"\r\n                  }\r\n              ],\r\n    \"stoppedReason\":  \"dry_run\",\r\n    \"completed\":  false,\r\n    \"exitCode\":  0,\r\n    \"plan\":  {\r\n                 \"goalMarkdown\":  \"# 紐⑺몴\\r\\n\\r\\n?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\\r\\n\\r\\n## 諛곌꼍\\r\\n\\r\\nPrepare the smallest actionable development goal from the P0 backlog item for the current repository state: ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\\r\\n\\r\\n## ?깃났 湲곗?\\r\\n\\r\\n- ?낅젰??紐⑺몴?먯꽌 ?꾩옱 ?묒뾽??以鍮꾪븳??\\r\\n- full auto-cycle ?ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.\\r\\n- full auto-cycle? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.\\r\\n\\r\\n## ?쒖빟?ы빆\\r\\n\\r\\n- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??\\r\\n- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??\\r\\n\\r\\n## 踰붿쐞 ?쒖쇅\\r\\n\\r\\n- ?⑦궎吏 蹂寃?\r\\n- DB ??젣 ?먮뒗 珥덇린??\r\\n- 愿묐쾾?꾪븳 由ы뙥?곕쭅\\r\\n\\r\\n## ?섎룞 寃利?\r\\n\\r\\n- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??\\r\\n- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.\\r\\n- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.\",\r\n                 \"queue\":  {\r\n                               \"goalTitle\":  \"?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\",\r\n                               \"goalSource\":  \".ai-dev/goal.md\",\r\n                               \"createdAt\":  \"2026-07-17T08:54:26.5893726Z\",\r\n                               \"updatedAt\":  \"2026-07-17T08:54:26.5893726Z\",\r\n                               \"currentTaskId\":  \"T001\",\r\n                               \"tasks\":  [\r\n                                             {\r\n                                                 \"id\":  \"T001\",\r\n                                                 \"title\":  \"?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\",\r\n                                                 \"description\":  \"Prepare the smallest actionable development goal from the P0 backlog item for the current repository state: ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐\",\r\n                                                 \"type\":  \"implementation\",\r\n                                                 \"status\":  \"in_progress\",\r\n                                                 \"priority\":  \"P0\",\r\n                                                 \"dependsOn\":  [\r\n\r\n                                                               ],\r\n                                                 \"filesLikelyToChange\":  [\r\n\r\n                                                                         ],\r\n                                                 \"verification\":  [\r\n                                                                      \"蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.\",\r\n                                                                      \"?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎.\"\r\n                                                                  ],\r\n                                                 \"commitMessage\":  null\r\n                                             }\r\n                                         ]\r\n                           },\r\n                 \"state\":  {\r\n                               \"goalStatus\":  \"in_progress\",\r\n                               \"currentTaskId\":  \"T001\",\r\n                               \"currentLoop\":  0,\r\n                               \"maxLoopsPerTask\":  2,\r\n                               \"repeatedFailureCount\":  0,\r\n                               \"lastCommand\":  null,\r\n                               \"lastCommandStatus\":  \"not_started\",\r\n                               \"lastErrorSummary\":  null,\r\n                               \"lastReviewDecision\":  \"not_started\",\r\n                               \"lastReviewSeverity\":  null,\r\n                               \"lastCommitHash\":  null,\r\n                               \"startedAt\":  \"2026-07-17T08:54:26.5893726Z\",\r\n                               \"updatedAt\":  \"2026-07-17T08:54:26.5893726Z\",\r\n                               \"stopReason\":  null\r\n                           }\r\n             },\r\n    \"goalPath\":  \".ai-dev/goal.md\",\r\n    \"queuePath\":  \".ai-dev/queue.json\",\r\n    \"statePath\":  \".ai-dev/state.json\",\r\n    \"promptPath\":  \".ai-dev/current-task-prompt.md\",\r\n    \"resultPath\":  \".ai-dev/codex-result.md\"\r\n}",
                      "goalCandidate":  {
                                            "title":  "?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐",
                                            "description":  "Prepare the smallest actionable development goal from the P0 backlog item for the current repository state: ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐",
                                            "priority":  "P0",
                                            "source":  ".ai-dev/backlog.md",
                                            "candidateKind":  "backlog",
                                            "suspiciousTitleReason":  ""
                                        }
                  }
              ],
    "stoppedReason":  "prepared_without_full_cycle",
    "completed":  true,
    "exitCode":  0,
    "maxGoals":  2,
    "preparedGoals":  1
}
`",
  ",
  

- DryRun no-change behavior is verified against a completed-goal baseline.
- DryRun left git status --short with zero entries.
- DryRun left git diff --exit-code --quiet with exit code 0.
- No verification output files were created inside the temporary git repository before checking status.
- No app src files were modified by this verification.

# Codex Implementation Result

## Run

- Started at: 2026-07-12 23:42:31
- Ended at: 2026-07-12 23:45:05
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019f56c7-a39c-7a93-b8cd-3712ef08b8b9
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\
current-task-prompt.md

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, git merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .git.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report the conflict.
codex
작업 프롬프트를 먼저 읽고, 저장소 규칙과 충돌하는 요구가 있는지 확인하겠습니다. 범위는 지정된 프롬프트 파일과 그 요구사항으로만 제한하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1823ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Codex 리뷰 실행 스크립트 추가

## 배경
현재 저장소에서 AI Dev Loop가 Codex 리뷰를 반복적으로 실행할 수 있도록, 로컬에서 호출 가능한 최소 실행 스크립트가 필요하다. 기존 구조를 해치지 않고 자동화 루프가
 사용할 수 있는 작은 단위의 실행 경로를 마련한다.

## 성공 기준
- Codex 리뷰 실행을 위한 스크립트 또는 명령 진입점이 추가된다.
- 기존 프로젝트 구조와 PowerShell 5.1 환경에서 사용할 수 있다.
- 실행 방법이 저장소 안에서 확인 가능하다.
- 변경 범위가 리뷰 실행에 필요한 파일로 제한된다.

## 제약사항
- 한 번에 하나의 작은 기능만 구현한다.
- 기존 사용자 변경 사항을 되돌리지 않는다.
- lock file은 수정하지 않는다.
- `src/App.css`는 수정하지 않는다.
- 로컬 앱의 privacy-first 제약을 유지한다.

## 범위 제외
- 앱 기능 UI 변경은 포함하지 않는다.
- 저장소 전반의 구조 재작성은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 추가된 스크립트 또는 명령을 PowerShell 5.1 기준으로 검토한다.
- 실행 명령이 예상 입력과 출력 흐름을 갖는지 확인한다.
- 변경 파일이 목표 범위 안에 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: Codex 리뷰 실행 스크립트 추가
- Description: 현재 저장소 구조를 확인한 뒤 AI Dev Loop에서 호출할 수 있는 최소 Codex 리뷰 실행 스크립트 또는 명령 진입점을 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/scripts/run-codex-review.ps1

## Verification

- PowerShell 5.1에서 스크립트 문법이 유효한지 확인한다.
- 스크립트가 리뷰 실행에 필요한 입력을 명확히 다루는지 확인한다.
- 변경 범위가 Codex 리뷰 실행 스크립트 추가에 한정되는지 확인한다.

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우

codex
프롬프트상 충돌은 없습니다. `src` 밖 파일을 수정해야 하는 작업이지만, 이유는 명확합니다: AI Dev Loop가 호출할 리뷰 실행 진입점을 `.ai-dev/scripts` 
아래에 추가하는 것이 성공 기준입니다. ಈಗ 현재 `.ai-dev` 구조와 기존 문서를 필요한 범위에서만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPat
h 'D:\\ai-apps\\planpilot-local\\.ai-dev'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\queue.json'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPat
h 'D:\\ai-apps\\planpilot-local\\.ai-dev\\scripts'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\state.json'" in D:\ai-apps\planpilot-local
 succeeded in 3627ms:
{
    "goalTitle":  "Codex 리뷰 실행 스크립트 추가",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-07-12T00:00:00+09:00",
    "updatedAt":  "2026-07-12T00:00:00+09:00",
    "currentTaskId":  "T001",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "Codex 리뷰 실행 스크립트 추가",
                      "description":  "현재 저장소 구조를 확인한 뒤 AI Dev Loop에서 호출할 수 있는 최소 Codex 리뷰 실행 스크립트 또
는 명령 진입점을 추가한다.",
                      "type":  "implementation",
                      "status":  "in_progress",
                      "priority":  "P0",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json",
                                                  ".ai-dev/scripts/run-codex-review.ps1"
                                              ],
                      "verification":  [
                                           "PowerShell 5.1에서 스크립트 문법이 유효한지 확인한다.",
                                           "스크립트가 리뷰 실행에 필요한 입력을 명확히 다루는지 확인한다.",
                                           "변경 범위가 Codex 리뷰 실행 스크립트 추가에 한정되는지 확인한다."
                                       ],
                      "commitMessage":  "Add Codex review script"
                  }
              ]
}

 succeeded in 3842ms:


    디렉터리: D:\ai-apps\planpilot-local\.ai-dev


Mode                 LastWriteTime         Length Name                                              
                   
----                 -------------         ------ ----                                              
                   
-a----        2026-07-12  오후 11:41           2323 auto-goal-planning-prompt.md                      
                   
-a----        2026-06-07   오후 8:00           1682 backlog.md                                        
                   
-a----        2026-07-09  오후 10:38           6662 codex-cli-automation-policy.md                    
                   
-a----        2026-07-12  오후 11:42           9486 codex-result.md                                   
                   
-a----        2026-07-12  오후 11:28          84248 codex-review-result.md                            
                   
-a----        2026-07-12  오후 11:42           3687 current-task-prompt.md                            
                   
-a----        2026-07-12  오후 11:27           1063 diff.md                                           
                   
-a----        2026-06-04  오전 12:01            307 extra-instructions.example.md                     
                   
-a----        2026-07-12  오후 11:26           5048 full-auto-cycle-draft.md                          
                   
-a----        2026-07-12  오후 11:42           1383 goal.md                                           
                   
-a----        2026-07-12  오후 11:28          33971 loop-log.md                                       
                   
-a----        2026-06-07  오후 10:10           6979 plan.md                                           
                   
-a----        2026-06-03   오후 4:30           4068 queue.example.json                                
                   
-a----        2026-07-12  오후 11:42           1798 queue.json                                        
                   
-a----        2026-07-09  오후 10:26          51897 README.md                                         
                   
-a----        2026-07-12  오후 11:27           6701 review-prompt.md                                  
                   
-a----        2026-07-12  오후 11:28            951 review-response.json                              
                   
-a----        2026-07-12  오후 11:28           1296 review.md                                         
                   
-a----        2026-07-12  오후 10:52          13171 revise-prompt.md                                  
                   
-a----        2026-06-03   오후 4:30            395 state.example.json                                
                   
-a----        2026-07-12  오후 11:42            487 state.json                                        
                   
-a----        2026-07-12  오후 11:27            974 test-result.md                                    
                   



 succeeded in 3858ms:
{
    "goalStatus":  "in_progress",
    "currentTaskId":  "T001",
    "currentLoop":  0,
    "maxLoopsPerTask":  2,
    "repeatedFailureCount":  0,
    "lastCommand":  null,
    "lastCommandStatus":  "not_started",
    "lastErrorSummary":  null,
    "lastReviewDecision":  "not_started",
    "lastReviewSeverity":  null,
    "lastCommitHash":  null,
    "startedAt":  "2026-07-12T00:00:00+09:00",
    "updatedAt":  "2026-07-12T00:00:00+09:00",
    "stopReason":  null
}

 exited 1 in 4028ms:
Get-ChildItem : 'D:\ai-apps\planpilot-local\.ai-dev\scripts' 경로는 존재하지 않으므로 찾을 수 없습니다.
위치 줄:2 문자:1
+ Get-ChildItem -LiteralPath 'D:\ai-apps\planpilot-local\.ai-dev\script ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan....ai-dev\scripts:String) [Get-ChildI
tem], ItemNotFound 
   Exception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
 

2026-07-12T14:43:02.872993Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 4 seconds
Output:
Get-ChildItem : 'D:\ai-apps\planpilot-local\.ai-dev\scripts' 경로는 존재하지 않으므로 찾을 수 없습니다.
위치 줄:2 문자:1
+ Get-ChildItem -LiteralPath 'D:\ai-apps\planpilot-local\.ai-dev\script ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (D:\ai-apps\plan....ai-dev\scripts:String) [Get-ChildI
tem], ItemNotFound 
   Exception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
 

 succeeded in 4110ms:
# 목표
Codex 리뷰 실행 스크립트 추가

## 배경
현재 저장소에서 AI Dev Loop가 Codex 리뷰를 반복적으로 실행할 수 있도록, 로컬에서 호출 가능한 최소 실행 스크립트가 필요하다. 기존 구조를 해치지 않고 자동화 루프가
 사용할 수 있는 작은 단위의 실행 경로를 마련한다.

## 성공 기준
- Codex 리뷰 실행을 위한 스크립트 또는 명령 진입점이 추가된다.
- 기존 프로젝트 구조와 PowerShell 5.1 환경에서 사용할 수 있다.
- 실행 방법이 저장소 안에서 확인 가능하다.
- 변경 범위가 리뷰 실행에 필요한 파일로 제한된다.

## 제약사항
- 한 번에 하나의 작은 기능만 구현한다.
- 기존 사용자 변경 사항을 되돌리지 않는다.
- lock file은 수정하지 않는다.
- `src/App.css`는 수정하지 않는다.
- 로컬 앱의 privacy-first 제약을 유지한다.

## 범위 제외
- 앱 기능 UI 변경은 포함하지 않는다.
- 저장소 전반의 구조 재작성은 포함하지 않는다.
- 알림, 동기화, 계정 관련 기능은 포함하지 않는다.

## 수동 검증
- 추가된 스크립트 또는 명령을 PowerShell 5.1 기준으로 검토한다.
- 실행 명령이 예상 입력과 출력 흐름을 갖는지 확인한다.
- 변경 파일이 목표 범위 안에 있는지 확인한다.

codex
`.ai-dev/scripts` 디렉터리는 아직 없습니다. 기존 자동화 문서에서 Codex CLI 호출 방식이 이미 정해져 있는지 확인한 뒤, 그 방식에 맞춰 최소 PowerShe
ll 스크립트를 추가하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\codex-cli-automation-policy.md'" in D:\ai-apps\planpilot-loc
al
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPat
h 'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md' -Pattern 'review|codex|PowerShell|script'" in D
:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 2706ms:
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
full auto-cycle 초안을 추가한다.

## 배경
현재 저장소의 P0 백로그 항목인 full auto-cycle 초안 추가를 가장 작은 실행 가능한 단위로 진행한다. 자동 개발 루프의 흐름과 책임 범위를 문서 초안으로 정리해 이후
 구현 또는 검토의 기준을 만든다.

## 성공 기준
- full auto-cycle의 목적, 입력, 처리 흐름, 종료 조건이 초안 문서에 정리된다.
- 기존 로컬 우선 구조와 현재 프로젝트 제약을 벗어나지 않는다.
- 후속 작업자가 바로 검토하거나 보완할 수 있을 만큼 항목이 구체적이다.

## 제약사항
- 한 번에 하나의 작은 문서 작업만 수행한다.
- 기존 앱 동작과 저장 구조는 변경하지 않는다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 기존 파일 구조와 현재 프로젝트 규칙을 따른다.

## 범위 제외
- 실제 자동 실행 로직 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조의 대규모 정리는 포함하지 않는다.
- 배포, 외부 연동, 계정 기반 기능은 포함하지 않는다.

## 수동 검증
- 추가된 초안 문서를 열어 섹션 구성이 자연스러운지 확인한다.
- 성공 기준과 범위 제외가 이번 목표에 맞게 좁게 유지되는지 확인한다.
- 후속 구현자가 다음 작업을 식별할 수 있는지 확인한다.

## Current Task

- Task ID: T001
- Title: full auto-cycle 초안 문서 추가
- Description: full auto-cycle의 목적, 입력, 처리 흐름, 종료 조건을 작은 문서 초안으로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- 문서에 목적, 입력, 처리 흐름, 종료 조건이 포함되어 있는지 확인한다.
- 이번 목표의 범위가 문서 초안 추가로 제한되어 있는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-12 23:27:16

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

[32m✓ built in 227ms[39m
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

## Diff To Review

# AI Dev Diff

## Generated At

2026-07-12 23:27:25

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
?? .ai-dev/full-auto-cycle-draft.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md
- .ai-dev/full-auto-cycle-draft.md

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

 succeeded in 2906ms:
# Codex CLI ?꾩쟾 ?먮룞???뺤콉

??臾몄꽌??PlanPilot Local??濡쒖뺄 AI Dev Loop?먯꽌 Codex CLI ?먮룞?붾? ?ъ슜???뚯쓽 紐⑹쟻, ?곸슜 踰붿쐞, ?묒뾽 ?⑥쐞, 寃利?湲곕줉,
 以묐떒 議곌굔???뺣━?쒕떎. ?먮룞?붾뒗 ?묒? task瑜??덉쟾?섍쾶 ?앸궡湲??꾪븳 蹂댁“ ?먮쫫?대ŉ, ??μ냼 洹쒖튃怨??ъ슜??吏?쒕낫???곗꽑?섏? ?딅뒗??

## 紐⑹쟻

- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`??湲곗??쇰줈 ?꾩옱 task ?섎굹留?援ы쁽, 寃利? 由щ럭,
 湲곕줉?쒕떎.
- Codex CLI瑜?援ы쁽?먯? 由щ럭?대줈 ?ъ슜?????꾩슂???덉슜 議곌굔怨?以묐떒 議곌굔??紐낇솗???쒕떎.
- ?먮룞?붽? ?꾩쓽濡?湲곕뒫 踰붿쐞, ?뚯씪 踰붿쐞, 寃利?踰붿쐞瑜??볧엳吏 ?딅룄濡??곹깭 ?뚯씪??洹쇨굅瑜??④릿??
- 寃利앺븯吏 ?딆? 寃곌낵瑜??듦낵濡?湲곕줉?섏? ?딄퀬, ?щ엺???댁뼱???먮떒?????덈뒗 理쒖냼 ?뺣낫瑜??④릿??

## ?곸슜 踰붿쐞

???뺤콉? ?꾩옱 ??μ냼 `D:\ai-apps\planpilot-local` ?덉뿉???ㅽ뻾?섎뒗 濡쒖뺄 AI Dev Loop?먮쭔 ?곸슜?쒕떎.

?곸슜 ???

- ?꾩옱 goal怨?current task 遺꾩꽍
- `current-task-prompt.md` ?앹꽦
- Codex CLI 湲곕컲 ?꾩옱 task 援ы쁽
- ?꾩슂??build, lint, test ?먮뒗 ?섎룞 寃利?湲곕줉
- diff ??κ낵 Codex CLI 由щ럭
- 由щ럭 pass ?댄썑 task ?꾨즺 泥섎━? ?꾩슂??寃쎌슦 ?먮룞 而ㅻ컠
- ?ㅽ뙣, 以묐떒, 寃利?寃곌낵瑜?`.ai-dev` ?곹깭 ?뚯씪??湲곕줉?섎뒗 ?묒뾽

?곸슜 ?쒖쇅:

- ??湲곕뒫??current task 諛뽰쑝濡??뺤옣?섎뒗 ?묒뾽
- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? ?뚮┝, Capacitor 異붽?
- DB ??젣, 珥덇린?? 蹂듭썝, 怨꾪쉷 ?녿뒗 migration
- package ?ㅼ튂, package ?뚯씪 蹂寃? lock file 蹂寃?- git push, PR ?앹꽦, 諛고룷
- ?ъ슜??蹂寃??ы빆 ?섎룎由ш린

## ?묒뾽 ?⑥쐞 湲곗?

- ??踰덉뿉 ?섎굹??goal ?덉뿉???섎굹??current task留?泥섎━?쒕떎.
- ?먮룞?붾뒗 `queue.json`??current task 紐⑹쟻, scope, verification??吏곸젒 ?꾩슂???뚯씪留??섏젙?쒕떎.
- ?꾩옱 task媛 臾몄꽌 ?묒뾽?대㈃ ???고???肄붾뱶? ???援ъ“瑜?蹂寃쏀븯吏 ?딅뒗??
- ?꾩옱 task媛 ??湲곕뒫 ?묒뾽?대㈃ 臾몄꽌 蹂닿컯, 由ы뙥?곕쭅, ?꾩냽 媛쒖꽑???꾩쓽濡??④퍡 臾띠? ?딅뒗??
- ??蹂寃쎌씠 ?꾩슂?섎떎怨??먮떒?섎㈃ ?꾩옱 task?먯꽌 ?뺤옣?섏? ?딄퀬 蹂꾨룄 task濡?遺꾨━?섍굅??以묐떒?쒕떎.
- `src/App.tsx`, `src/db.ts`, package ?뚯씪泥섎읆 ?곹뼢 踰붿쐞媛 ???뚯씪? task ?붽뎄? migration 怨꾪쉷??紐낇솗???뚮쭔 ?ㅻ
，??

## ?먮룞 ?ㅽ뻾 ?덉슜 議곌굔

Codex CLI ?먮룞?붾뒗 ?꾨옒 議곌굔??異⑹”???뚮쭔 ?ㅼ쓬 ?④퀎濡?吏꾪뻾?쒕떎.

- ?ъ슜??吏?? `AGENTS.md`, ?꾩옱 task prompt媛 ?쒕줈 異⑸룎?섏? ?딅뒗??
- ?묒뾽 寃쎈줈媛 ????μ냼 猷⑦듃?대ŉ, ?덉슜???뚯씪 踰붿쐞媛 紐낇솗?섎떎.
- current task媛 議댁옱?섍퀬 ?곹깭媛 `in_progress` ?먮뒗 ?ㅽ뻾 媛?ν븳 ?곹깭??
- ?꾩슂??prompt ?뚯씪???꾩옱 goal怨?current task 湲곗??쇰줈 ?앹꽦?섏뼱 ?덈떎.
- dirty worktree媛 ?덉슜???먮룞???곗텧臾??먮뒗 紐낆떆?곸쑝濡??덉슜??蹂寃쎌뿉 ?쒖젙?쒕떎.
- build, lint, test, 由щ럭, 而ㅻ컠 媛숈? ?꾪뿕 ?④퀎???대떦 ?ㅽ겕由쏀듃??紐낆떆 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
- ?먮룞 而ㅻ컠? 寃利??듦낵, 由щ럭 pass, package ?뚯씪 誘몃?寃? task 踰붿쐞 ?쇱튂媛 ?뺤씤??寃쎌슦?먮쭔 ?덉슜?쒕떎.

## 寃利?湲곕줉 湲곗?

寃利?寃곌낵???ㅼ젣濡??섑뻾????ぉ留?湲곕줉?쒕떎.

- build, lint, test瑜??ㅽ뻾?덈떎硫?紐낅졊, 寃곌낵, ?ㅽ뙣 ?붿빟??`.ai-dev/test-result.md`? ?꾩슂???곹깭 ?꾨뱶???④릿??
- 臾몄꽌 ?묒뾽泥섎읆 紐낅졊 寃利앹씠 遺덊븘?뷀븯嫄곕굹 ?덉슜?섏? ?딆? 寃쎌슦?먮뒗 ?섎룞 寃????ぉ怨?誘몄떎???ъ쑀瑜?湲곕줉?쒕떎.
- 由щ럭瑜??섑뻾?덈떎硫?decision, severity, summary, required changes, next step??`.ai-dev/review.md`? `stat
e.json`??諛섏쁺?쒕떎.
- ?ㅽ뙣??寃利앹쓣 ?듦낵濡?湲곕줉?섏? ?딅뒗??
- ?ㅽ뻾?섏? ?딆? 寃利앹? `誘몄떎?? ?먮뒗 `?щ엺??蹂꾨룄 ?ㅽ뻾`?쇰줈 紐낇솗???④릿??
- 媛숈? ?ㅽ뙣媛 諛섎났?섎㈃ 諛섎났 ?잛닔? 留덉?留??ㅽ뙣 ?붿빟??`state.json` ?먮뒗 `loop-log.md`???④릿??

## ?곹깭 湲곕줉 湲곗?

?먮룞?붾뒗 ?щ엺???댁뼱???먮떒?????덈룄濡??ㅼ쓬 ?뺣낫瑜??④릿??

- `state.json`: ?꾩옱 goal/task, 留덉?留?紐낅졊, 紐낅졊 ?곹깭, 由щ럭 decision, 寃利??쒓컖, 以묐떒 ?ъ쑀, 諛섎났 ?ㅽ뙣 ?잛닔
- `test-result.md`: ?ㅼ젣 寃利?紐낅졊 ?먮뒗 ?섎룞 寃??寃곌낵
- `review.md`: Codex CLI ?먮뒗 ?섎룞 由щ럭 寃곌낵
- `loop-log.md`: task 吏꾪뻾, ?꾨즺, 以묐떒, ?ㅽ뙣, 而ㅻ컠 寃곌낵???쒓컙 ?쒖꽌 ?붿빟
- `diff.md`? `review-prompt.md`: 由щ럭???꾩슂??寃쎌슦?먮쭔 ?앹꽦?섎ŉ, ??diff??誘쇨컧 ?뺣낫 ?ы븿 ?щ?瑜?二쇱쓽?쒕떎.

?곹깭 ?뚯씪? 湲곗〈 ?뺤떇怨??섎?瑜??좎??쒕떎. ?먮룞???몄쓽瑜??꾪빐 enum 媛믪씠??JSON 援ъ“瑜??꾩쓽濡?諛붽씀吏 ?딅뒗??

## 以묐떒 議곌굔

?꾨옒 議곌굔 以??섎굹?쇰룄 諛쒖깮?섎㈃ ?먮룞?붾뒗 ?ㅼ쓬 ?④퀎濡?吏꾪뻾?섏? ?딄퀬 以묐떒 ?ъ쑀瑜?湲곕줉?쒕떎.

- ?ъ슜??吏?? ??μ냼 洹쒖튃, ?꾩옱 task ?붽뎄?ы빆??異⑸룎?쒕떎.
- ?꾩옱 task 踰붿쐞 諛??뚯씪 ?섏젙???꾩슂?섎떎.
- package 異붽?, package ?뚯씪 蹂寃? lock file 蹂寃쎌씠 ?꾩슂?섎떎.
- DB schema 蹂寃? ?곗씠????젣, 蹂듭썝, migration???꾩슂?섎떎.
- package ?뚯씪 蹂寃? build/check ?ㅽ뙣, 由щ럭 `pass` ?꾨떂, 由щ럭 JSON ?뚯떛 ?ㅽ뙣媛 諛쒖깮?쒕떎.
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠 ?묒뾽 ?몃━???덈떎.
- 媛숈? ?ㅻ쪟媛 諛섎났?섏뼱 ?꾩옱 task 踰붿쐞 ?덉뿉???덉쟾?섍쾶 ?닿껐?????녿떎.
- 誘쇨컧 ?뺣낫, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?? API key媛 diff??prompt???ы븿???꾪뿕???덈떎.
- ?ㅽ듃?뚰겕, 沅뚰븳, sandbox ?쒗븳 ?뚮Ц??寃利??먮뒗 ?ㅽ뻾 寃곌낵瑜??좊ː?????녿떎.
- ?먮룞?붽? ?꾩옱 task ?꾨즺 湲곗????먮떒??洹쇨굅瑜?異⑸텇???뺣낫?섏? 紐삵뻽??

以묐떒 ?쒖뿉???섏젙 媛?ν븳 踰붿쐞瑜??꾩쓽濡??볧엳吏 ?딅뒗?? ?꾩슂???ㅼ쓬 寃곗젙, ?ㅽ뙣???④퀎, ?щ엺???뺤씤???뚯씪??湲곕줉?섍퀬 硫덉텣??

## ?꾨즺 湲곗?

?꾩옱 task???꾨옒 議곌굔??異⑹”?????꾨즺濡?蹂????덈떎.

- current task???깃났 湲곗???異⑹”?덈떎.
- 蹂寃??뚯씪??task 踰붿쐞 ?덉뿉 ?덈떎.
- ?꾩슂??寃利??먮뒗 ?섎룞 寃??寃곌낵媛 湲곕줉?먮떎.
- 由щ럭媛 ?꾩슂??寃쎌슦 pass ?먮뒗 ?щ엺???뱀씤???곹깭??
- ?먮룞 而ㅻ컠???붽뎄???먮쫫?먯꽌??而ㅻ컠 hash媛 ?곹깭??湲곕줉?먮떎.
- ?먮룞 而ㅻ컠???붽뎄?섏? ?딆? ?먮쫫?먯꽌??誘몄빱諛??곹깭? ?꾩냽 議곗튂瑜?紐낇솗???④꼈??
- ?ㅼ쓬 task濡??섏뼱媛???섎뒗吏 ?щ?媛 `loop-log.md` ?먮뒗 理쒖쥌 ?묒뾽 ?붿빟??湲곕줉?먮떎.

 succeeded in 3211ms:

.ai-dev\README.md:5:현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex CLI 완전 자동화 실행기는 다음 목표에서 단
계적으로 도입하며, 각 task 전
환 전에는 `goal.md`, `queue.json`, `state.json`을 확인한다.
.ai-dev\README.md:24:- 수동 `ai-dev-auto-goal.ps1` 흐름은 여전히 명시적인 `GoalTitle`과 `GoalDescription`을 사용한다.
.ai-dev\README.md:25:- 단, 현재 goal이 완료되었고 open task가 없을 때 `scripts/ai-dev-autopilot.ps1`는 제한된 범위에서 `.
ai-dev/backlog.md`의
 다음 goal 후보를 선택할 수 있다.
.ai-dev\README.md:36:- `review.md`
.ai-dev\README.md:52:AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 사용자가 매
번 `chcp 65001`을 직접 
실행할 필요는 없다.
.ai-dev\README.md:56:```powershell
.ai-dev\README.md:57:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-init.ps1 -Force
.ai-dev\README.md:64:```powershell
.ai-dev\README.md:65:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-init.ps1
.ai-dev\README.md:70:```powershell
.ai-dev\README.md:71:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-init.ps1 -Force
.ai-dev\README.md:74:초기화 스크립트는 Codex 실행, GPT 리뷰, build/test 실행, git commit을 수행하지 않는다.
.ai-dev\README.md:80:```powershell
.ai-dev\README.md:81:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-current-task.ps1
.ai-dev\README.md:86:```powershell
.ai-dev\README.md:87:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-current-task.ps1 -Json
.ai-dev\README.md:90:현재 task 확인 스크립트는 상태 파일을 수정하지 않으며, Codex 실행, GPT 리뷰, build/test 실행, git commit을 
수행하지 않는다.
.ai-dev\README.md:96:```powershell
.ai-dev\README.md:97:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
.ai-dev\README.md:100:프롬프트 생성 스크립트는 기존 `current-task-prompt.md`를 현재 task 기준으로 덮어쓴다. Codex 실행, GPT 리뷰
, build/test 실행, gi
t commit은 수행하지 않는다.
.ai-dev\README.md:106:```powershell
.ai-dev\README.md:107:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1 -Extra
InstructionsPath .a
i-dev/extra-instructions.example.md
.ai-dev\README.md:116:```powershell
.ai-dev\README.md:117:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -Res
ultSummary "T001 분석
 완료"
.ai-dev\README.md:122:```powershell
.ai-dev\README.md:123:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -Tas
kId T001 -ResultSum
mary "분석 완료"
.ai-dev\README.md:128:```powershell
.ai-dev\README.md:129:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoN
ext
.ai-dev\README.md:132:task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행, GP
T 리뷰, build/test 실행
, git commit은 수행하지 않는다.
.ai-dev\README.md:136:`package.json`에 정의된 build, test, lint script를 확인하고 실행 결과를 `test-result.md`와 `s
tate.json`에 기록한다.
.ai-dev\README.md:138:```powershell
.ai-dev\README.md:139:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1
.ai-dev\README.md:144:```powershell
.ai-dev\README.md:145:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
.ai-dev\README.md:150:검증 실행 스크립트는 Codex 실행, GPT 리뷰, git commit을 수행하지 않는다.
.ai-dev\README.md:152:T006 같은 최종 검증 task에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-
review` 성공/실패 흐름 확인
 결과를 사람이 직접 수행했다면 수동 요약만 `test-result.md`에 기록할 수 있다. 이 모드는 npm build/test/lint를 실행하지 않는다.
.ai-dev\README.md:154:```powershell
.ai-dev\README.md:155:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -ManualSumma
ryOnly -ManualSumma
ry "PowerShell 문법 검증 통과. auto-step DryRun 통과. auto-cycle DryRun 통과. save-review 실패/성공 흐름 확인."
.ai-dev\README.md:166:```powershell
.ai-dev\README.md:167:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
.ai-dev\README.md:172:```powershell
.ai-dev\README.md:173:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1 -Include
UntrackedContent
.ai-dev\README.md:176:git diff 저장 스크립트는 `diff.md`와 `state.json`만 갱신한다. Codex 실행, GPT 리뷰, build/test 
실행, git commit은 수행하
지 않는다.
.ai-dev\README.md:181:- `.ai-dev/review-prompt.md`
.ai-dev\README.md:185:- `.ai-dev/review.md`
.ai-dev\README.md:186:- `.ai-dev/review-response.json`
.ai-dev\README.md:190:`Git Status` 섹션에는 생성 산출물을 포함한 전체 변경 파일을 그대로 표시한다. `.ai-dev/README.md`, `script
s/ai-dev-save-diff.
ps1`처럼 실제 작업 대상 파일은 위 제외 목록에 없으므로 diff 본문에 포함된다.
.ai-dev\README.md:194:현재 goal, task, 검증 결과, git diff를 포함한 GPT 코드 리뷰용 `review-prompt.md`를 생성한다.
.ai-dev\README.md:196:```powershell
.ai-dev\README.md:197:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1
.ai-dev\README.md:202:```powershell
.ai-dev\README.md:203:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1
 -Strict
.ai-dev\README.md:206:리뷰 프롬프트 생성 스크립트는 GPT API 호출, Codex 실행, build/test 실행, git commit을 수행하지 않는다.
.ai-dev\README.md:214:1. `ai-dev-make-review-prompt.ps1 -Strict`로 `.ai-dev/review-prompt.md`를 생성한다.
.ai-dev\README.md:215:2. `review-prompt.md` 내용을 클립보드에 복사한다.
.ai-dev\README.md:219:6. `ai-dev-save-review.ps1 -FromClipboard`로 리뷰를 저장한다.
.ai-dev\README.md:222:현재 task의 다음 단계에서는 `review-prompt.md` 클립보드 복사를 돕는 helper를 추가할 예정이다. 그 전까지는 파일 내
용을 직접 복사하거나 운영 환경에 
맞는 안전한 방법으로 클립보드에 옮긴다.
.ai-dev\README.md:224:`review-prompt.md`가 이미 있으면 다음 명령으로 내용을 클립보드에 복사한다.
.ai-dev\README.md:226:```powershell
.ai-dev\README.md:227:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
.ai-dev\README.md:230:`review-prompt.md`가 없을 때 생성 후 복사하려면 `-GenerateIfMissing`을 사용한다.
.ai-dev\README.md:232:```powershell
.ai-dev\README.md:233:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
 -GenerateIfMissing
.ai-dev\README.md:238:```powershell
.ai-dev\README.md:239:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
 -GenerateIfMissing
 -Strict
.ai-dev\README.md:244:```powershell
.ai-dev\README.md:245:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
 -Json
.ai-dev\README.md:250:```powershell
.ai-dev\README.md:251:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard
.ai-dev\README.md:256:- `review-prompt.md`에는 diff와 테스트 결과가 포함될 수 있다.
.ai-dev\README.md:259:- `ai-dev-auto-step.ps1`는 `ask_gpt_review` 상태에서 GPT API를 호출하지 않고 수동 브리지 안내만 해야
 한다.
.ai-dev\README.md:263:GPT Chat 또는 외부 리뷰어가 반환한 리뷰 JSON을 `review.md`에 저장하고, decision과 severity를 `state
.json`에 반영한다.
.ai-dev\README.md:265:```powershell
.ai-dev\README.md:266:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -Revie
wFile .ai-dev/revie
w-response.json
.ai-dev\README.md:271:```powershell
.ai-dev\README.md:272:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -Revie
wJson '{"decision":
"pass","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_step":
"complete_task"}'
.ai-dev\README.md:273:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard
.ai-dev\README.md:283:- 오류 메시지의 입력 preview 앞부분을 보고 다른 설명 문장이나 잘린 JSON이 섞였는지 확인한다.
.ai-dev\README.md:285:파싱 실패, 빈 입력, 필수 필드 누락 같은 입력 오류는 기본적으로 `review.md`와 `state.json`을 수정하지 않는다. rev
iew-prompt나 명령어를 실수
로 클립보드에 둔 상태에서 `-FromClipboard`를 실행해도 기존 리뷰 상태를 blocked/critical로 덮어쓰지 않기 위한 안전 동작이다.
.ai-dev\README.md:287:실패 자체를 리뷰 결과로 기록해야 하는 특별한 경우에만 `-WriteFailureReview`를 함께 사용한다.
.ai-dev\README.md:289:```powershell
.ai-dev\README.md:290:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard -WriteFail
ureReview
.ai-dev\README.md:295:리뷰 결과 저장 스크립트는 `pass + complete_task`, `revise + revise_with_codex`, `blocked`
 또는 `stop_for_user`
 결과에 맞는 다음 행동을 안내만 한다. GPT API 호출, Codex 실행, build/test 실행, git commit은 수행하지 않는다.
.ai-dev\README.md:299:`review.md`의 required changes를 반영하도록 Codex 또는 Cline에 전달할 `revise-prompt.md`를 생
성한다.
.ai-dev\README.md:301:```powershell
.ai-dev\README.md:302:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
.ai-dev\README.md:307:```powershell
.ai-dev\README.md:308:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
 -AllowOptionalSugg
estions
.ai-dev\README.md:311:재수정 프롬프트 생성 스크립트는 Codex 실행, GPT API 호출, build/test 실행, git commit을 수행하지 않는다.
.ai-dev\README.md:317:```powershell
.ai-dev\README.md:318:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -DryRun
.ai-dev\README.md:319:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
.ai-dev\README.md:324:```powershell
.ai-dev\README.md:325:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scri
pts/ai-dev-commit.p
s1,.ai-dev/README.md -DryRun
.ai-dev\README.md:326:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scri
pts/ai-dev-commit.p
s1,.ai-dev/README.md
.ai-dev\README.md:331:```powershell
.ai-dev\README.md:332:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Message "c
hore(ai-dev): add a
utomation helpers"
.ai-dev\README.md:333:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -AllowWitho
utPassedCheck -Allo
wWithoutPassedReview
.ai-dev\README.md:338:실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 수행하지 않
는다.
.ai-dev\README.md:345:- 루프 상태 커밋에는 필요할 때 `queue.json`, `state.json`, `loop-log.md`, `test-result.md`
, `review.md` 등을 포함
할 수 있다.
.ai-dev\README.md:346:- `diff.md`와 `review-prompt.md`는 커질 수 있으므로 항상 커밋하지 않는다.
.ai-dev\README.md:347:- `review-response.json`은 민감 정보나 장문 내용이 포함될 수 있으므로 내용을 확인한 뒤 커밋 여부를 결정한다.
.ai-dev\README.md:359:```powershell
.ai-dev\README.md:360:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
.ai-dev\README.md:365:```powershell
.ai-dev\README.md:366:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1 -Json
.ai-dev\README.md:369:상태 요약 스크립트는 파일을 수정하지 않으며, Codex 실행, GPT API 호출, build/test 실행, git add, git co
mmit을 수행하지 않는다.
.ai-dev\README.md:373:현재 queue, state, review, test, git 상태를 확인해 다음에 실행할 추천 명령을 출력한다.
.ai-dev\README.md:375:```powershell
.ai-dev\README.md:376:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
.ai-dev\README.md:381:```powershell
.ai-dev\README.md:382:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1 -Json
.ai-dev\README.md:385:다음 행동 안내 스크립트는 추천 명령만 출력하며, Codex 실행, GPT API 호출, build/test 실행, git add, git 
commit을 수행하지 않는다.
.ai-dev\README.md:391:```powershell
.ai-dev\README.md:392:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
.ai-dev\README.md:397:```powershell
.ai-dev\README.md:398:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1 -Json
.ai-dev\README.md:401:수동 사이클 안내 스크립트는 추천 명령과 파일 경로만 보여주며, Codex 실행, GPT API 호출, build/test 실행, git a
dd, git commit을 수행하
지 않는다.
.ai-dev\README.md:403:`manual-cycle`에서 다음 action이 `ask_gpt_review`로 표시되면 수동 리뷰 브리지를 사용한다. GPT API 키가
 없어도 아래 흐름으로 리뷰를 진행
할 수 있다.
.ai-dev\README.md:405:```powershell
.ai-dev\README.md:406:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
.ai-dev\README.md:407:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
.ai-dev\README.md:410:1. `manual-cycle`에서 현재 task와 다음 action이 `ask_gpt_review`인지 확인한다.
.ai-dev\README.md:411:2. `ai-dev-copy-review-prompt.ps1`로 `review-prompt.md`를 클립보드에 복사한다.
.ai-dev\README.md:416:```powershell
.ai-dev\README.md:417:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard
.ai-dev\README.md:423:- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든 뒤 Codex/Cline에 수동 전달
한다.
.ai-dev\README.md:426:`review-prompt.md`에는 diff, 테스트 결과, 로컬 경로, 민감 정보가 포함될 수 있다. ChatGPT에 붙여넣기 전에 사용
자가 공유 범위를 확인해야 한다.
.ai-dev\README.md:436:| 현재 상태와 다음 행동을 한 화면에서 보고 싶을 때 | `scripts/ai-dev-manual-cycle.ps1` | 상태 요약, 다음
 action, 관련 파일 존재 여
부를 함께 보여주는 수동 운영 대시보드다. |
.ai-dev\README.md:437:| 다음 action과 추천 명령만 확인하고 싶을 때 | `scripts/ai-dev-next.ps1` | 읽기/안내용 스크립트이며 하위 명
령을 자동 실행하지 않는다. |
.ai-dev\README.md:438:| 안전한 다음 한 단계만 자동으로 진행하고 싶을 때 | `scripts/ai-dev-auto-step.ps1` | `next` 판단 결과를
 기반으로 허용된 로컬 스크립트만 
한 번 실행한다. |
.ai-dev\README.md:439:| 여러 안전 단계를 제한 횟수 안에서 이어가고 싶을 때 | `scripts/ai-dev-auto-cycle.ps1` | auto-step 
반복용이며 사용자 개입 필요 상태에
서 중단한다. |
.ai-dev\README.md:441:```powershell
.ai-dev\README.md:442:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
.ai-dev\README.md:443:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
.ai-dev\README.md:444:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -Json
.ai-dev\README.md:449:```powershell
.ai-dev\README.md:450:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowCh
eck
.ai-dev\README.md:451:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowSa
veDiff
.ai-dev\README.md:452:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowRe
viewPrompt
.ai-dev\README.md:457:- `current-task-prompt.md`가 없을 때 `scripts/ai-dev-make-prompt.ps1`
.ai-dev\README.md:458:- 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1`
.ai-dev\README.md:459:- diff 저장이 필요한 경우 `scripts/ai-dev-save-diff.ps1`
.ai-dev\README.md:460:- review prompt 생성이 필요한 경우 `scripts/ai-dev-make-review-prompt.ps1`
.ai-dev\README.md:464:- Codex 또는 Cline 작업
.ai-dev\README.md:471:`ask_gpt_review` 상태에서 auto-step은 GPT API를 호출하지 않고 수동 리뷰 브리지 명령을 안내한다.
.ai-dev\README.md:473:```powershell
.ai-dev\README.md:474:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
.ai-dev\README.md:475:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -Json
.ai-dev\README.md:480:```powershell
.ai-dev\README.md:481:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
.ai-dev\README.md:482:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard
.ai-dev\README.md:485:첫 번째 명령으로 `review-prompt.md`를 클립보드에 복사한 뒤 ChatGPT 웹 화면에 붙여넣는다. ChatGPT가 JSON 리
뷰만 출력하면 그 JSON을 다시 
클립보드에 복사하고 두 번째 명령으로 저장한다.
.ai-dev\README.md:489:```powershell
.ai-dev\README.md:490:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1
.ai-dev\README.md:491:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun
.ai-dev\README.md:492:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -MaxSte
ps 3
.ai-dev\README.md:493:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -Json
.ai-dev\README.md:496:auto-cycle에서 check, diff 저장, review prompt 생성을 허용하려면 auto-step과 같은 허용 옵션을 전달한다
.
.ai-dev\README.md:498:```powershell
.ai-dev\README.md:499:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowC
heck
.ai-dev\README.md:500:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowS
aveDiff
.ai-dev\README.md:501:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowR
eviewPrompt
.ai-dev\README.md:504:auto-cycle은 Codex/Cline 작업, GPT 리뷰, revise, commit, blocked, 사용자 개입 필요 action에
서 멈춘다. 무한 루프를 피하기 위
해 `-MaxSteps` 제한과 같은 action 반복 감지를 사용한다.
.ai-dev\README.md:506:auto-cycle이 `ask_gpt_review`에서 멈추면 `stoppedReason`은 `user_intervention_require
d:ask_gpt_review`로 
표시된다. 이때 텍스트 출력과 JSON 출력의 step 항목에는 수동 리뷰 브리지 명령이 함께 표시된다.
.ai-dev\README.md:508:```powershell
.ai-dev\README.md:509:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
.ai-dev\README.md:510:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard
.ai-dev\README.md:513:첫 번째 명령으로 `review-prompt.md`를 ChatGPT 웹 화면에 붙여넣을 수 있도록 복사하고, JSON 리뷰를 받은 뒤 두 번
째 명령으로 클립보드의 리뷰 JSO
N을 저장한다. auto-cycle은 이 단계에서 GPT API를 호출하지 않고 중단한다.
.ai-dev\README.md:522:auto-step과 auto-cycle은 Codex/GPT API 호출, git commit, git push를 자동 실행하지 않는다.
.ai-dev\README.md:528:```powershell
.ai-dev\README.md:529:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
.ai-dev\README.md:530:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
.ai-dev\README.md:531:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
.ai-dev\README.md:532:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
.ai-dev\README.md:533:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun
 -MaxSteps 3
.ai-dev\README.md:539:- `ask_gpt_review`: `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -
FromClipboard`를 사용해
 수동 리뷰 브리지로 진행한다.
.ai-dev\README.md:548:`save-review` 실패는 잘못된 클립보드 입력 때문에 발생할 수 있다. 실패 시에는 오류 preview를 확인하고 JSON 리뷰만 다
시 복사한다. 완료된 goal이나 
기존 정상 상태를 불필요하게 오염시키지 않도록 실패 기록 방식은 별도 정책에 따라 개선한다.
.ai-dev\README.md:550:최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review`
 성공/실패 흐름 확인 결과를 `t
est-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.
.ai-dev\README.md:552:## Codex CLI 완전 자동화 준비
.ai-dev\README.md:554:다음 자동화 단계에서는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI, `gh` 
없이 Codex CLI만 사용한다.
.ai-dev\README.md:558:- `codex-cli 0.133.0` 사용 가능
.ai-dev\README.md:559:- `codex exec` 동작 확인 완료
.ai-dev\README.md:568:- `scripts/ai-dev-run-codex.ps1`: `.ai-dev/current-task-prompt.md`를 Codex CLI에
 전달해 현재 task 구현을 수행
한다.
.ai-dev\README.md:569:- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Codex CLI
에 전달해 JSON 리뷰를 생성하고
 저장 흐름에 연결한다.
.ai-dev\README.md:570:- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저장, C
odex 리뷰, save-revie
w, pass 시 commit/complete-task를 연결한다.
.ai-dev\README.md:571:- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입력하면 go
al/queue/state 생성, 
current-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.
.ai-dev\README.md:572:- `scripts/ai-dev-autopilot.ps1`: 완료된 현재 goal과 backlog를 기준으로 다음 goal 후보를 고르고 `
ai-dev-auto-goal.ps
1` 흐름에 전달한다.
.ai-dev\README.md:577:- Codex 구현 실행은 `AllowCodex`가 있을 때만 수행한다.
.ai-dev\README.md:578:- Codex 리뷰 실행은 `AllowReviewCodex`가 있을 때만 수행한다.
.ai-dev\README.md:582:- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
.ai-dev\README.md:588:- `.ai-dev/codex-result.md`: Codex 구현 실행 결과
.ai-dev\README.md:589:- `.ai-dev/review-response.json`: Codex 리뷰 JSON 원문
.ai-dev\README.md:590:- `.ai-dev/review.md`: 저장된 리뷰 요약
.ai-dev\README.md:595:### Codex 구현 실행
.ai-dev\README.md:597:`.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 실행한다. 실행 전 `git s
tatus --short`를 확인하
고, 작업 트리가 dirty이면 기본 중단한다. 단, dirty 파일이 `.ai-dev/current-task-prompt.md`뿐이면 프롬프트 생성 산출물로 보고 진행할 수 있다
.
.ai-dev\README.md:601:```powershell
.ai-dev\README.md:602:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -DryRun
.ai-dev\README.md:605:기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-result.md`에 저장한다.
.ai-dev\README.md:607:```powershell
.ai-dev\README.md:608:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
.ai-dev\README.md:613:```powershell
.ai-dev\README.md:614:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -Generat
ePromptIfMissing
.ai-dev\README.md:619:```powershell
.ai-dev\README.md:620:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -DryRun 
-Json
.ai-dev\README.md:623:dirty worktree에서도 실행해야 하는 특별한 경우에만 `-AllowDirty`를 명시한다. 이 옵션은 사용자 변경과 Codex 변경
이 섞일 수 있으므로 full cy
cle에서는 초기 기본값으로 사용하지 않는다.
.ai-dev\README.md:625:```powershell
.ai-dev\README.md:626:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDi
rty
.ai-dev\README.md:629:이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, n
pm install, package
 파일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.
.ai-dev\README.md:631:### Codex 리뷰 실행
.ai-dev\README.md:633:`.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 `.ai-dev/review-respo
nse.json`에 저장한다. 실행
 전 `git status --short`를 확인하고, 작업 트리가 dirty이면 기본 중단한다. 리뷰 대상 변경사항이 남아 있는 상태에서 실행해야 하는 경우에만 `-AllowDi
rty`를 명시한다.
.ai-dev\README.md:637:```powershell
.ai-dev\README.md:638:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -
DryRun
.ai-dev\README.md:641:기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-review-result.md`에 저장한
다. Codex 출력에서 첫 번째 
유효 JSON 리뷰 객체를 추출해 `.ai-dev/review-response.json`에 저장한다.
.ai-dev\README.md:643:```powershell
.ai-dev\README.md:644:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1
.ai-dev\README.md:647:`review-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GenerateReviewPromptIfMissing`를 사용한다.
.ai-dev\README.md:649:```powershell
.ai-dev\README.md:650:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -
GenerateReviewPromp
tIfMissing
.ai-dev\README.md:653:리뷰 JSON 저장 후 `ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json`
 흐름까지 이어가려면 `-SaveR
eview`를 사용한다.
.ai-dev\README.md:655:```powershell
.ai-dev\README.md:656:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -
AllowDirty -SaveRev
iew
.ai-dev\README.md:661:```powershell
.ai-dev\README.md:662:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -
DryRun -Json
.ai-dev\README.md:667:- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체만 출력하라
는 안전 규칙을 추가한다.
.ai-dev\README.md:669:- JSON 추출에 실패하면 출력 preview를 보여주고 종료 코드 1로 종료한다.
.ai-dev\README.md:675:`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, d
iff 저장, strict revi
ew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.
.ai-dev\README.md:680:2. `ai-dev-run-codex.ps1`
.ai-dev\README.md:683:5. `ai-dev-make-review-prompt.ps1 -Strict`
.ai-dev\README.md:684:6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
.ai-dev\README.md:685:7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`
이 `pass`여야 한다.
.ai-dev\README.md:694:```powershell
.ai-dev\README.md:695:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -D
ryRun
.ai-dev\README.md:700:```powershell
.ai-dev\README.md:701:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -D
ryRun -Json
.ai-dev\README.md:706:```powershell
.ai-dev\README.md:707:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -D
ryRun -MaxTasks 1 -
MaxSteps 20
.ai-dev\README.md:712:```powershell
.ai-dev\README.md:713:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -D
ryRun -MaxTasks 3 -
MaxSteps 20
.ai-dev\README.md:716:`-AllowCodex` 없이 실제 실행하면 prompt 생성 이후 Codex 구현 실행 직전에서 중단하고 추천 명령을 출력한다. Codex
 구현까지 허용하려면 명시적으로 `
-AllowCodex`를 지정한다.
.ai-dev\README.md:718:```powershell
.ai-dev\README.md:719:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -A
llowCodex
.ai-dev\README.md:722:Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowReviewCodex`를 함께 지정한다.
.ai-dev\README.md:724:```powershell
.ai-dev\README.md:725:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -A
llowCodex -AllowRev
iewCodex -MaxTasks 1
.ai-dev\README.md:730:```powershell
.ai-dev\README.md:731:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -A
llowCodex -AllowRev
iewCodex -AllowCommit -MaxTasks 1
.ai-dev\README.md:736:```powershell
.ai-dev\README.md:737:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -A
llowCodex -AllowRev
iewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 1
.ai-dev\README.md:742:```powershell
.ai-dev\README.md:743:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -A
llowCodex -AllowRev
iewCodex -AllowCommit -AllowDirty -MaxTasks 3
.ai-dev\README.md:746:dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중
단 정책은 `ai-dev-run-c
odex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.
.ai-dev\README.md:748:```powershell
.ai-dev\README.md:749:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -A
llowCodex -AllowRev
iewCodex -AllowDirty -MaxTasks 1
.ai-dev\README.md:752:리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`
가 아니면 자동 커밋과 comple
te-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package-l
ock.json` 변경이 감지되면 
`package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 `commit_not_confirmed`로
 중단하고 complete-task
를 실행하지 않는다.
.ai-dev\README.md:760:```powershell
.ai-dev\README.md:761:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalT
itle "업무 검색 결과 하이라이
트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun
.ai-dev\README.md:767:```powershell
.ai-dev\README.md:768:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalT
itle "업무 검색 결과 하이라이
트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun -Json
.ai-dev\README.md:773:```powershell
.ai-dev\README.md:774:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalT
itle "업무 검색 결과 하이라이
트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다."
.ai-dev\README.md:777:생성 후 full auto-cycle 래퍼 호출까지 이어가려면 `-AllowRun` 또는 `-AllowCodex`, `-AllowReview
Codex`, `-AllowComm
it` 같은 명시적 실행 옵션을 지정한다. `-AllowRun` 단독은 full-cycle 래퍼 호출만 허용하며 Codex 구현이나 Codex 리뷰 권한을 대신하지 않는다. 실제 
구현까지 허용하려면 `-AllowC
odex`, 리뷰까지 허용하려면 `-AllowReviewCodex`, 자동 커밋과 task 완료까지 허용하려면 기존 full cycle과 동일하게 `-AllowCodex -Allo
wReviewCodex -Allow
Commit`을 함께 지정한다.
.ai-dev\README.md:779:```powershell
.ai-dev\README.md:780:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalT
itle "업무 검색 결과 하이라이
트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -Allo
wCommit -MaxTasks 1
.ai-dev\README.md:785:1. `GoalTitle`과 `GoalDescription`을 검증한다.
.ai-dev\README.md:786:2. Codex CLI를 이용해 goal/queue/state 초안을 생성한다.
.ai-dev\README.md:787:3. Codex 출력에서 `goalMarkdown`, `queue`, `state` JSON을 추출한다.
.ai-dev\README.md:796:- `GoalTitle` 또는 `GoalDescription`이 비어 있으면 종료한다.
.ai-dev\README.md:800:- full cycle 호출은 `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommi
t` 중 하나가 있을 때만 수행한다
.
.ai-dev\README.md:801:- `-AllowRun` 단독은 구현, 리뷰, 커밋을 수행한다는 의미가 아니다. 하위 full cycle은 여전히 `-AllowCodex`,
 `-AllowReviewCodex
`, `-AllowCommit` 권한에 따라 각 위험 단계를 허용하거나 중단한다.
.ai-dev\README.md:819:| `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit` | 꺼짐 | 하위 auto-goal/full-
cycle 흐름의 Codex 구현,
 Codex 리뷰, 커밋 단계를 각각 허용한다. |
.ai-dev\README.md:823:```powershell
.ai-dev\README.md:824:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRu
n
.ai-dev\README.md:829:```powershell
.ai-dev\README.md:830:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRu
n -Json
.ai-dev\README.md:835:```powershell
.ai-dev\README.md:836:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -MaxGo
als 1
.ai-dev\README.md:841:```powershell
.ai-dev\README.md:842:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -Allow
Codex -AllowReviewC
odex -AllowCommit -MaxGoals 1 -MaxTasks 1
.ai-dev\README.md:850:- build/lint/review 실패, 반복 revise loop, dirty worktree 안전 검사 실패처럼 하위 full cycl
e 게이트가 실패하면 해당 실패 사
유를 읽을 수 있게 남기고 중단한다.
.ai-dev\README.md:871:- 기존 단일 goal 흐름 확인: `scripts/ai-dev-auto-goal.ps1`는 여전히 `GoalTitle`과 `GoalDesc
ription`을 직접 받는 진입점
이다. autopilot 검증 후에도 auto-goal DryRun이 기존처럼 goal/task 계획을 출력하는지 확인한다.
.ai-dev\README.md:872:- 실행 권한 확인: `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit`을 주
지 않은 autopilot은 다음 
goal 준비까지만 수행하고 full cycle을 실행하지 않아야 한다.



codex
README에는 이미 `scripts/ai-dev-run-review-codex.ps1`라는 이름과 사용 흐름이 문서화되어 있습니다. 실제 파일 구조를 확인해 기존 PowerShe
ll 스타일에 맞추겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPat
h 'D:\\ai-apps\\planpilot-local\\scripts'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-run-codex.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-make-review-prompt.ps1'" in D:\ai-apps\planpilot-loca
l
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-save-review.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 3253ms:


    디렉터리: D:\ai-apps\planpilot-local\scripts


Mode                 LastWriteTime         Length Name                                              
                   
----                 -------------         ------ ----                                              
                   
-a----        2026-07-09  오후 10:21          56505 ai-dev-auto-cycle-full.ps1                        
                   
-a----        2026-06-23   오후 3:20          19373 ai-dev-auto-cycle.ps1                             
                   
-a----        2026-06-19   오후 9:29          56799 ai-dev-auto-goal.ps1                              
                   
-a----        2026-06-07   오후 3:03           8471 ai-dev-auto-step.ps1                              
                   
-a----        2026-07-12  오후 10:28          26673 ai-dev-autopilot.ps1                              
                   
-a----        2026-06-14  오후 10:04           7776 ai-dev-check.ps1                                  
                   
-a----        2026-06-14   오후 9:21          13495 ai-dev-commit.ps1                                 
                   
-a----        2026-06-10  오후 11:27           7152 ai-dev-complete-task.ps1                          
                   
-a----        2026-06-04   오후 4:24           3805 ai-dev-copy-review-prompt.ps1                     
                   
-a----        2026-06-03  오후 10:14           5446 ai-dev-current-task.ps1                           
                   
-a----        2026-06-03  오후 10:14            309 ai-dev-env.ps1                                    
                   
-a----        2026-06-03  오후 10:14           3085 ai-dev-init.ps1                                   
                   
-a----        2026-06-04  오전 12:01           7243 ai-dev-make-prompt.ps1                            
                   
-a----        2026-06-09  오후 11:54           8493 ai-dev-make-review-prompt.ps1                     
                   
-a----        2026-06-03  오후 10:14          11227 ai-dev-make-revise-prompt.ps1                     
                   
-a----        2026-06-03  오후 10:14           2692 ai-dev-manual-cycle.ps1                           
                   
-a----        2026-06-14   오후 9:34          14878 ai-dev-next.ps1                                   
                   
-a----        2026-07-09  오후 11:00           7233 ai-dev-run-codex.ps1                              
                   
-a----        2026-06-08  오후 11:43          11520 ai-dev-run-review-codex.ps1                       
                   
-a----        2026-06-10  오후 10:15          10727 ai-dev-save-diff.ps1                              
                   
-a----        2026-06-07   오후 3:57          13077 ai-dev-save-review.ps1                            
                   
-a----        2026-06-28   오후 7:52          14218 ai-dev-status.ps1                                 
                   
-a----        2026-05-24   오후 1:50           9682 monitor-and-dev-loop.ps1                          
                   



 succeeded in 3264ms:
param(
    [switch]$Strict
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"
$diffRelativePath = ".ai-dev/diff.md"
$reviewPromptRelativePath = ".ai-dev/review-prompt.md"

$goalPath = Join-Path $projectRoot $goalRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
$diffPath = Join-Path $projectRoot $diffRelativePath
$reviewPromptPath = Join-Path $projectRoot $reviewPromptRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Get-MissingFields {
    param(
        [object]$InputObject,
        [string[]]$RequiredFields
    )

    $missingFields = @()

    foreach ($field in $RequiredFields) {
        if (-not ($InputObject.PSObject.Properties.Name -contains $field)) {
            $missingFields += $field
        }
    }

    return $missingFields
}

function Stop-ForMissingFields {
    param(
        [string]$SourceName,
        [string[]]$MissingFields
    )

    if ($MissingFields.Count -eq 0) {
        return
    }

    Write-Host "$SourceName 누락 필드:"
    foreach ($field in $MissingFields) {
        Write-Host "  - $field"
    }

    Stop-WithError "$SourceName 필수 필드가 누락되었습니다."
}

function Test-HasValue {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Convert-ToMarkdownList {
    param(
        [object]$Value
    )

    if ($null -eq $Value -or @($Value).Count -eq 0) {
        return "- 없음"
    }

    return (@($Value) | ForEach-Object { "- $_" }) -join "`r`n"
}

foreach ($requiredPath in @(
    $goalRelativePath,
    $queueRelativePath,
    $stateRelativePath,
    $testResultRelativePath,
    $diffRelativePath
)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $goalPath
$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath
$testResultContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $testResultPath
$diffContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $diffPath

$queueRequiredFields = @(
    "goalTitle",
    "currentTaskId",
    "tasks"
)
$stateRequiredFields = @(
    "goalStatus",
    "currentTaskId"
)

Stop-ForMissingFields $queueRelativePath (Get-MissingFields $queue $queueRequiredFields)
Stop-ForMissingFields $stateRelativePath (Get-MissingFields $state $stateRequiredFields)

if ($null -eq $queue.tasks -or -not ($queue.tasks -is [System.Collections.IEnumerable])) {
    Stop-WithError "$queueRelativePath tasks 필드는 배열이어야 합니다."
}

$tasks = @($queue.tasks)
$currentTaskId = $null

if (Test-HasValue $state.currentTaskId) {
    $currentTaskId = [string]$state.currentTaskId
} elseif (Test-HasValue $queue.currentTaskId) {
    $currentTaskId = [string]$queue.currentTaskId
} else {
    $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -First 1

    if ($null -ne $inProgressTask) {
        $currentTaskId = [string]$inProgressTask.id
    } else {
        $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

        if ($null -ne $pendingTask) {
            $currentTaskId = [string]$pendingTask.id
        }
    }
}

if (-not (Test-HasValue $currentTaskId)) {
    Stop-WithError "리뷰할 task가 없습니다."
}

$currentTask = $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1

if ($null -eq $currentTask) {
    Stop-WithError "currentTaskId에 해당하는 task를 찾을 수 없습니다: $currentTaskId"
}

$taskRequiredFields = @(
    "id",
    "title",
    "description",
    "type",
    "status",
    "priority",
    "dependsOn",
    "verification"
)

Stop-ForMissingFields "task $currentTaskId" (Get-MissingFields $currentTask $taskRequiredFields)

$dependsOnText = Convert-ToMarkdownList $currentTask.dependsOn
$verificationText = Convert-ToMarkdownList $currentTask.verification
$strictCriteria = if ($Strict) {
@"
- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.
"@
} else {
    "- Strict 추가 기준 없음"
}

$outputFormat = @'
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
'@

$reviewPromptContent = @"
# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 `App Change Files`와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- `.ai-dev` 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

$goalContent

## Current Task

- Task ID: $($currentTask.id)
- Title: $($currentTask.title)
- Description: $($currentTask.description)
- Type: $($currentTask.type)
- Status: $($currentTask.status)
- Priority: $($currentTask.priority)
- Depends on:
$dependsOnText
- Verification:
$verificationText

## Test Result

$testResultContent

## Diff To Review

$diffContent

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 `.ai-dev` 운영 산출물이 구분되어 있는가
- `.ai-dev` 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

$strictCriteria

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

$outputFormat

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요
"@

[System.IO.File]::WriteAllText($reviewPromptPath, $reviewPromptContent, $utf8WithBom)

Write-Host "생성된 리뷰 프롬프트 파일: $reviewPromptRelativePath"
Write-Host "Current task id: $($currentTask.id)"
Write-Host "Current task title: $($currentTask.title)"
Write-Host "Strict 사용 여부: $($Strict.IsPresent)"

 succeeded in 3371ms:
param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GeneratePromptIfMissing,
    [string]$PromptPath = ".ai-dev/current-task-prompt.md",
    [string]$ResultPath = ".ai-dev/codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'

function Resolve-RepoPath {
    param(
        [string]$Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param(
        [string]$Path
    )

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
}

function Write-RunResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message
    )

    if ($Json) {
        [ordered]@{
            action = $Action
            executed = $Executed
            exitCode = $ExitCode
            resultPath = (ConvertTo-RepoRelativePath $ResultPath)
            message = $Message
        } | ConvertTo-Json -Depth 10
    } else {
        Write-Host $Message
    }

    exit $ExitCode
}

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $message = "git status 확인에 실패했습니다: $($statusOutput -join "`n")"
        Write-RunResult "run_codex" $false 1 $message
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-GitStatusPath {
    param(
        [string]$StatusLine
    )

    if ($StatusLine.Length -lt 4) {
        return $StatusLine.Trim().Replace("\", "/")
    }

    $path = $StatusLine.Substring(3).Trim()

    if ($path.Contains(" -> ")) {
        $path = ($path -split " -> ")[-1].Trim()
    }

    return $path.Replace("\", "/")
}

function Test-OnlyAllowedPromptDirty {
    param(
        [string[]]$StatusLines,
        [string]$PromptRelativePath
    )

    if ($StatusLines.Count -eq 0) {
        return $true
    }

    foreach ($line in $StatusLines) {
        $statusPath = Get-GitStatusPath $line

        if ($statusPath -ne $PromptRelativePath) {
            return $false
        }
    }

    return $true
}

function New-CodexPrompt {
    param(
        [string]$PromptFilePath
    )

    return @"
Read and follow the full task prompt at this absolute file path: $PromptFilePath

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, git merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .git.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report the conflict.
"@
}

function New-RunCommandText {
    $arguments = @(
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        "scripts/ai-dev-run-codex.ps1"
    )

    if ($PromptPath -ne ".ai-dev/current-task-prompt.md") {
        $arguments += "-PromptPath"
        $arguments += $promptRelativePath
    }

    if ($ResultPath -ne ".ai-dev/codex-result.md") {
        $arguments += "-ResultPath"
        $arguments += $resultRelativePath
    }

    if ($AllowDirty) {
        $arguments += "-AllowDirty"
    }

    if ($GeneratePromptIfMissing) {
        $arguments += "-GeneratePromptIfMissing"
    }

    return "powershell $($arguments -join ' ')"
}

Set-Location $repoRoot

$promptRelativePath = ConvertTo-RepoRelativePath $PromptPath
$resultRelativePath = ConvertTo-RepoRelativePath $ResultPath
$resolvedPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $PromptPath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    if (-not (Test-OnlyAllowedPromptDirty $statusLines $promptRelativePath)) {
        $dirtyText = ($statusLines -join "`n")
        $message = "작업 트리가 dirty 상태라 Codex 실행을 중단합니다. 계속하려면 변경사항을 정리하거나 -AllowDirty를 명시하세요.`n$dirtyT
ext"
        Write-RunResult "run_codex" $false 1 $message
    }
}

if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
    if (-not $GeneratePromptIfMissing) {
        $message = "프롬프트 파일이 없습니다: $promptRelativePath`n먼저 다음 명령을 실행하세요: powershell -ExecutionPolicy
 Bypass -File scripts/ai-dev-make-prompt.ps1"
        Write-RunResult "run_codex" $false 1 $message
    }

    $makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"

    if (-not (Test-Path -LiteralPath $makePromptPath -PathType Leaf)) {
        Write-RunResult "run_codex" $false 1 "프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make-prompt.ps
1"
    }

    $makePromptOutput = & powershell -ExecutionPolicy Bypass -File $makePromptPath 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_codex" $false 1 "프롬프트 생성에 실패했습니다: $($makePromptOutput.Trim())"
    }
}

if (-not (Test-Path -LiteralPath $resolvedPromptPath -PathType Leaf)) {
    Write-RunResult "run_codex" $false 1 "프롬프트 파일을 찾을 수 없습니다: $promptRelativePath"
}

$codexPrompt = New-CodexPrompt $resolvedPromptPath
$commandText = New-RunCommandText

if ($DryRun) {
    $message = @"
Codex 구현 실행 DryRun입니다.
- EntryPoint: scripts/ai-dev-run-codex.ps1
- Repository: $repoRoot
- Prompt: $promptRelativePath
- Result: $resultRelativePath
- Command: $commandText
- CodexCommand: codex exec <wrapper prompt reading $promptRelativePath>
- AllowDirty: $([bool]$AllowDirty)
- DirtyCount: $($statusLines.Count)
"@

    Write-RunResult "run_codex" $false 0 $message
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    Write-RunResult "run_codex" $false 1 "Codex CLI를 찾을 수 없습니다. codex 명령을 사용할 수 있는지 확인하세요."
}

$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Implementation Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Prompt: $promptRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    Write-RunResult "run_codex" $true 1 "Codex 실행에 실패했습니다. 결과 파일을 확인하세요: $resultRelativePath"
}

Write-RunResult "run_codex" $true 0 "Codex 실행이 완료되었습니다. 결과 파일: $resultRelativePath"

 succeeded in 3592ms:
param(
    [string]$ReviewFile,
    [string]$ReviewJson,
    [switch]$FromClipboard,
    [switch]$WriteFailureReview
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$stateRelativePath = ".ai-dev/state.json"
$reviewRelativePath = ".ai-dev/review.md"
$statePath = Join-Path $projectRoot $stateRelativePath
$reviewPath = Join-Path $projectRoot $reviewRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'

function Stop-WithError {
    param(
        [string]$Message
    )

    Write-Error $Message
    exit 1
}

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        Stop-WithError "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Test-HasValue {
    param(
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function Set-ObjectProperty {
    param(
        [object]$InputObject,
        [string]$Name,
        [object]$Value
    )

    if ($InputObject.PSObject.Properties.Name -contains $Name) {
        $InputObject.$Name = $Value
    } else {
        $InputObject | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Save-StateReviewResult {
    param(
        [object]$State,
        [string]$Decision,
        [string]$Severity,
        [string]$CommandStatus,
        [string]$ErrorSummary
    )

    Set-ObjectProperty $State "lastReviewDecision" $Decision
    Set-ObjectProperty $State "lastReviewSeverity" $Severity
    Set-ObjectProperty $State "lastCommand" "save-review"
    Set-ObjectProperty $State "lastCommandStatus" $CommandStatus
    Set-ObjectProperty $State "lastErrorSummary" $ErrorSummary
    Set-ObjectProperty $State "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))

    $stateJson = $State | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)
}

function Get-ReviewInput {
    $inputCount = 0

    if (Test-HasValue $ReviewJson) {
        $inputCount++
    }

    if (Test-HasValue $ReviewFile) {
        $inputCount++
    }

    if ($FromClipboard) {
        $inputCount++
    }

    if ($inputCount -eq 0) {
        Write-Host "사용 예시:"
        Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -Revie
wFile .ai-dev/review-response.json"
        Write-Host '  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -Revie
wJson ''{"decision":"pass","severity":"none","summary":"OK","required_changes":[],"optional_suggesti
ons":[],"next_step":"complete_task"}'''
        Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromC
lipboard"
        Stop-WithError "리뷰 입력을 지정해야 합니다."
    }

    if ($inputCount -gt 1) {
        Stop-WithError "-ReviewJson, -ReviewFile, -FromClipboard 중 하나만 지정해야 합니다."
    }

    if (Test-HasValue $ReviewJson) {
        return $ReviewJson
    }

    if (Test-HasValue $ReviewFile) {
        $reviewFilePath = if ([System.IO.Path]::IsPathRooted($ReviewFile)) {
            $ReviewFile
        } else {
            Join-Path $projectRoot $ReviewFile
        }

        if (-not (Test-Path -LiteralPath $reviewFilePath -PathType Leaf)) {
            Stop-WithError "리뷰 파일이 없습니다: $ReviewFile"
        }

        try {
            return Get-Content -Raw -Encoding UTF8 -LiteralPath $reviewFilePath
        } catch {
            Stop-WithError "리뷰 파일을 읽지 못했습니다: $ReviewFile"
        }
    }

    try {
        return Get-Clipboard -Raw
    } catch {
        Stop-WithError "클립보드 내용을 읽지 못했습니다: $($_.Exception.Message)"
    }
}

function Get-JsonCandidates {
    param(
        [string]$RawInput
    )

    $candidates = @()
    $trimmed = $RawInput.Trim()

    if (-not [string]::IsNullOrWhiteSpace($trimmed)) {
        $candidates += $trimmed
    }

    $codeBlockMatch = [regex]::Match(
        $RawInput,
        '```(?:json)?\s*(\{[\s\S]*?\})\s*```',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    if ($codeBlockMatch.Success) {
        $candidates += $codeBlockMatch.Groups[1].Value.Trim()
    }

    $firstJsonObject = Get-FirstJsonObject $RawInput

    if (-not [string]::IsNullOrWhiteSpace($firstJsonObject)) {
        $candidates += $firstJsonObject
    }

    return @($candidates | Select-Object -Unique)
}

function Get-FirstJsonObject {
    param(
        [string]$RawInput
    )

    $start = $RawInput.IndexOf("{")

    if ($start -lt 0) {
        return $null
    }

    $depth = 0
    $inString = $false
    $escaped = $false

    for ($index = $start; $index -lt $RawInput.Length; $index++) {
        $char = $RawInput[$index]

        if ($escaped) {
            $escaped = $false
            continue
        }

        if ($char -eq "\") {
            $escaped = $true
            continue
        }

        if ($char -eq '"') {
            $inString = -not $inString
            continue
        }

        if ($inString) {
            continue
        }

        if ($char -eq "{") {
            $depth++
            continue
        }

        if ($char -eq "}") {
            $depth--

            if ($depth -eq 0) {
                return $RawInput.Substring($start, $index - $start + 1).Trim()
            }
        }
    }

    return $null
}

function Get-InputPreview {
    param(
        [string]$RawInput
    )

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 300) {
        return $normalized
    }

    return $normalized.Substring(0, 300)
}

function ConvertFrom-ReviewJson {
    param(
        [string]$RawInput
    )

    foreach ($candidate in Get-JsonCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -ne $parsed -and $parsed -isnot [System.Array]) {
                return [PSCustomObject]@{
                    Parsed = $parsed
                    JsonText = $candidate
                }
            }
        } catch {
        }
    }

    throw "리뷰 입력에서 유효한 JSON 객체를 찾지 못했습니다."
}

function Get-ValidationErrors {
    param(
        [object]$Review
    )

    $errors = @()
    $requiredFields = @(
        "decision",
        "severity",
        "summary",
        "required_changes",
        "optional_suggestions",
        "next_step"
    )

    foreach ($field in $requiredFields) {
        if (-not ($Review.PSObject.Properties.Name -contains $field)) {
            $errors += "필수 필드 누락: $field"
        }
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("pass", "revise", "blocked") -notcontains $Review.decision) {
        $errors += "허용되지 않은 decision: $($Review.decision)"
    }

    if (@("none", "low", "medium", "high", "critical") -notcontains $Review.severity) {
        $errors += "허용되지 않은 severity: $($Review.severity)"
    }

    if (@("complete_task", "revise_with_codex", "stop_for_user") -notcontains $Review.next_step) {
        $errors += "허용되지 않은 next_step: $($Review.next_step)"
    }

    if ($Review.required_changes -isnot [System.Collections.IEnumerable] -or $Review.required_change
s -is [string]) {
        $errors += "required_changes는 배열이어야 합니다."
    }

    if ($Review.optional_suggestions -isnot [System.Collections.IEnumerable] -or $Review.optional_su
ggestions -is [string]) {
        $errors += "optional_suggestions는 배열이어야 합니다."
    }

    return $errors
}

function Format-RequiredChanges {
    param(
        [object]$Changes
    )

    $items = @($Changes)

    if ($items.Count -eq 0) {
        return "- 없음"
    }

    return ($items | ForEach-Object {
        $file = if (Test-HasValue $_.file) { $_.file } else { "unknown" }
        $reason = if (Test-HasValue $_.reason) { $_.reason } else { "이유 없음" }
        $suggestion = if (Test-HasValue $_.suggestion) { $_.suggestion } else { "제안 없음" }
        "- $file`: $reason / $suggestion"
    }) -join "`r`n"
}

function Format-OptionalSuggestions {
    param(
        [object]$Suggestions
    )

    $items = @($Suggestions)

    if ($items.Count -eq 0) {
        return "- 없음"
    }

    return ($items | ForEach-Object {
        $file = if (Test-HasValue $_.file) { $_.file } else { "unknown" }
        $suggestion = if (Test-HasValue $_.suggestion) { $_.suggestion } else { "제안 없음" }
        "- $file`: $suggestion"
    }) -join "`r`n"
}

function Save-InvalidReview {
    param(
        [object]$State,
        [string]$RawInput,
        [string]$ErrorSummary
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $content = @"
# AI Dev Review

## $timestamp

- Decision: blocked
- Severity: critical
- Next step: stop_for_user
- Summary: 리뷰 JSON을 파싱하거나 검증하지 못했습니다.

### Validation Error

- $ErrorSummary

### Raw Input

${codeFence}text
$RawInput
$codeFence
"@

    [System.IO.File]::WriteAllText($reviewPath, $content, $utf8WithBom)
    Save-StateReviewResult $State "blocked" "critical" "failed" $ErrorSummary
}

function Stop-WithInvalidReviewInput {
    param(
        [object]$State,
        [string]$RawInput,
        [string]$ErrorSummary
    )

    if ($WriteFailureReview) {
        Save-InvalidReview $State $RawInput $ErrorSummary
        Stop-WithError "리뷰 JSON 저장에 실패했습니다: $ErrorSummary"
    }

    Write-Host "리뷰 입력 오류로 review.md와 state.json을 수정하지 않았습니다."
    Write-Host "실패 리뷰를 명시적으로 기록하려면 -WriteFailureReview 옵션을 사용하세요."
    Stop-WithError "리뷰 JSON 저장에 실패했습니다: $ErrorSummary"
}

if (-not (Test-Path -LiteralPath $statePath -PathType Leaf)) {
    Stop-WithError "필수 파일이 없습니다: $stateRelativePath"
}

$state = Read-JsonFile $statePath $stateRelativePath
$rawReview = Get-ReviewInput
$inputPreview = Get-InputPreview $rawReview

if ([string]::IsNullOrWhiteSpace($rawReview)) {
    $errorSummary = "리뷰 입력이 비어 있습니다. ChatGPT가 출력한 JSON 리뷰를 클립보드에 복사한 뒤 다시 실행하세요. 입력 preview: $inputP
review"
    Stop-WithInvalidReviewInput $state $rawReview $errorSummary
}

try {
    $reviewResult = ConvertFrom-ReviewJson $rawReview
    $review = $reviewResult.Parsed
    $validationErrors = @(Get-ValidationErrors $review)

    if ($validationErrors.Count -gt 0) {
        throw ($validationErrors -join "; ")
    }
} catch {
    $errorSummary = "$($_.Exception.Message) 입력 preview: $inputPreview"
    Stop-WithInvalidReviewInput $state $rawReview $errorSummary
}

$prettyJson = $review | ConvertTo-Json -Depth 20
$requiredChangesText = Format-RequiredChanges $review.required_changes
$optionalSuggestionsText = Format-OptionalSuggestions $review.optional_suggestions
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$reviewContent = @"
# AI Dev Review

## $timestamp

- Decision: $($review.decision)
- Severity: $($review.severity)
- Next step: $($review.next_step)
- Summary: $($review.summary)

### Required Changes

$requiredChangesText

### Optional Suggestions

$optionalSuggestionsText

### Raw JSON

${codeFence}json
$prettyJson
$codeFence
"@

[System.IO.File]::WriteAllText($reviewPath, $reviewContent, $utf8WithBom)
Save-StateReviewResult $state $review.decision $review.severity "passed" ""

$nextAction = if ($review.decision -eq "pass" -and $review.next_step -eq "complete_task") {
    "pass + complete_task: 다음 명령을 실행해 현재 task 완료 처리를 검토하세요. powershell -ExecutionPolicy Bypass -File
 scripts/ai-dev-complete-task.ps1 -ResultSummary `"리뷰 통과`""
} elseif ($review.decision -eq "revise" -and $review.next_step -eq "revise_with_codex") {
    "revise + make_revise_prompt: 다음 명령으로 재수정 프롬프트를 생성한 뒤 Codex/Cline에 전달하세요. powershell -ExecutionP
olicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1"
} elseif ($review.decision -eq "blocked" -or $review.next_step -eq "stop_for_user") {
    "blocked/stop_for_user: 사용자 판단이 필요합니다. 자동 진행을 중단하고 review.md의 Required Changes와 Summary를 확인하세요."
} else {
    "decision과 next_step 조합을 확인한 뒤 다음 행동을 결정하세요."
}

Write-Host "리뷰 저장 완료: $reviewRelativePath"
Write-Host "Decision: $($review.decision)"
Write-Host "Severity: $($review.severity)"
Write-Host "Next step: $($review.next_step)"
Write-Host "안내: $nextAction"

codex
이미 `scripts/ai-dev-run-review-codex.ps1`는 존재하므로, 새 로직을 중복 구현하기보다 AI Dev Loop가 고정 경로로 호출할 수 있는 얇은 wra
pper를 `.ai-dev/scripts`에 추가하는 방향이 가장 작습니다. 하위 스크립트의 파라미터 이름을 확인한 뒤 그대로 전달하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-run-review-codex.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1866ms:
param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GenerateReviewPromptIfMissing,
    [switch]$SaveReview,
    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
    [string]$ResultPath = ".ai-dev/codex-review-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'

function Resolve-RepoPath {
    param(
        [string]$Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param(
        [string]$Path
    )

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
}

function Write-RunResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message
    )

    if ($Json) {
        [ordered]@{
            action = $Action
            executed = $Executed
            exitCode = $ExitCode
            reviewResponsePath = (ConvertTo-RepoRelativePath $ReviewResponsePath)
            resultPath = (ConvertTo-RepoRelativePath $ResultPath)
            message = $Message
        } | ConvertTo-Json -Depth 10
    } else {
        Write-Host $Message
    }

    exit $ExitCode
}

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $message = "git status 확인에 실패했습니다: $($statusOutput -join "`n")"
        Write-RunResult "run_review_codex" $false 1 $message
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-InputPreview {
    param(
        [string]$RawInput
    )

    if ($null -eq $RawInput) {
        return "<null>"
    }

    $normalized = $RawInput.Replace("`r", " ").Replace("`n", " ").Trim()

    if ($normalized.Length -eq 0) {
        return "<empty>"
    }

    if ($normalized.Length -le 500) {
        return $normalized
    }

    return $normalized.Substring(0, 500)
}

function Get-JsonObjectCandidates {
    param(
        [string]$RawInput
    )

    $candidates = @()

    for ($start = 0; $start -lt $RawInput.Length; $start++) {
        if ($RawInput[$start] -ne "{") {
            continue
        }

        $depth = 0
        $inString = $false
        $escaped = $false

        for ($index = $start; $index -lt $RawInput.Length; $index++) {
            $char = $RawInput[$index]

            if ($escaped) {
                $escaped = $false
                continue
            }

            if ($char -eq "\") {
                $escaped = $true
                continue
            }

            if ($char -eq '"') {
                $inString = -not $inString
                continue
            }

            if ($inString) {
                continue
            }

            if ($char -eq "{") {
                $depth++
                continue
            }

            if ($char -eq "}") {
                $depth--

                if ($depth -eq 0) {
                    $candidates += $RawInput.Substring($start, $index - $start + 1).Trim()
                    break
                }
            }
        }
    }

    return @($candidates | Select-Object -Unique)
}

function Get-ValidationErrors {
    param(
        [object]$Review
    )

    $errors = @()
    $requiredFields = @(
        "decision",
        "severity",
        "summary",
        "required_changes",
        "optional_suggestions",
        "next_step"
    )

    foreach ($field in $requiredFields) {
        if (-not ($Review.PSObject.Properties.Name -contains $field)) {
            $errors += "필수 필드 누락: $field"
        }
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("pass", "revise", "blocked") -notcontains $Review.decision) {
        $errors += "허용되지 않은 decision: $($Review.decision)"
    }

    if (@("none", "low", "medium", "high", "critical") -notcontains $Review.severity) {
        $errors += "허용되지 않은 severity: $($Review.severity)"
    }

    if (@("complete_task", "revise_with_codex", "stop_for_user") -notcontains $Review.next_step) {
        $errors += "허용되지 않은 next_step: $($Review.next_step)"
    }

    if ($Review.required_changes -isnot [System.Collections.IEnumerable] -or $Review.required_change
s -is [string]) {
        $errors += "required_changes는 배열이어야 합니다."
    }

    if ($Review.optional_suggestions -isnot [System.Collections.IEnumerable] -or $Review.optional_su
ggestions -is [string]) {
        $errors += "optional_suggestions는 배열이어야 합니다."
    }

    return $errors
}

function ConvertFrom-CodexReviewOutput {
    param(
        [string]$RawInput
    )

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            $validationErrors = @(Get-ValidationErrors $parsed)

            if ($validationErrors.Count -gt 0) {
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 20)
            }
        } catch {
        }
    }

    throw "Codex 출력에서 필수 필드를 포함한 유효한 JSON 리뷰 객체를 찾지 못했습니다."
}

function New-CodexReviewPrompt {
    param(
        [string]$PromptFilePath
    )

    return "Read and follow the full review prompt at this absolute file path: $PromptFilePath"
}

Set-Location $repoRoot

$reviewPromptRelativePath = ConvertTo-RepoRelativePath $ReviewPromptPath
$reviewResponseRelativePath = ConvertTo-RepoRelativePath $ReviewResponsePath
$resultRelativePath = ConvertTo-RepoRelativePath $ResultPath
$resolvedReviewPromptPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ReviewPromptPath))
$resolvedReviewResponsePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ReviewResponsePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))
$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $message = "작업 트리가 dirty 상태라 Codex 리뷰 실행을 중단합니다. 계속하려면 변경사항을 정리하거나 -AllowDirty를 명시하세요.`n$dirtyTe
xt"
    Write-RunResult "run_review_codex" $false 1 $message
}

$promptExists = Test-Path -LiteralPath $resolvedReviewPromptPath -PathType Leaf

if (-not $promptExists -and -not $GenerateReviewPromptIfMissing) {
    $message = "리뷰 프롬프트 파일이 없습니다: $reviewPromptRelativePath`n먼저 다음 명령을 실행하세요: powershell -ExecutionP
olicy Bypass -File scripts/ai-dev-make-review-prompt.ps1"
    Write-RunResult "run_review_codex" $false 1 $message
}

$commandText = "codex exec <short wrapper pointing to $reviewPromptRelativePath>"
$saveReviewCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -R
eviewFile $reviewResponseRelativePath"

if ($DryRun) {
    $message = @"
Codex 리뷰 실행 DryRun입니다.
- Repository: $repoRoot
- Review prompt: $reviewPromptRelativePath
- Review response: $reviewResponseRelativePath
- Result: $resultRelativePath
- Command: $commandText
- SaveReview: $([bool]$SaveReview)
- SaveReviewCommand: $saveReviewCommandText
- GenerateReviewPromptIfMissing: $([bool]$GenerateReviewPromptIfMissing)
- WouldGenerateReviewPrompt: $(-not $promptExists -and [bool]$GenerateReviewPromptIfMissing)
- AllowDirty: $([bool]$AllowDirty)
- DirtyCount: $($statusLines.Count)
"@

    Write-RunResult "run_review_codex" $false 0 $message
}

if (-not $promptExists -and $GenerateReviewPromptIfMissing) {
    $makeReviewPromptPath = Join-Path $PSScriptRoot "ai-dev-make-review-prompt.ps1"

    if (-not (Test-Path -LiteralPath $makeReviewPromptPath -PathType Leaf)) {
        Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성 스크립트를 찾을 수 없습니다: scripts/ai-dev-make
-review-prompt.ps1"
    }

    $makeReviewPromptOutput = & powershell -ExecutionPolicy Bypass -File $makeReviewPromptPath 2>&1 
| Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 생성에 실패했습니다: $($makeReviewPromptOutput.T
rim())"
    }
}

if (-not (Test-Path -LiteralPath $resolvedReviewPromptPath -PathType Leaf)) {
    Write-RunResult "run_review_codex" $false 1 "리뷰 프롬프트 파일을 찾을 수 없습니다: $reviewPromptRelativePath"
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    Write-RunResult "run_review_codex" $false 1 "Codex CLI를 찾을 수 없습니다. codex 명령을 사용할 수 있는지 확인하세요."
}

$codexPrompt = New-CodexReviewPrompt $resolvedReviewPromptPath
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $codexPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Review Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Review prompt: $reviewPromptRelativePath
- Review response: $reviewResponseRelativePath
- Command: $commandText

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    Write-RunResult "run_review_codex" $true 1 "Codex 리뷰 실행에 실패했습니다. 결과 파일을 확인하세요: $resultRelativePa
th"
}

try {
    $reviewResult = ConvertFrom-CodexReviewOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    Write-RunResult "run_review_codex" $true 1 "Codex 리뷰 JSON 추출에 실패했습니다: $($_.Exception.Message) 출력
 preview: $preview"
}

[System.IO.File]::WriteAllText($resolvedReviewResponsePath, $reviewResult.JsonText, $utf8WithBom)

if ($SaveReview) {
    $saveReviewPath = Join-Path $PSScriptRoot "ai-dev-save-review.ps1"

    if (-not (Test-Path -LiteralPath $saveReviewPath -PathType Leaf)) {
        Write-RunResult "run_review_codex" $true 1 "리뷰 저장 스크립트를 찾을 수 없습니다: scripts/ai-dev-save-revie
w.ps1"
    }

    $saveReviewOutput = & powershell -ExecutionPolicy Bypass -File $saveReviewPath -ReviewFile $revi
ewResponseRelativePath 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-RunResult "run_review_codex" $true 1 "리뷰 JSON은 저장했지만 save-review 실행에 실패했습니다: $($saveRe
viewOutput.Trim())"
    }
}

$saveReviewMessage = if ($SaveReview) {
    " save-review 흐름까지 실행했습니다."
} else {
    " save-review를 실행하려면 -SaveReview를 사용하세요."
}

Write-RunResult "run_review_codex" $true 0 "Codex 리뷰 실행이 완료되었습니다. 리뷰 JSON: $reviewResponseRelativePa
th 결과 파일: $resultRelativePath$saveReviewMessage"

codex
수정은 새 wrapper 파일 하나로 제한하겠습니다. 이 파일은 `.ai-dev/scripts`라는 AI Dev Loop 전용 경로에서 호출되며, 실제 리뷰 실행은 이미 검증된 `
scripts/ai-dev-run-review-codex.ps1`에 위임하도록 만들겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\scripts\run-codex-review.ps1
diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..4af9f2f6fb037f7ae498378a103a4896432b5724
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+AI Dev Loop에서 Codex 리뷰를 실행하는 고정 진입점입니다.
+
+.DESCRIPTION
+이 스크립트는 저장소 루트의 scripts/ai-dev-run-review-codex.ps1를 호출하는
+얇은 wrapper입니다. Codex 리뷰 실행 로직은 기존 스크립트에 위임하고,
+자동화 루프는 .ai-dev/scripts/run-codex-review.ps1 경로만 호출하면 됩니다.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex 리뷰 실행 스크립트를 찾을 수 없습니다: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..4af9f2f6fb037f7ae498378a103a4896432b5724
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+AI Dev Loop에서 Codex 리뷰를 실행하는 고정 진입점입니다.
+
+.DESCRIPTION
+이 스크립트는 저장소 루트의 scripts/ai-dev-run-review-codex.ps1를 호출하는
+얇은 wrapper입니다. Codex 리뷰 실행 로직은 기존 스크립트에 위임하고,
+자동화 루프는 .ai-dev/scripts/run-codex-review.ps1 경로만 호출하면 됩니다.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex 리뷰 실행 스크립트를 찾을 수 없습니다: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

codex
wrapper 파일을 추가했습니다. 이제 실행은 하지 않고, PowerShell 파서로 문법만 확인해 실제 git/Codex 호출이 발생하지 않도록 검증하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\scripts\\run-codex-review.ps1'" in D:\ai-apps\planpilot-loca
l
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $errors 
= $null; [System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-apps\\planpilot-local\\
.ai-dev\\scripts\\run-codex-review.ps1', [ref]"'$tokens, [ref]$errors) > $null; if ($errors.Count -e
q 0) { '"'Parse OK' } else { "'$errors | ForEach-Object { $_.Message }; exit 1 }' in D:\ai-apps\plan
pilot-local
 succeeded in 2251ms:
<#
.SYNOPSIS
AI Dev Loop?먯꽌 Codex 由щ럭瑜??ㅽ뻾?섎뒗 怨좎젙 吏꾩엯?먯엯?덈떎.

.DESCRIPTION
???ㅽ겕由쏀듃????μ냼 猷⑦듃??scripts/ai-dev-run-review-codex.ps1瑜??몄텧?섎뒗
?뉗? wrapper?낅땲?? Codex 由щ럭 ?ㅽ뻾 濡쒖쭅? 湲곗〈 ?ㅽ겕由쏀듃???꾩엫?섍퀬,
?먮룞??猷⑦봽??.ai-dev/scripts/run-codex-review.ps1 寃쎈줈留??몄텧?섎㈃ ?⑸땲??

.EXAMPLE
powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun

.EXAMPLE
powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevie
w
#>

param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GenerateReviewPromptIfMissing,
    [switch]$SaveReview,
    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
    [string]$ResultPath = ".ai-dev/codex-review-result.md"
)

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"

if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
    Write-Error "Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃瑜?李얠쓣 ???놁뒿?덈떎: scripts/ai-dev-run-review-codex.ps1"
    exit 1
}

$arguments = @(
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    $reviewRunnerPath,
    "-ReviewPromptPath",
    $ReviewPromptPath,
    "-ReviewResponsePath",
    $ReviewResponsePath,
    "-ResultPath",
    $ResultPath
)

if ($DryRun) {
    $arguments += "-DryRun"
}

if ($Json) {
    $arguments += "-Json"
}

if ($AllowDirty) {
    $arguments += "-AllowDirty"
}

if ($GenerateReviewPromptIfMissing) {
    $arguments += "-GenerateReviewPromptIfMissing"
}

if ($SaveReview) {
    $arguments += "-SaveReview"
}

& powershell @arguments
exit $LASTEXITCODE

 succeeded in 2298ms:
Parse OK

diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..4af9f2f6fb037f7ae498378a103a4896432b5724
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+AI Dev Loop에서 Codex 리뷰를 실행하는 고정 진입점입니다.
+
+.DESCRIPTION
+이 스크립트는 저장소 루트의 scripts/ai-dev-run-review-codex.ps1를 호출하는
+얇은 wrapper입니다. Codex 리뷰 실행 로직은 기존 스크립트에 위임하고,
+자동화 루프는 .ai-dev/scripts/run-codex-review.ps1 경로만 호출하면 됩니다.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex 리뷰 실행 스크립트를 찾을 수 없습니다: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

codex
문법은 통과했지만 콘솔 출력에서 한글 주석과 메시지가 깨져 보입니다. PowerShell 5.1 환경 호환성을 위해 새 스크립트 자체는 ASCII 텍스트로 정리하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\scripts\run-codex-review.ps1
diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..1d1527ca1f07ce2e963af3c15c159ec09539d3b4
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+Runs the Codex review entry point for the AI Dev Loop.
+
+.DESCRIPTION
+This is a thin wrapper around scripts/ai-dev-run-review-codex.ps1.
+Automation can call this stable path while the existing root script owns
+the review execution behavior.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex review runner was not found: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..1d1527ca1f07ce2e963af3c15c159ec09539d3b4
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+Runs the Codex review entry point for the AI Dev Loop.
+
+.DESCRIPTION
+This is a thin wrapper around scripts/ai-dev-run-review-codex.ps1.
+Automation can call this stable path while the existing root script owns
+the review execution behavior.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex review runner was not found: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

codex
새 파일을 ASCII로 정리했습니다. 다시 파일 내용과 PowerShell 파서 검증을 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\scripts\\run-codex-review.ps1'" in D:\ai-apps\planpilot-loca
l
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens = $null; $errors 
= $null; [System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-apps\\planpilot-local\\
.ai-dev\\scripts\\run-codex-review.ps1', [ref]"'$tokens, [ref]$errors) > $null; if ($errors.Count -e
q 0) { '"'Parse OK' } else { "'$errors | ForEach-Object { $_.Message }; exit 1 }' in D:\ai-apps\plan
pilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$text = Get-Content -Raw 
-LiteralPath '"'D:\\ai-apps\\planpilot-local\\.ai-dev\\scripts\\run-codex-review.ps1'; if ("'$text.T
oCharArray() | Where-Object { [int]$_ -gt 127 } | Select-Object -First 1) { '"'Non-ASCII found'; exi
t 1 } else { 'ASCII OK' }" in D:\ai-apps\planpilot-local
 succeeded in 2672ms:
Parse OK

 succeeded in 2709ms:
<#
.SYNOPSIS
Runs the Codex review entry point for the AI Dev Loop.

.DESCRIPTION
This is a thin wrapper around scripts/ai-dev-run-review-codex.ps1.
Automation can call this stable path while the existing root script owns
the review execution behavior.

.EXAMPLE
powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun

.EXAMPLE
powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevie
w
#>

param(
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowDirty,
    [switch]$GenerateReviewPromptIfMissing,
    [switch]$SaveReview,
    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
    [string]$ResultPath = ".ai-dev/codex-review-result.md"
)

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"

if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
    Write-Error "Codex review runner was not found: scripts/ai-dev-run-review-codex.ps1"
    exit 1
}

$arguments = @(
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    $reviewRunnerPath,
    "-ReviewPromptPath",
    $ReviewPromptPath,
    "-ReviewResponsePath",
    $ReviewResponsePath,
    "-ResultPath",
    $ResultPath
)

if ($DryRun) {
    $arguments += "-DryRun"
}

if ($Json) {
    $arguments += "-Json"
}

if ($AllowDirty) {
    $arguments += "-AllowDirty"
}

if ($GenerateReviewPromptIfMissing) {
    $arguments += "-GenerateReviewPromptIfMissing"
}

if ($SaveReview) {
    $arguments += "-SaveReview"
}

& powershell @arguments
exit $LASTEXITCODE

 succeeded in 2892ms:
ASCII OK

diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..1d1527ca1f07ce2e963af3c15c159ec09539d3b4
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+Runs the Codex review entry point for the AI Dev Loop.
+
+.DESCRIPTION
+This is a thin wrapper around scripts/ai-dev-run-review-codex.ps1.
+Automation can call this stable path while the existing root script owns
+the review execution behavior.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex review runner was not found: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

codex
완료했습니다.

**변경한 파일**
- [.ai-dev/scripts/run-codex-review.ps1](D:/ai-apps/planpilot-local/.ai-dev/scripts/run-codex-review
.ps1)

**요약**
- AI Dev Loop가 고정 경로로 호출할 수 있는 Codex 리뷰 실행 wrapper를 추가했습니다.
- 실제 리뷰 실행 로직은 기존 `scripts/ai-dev-run-review-codex.ps1`에 위임합니다.
- `-DryRun`, `-Json`, `-AllowDirty`, `-GenerateReviewPromptIfMissing`, `-SaveReview`, 경로 옵션을 그대로 전달합
니다.
- `src` 밖 수정 이유: 이번 task의 목표가 `.ai-dev` 자동화 루프용 리뷰 실행 진입점 추가이기 때문입니다.

**검증**
- PowerShell 파서로 문법 확인: `Parse OK`
- 새 스크립트 ASCII 확인: `ASCII OK`
- 실제 스크립트 실행은 하지 않았습니다. 실행 시 하위 스크립트가 `git status` 및 Codex CLI 호출 흐름에 들어갈 수 있어 이번 검증은 문법/구조 검토로 제한했습
니다.
- `npm run build`, `npm run lint`, `npm run test`는 실행하지 않았습니다.

**남은 위험**
- 실제 Codex CLI 실행 경로는 런타임 검증하지 않았습니다.
- wrapper는 기존 `scripts/ai-dev-run-review-codex.ps1`의 동작과 제약을 그대로 따릅니다.

**다음 task 진행 여부**
- 현재 task 성공 기준은 충족했습니다. 다음 task로 넘어가도 됩니다.

**`.ai-dev/loop-log.md` 기록용 요약**
- `T001`: `.ai-dev/scripts/run-codex-review.ps1` 추가. AI Dev Loop용 고정 Codex 리뷰 실행 진입점을 마련했고, 기존 `scri
pts/ai-dev-run-review-codex.ps1`에 파라미터를 위임하도록 구현했다. PowerShell 파서 검증과 ASCII 확인을 완료했다.
diff --git a/.ai-dev/scripts/run-codex-review.ps1 b/.ai-dev/scripts/run-codex-review.ps1
new file mode 100644
index 0000000000000000000000000000000000000000..1d1527ca1f07ce2e963af3c15c159ec09539d3b4
--- /dev/null
+++ b/.ai-dev/scripts/run-codex-review.ps1
@@ -0,0 +1,70 @@
+<#
+.SYNOPSIS
+Runs the Codex review entry point for the AI Dev Loop.
+
+.DESCRIPTION
+This is a thin wrapper around scripts/ai-dev-run-review-codex.ps1.
+Automation can call this stable path while the existing root script owns
+the review execution behavior.
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -DryRun
+
+.EXAMPLE
+powershell -ExecutionPolicy Bypass -File .ai-dev/scripts/run-codex-review.ps1 -AllowDirty -SaveRevi
ew
+#>
+
+param(
+    [switch]$DryRun,
+    [switch]$Json,
+    [switch]$AllowDirty,
+    [switch]$GenerateReviewPromptIfMissing,
+    [switch]$SaveReview,
+    [string]$ReviewPromptPath = ".ai-dev/review-prompt.md",
+    [string]$ReviewResponsePath = ".ai-dev/review-response.json",
+    [string]$ResultPath = ".ai-dev/codex-review-result.md"
+)
+
+$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
+$reviewRunnerPath = Join-Path $repoRoot "scripts\ai-dev-run-review-codex.ps1"
+
+if (-not (Test-Path -LiteralPath $reviewRunnerPath -PathType Leaf)) {
+    Write-Error "Codex review runner was not found: scripts/ai-dev-run-review-codex.ps1"
+    exit 1
+}
+
+$arguments = @(
+    "-ExecutionPolicy",
+    "Bypass",
+    "-File",
+    $reviewRunnerPath,
+    "-ReviewPromptPath",
+    $ReviewPromptPath,
+    "-ReviewResponsePath",
+    $ReviewResponsePath,
+    "-ResultPath",
+    $ResultPath
+)
+
+if ($DryRun) {
+    $arguments += "-DryRun"
+}
+
+if ($Json) {
+    $arguments += "-Json"
+}
+
+if ($AllowDirty) {
+    $arguments += "-AllowDirty"
+}
+
+if ($GenerateReviewPromptIfMissing) {
+    $arguments += "-GenerateReviewPromptIfMissing"
+}
+
+if ($SaveReview) {
+    $arguments += "-SaveReview"
+}
+
+& powershell @arguments
+exit $LASTEXITCODE

tokens used
42,344
완료했습니다.

**변경한 파일**
- [.ai-dev/scripts/run-codex-review.ps1](D:/ai-apps/planpilot-local/.ai-dev/scripts/run-codex-review.ps1)

**요약**
- AI Dev Loop가 고정 경로로 호출할 수 있는 Codex 리뷰 실행 wrapper를 추가했습니다.
- 실제 리뷰 실행 로직은 기존 `scripts/ai-dev-run-review-codex.ps1`에 위임합니다.
- `-DryRun`, `-Json`, `-AllowDirty`, `-GenerateReviewPromptIfMissing`, `-SaveReview`, 경로 옵션을 그대로 전달합니다.
- `src` 밖 수정 이유: 이번 task의 목표가 `.ai-dev` 자동화 루프용 리뷰 실행 진입점 추가이기 때문입니다.

**검증**
- PowerShell 파서로 문법 확인: `Parse OK`
- 새 스크립트 ASCII 확인: `ASCII OK`
- 실제 스크립트 실행은 하지 않았습니다. 실행 시 하위 스크립트가 `git status` 및 Codex CLI 호출 흐름에 들어갈 수 있어 이번 검증은 문법/구조 검토로 제한했습니다.
- `npm run build`, `npm run lint`, `npm run test`는 실행하지 않았습니다.

**남은 위험**
- 실제 Codex CLI 실행 경로는 런타임 검증하지 않았습니다.
- wrapper는 기존 `scripts/ai-dev-run-review-codex.ps1`의 동작과 제약을 그대로 따릅니다.

**다음 task 진행 여부**
- 현재 task 성공 기준은 충족했습니다. 다음 task로 넘어가도 됩니다.

**`.ai-dev/loop-log.md` 기록용 요약**
- `T001`: `.ai-dev/scripts/run-codex-review.ps1` 추가. AI Dev Loop용 고정 Codex 리뷰 실행 진입점을 마련했고, 기존 `scripts/ai-dev-run-review-codex.ps1`에 파라미터를 위임하도록 구현했다. PowerShell 파서 검증과 ASCII 확인을 완료했다.

```
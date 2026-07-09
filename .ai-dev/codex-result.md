# Codex Implementation Result

## Run

- Started at: 2026-07-09 22:37:16
- Ended at: 2026-07-09 22:39:00
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: codex exec <short wrapper pointing to .ai-dev/current-task-prompt.md>

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
session id: 019f4718-d26e-7762-bc17-50f69640c29d
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-
dev\current-task-prompt.md
codex
작업 지시 파일을 먼저 읽어 범위와 제약을 확인하겠습니다. 지정된 파일만 읽고, 이후 필요한 파일이 있으면 이유를 먼저 밝히겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-loc
al
 succeeded in 1328ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Codex CLI 완전 자동화 정책을 현재 저장소의 로컬 AI Dev Loop 운영 문서로 작고 명확하게 정리한다.

## 배경
현재 프로젝트는 로컬 우선 React + Vite + TypeScript 앱이며, AI Dev Loop 상태 파일을 기준으로 작은 단위의 작업을 안전하게 진행해야 한다. C
odex CLI 자동화가 어떤 조건에서 진행되고, 언제 멈추며, 어떤 검증 정보를 남겨야 하는지 문서화가 필요하다.

## 성공 기준
- Codex CLI 자동화 정책의 목적, 적용 범위, 중단 조건, 검증 기록 방식을 한국어로 문서화한다.
- 기존 프로젝트 제약을 해치지 않는 작은 문서 변경으로 제한한다.
- 자동화가 임의로 기능 범위를 넓히지 않도록 작업 단위와 상태 기록 기준을 명확히 한다.

## 제약사항
- 앱 런타임 코드와 저장 구조는 변경하지 않는다.
- 사용자-facing 문서는 한국어로 작성한다.
- 기존 AI Dev Loop 상태 파일 형식과 충돌하지 않게 작성한다.
- 한 번에 하나의 작은 문서 작업으로 진행한다.

## 범위 제외
- 새 기능 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조 개편은 포함하지 않는다.
- 자동화 실행 도구 자체의 구현 변경은 포함하지 않는다.

## 수동 검증
- 작성된 정책 문서가 현재 저장소 작업 규칙과 모순되지 않는지 확인한다.
- 정책 문서에 목표 진행, 검증, 중단 조건이 구체적으로 포함되어 있는지 확인한다.
- 변경 파일 수가 최소 범위인지 확인한다.


## Current Task

- Task ID: T001
- Title: Codex CLI 자동화 정책 문서 작성
- Description: 현재 저장소의 로컬 AI Dev Loop 운영 방식에 맞춰 Codex CLI 완전 자동화 정책을 한국어 문서로 정리한다.
- Type: documentation
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
- .ai-dev/codex-cli-automation-policy.md

## Verification

- 정책 문서에 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건이 포함되어 있는지 확인한다.
- 문서 내용이 현재 저장소 작업 규칙과 충돌하지 않는지 확인한다.

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
문서 작업만 요구되어 앱 코드는 건드리지 않습니다. 기존 AI Dev Loop 문서와 충돌하지 않도록 `.ai-dev/goal.md`와 기존 정책 문서 존재 여부를 확인하겠
습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\loop-log.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "if (Test-Path -Litera
lPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\codex-cli-automation-policy.md') { Get-Content -Li
teralPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\codex-cli-automation-policy.md' } else { Write
-Output '[missing]' }" in D:\ai-apps\planpilot-local
 succeeded in 2106ms:
# 목표
Codex CLI 완전 자동화 정책을 현재 저장소의 로컬 AI Dev Loop 운영 문서로 작고 명확하게 정리한다.

## 배경
현재 프로젝트는 로컬 우선 React + Vite + TypeScript 앱이며, AI Dev Loop 상태 파일을 기준으로 작은 단위의 작업을 안전하게 진행해야 한다. C
odex CLI 자동화가 어떤 조건에서 진행되고, 언제 멈추며, 어떤 검증 정보를 남겨야 하는지 문서화가 필요하다.

## 성공 기준
- Codex CLI 자동화 정책의 목적, 적용 범위, 중단 조건, 검증 기록 방식을 한국어로 문서화한다.
- 기존 프로젝트 제약을 해치지 않는 작은 문서 변경으로 제한한다.
- 자동화가 임의로 기능 범위를 넓히지 않도록 작업 단위와 상태 기록 기준을 명확히 한다.

## 제약사항
- 앱 런타임 코드와 저장 구조는 변경하지 않는다.
- 사용자-facing 문서는 한국어로 작성한다.
- 기존 AI Dev Loop 상태 파일 형식과 충돌하지 않게 작성한다.
- 한 번에 하나의 작은 문서 작업으로 진행한다.

## 범위 제외
- 새 기능 구현은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 저장소 구조 개편은 포함하지 않는다.
- 자동화 실행 도구 자체의 구현 변경은 포함하지 않는다.

## 수동 검증
- 작성된 정책 문서가 현재 저장소 작업 규칙과 모순되지 않는지 확인한다.
- 정책 문서에 목표 진행, 검증, 중단 조건이 구체적으로 포함되어 있는지 확인한다.
- 변경 파일 수가 최소 범위인지 확인한다.

 succeeded in 2191ms:
# AI Dev Loop Log

## 2026-06-07 19:59:48 - New goal initialized

- Previous goal: PlanPilot Local 업무 검색/필터 UX 개선
- Previous status: 업무 검색/필터 UX 개선 목표는 진행 중이었으나 Codex CLI 기반 완전 자동화 도입을 위해 잠시 중단함
- New goal: AI Dev Loop Codex CLI 완전 자동화 도입
- Current task: T001 Codex CLI 완전 자동화 정책 문서화
- Scope: Codex CLI를 구현자와 리뷰어로 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리 자동화 초안을 만든다.
- Known environment: `codex --version`은 `codex-cli 0.133.0`으로 확인되었고, `codex exec`는 현재 저장소에서 파일 수
정 없이 응답하는 테스트를 통과했다.
- Excluded: scripts/src/package 파일 수정은 이번 목표 전환 단계에서 하지 않음, build/test 실행 안 함, git add/commit 안 
함, Codex CLI 호출 안 함, Cline/Copilot/gh/GPT API 사용 안 함
- Result: `goal.md`, `backlog.md`, `queue.json`, `state.json`, `plan.md`, `test-result.md`, `rev
iew.md`, `loop-log.md`를 새 목표 기준으로 초기화함

## 2026-06-07 21:46:14 - Task completed

- Task: T001 Codex CLI 완전 자동화 정책 문서화
- Result: T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건 문서화
- Next task: T002 Codex 구현 실행 스크립트 추가
## 2026-06-07 21:48:36 - Task completed

- Task: T002 Codex 구현 실행 스크립트 추가
- Result: T001 완료: Codex CLI를 구현자/리뷰어로 사용하는 완전 자동화 정책, 허용/금지 명령, 안전 중단 조건 문서화
- Next task: T003 Codex 리뷰 실행 스크립트 추가
## 2026-06-07 21:58:28 - Task completed

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: T002 완료: current-task-prompt.md를 codex exec에 전달하는 ai-dev-run-codex.ps1 추가, 문법 검증과 DryR
un/Json/dirty 상태 중단 확인
- Next task: T004 full auto-cycle 초안 추가

## 2026-06-07 22:10:00 - Goal expanded

- Goal: AI Dev Loop Codex CLI 완전 자동화 도입
- Change: T001~T006 진행 상태는 유지하고 T007 목표 입력 기반 자동 goal 실행 스크립트 추가 task를 queue에 추가함
- Final target command: `powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1
 -GoalTitle "업무 검색 결과 하이라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -Allo
wCodex -AllowReviewCodex -AllowCommit -MaxTasks 1`
- Scope: scripts/src/package 파일은 수정하지 않고 queue, plan, README, 정책 문서에 auto-goal 목표와 안전 기준만 반영함

## 2026-06-07 22:20:00 - State repaired

- Reason: T003 `Codex 리뷰 실행 스크립트 추가`가 `done`으로 표시되어 있었지만 실제 `scripts/ai-dev-run-review-codex.ps1
` 산출물이 누락됨
- Change: T003 상태를 `in_progress`로 되돌리고 T004 `full auto-cycle 초안 추가` 상태를 `pending`으로 되돌림
- Current task: T003 Codex 리뷰 실행 스크립트 추가
- Preserved: T001/T002는 `done` 유지, T005/T006/T007은 `pending` 유지, T007 추가 내용 유지
- Excluded: scripts/src/package 파일 수정 없음, git add/commit 없음, Codex CLI 호출 없음

## 2026-06-07 22:35:00 - Task progress

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: `scripts/ai-dev-run-review-codex.ps1` 추가, `review-prompt.md`를 Codex CLI에 전달하고 JSON 리뷰를
 `review-response.json`에 저장하며 `-SaveReview`로 `ai-dev-save-review.ps1 -ReviewFile` 흐름에 연결하도록 구현
- Docs: `.ai-dev/README.md`에 DryRun, 기본 실행, `-GenerateReviewPromptIfMissing`, `-SaveReview`, `-A
llowDirty` 주의사항을 추가
- Verification: PowerShell 문법 검증 예정. 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음

## 2026-06-07 22:23:42 - Task completed

- Task: T003 Codex 리뷰 실행 스크립트 추가
- Result: T003 완료: review-prompt.md를 codex exec에 전달해 JSON 리뷰를 생성하는 ai-dev-run-review-codex.ps1 추
가, 문법 검증과 DryRun/Json 확인
- Next task: T004 full auto-cycle 초안 추가
## 2026-06-07 22:57:13 - Task completed

- Task: T004 full auto-cycle 초안 추가
- Result: T004 완료: make-prompt/run-codex/check/save-diff/make-review-prompt/run-review-codex를 연결
하는 ai-dev-auto-cycle-full.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인
- Next task: T005 자동 커밋과 task 완료 연결
## 2026-06-08 23:11:23 - Task completed

- Task: T005 자동 커밋과 task 완료 연결
- Result: T004 완료: make-prompt/run-codex/check/save-diff/make-review-prompt/run-review-codex를 연결
하는 ai-dev-auto-cycle-full.ps1 초안 추가, DryRun/Json/AllowCodex 중단 확인
- Next task: T006 작은 앱 task로 end-to-end 검증

## 2026-06-08 23:30:00 - Task progress

- Task: T005 자동 커밋과 task 완료 연결
- Result: `ai-dev-auto-cycle-full.ps1`에서 review pass 이후 package 변경 게이트, `-AllowCommit` 기반 자동 커밋,
 커밋 확인 후 complete-task 실행, `MaxTasks` 반복 구조를 정리함
- Docs: `.ai-dev/README.md`에 DryRun, MaxTasks 1/3, `AllowCodex + AllowReviewCodex + AllowCommit`
, 선택 파일 커밋 예시를 추가함
- Verification: PowerShell AST 문법 검증 통과, full auto-cycle DryRun/Json 출력에서 commit 및 complete-task
 단계 포함 확인
- Excluded: 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음

## 2026-06-09 00:17:52 - Task completed

- Task: T006 작은 앱 task로 end-to-end 검증
- Result: T006 완료: full auto-cycle DryRun/Json 구조 검증 및 Codex runner 인자 길이 버그 수정 확인, 실제 end-to-en
d 검증은 T007 auto-goal 이후 작은 앱 목표로 수행
- Next task: T007 목표 입력 기반 자동 goal 실행 스크립트 추가
## 2026-06-09 23:05:15 - Task completed

- Task: T007 목표 입력 기반 자동 goal 실행 스크립트 추가
- Result: T007 완료: 목표 제목/설명 입력 기반 auto-goal 실행 스크립트 추가, DryRun/Json 출력, 입력 검증, dirty 처리, full au
to-cycle 연결 및 Codex 리뷰 pass 확인
- Next task: 없음
## 2026-06-09 23:50:32 - Task completed

- Task: T001 업무 검색창 placeholder 문구 수정
- Result: T001 완료: 업무 검색창 placeholder를 업무명과 프로젝트명 검색 대상에 맞는 명확한 한국어 문구로 개선하고 build 및 Codex 리뷰 결과
를 확인함
- Next task: 없음
## 2026-06-10 22:22:07 - Task completed

- Task: T001 리뷰 diff 범위 분리 로직 정리
- Result: T001 완료: 리뷰 diff 생성과 리뷰 프롬프트에서 실제 변경 파일과 .ai-dev 운영 산출물을 분리하고, 앱 변경 중심 리뷰가 가능하도록 개선함
- Next task: 없음

## 2026-06-10 23:09:10 - Task progress

- Task: T001 커밋 해시 상태 기록 흐름 개선
- Result: `ai-dev-auto-cycle-full.ps1`의 commit-result-gate가 커밋 전 HEAD와 커밋 후 HEAD를 비교하고, commit/p
assed 상태에서 최신 HEAD를 `lastCommitHash`에 보강하도록 수정함. `ai-dev-complete-task.ps1`은 완료 처리 전 commit/pass
ed 상태에서 기록된 해시가 있거나 HEAD 커밋 시각이 상태 갱신 이후인 경우에만 `lastCommitHash`를 동기화하도록 수정함
- Verification: 관련 PowerShell 스크립트 2개 AST 문법 검증 통과
- Excluded: build/test/lint, 실제 커밋 생성, git 명령 직접 실행은 수행하지 않음

## 2026-06-10 23:34:13 - Task completed

- Task: T001 커밋 해시 상태 기록 흐름 개선
- Result: T001 완료: 커밋 성공 후 명시적으로 전달된 커밋 해시를 검증하여 state.lastCommitHash에 기록하도록 commit-result-gate와
 complete-task 흐름을 개선함
- Next task: 없음
## 2026-06-13 00:33:57 - Task completed

- Task: T001 업무 카드 완료 버튼 문구 수정
- Result: T001 완료: 업무 카드의 미완료 상태 완료 버튼 문구를 더 명확한 한국어 표현으로 개선했으며, 동작 로직이나 구조 변경 없이 UI 문구만 최소 범위로 
수정함
- Next task: 없음
## 2026-06-14 20:18:29 - Task completed

- Task: T001 마감 임박 배지 표시 구현
- Result: T001 완료: 미완료 업무 중 마감일이 오늘부터 7일 이내인 경우 업무 카드에 마감 임박 배지를 표시하도록 구현함
- Next task: 없음
## 2026-06-14 21:50:57 - Commit created

- Task: T001 pass 이후 자동 완료 흐름 구현
- Commit: be79d21ea8edc7f08d3634575ad8ccd76c38079d
- Message: Auto-complete passed dev loop tasks
## 2026-06-14 21:51:07 - Task completed

- Task: T001 pass 이후 자동 완료 흐름 구현
- Result: T001 완료: pass 이후 구현 커밋, CommitHash 전달 complete-task, .ai-dev 메타 커밋 및 clean 검증 흐름 구현 완료
- Next task: 없음
## 2026-06-14 22:01:20 - Commit created

- Task: T001 업무 목록 빈 상태 문구 수정
- Commit: 3f53ac6c1b9fd7f43ab7dcb161eb112c78c7cbb4
- Message: Improve empty task list copy
## 2026-06-14 22:01:28 - Task completed

- Task: T001 업무 목록 빈 상태 문구 수정
- Result: T001 완료: 업무 목록 빈 상태 안내 문구를 자연스러운 한국어로 개선하고 lint 검증을 통과함
- Next task: 없음
## 2026-06-14 22:06:40 - Commit created

- Task: T001 검증 기록 흐름 분석 및 lint 기록 개선
- Commit: db479f4caa4afbac65caefb6105394df18d9211c
- Message: Record lint validation results
## 2026-06-14 22:06:51 - Task completed

- Task: T001 검증 기록 흐름 분석 및 lint 기록 개선
- Result: T001 완료: BuildOnly에서도 lint 실행 결과를 자동 기록하고 test script 부재 사유를 명확히 남기도록 개선함
- Next task: 없음
## 2026-06-14 22:13:29 - Commit created

- Task: T001 업무 카드 문구 최소 개선
- Commit: 151cfa8a95b068d55a652a29c306cbdf5c19e4f5
- Message: Improve task card accessibility labels
## 2026-06-14 22:13:38 - Task completed

- Task: T001 업무 카드 문구 최소 개선
- Result: T001 완료: 업무 카드 버튼 및 상태 표시의 접근성/안내 문구를 최소 범위로 개선하고 build/lint 검증을 통과함
- Next task: 없음
## 2026-06-14 22:29:29 - Commit created

- Task: T001 auto-goal pass 이후 완료 흐름 연결
- Commit: a41df7ba976d41328ac39cd92a3eefed1e04ba19
- Message: Wire auto-goal pass completion flow
## 2026-06-14 22:29:48 - Task completed

- Task: T001 auto-goal pass 이후 완료 흐름 연결
- Result: T001 완료: auto-goal 실행 경로에서 리뷰 pass 이후 커밋, complete-task -CommitHash 전달, .ai-dev 메타 커밋,
 최종 상태 확인까지 이어지도록 개선함
- Next task: 없음
## 2026-06-14 23:00:14 - Commit created

- Task: T001 업무 카드 완료 문구 개선
- Commit: 14b1d6137c5a0fd09b671793c2925f7cd6981bae
- Message: Refine completed task card copy
## 2026-06-14 23:00:21 - Task completed

- Task: T001 업무 카드 완료 문구 개선
- Result: T001 완료: 업무 카드 완료 버튼과 aria-label 문구를 자연스러운 한국어로 최소 개선하고 build/lint 검증을 통과함
- Next task: 없음
## 2026-06-14 23:23:51 - Commit created

- Task: T001 auto-goal 완료 판정 흐름 수정
- Commit: 541b9d02569576d0c56cbe60ede92fe924dbd64c
- Message: Fix auto-goal completion handling
## 2026-06-14 23:24:03 - Task completed

- Task: T001 auto-goal 완료 판정 흐름 수정
- Result: T001 완료: complete_task/complete-task 정규화, 저장된 리뷰 pass 이후 완료 재개, auto-goal 미완료 판정 실패 처리
를 반영함
- Next task: 없음
## 2026-06-14 23:28:13 - Commit created

- Task: T001 업무 카드 문구 확인 및 최소 수정
- Commit: 3dd089ad71e0b17ac45dbc9af09db4e48db57d01
- Message: Refine task card helper copy
## 2026-06-14 23:28:16 - Task completed

- Task: T001 업무 카드 문구 확인 및 최소 수정
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-19 21:36:52 - Commit created

- Task: T001 auto-goal 종료 전 최종 변경 상태 검증 보강
- Commit: 058a75bb425c1f488c7b466945f7c2baf66504e1
- Message: Ensure auto goal final clean state
## 2026-06-19 21:37:24 - Task completed

- Task: T001 auto-goal 종료 전 최종 변경 상태 검증 보강
- Result: T001 완료: auto-goal 종료 전 최종 변경 상태 검증을 보강하고, 완료 직전 .ai-dev 운영 변경의 최종 메타 커밋, baseline dir
ty 보호, non-.ai-dev dirty 실패, completed 상태의 git clean 보장을 반영함
- Next task: 없음
## 2026-06-19 21:49:07 - Commit created

- Task: T001 업무 카드 접근성 문구 점검 및 미세 수정
- Commit: 3591ee2bb9a7be7a72d8c360fc294a643d06ab85
- Message: Polish task card accessibility labels
## 2026-06-19 21:49:21 - Task completed

- Task: T001 업무 카드 접근성 문구 점검 및 미세 수정
- Result: T001 완료: 업무 카드의 aria-label 문구를 자연스러운 한국어로 최소 수정하고 build/lint 검증 및 리뷰 pass를 확인함
- Next task: 없음
## 2026-06-19 21:57:00 - Task completed

- Task: T001 완료 기준 안내 문구 보강
- Result: T001 완료: AI Dev Loop 완료 기준을 .ai-dev/README.md 운영 원칙에 짧게 보강하고 build/lint 검증 및 리뷰 pass를 
확인함
- Next task: 없음
## 2026-06-19 22:00:35 - Commit created

- Task: T001 AI Dev Loop 운영 순서 문서 보강
- Commit: 1f8952d265ae7d889e5a4033cba46876f9272972
- Message: Document AI dev loop operation flow
## 2026-06-19 22:00:37 - Task completed

- Task: T001 AI Dev Loop 운영 순서 문서 보강
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-19 22:08:47 - Task completed

- Task: T001 업무 상태 안내 개선 범위 확인
- Result: T001 완료: 업무 상태 안내 개선 범위를 확인하고, 앱 변경 없이 TaskList 중심으로 개선 위치를 정리했으며 build/lint 검증 및 리뷰 p
ass를 확인함
- Next task: T002 업무 흐름 상태 표시 개선

## 2026-06-19 22:10:34 - Task progress

- Task: T002 업무 흐름 상태 표시 개선
- Result: 업무 목록 상단 요약에 진행 중, 완료, 남은 업무 개수를 표시하고 업무 카드 상태 라벨을 todo/in_progress/done 상태별 한국어 문구로 구
분함
- Verification: build/test/lint는 현재 프롬프트에서 자동 실행 지시가 없어 실행하지 않음
- Excluded: DB schema 변경, 저장 구조 변경, 새 화면 추가, 대규모 리팩터링, git commit 없음

## 2026-06-19 22:19:24 - Commit created

- Task: T002 업무 흐름 상태 표시 개선
- Commit: 86280c0fad1af38608410ac6817d2931e0f24314
- Message: Improve task status guidance
## 2026-06-19 22:19:43 - Task completed

- Task: T002 업무 흐름 상태 표시 개선
- Result: T002 완료: 업무 목록 영역에서 진행 중, 완료, 남은 업무 상태 요약과 상태 라벨을 한국어로 명확히 표시하고 build/lint 검증 및 리뷰 pas
s를 확인함
- Next task: T003 검증 및 작업 기록 완료

## 2026-06-19 22:21:41 - Task completed

- Task: T003 검증 및 작업 기록 완료
- Result: T003 완료: 기존 검증 기록에서 npm run build 통과, npm run lint 통과, 리뷰 pass를 확인하고 AI Dev Loop 메타 상태
를 완료로 기록함
- Verification: .ai-dev/test-result.md의 build/lint passed, .ai-dev/review.md의 Decision pass, sta
te.json의 lastReviewDecision pass 확인
- Remaining risk: 현재 세션에서는 규칙상 npm run build/lint와 git 상태 확인 명령을 새로 실행하지 않음
- Next task: 없음

## 2026-06-19 22:35:05 - Commit created

- Task: T001 완료 종료 경로 최종 정리 보강
- Commit: ba0d33f11f0f7d25186e2fec783c2bf46660c97e
- Message: Finalize meta changes on completed auto cycle
## 2026-06-19 22:35:22 - Task completed

- Task: T001 완료 종료 경로 최종 정리 보강
- Result: T001 완료: auto-cycle-full completed 종료 경로에서 .ai-dev 운영 변경만 남은 경우 final meta commit 후 gi
t clean을 보장하고, DryRun/AllowCommit/non-.ai-dev dirty 실패 경로 검증을 반영함
- Next task: 없음
## 2026-06-19 23:08:16 - Task completed

- Task: T001 review revise 자동 재시도 흐름 보강
- Result: T001 완료: auto-cycle-full이 saved review revise/revise_with_codex 상태에서 일반 실행 시 자동 재시도하고,
 DryRun에서는 Codex/검증/리뷰 단계를 실행하지 않고 변경 없이 preview/stop 처리하도록 보강했으며 build/lint 및 DryRun no-mutatio
n 검증과 리뷰 pass를 확인함
- Next task: 없음

## 2026-06-19 23:24:20 - Task progress

- Task: T001 revise 재시도 중단 사유 보존 보강
- Result: auto-cycle-full의 review gate가 pass가 아닌 최신 리뷰에서 summary, severity, next_step, lastRevie
wDecision을 중단 메시지와 state.lastErrorSummary/stopReason에 보존하도록 보강함
- Verification: PowerShell parse OK, DryRun preview-only 실행, DryRun 전후 state/queue/review-respon
se/loop-log 해시 동일 확인
- Remaining risk: build/lint, 실제 revise 반복 실행, 리뷰 pass, git commit, complete-task, 최종 clean 확인은 
현재 프롬프트와 저장소 규칙상 실행하지 않음

## 2026-06-19 23:34:08 - Task completed

- Task: T001 revise 재시도 중단 사유 보존 보강
- Result: T001 완료: revise 재시도 후 재리뷰가 계속 revise인 경우 최신 summary, severity, next_step, lastReviewDe
cision을 보존해 명확히 중단하도록 보강하고, DryRun no-mutation 및 revise 중단 사유 보존 검증과 리뷰 pass를 확인함
- Next task: 없음
## 2026-06-23 15:45:52 - Commit created

- Task: T001 구현 없는 revise 반복 실패 처리 보강
- Commit: 9a2c93cf08ba69bac0ae2e3f48f008595be250f3
- Message: Guard stale revise loops
## 2026-06-23 15:45:56 - Task completed

- Task: T001 구현 없는 revise 반복 실패 처리 보강
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음

## 2026-06-24 - Task revise

- Task: T001 review-gate revise 자동 재시도 흐름 연결
- Result: 리뷰 지적에 따라 `.ai-dev/test-result.md`에 재리뷰 pass 경로와 반복 revise 실패 경로의 검증 근거를 추가함
- Verification: PowerShell AST parse OK, runtime branch order checks passed, failure state 기록 필드
 checks passed
- Not executed: Codex, build, lint, test, review, commit, complete-task는 공유 작업공간 상태 변경 가능성이 있어 실
행하지 않음
- Remaining risk: 실제 Codex mock runner를 주입한 end-to-end 자동 재시도는 별도 격리 환경에서 추가 확인이 필요함

## 2026-06-24 10:48:01 - Commit created

- Task: T001 review-gate revise 자동 재시도 흐름 연결
- Commit: 388d05a41c652ca0c198fcceb9ec8d785dafbd6c
- Message: Connect review revise retry flow
## 2026-06-24 10:48:04 - Task completed

- Task: T001 review-gate revise 자동 재시도 흐름 연결
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-25 15:14:53 - Commit created

- Task: T001 업무 흐름 안내 문구 개선
- Commit: 7814005d29f5449d9c687f1b90e115806825280f
- Message: Improve task flow guidance copy
## 2026-06-25 15:14:56 - Task completed

- Task: T001 업무 흐름 안내 문구 개선
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-25 15:52:16 - Commit created

- Task: T001 빈 상태와 필터 결과 없음 안내 개선
- Commit: 8d8cc3b5a90dbfface49ee1db932589c08e34ca8
- Message: Improve empty state copy
## 2026-06-25 15:52:22 - Task completed

- Task: T001 빈 상태와 필터 결과 없음 안내 개선
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: T002 업무 카드 상태와 다음 행동 안내 정리

## 2026-06-25 15:54:29 - Task completed

- Task: T002 업무 카드 상태와 다음 행동 안내 정리
- Result: 업무 카드에서 상태 라벨과 다음 행동 안내를 같은 문구 규칙으로 정리하고, 토글 버튼 문구와 aria-label이 같은 다음 행동 문구를 사용하도록 조정함
- Verification: `src/components/TaskCard.tsx` 수동 검토로 완료/미완료 상태별 다음 행동 문구가 모순되지 않는지 확인함
- Not executed: 프롬프트가 자동 build/test/lint 실행을 지시하지 않아 `npm run build`, `npm run test`, `npm run l
int`는 실행하지 않음
- Remaining risk: 실제 브라우저 화면 확인과 빌드 검증은 사람이 별도로 수행해야 함
- Next task: T003 로컬 저장 안내 문구 보강

## 2026-06-25 15:59:09 - Commit created

- Task: T003 로컬 저장 안내 문구 보강
- Commit: 1bda5d3d991141379a6bf60e85c87a69f288f9c8
- Message: Add local storage guidance
## 2026-06-25 15:59:13 - Task completed

- Task: T003 로컬 저장 안내 문구 보강
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-25 16:33:41 - Commit created

- Task: T001 상태 출력의 오래된 요약 차단
- Commit: ff5f085982b462cd01657b3bad5e8f1927dc5d06
- Message: Hide stale AI dev status summaries
## 2026-06-25 16:33:45 - Task completed

- Task: T001 상태 출력의 오래된 요약 차단
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-28 20:03:25 - Commit created

- Task: T001 stale Review summary 상세 숨김 구현
- Commit: d8e7ba0a517d92af064979342df903b817613195
- Message: Hide stale review summary details
## 2026-06-28 20:03:30 - Task completed

- Task: T001 stale Review summary 상세 숨김 구현
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: 없음
## 2026-06-28 20:41:18 - Task completed

- Task: T001 기존 AI Dev Loop 자동화 흐름 분석
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 구현 커밋 없음, 저장된 리뷰 pass에서 자동 완료
- Next task: T002 제한된 autopilot 실행 흐름 구현

## 2026-06-28 21:10:00 - Task progress

- Task: T002 제한된 autopilot 실행 흐름 구현
- Result: `scripts/ai-dev-autopilot.ps1`를 추가해 완료된 현재 goal 확인, backlog 기반 다음 goal 후보 생성, 기존 `ai-d
ev-auto-goal.ps1` 호출, `MaxGoals` 제한, 실패 시 state/loop-log 기록 흐름을 구현함
- Docs: `.ai-dev/README.md`에 autopilot 실행 방법, 기본 제한값, full cycle 권한 옵션, 중단 조건, 실패 기록 방식을 추가함
- Verification: PowerShell AST 문법 검증 예정. build/test/lint, git 명령, 실제 Codex 실행은 수행하지 않음

## 2026-07-09 22:12:28 - Commit created

- Task: T002 제한된 autopilot 실행 흐름 구현
- Commit: 98977ec50aaea338f258131fb0738e090b5cbfda
- Message: Add AI dev loop autopilot mode
## 2026-07-09 22:12:32 - Task completed

- Task: T002 제한된 autopilot 실행 흐름 구현
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료
- Next task: T003 사용법과 검증 기준 문서화

## 2026-07-09 22:30:00 - Task progress

- Task: T003 사용법과 검증 기준 문서화
- Result: `.ai-dev/README.md`의 제한된 autopilot 실행 섹션에 수동 검증 기준을 추가함
- Scope: 문서와 AI Dev Loop 기록만 수정함. 앱 `src` 기능 코드는 변경하지 않음
- Verification: 문서에 제한값 확인, 중단 조건, 상태 파일 확인 지점, 기존 auto-goal 흐름 확인 절차가 포함되는지 수동 검토 예정

## 2026-07-09 22:38:00 - Task progress

- Task: T003 사용법과 검증 기준 문서화
- Result: `.ai-dev/README.md`의 autopilot 문서에 제한값/실행 옵션 표와 실패 후 확인할 상태 파일 표를 보강함
- Verification: `.ai-dev/test-result.md`에 문서 수동 검증 기준과 미실행 항목을 기록함
- Not executed: 문서화 작업이므로 `npm run build`, `npm run test`, `npm run lint`, autopilot 실제 실행은 수행하지
 않음

## 2026-07-09 22:28:04 - Task completed

- Task: T003 사용법과 검증 기준 문서화
- Result: 자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 구현 커밋 없음, 저장된 리뷰 pass에서 자동 완료
- Next task: 없음

 succeeded in 2227ms:
[missing]

codex
기존 정책 파일은 없어 새 문서 하나를 추가하는 작업으로 보입니다. 현재 운영 문서의 표현과 상태 파일 관례를 맞추기 위해 `.ai-dev/README.md`만 추가로 확인
하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md'" in D:\ai-apps\planpilot-local
 succeeded in 1364ms:
# PlanPilot Local AI 개발 입력 폴더

이 폴더는 PlanPilot Local의 Level 5 AI 자동 개발 루프에서 목표와 후속 작업 후보를 관리하기 위한 기본 공간이다.

현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex CLI 완전 자동화 실행기는 다음 목표에서 단계적으로 도입하며, 각 tas
k 전환 전에는 `goal.md`, `queue.json`, `state.json`을 확인한다.

## 사람이 직접 관리하는 파일

### `goal.md`

현재 자동 개발 루프가 수행할 하나의 목표를 작성한다.

- 목표는 결과 중심으로 작성한다.
- 완료 기준, 제약 조건, 범위 밖 항목, 수동 검증 방법을 함께 적는다.
- 한 번에 하나의 명확한 목표만 유지한다.
- 저장소의 `AGENTS.md`와 `docs/ai-dev-loop-policy.md`를 위반하는 목표는 실행하지 않는다.

### `backlog.md`

추후 검토할 목표 후보와 아이디어를 우선순위별로 기록한다.

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- 기본 흐름에서는 실행할 항목을 사용자가 검토한 뒤 `goal.md`로 옮긴다.
- 수동 `ai-dev-auto-goal.ps1` 흐름은 여전히 명시적인 `GoalTitle`과 `GoalDescription`을 사용한다.
- 단, 현재 goal이 완료되었고 open task가 없을 때 `scripts/ai-dev-autopilot.ps1`는 제한된 범위에서 `.ai-dev/backlog.md
`의 다음 goal 후보를 선택할 수 있다.
- autopilot은 `MaxGoals`, `MaxTasks`, `MaxSteps` 제한 안에서만 동작하며 무제한 백그라운드 데몬이 아니다.

## AI가 추후 생성하거나 수정할 파일

실제 자동 개발 루프를 구현하는 단계에서는 AI가 다음 파일을 생성하거나 갱신할 수 있다.

- `plan.md`
- `queue.json`
- `state.json`
- `test-result.md`
- `review.md`
- `loop-log.md`

이 파일들은 목표 분석, task queue, 실행 상태, 검증 결과, 리뷰 결과, 실행 이력을 기록하기 위한 파일이다.

현재 단계에서는 위 파일을 만들지 않는다.

## 구조 예시 파일

- `queue.example.json`: `goal.md`를 task 단위로 분해한 `queue.json` 구조 예시다.
- `state.example.json`: 자동 개발 루프의 현재 진행 상태를 기록할 `state.json` 구조 예시다.

예시 파일은 실제 실행 상태가 아니며, 초기화 스크립트가 `queue.json`과 `state.json`을 만들 때 복사 원본으로 사용한다.

## UTF-8 콘솔 설정

AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 사용자가 매번 `chcp 65001`을 직
접 실행할 필요는 없다.

기존에 한글이 깨진 `.ai-dev/*.md` 상태 파일은 필요한 경우 다음 명령으로 재초기화할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-init.ps1 -Force
```

## 실행 파일 초기화

프로젝트 루트에서 다음 명령을 실행하면 실제 실행용 상태 파일과 기본 Markdown 템플릿을 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-init.ps1
```

이미 생성된 파일을 덮어쓰려면 `-Force` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-init.ps1 -Force
```

초기화 스크립트는 Codex 실행, GPT 리뷰, build/test 실행, git commit을 수행하지 않는다.

## 현재 task 확인

`queue.json`과 `state.json`에서 현재 수행할 task를 사람이 읽기 쉬운 형태로 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-current-task.ps1
```

현재 task 정보를 JSON으로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-current-task.ps1 -Json
```

현재 task 확인 스크립트는 상태 파일을 수정하지 않으며, Codex 실행, GPT 리뷰, build/test 실행, git commit을 수행하지 않는다.

## 현재 task 프롬프트 생성

`goal.md`, `queue.json`, `state.json`을 읽어 현재 task만 수행하도록 지시하는 `.ai-dev/current-task-prompt.md` 파
일을 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
```

프롬프트 생성 스크립트는 기존 `current-task-prompt.md`를 현재 task 기준으로 덮어쓴다. Codex 실행, GPT 리뷰, build/test 실행, g
it commit은 수행하지 않는다.

기본 추가 지시 파일인 `.ai-dev/extra-instructions.md`가 있으면 해당 내용을 프롬프트 끝의 `Extra Instructions` 섹션에 포함한다. 
이 파일이 없으면 기존과 동일하게 goal, queue, state만 사용해 프롬프트를 생성한다.

다른 추가 지시 파일을 사용하려면 `-ExtraInstructionsPath`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1 -ExtraInstructionsPath .
ai-dev/extra-instructions.example.md
```

추가 지시는 goal, queue, state 내용을 덮어쓰지 않는다. `current-task-prompt.md`를 직접 수정하지 말고, 반복해서 필요한 보조 지시는 `.
ai-dev/extra-instructions.md` 또는 별도 파일에 작성한다.

## task 완료 처리

현재 task를 완료 처리하고 다음 pending task로 이동하려면 다음 명령을 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "T001 분
석 완료"
```

특정 task를 완료 처리하려면 `-TaskId`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -TaskId T001 -ResultSu
mmary "분석 완료"
```

다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoNext
```

task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실
행, git commit은 수행하지 않는다.

## 프로젝트 검증 실행

`package.json`에 정의된 build, test, lint script를 확인하고 실행 결과를 `test-result.md`와 `state.json`에 기록한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1
```

build만 실행하려면 `-BuildOnly` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
```

필요한 검증을 개별적으로 건너뛰려면 `-SkipBuild`, `-SkipTest`, `-SkipLint` 옵션을 사용한다.

검증 실행 스크립트는 Codex 실행, GPT 리뷰, git commit을 수행하지 않는다.

T006 같은 최종 검증 task에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확
인 결과를 사람이 직접 수행했다면 수동 요약만 `test-result.md`에 기록할 수 있다. 이 모드는 npm build/test/lint를 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -ManualSummaryOnly -ManualSumm
ary "PowerShell 문법 검증 통과. auto-step DryRun 통과. auto-cycle DryRun 통과. save-review 실패/성공 흐름 확인."
```

수동 요약 모드는 실제 명령 실행 결과를 조작하는 용도가 아니다. 실행하지 않은 검증은 통과로 적지 말고, 수행한 명령과 결과만 요약한다.

이 모드에서 `state.json`의 `lastCommandStatus`는 수동 요약 기록 작업의 성공 여부를 뜻한다. 실제 검증 통과/실패/미수행 판단은 `test-res
ult.md`의 요약 본문에 명확히 적는다.

## git diff 저장

현재 git 변경사항을 `diff.md`에 저장해 GPT 리뷰 또는 사람 검토에 사용할 수 있게 한다. 기본 동작은 untracked 파일명을 git status에 표시하지
만 파일 내용은 포함하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
```

추적되지 않은 작은 텍스트 파일의 내용도 포함하려면 `-IncludeUntrackedContent` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1 -IncludeUntrackedContent
```

git diff 저장 스크립트는 `diff.md`와 `state.json`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행
하지 않는다.

다음 생성 산출물은 자기 중첩과 과도한 크기 증가를 줄이기 위해 Unstaged/Staged Diff와 Diff Stat 대상에서 기본 제외한다. tracked 변경 파일은
 `Skipped Generated AI Dev Artifact Diffs` 섹션에 파일명만 기록한다. `-IncludeUntrackedContent`를 사용한 경우 unt
racked 생성 산출물도 내용 포함에서 제외하고 `Skipped Generated AI Dev Artifacts` 섹션에 파일명만 기록한다.

- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/current-task-prompt.md`
- `.ai-dev/revise-prompt.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/review-response.json`

git diff/stat 명령의 stderr 경고는 diff 본문과 분리한다. git 명령이 실패하면 기존처럼 `state.json`에 실패 결과를 기록하고 종료한다.

`Git Status` 섹션에는 생성 산출물을 포함한 전체 변경 파일을 그대로 표시한다. `.ai-dev/README.md`, `scripts/ai-dev-save-diff
.ps1`처럼 실제 작업 대상 파일은 위 제외 목록에 없으므로 diff 본문에 포함된다.

## GPT 리뷰 프롬프트 생성

현재 goal, task, 검증 결과, git diff를 포함한 GPT 코드 리뷰용 `review-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1
```

더 엄격한 판정 기준을 포함하려면 `-Strict` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict
```

리뷰 프롬프트 생성 스크립트는 GPT API 호출, Codex 실행, build/test 실행, git commit을 수행하지 않는다.

## 수동 GPT 리뷰 브리지

GPT API 키가 없는 환경에서는 ChatGPT 웹 화면을 사용해 리뷰를 수동으로 진행한다. AI Dev Loop는 prompt 생성과 저장 흐름만 돕고, ChatGPT 
웹 화면에 자동 접속하거나 GPT API를 직접 호출하지 않는다.

기본 흐름:

1. `ai-dev-make-review-prompt.ps1 -Strict`로 `.ai-dev/review-prompt.md`를 생성한다.
2. `review-prompt.md` 내용을 클립보드에 복사한다.
3. 사용자가 ChatGPT 웹 화면에 직접 붙여넣는다.
4. ChatGPT가 JSON 리뷰만 출력하도록 한다.
5. 사용자가 JSON 리뷰를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`로 리뷰를 저장한다.
7. 저장된 decision에 따라 `pass`, `revise`, `blocked` 흐름을 계속 진행한다.

현재 task의 다음 단계에서는 `review-prompt.md` 클립보드 복사를 돕는 helper를 추가할 예정이다. 그 전까지는 파일 내용을 직접 복사하거나 운영 환경에
 맞는 안전한 방법으로 클립보드에 옮긴다.

`review-prompt.md`가 이미 있으면 다음 명령으로 내용을 클립보드에 복사한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
```

`review-prompt.md`가 없을 때 생성 후 복사하려면 `-GenerateIfMissing`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissin
g
```

엄격한 리뷰 프롬프트를 생성한 뒤 복사하려면 `-Strict`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissin
g -Strict
```

자동화에서 결과만 읽고 싶으면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -Json
```

복사 후에는 ChatGPT 웹 화면에 붙여넣고, JSON 리뷰만 출력하도록 요청한다. 리뷰 JSON을 받은 뒤에는 아래 명령으로 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

주의:

- `review-prompt.md`에는 diff와 테스트 결과가 포함될 수 있다.
- API Key, 개인정보, 백업 데이터, 민감한 로컬 경로가 포함되어 있으면 ChatGPT에 붙여넣지 않는다.
- prompt가 너무 길거나 민감 정보가 의심되면 diff 범위를 줄인 뒤 다시 생성한다.
- `ai-dev-auto-step.ps1`는 `ask_gpt_review` 상태에서 GPT API를 호출하지 않고 수동 브리지 안내만 해야 한다.

## GPT 리뷰 결과 저장

GPT Chat 또는 외부 리뷰어가 반환한 리뷰 JSON을 `review.md`에 저장하고, decision과 severity를 `state.json`에 반영한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/revi
ew-response.json
```

JSON 문자열이나 클립보드 내용을 직접 사용할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewJson '{"decision"
:"pass","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_s
tep":"complete_task"}'
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

ChatGPT 웹 화면에서 받은 리뷰를 저장할 때는 JSON 리뷰 전체를 클립보드에 복사한 뒤 `-FromClipboard`를 실행한다. 순수 JSON 객체, `json` 
코드블록, 일반 텍스트 안에 포함된 첫 번째 JSON 객체를 최대한 파싱한다.

저장 실패 시 확인할 항목:

- 클립보드가 비어 있지 않은지 확인한다.
- ChatGPT 응답에서 JSON 객체 전체를 다시 복사한다.
- Markdown 코드블록을 포함해도 되지만, 가능하면 JSON만 복사한다.
- 오류 메시지의 입력 preview 앞부분을 보고 다른 설명 문장이나 잘린 JSON이 섞였는지 확인한다.

파싱 실패, 빈 입력, 필수 필드 누락 같은 입력 오류는 기본적으로 `review.md`와 `state.json`을 수정하지 않는다. review-prompt나 명령어를 실
수로 클립보드에 둔 상태에서 `-FromClipboard`를 실행해도 기존 리뷰 상태를 blocked/critical로 덮어쓰지 않기 위한 안전 동작이다.

실패 자체를 리뷰 결과로 기록해야 하는 특별한 경우에만 `-WriteFailureReview`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard -WriteFai
lureReview
```

잘못 실행했다면 ChatGPT가 출력한 JSON 리뷰만 다시 클립보드에 복사한 뒤 `-FromClipboard`를 재실행한다.

리뷰 결과 저장 스크립트는 `pass + complete_task`, `revise + revise_with_codex`, `blocked` 또는 `stop_for_user
` 결과에 맞는 다음 행동을 안내만 한다. GPT API 호출, Codex 실행, build/test 실행, git commit은 수행하지 않는다.

## 리뷰 반영 재수정 프롬프트 생성

`review.md`의 required changes를 반영하도록 Codex 또는 Cline에 전달할 `revise-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
```

optional suggestions도 현재 task 범위 안에서 반영할 수 있게 하려면 `-AllowOptionalSuggestions` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 -AllowOptionalSug
gestions
```

재수정 프롬프트 생성 스크립트는 Codex 실행, GPT API 호출, build/test 실행, git commit을 수행하지 않는다.

## task 단위 자동 커밋

검증과 리뷰를 통과한 현재 변경사항을 task 단위로 커밋한다. 먼저 `-DryRun`으로 커밋 대상과 메시지를 확인하는 것을 권장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
```

지정한 파일만 커밋 대상으로 확인하거나 실제로 커밋하려면 `-Files` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.
ps1,.ai-dev/README.md -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.
ps1,.ai-dev/README.md
```

커밋 메시지를 직접 지정하거나 검증·리뷰 게이트를 명시적으로 우회할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Message "chore(ai-dev): add 
automation helpers"
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -AllowWithoutPassedCheck -All
owWithoutPassedReview
```

`-Files`를 지정하지 않으면 자동 커밋 스크립트는 기존처럼 `git add -A`로 현재 작업 트리의 모든 변경사항을 stage한다. `-Files`를 지정하면 각 파
일이 존재하고 변경사항이 있는지 확인한 뒤 `git add -- <files>`로 지정 파일만 stage한다. 선택 파일 외에 이미 staged 된 파일이 있으면 안전을 위
해 중단한다.

실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 수행하지 않는다.

## 실행 산출물 커밋 기준

AI Dev Loop의 실제 기능 변경과 `.ai-dev` 실행 상태는 가능한 한 별도 커밋으로 관리한다.

- 기능 커밋에는 현재 task의 코드와 직접 관련 문서만 포함한다.
- 루프 상태 커밋에는 필요할 때 `queue.json`, `state.json`, `loop-log.md`, `test-result.md`, `review.md` 등을 포
함할 수 있다.
- `diff.md`와 `review-prompt.md`는 커질 수 있으므로 항상 커밋하지 않는다.
- `review-response.json`은 민감 정보나 장문 내용이 포함될 수 있으므로 내용을 확인한 뒤 커밋 여부를 결정한다.
- untracked 텍스트 파일 내용은 리뷰에 필요할 수 있지만, 리뷰 포함 여부와 커밋 대상 여부는 별도로 판단한다.
- 대형 또는 민감 산출물은 정리하거나 별도 정책에 따라 제외한다.

커밋 전에는 `git status --short`와 `ai-dev-commit.ps1 -DryRun`으로 대상을 먼저 확인한다. 선택 파일 커밋 기능이 준비되면 전체 sta
ge보다 선택 파일 방식을 우선한다.

세부 기준은 `docs/ai-dev-loop-policy.md`의 `.ai-dev` 실행 산출물 커밋/무시 정책을 따른다. 실제 `.gitignore` 변경은 별도 task
에서 검토한다.

## 자동 개발 루프 상태 요약

현재 queue, state, git 변경사항, 테스트 결과, 리뷰 결과를 한 번에 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
```

상태 요약을 JSON으로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1 -Json
```

상태 요약 스크립트는 파일을 수정하지 않으며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 않는다.

## 다음 행동 안내

현재 queue, state, review, test, git 상태를 확인해 다음에 실행할 추천 명령을 출력한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
```

다음 행동 안내를 JSON으로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1 -Json
```

다음 행동 안내 스크립트는 추천 명령만 출력하며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 않는다.

## 수동 사이클 안내

상태 요약과 다음 행동 안내를 한 번에 확인하고, 관련 프롬프트·결과 파일의 존재 여부를 표시한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
```

상태와 다음 행동을 하나의 JSON 객체로 출력하려면 `-Json` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1 -Json
```

수동 사이클 안내 스크립트는 추천 명령과 파일 경로만 보여주며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행
하지 않는다.

`manual-cycle`에서 다음 action이 `ask_gpt_review`로 표시되면 수동 리뷰 브리지를 사용한다. GPT API 키가 없어도 아래 흐름으로 리뷰를 진
행할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
```

1. `manual-cycle`에서 현재 task와 다음 action이 `ask_gpt_review`인지 확인한다.
2. `ai-dev-copy-review-prompt.ps1`로 `review-prompt.md`를 클립보드에 복사한다.
3. ChatGPT 웹 화면에 붙여넣고 JSON 리뷰만 출력하도록 요청한다.
4. ChatGPT가 반환한 JSON 리뷰를 클립보드에 복사한다.
5. 아래 명령으로 리뷰 결과를 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

리뷰 저장 후 decision별 다음 단계:

- `pass`: `ai-dev-complete-task.ps1` 실행 또는 커밋 조건을 검토한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든 뒤 Codex/Cline에 수동 전달한다.
- `blocked`: 사용자 판단이 필요하므로 루프를 중단하고 요구사항이나 범위를 조정한다.

`review-prompt.md`에는 diff, 테스트 결과, 로컬 경로, 민감 정보가 포함될 수 있다. ChatGPT에 붙여넣기 전에 사용자가 공유 범위를 확인해야 한다.

## 자동 실행 단계 정책

`ai-dev-auto-step.ps1`는 현재 상태를 보고 안전한 다음 한 단계만 실행하는 보조 스크립트로 도입할 예정이다. `ai-dev-next.ps1`처럼 안내만 하
는 명령과 달리, 허용된 로컬 스크립트는 직접 실행할 수 있다.

명령 선택 기준:

| 상황 | 사용할 명령 | 이유 |
| --- | --- | --- |
| 현재 상태와 다음 행동을 한 화면에서 보고 싶을 때 | `scripts/ai-dev-manual-cycle.ps1` | 상태 요약, 다음 action, 관련 파일 존재 
여부를 함께 보여주는 수동 운영 대시보드다. |
| 다음 action과 추천 명령만 확인하고 싶을 때 | `scripts/ai-dev-next.ps1` | 읽기/안내용 스크립트이며 하위 명령을 자동 실행하지 않는다. |
| 안전한 다음 한 단계만 자동으로 진행하고 싶을 때 | `scripts/ai-dev-auto-step.ps1` | `next` 판단 결과를 기반으로 허용된 로컬 스크립트만
 한 번 실행한다. |
| 여러 안전 단계를 제한 횟수 안에서 이어가고 싶을 때 | `scripts/ai-dev-auto-cycle.ps1` | auto-step 반복용이며 사용자 개입 필요 상태
에서 중단한다. |

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -Json
```

검증, diff 저장, 리뷰 프롬프트 생성처럼 기본 자동 실행보다 한 단계 위험한 로컬 작업은 명시적 허용 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowCheck
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowSaveDiff
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -AllowReviewPrompt
```

초기 auto-step 자동 실행 허용 후보:

- `current-task-prompt.md`가 없을 때 `scripts/ai-dev-make-prompt.ps1`
- 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1`
- diff 저장이 필요한 경우 `scripts/ai-dev-save-diff.ps1`
- review prompt 생성이 필요한 경우 `scripts/ai-dev-make-review-prompt.ps1`

auto-step이 직접 실행하지 않고 중단 또는 안내해야 하는 단계:

- Codex 또는 Cline 작업
- GPT 리뷰
- blocked 상태
- revise 반영
- git commit
- 사용자 데이터 삭제, 복원, 마이그레이션 위험이 있는 작업

`ask_gpt_review` 상태에서 auto-step은 GPT API를 호출하지 않고 수동 리뷰 브리지 명령을 안내한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -Json
```

안내에 포함되는 수동 리뷰 브리지 명령:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

첫 번째 명령으로 `review-prompt.md`를 클립보드에 복사한 뒤 ChatGPT 웹 화면에 붙여넣는다. ChatGPT가 JSON 리뷰만 출력하면 그 JSON을 다시
 클립보드에 복사하고 두 번째 명령으로 저장한다.

`ai-dev-auto-cycle.ps1`는 제한 횟수 안에서 auto-step을 반복하는 초기 자동화 스크립트다. 사용자 개입이 필요한 action, 실패, 반복 위험, 
commit 필요 상태에서는 중단한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -MaxSteps 3
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -Json
```

auto-cycle에서 check, diff 저장, review prompt 생성을 허용하려면 auto-step과 같은 허용 옵션을 전달한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowCheck
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowSaveDiff
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -AllowReviewPrompt
```

auto-cycle은 Codex/Cline 작업, GPT 리뷰, revise, commit, blocked, 사용자 개입 필요 action에서 멈춘다. 무한 루프를 피하기 
위해 `-MaxSteps` 제한과 같은 action 반복 감지를 사용한다.

auto-cycle이 `ask_gpt_review`에서 멈추면 `stoppedReason`은 `user_intervention_required:ask_gpt_review`로
 표시된다. 이때 텍스트 출력과 JSON 출력의 step 항목에는 수동 리뷰 브리지 명령이 함께 표시된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

첫 번째 명령으로 `review-prompt.md`를 ChatGPT 웹 화면에 붙여넣을 수 있도록 복사하고, JSON 리뷰를 받은 뒤 두 번째 명령으로 클립보드의 리뷰 JS
ON을 저장한다. auto-cycle은 이 단계에서 GPT API를 호출하지 않고 중단한다.

명령 역할 구분:

- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 출력한다. 자동 실행하지 않는다.
- `ai-dev-manual-cycle.ps1`: `status`와 `next`를 함께 보여주는 수동 운영 대시보드다. 자동 실행하지 않는다.
- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전한 action 한 단계만 자동 실행한다. 위험 action은 실행하지 않고 안내 후 중
단한다.
- `ai-dev-auto-cycle.ps1`: 제한 횟수 안에서 auto-step을 반복한다. 사용자 개입 필요 action에서 중단한다.

auto-step과 auto-cycle은 Codex/GPT API 호출, git commit, git push를 자동 실행하지 않는다.

## 수동 자동화 UX 판단 순서

GPT API 없이 수동 자동화 흐름을 운영할 때는 먼저 상태를 읽고, 그 다음 안전한 DryRun으로 다음 행동을 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun -MaxSteps 3
```

확인 기준:

- `goal_completed`: 더 이상 실행할 task가 없으므로 새 goal 초기화가 필요하다.
- `ask_gpt_review`: `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -FromClipboard`를 사용
해 수동 리뷰 브리지로 진행한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든다.
- `blocked`: 사용자 판단이 필요하므로 자동 진행을 멈춘다.
- `commit`: 자동 실행하지 않고 커밋 조건과 대상 파일을 사람이 확인한다.

`goal_completed` 상태에서 `auto-step`은 추가 작업을 실행하지 않고 현재 goal이 완료되었으며 더 실행할 task가 없다고 안내한다. 추천 명령에는 
상태 확인용 `ai-dev-status.ps1`만 포함한다.

`auto-cycle`이 `goal_completed`로 멈추면 텍스트 출력에서는 “목표 완료로 종료” 의미를 표시하고, JSON 출력에서는 `completed: true`
, `stoppedReason: "goal_completed"`를 유지한다. 다음 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`,
 `.ai-dev/state.json`을 새 목표 기준으로 초기화한다.

`save-review` 실패는 잘못된 클립보드 입력 때문에 발생할 수 있다. 실패 시에는 오류 preview를 확인하고 JSON 리뷰만 다시 복사한다. 완료된 goal이나
 기존 정상 상태를 불필요하게 오염시키지 않도록 실패 기록 방식은 별도 정책에 따라 개선한다.

최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 결과를 `
test-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.

## Codex CLI 완전 자동화 준비

다음 자동화 단계에서는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI, `gh` 없이 Codex CLI만 사용한다
.

현재 전제:

- `codex-cli 0.133.0` 사용 가능
- `codex exec` 동작 확인 완료
- approval: `never`
- sandbox: `workspace-write`
- workdir: `D:\ai-apps\planpilot-local`
- Cline은 삭제되어 사용하지 않음
- Copilot CLI와 `gh`는 현재 사용하지 않음

도입 예정 스크립트:

- `scripts/ai-dev-run-codex.ps1`: `.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 수
행한다.
- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하
고 저장 흐름에 연결한다.
- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저장, Codex 리뷰, save-revi
ew, pass 시 commit/complete-task를 연결한다.
- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입력하면 goal/queue/state 생성,
 current-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.
- `scripts/ai-dev-autopilot.ps1`: 완료된 현재 goal과 backlog를 기준으로 다음 goal 후보를 고르고 `ai-dev-auto-goal.p
s1` 흐름에 전달한다.

초기 안전 기준:

- full cycle은 처음에 `MaxTasks 1` 중심으로 제한한다.
- Codex 구현 실행은 `AllowCodex`가 있을 때만 수행한다.
- Codex 리뷰 실행은 `AllowReviewCodex`가 있을 때만 수행한다.
- git commit은 `AllowCommit`이 있을 때만 수행한다.
- auto-goal에서 실제 full cycle 실행은 `AllowRun` 또는 명시적 실행 옵션이 있을 때만 수행한다.
- autopilot은 기본 `MaxGoals 1`로 제한하며, 현재 goal이 완료되지 않았거나 후보 생성에 실패하면 state와 loop-log에 중단 사유를 기록한다.
- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
- build/check 실패, package 파일 변경, 리뷰 decision이 `pass`가 아닌 경우 자동 커밋하지 않는다.
- `git reset`, `git clean`, `npm install`, `git push`는 자동 실행하지 않는다.

자동화 로그와 결과 파일:

- `.ai-dev/codex-result.md`: Codex 구현 실행 결과
- `.ai-dev/review-response.json`: Codex 리뷰 JSON 원문
- `.ai-dev/review.md`: 저장된 리뷰 요약
- `.ai-dev/test-result.md`: check/build 또는 수동 검증 요약
- `.ai-dev/loop-log.md`: 루프 진행 기록
- `.ai-dev/state.json`: 현재 상태와 마지막 실패 요약

### Codex 구현 실행

`.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 실행한다. 실행 전 `git status --short`를 확인
하고, 작업 트리가 dirty이면 기본 중단한다. 단, dirty 파일이 `.ai-dev/current-task-prompt.md`뿐이면 프롬프트 생성 산출물로 보고 진행할
 수 있다.

실행 예정 정보만 확인하려면 `-DryRun`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -DryRun
```

기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-result.md`에 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1
```

`current-task-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GeneratePromptIfMissing`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -GeneratePromptIfMissing
```

자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -DryRun -Json
```

dirty worktree에서도 실행해야 하는 특별한 경우에만 `-AllowDirty`를 명시한다. 이 옵션은 사용자 변경과 Codex 변경이 섞일 수 있으므로 full c
ycle에서는 초기 기본값으로 사용하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty
```

이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, npm install, packag
e 파일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.

### Codex 리뷰 실행

`.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 `.ai-dev/review-response.json`에 저장한다. 실
행 전 `git status --short`를 확인하고, 작업 트리가 dirty이면 기본 중단한다. 리뷰 대상 변경사항이 남아 있는 상태에서 실행해야 하는 경우에만 `-Al
lowDirty`를 명시한다.

실행 예정 정보만 확인하려면 `-DryRun`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun
```

기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-review-result.md`에 저장한다. Codex 출력에서 첫 번째
 유효 JSON 리뷰 객체를 추출해 `.ai-dev/review-response.json`에 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1
```

`review-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GenerateReviewPromptIfMissing`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -GenerateReviewProm
ptIfMissing
```

리뷰 JSON 저장 후 `ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json` 흐름까지 이어가려면 `-Save
Review`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveRe
view
```

자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun -Json
```

주의:

- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체만 출력하라는 안전 규칙을 추가한다.
- JSON 리뷰에는 `decision`, `severity`, `summary`, `required_changes`, `optional_suggestions`, `next
_step` 필드가 필요하다.
- JSON 추출에 실패하면 출력 preview를 보여주고 종료 코드 1로 종료한다.
- `-AllowDirty`는 구현 변경사항을 리뷰해야 할 때만 사용한다. 사용자 변경과 자동화 산출물이 섞여 있으면 리뷰 결과와 후속 저장 상태가 혼동될 수 있다.
- 이 스크립트는 git add, git commit, build/test/lint, GPT API 호출을 수행하지 않는다.

### full auto-cycle 초안

`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict rev
iew prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.

T005 버전의 실행 단계:

1. `ai-dev-make-prompt.ps1`
2. `ai-dev-run-codex.ps1`
3. `ai-dev-check.ps1 -BuildOnly`
4. `ai-dev-save-diff.ps1`
5. `ai-dev-make-review-prompt.ps1 -Strict`
6. `ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview`
7. 리뷰 게이트 확인: `state.lastCommandStatus`가 `passed`이고 `state.lastReviewDecision`이 `pass`여야 한다.
8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다.
9. `-AllowCommit`이 있을 때만 `ai-dev-commit.ps1`을 실행한다. `-CommitFiles`가 있으면 선택 파일만 커밋 대상으로 전달한다.
10. 커밋 결과 게이트 확인: `state.lastCommand`가 `commit`이고 `lastCommitHash`가 있어야 한다.
11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
12. `MaxTasks`가 1보다 크면 complete-task 성공 후 다음 task를 다시 읽고 같은 흐름을 반복한다.

먼저 DryRun으로 전체 단계를 확인한다. DryRun은 하위 스크립트를 실제 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun
```

자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -Json
```

기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이다. `MaxTasks`가 1보다 크
면 각 task가 커밋과 complete-task까지 성공한 경우에만 다음 task로 반복한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 
-MaxSteps 20
```

여러 task 반복 구조를 확인하려면 `MaxTasks`를 늘릴 수 있다. 실제 반복은 각 task의 commit/complete-task가 성공해야 다음 task로 넘어간
다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 3 
-MaxSteps 20
```

`-AllowCodex` 없이 실제 실행하면 prompt 생성 이후 Codex 구현 실행 직전에서 중단하고 추천 명령을 출력한다. Codex 구현까지 허용하려면 명시적으로 
`-AllowCodex`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex
```

Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowReviewCodex`를 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRe
viewCodex -MaxTasks 1
```

리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 함께 지정한다. 커밋 메시지는 기본적으로 현
재 task의 `commitMessage`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRe
viewCodex -AllowCommit -MaxTasks 1
```

선택 파일만 커밋하려면 `-CommitFiles`를 지정한다. 이 값은 그대로 `ai-dev-commit.ps1 -Files`에 전달된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRe
viewCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTas
ks 1
```

최대 3개 task까지 연속 실행하려면 `MaxTasks 3`을 지정한다. complete-task가 queue/state/loop-log를 갱신하므로, 다음 task 구현
 실행 시 dirty worktree 정책을 별도로 판단해야 한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRe
viewCodex -AllowCommit -AllowDirty -MaxTasks 3
```

dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-
codex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRe
viewCodex -AllowDirty -MaxTasks 1
```

리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 compl
ete-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `pack
age-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지
 못하면 `commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.

### 목표 입력 기반 자동 실행

최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게 하는 것이다.

먼저 DryRun으로 생성될 goal/task 계획과 실행 단계를 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라
이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun
```

자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다. JSON 출력은 사람이 읽는 텍스트와 섞지 않는다.
DryRun JSON에는 `plan.goalMarkdown`, `plan.queue`, `plan.state` 미리보기가 포함되므로 파일 작성 전에 생성될 goal/task
 계획을 검토할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라
이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun -Json
```

실제 goal/queue/state 생성과 current-task-prompt 생성까지만 수행하려면 `-DryRun`을 제거한다. 이 모드는 `ai-dev-auto-cycl
e-full.ps1`을 호출하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라
이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다."
```

생성 후 full auto-cycle 래퍼 호출까지 이어가려면 `-AllowRun` 또는 `-AllowCodex`, `-AllowReviewCodex`, `-AllowCom
mit` 같은 명시적 실행 옵션을 지정한다. `-AllowRun` 단독은 full-cycle 래퍼 호출만 허용하며 Codex 구현이나 Codex 리뷰 권한을 대신하지 않는다
. 실제 구현까지 허용하려면 `-AllowCodex`, 리뷰까지 허용하려면 `-AllowReviewCodex`, 자동 커밋과 task 완료까지 허용하려면 기존 full cy
cle과 동일하게 `-AllowCodex -AllowReviewCodex -AllowCommit`을 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라
이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex 
-AllowCommit -MaxTasks 1
```

동작:

1. `GoalTitle`과 `GoalDescription`을 검증한다.
2. Codex CLI를 이용해 goal/queue/state 초안을 생성한다.
3. Codex 출력에서 `goalMarkdown`, `queue`, `state` JSON을 추출한다.
4. `queue.json`과 `state.json`의 필수 필드, currentTaskId, task 배열, enum 값을 검증한다.
5. `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 작성한다.
6. `.ai-dev/current-task-prompt.md`를 생성한다.
7. 명시적 실행 옵션이 있을 때만 `ai-dev-auto-cycle-full.ps1`로 이어간다.
8. auto-goal이 생성한 `.ai-dev/goal.md`, `queue.json`, `state.json`, `current-task-prompt.md`, 결과 파일
 때문에 하위 full cycle의 dirty worktree 게이트가 중단되지 않도록 내부적으로 `-AllowDirty`를 전달한다. 초기 dirty worktree 게이
트는 auto-goal 시작 전에 별도로 유지한다.

안전 기준:

- `GoalTitle` 또는 `GoalDescription`이 비어 있으면 종료한다.
- DryRun에서는 생성될 goal/task 계획과 실행 단계만 표시하고 파일을 수정하지 않는다.
- Json 출력은 사람이 읽는 텍스트와 섞지 않는다.
- 생성된 goal/queue/state JSON 파싱 또는 필드 검증에 실패하면 파일 작성과 full cycle 실행으로 넘어가지 않는다.
- full cycle 호출은 `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit` 중 하나가 있을 때만 수행한
다.
- `-AllowRun` 단독은 구현, 리뷰, 커밋을 수행한다는 의미가 아니다. 하위 full cycle은 여전히 `-AllowCodex`, `-AllowReviewCode
x`, `-AllowCommit` 권한에 따라 각 위험 단계를 허용하거나 중단한다.
- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, dirty worktree 위험이 있으면 자동 커밋하지 않는다.
- `git reset`, `git clean`, `npm install`, `git push`는 실행하지 않는다.

### 제한된 autopilot 실행

`ai-dev-autopilot.ps1`는 현재 goal이 완료되고 open task가 없는 상태인지 확인한 뒤 `.ai-dev/backlog.md`에서 제한된 다음 goa
l 후보를 하나 고르고, 기존 `ai-dev-auto-goal.ps1`에 전달한다. 기본값은 `MaxGoals 1`, `MaxTasks 1`, `MaxSteps 22`이며 
무한 반복하지 않는 제한 실행 흐름이다.

주요 제한값과 실행 옵션:

| 옵션 | 기본값 | 의미 |
| --- | --- | --- |
| `-MaxGoals` | `1` | autopilot 한 번의 실행에서 준비할 수 있는 최대 goal 수다. `1`보다 작으면 실행하지 않고 중단한다. |
| `-MaxTasks` | `1` | 생성되는 다음 goal의 최대 task 수로 `ai-dev-auto-goal.ps1`에 전달된다. |
| `-MaxSteps` | `22` | 하위 full cycle 래퍼가 사용할 최대 step 수로 전달된다. |
| `-DryRun` | 꺼짐 | 파일을 수정하지 않고 gate, 후보, 하위 실행 계획만 확인한다. |
| `-Json` | 꺼짐 | 사람이 읽는 로그 대신 JSON 결과를 출력한다. |
| `-AllowRun` | 꺼짐 | 다음 goal 준비 뒤 기존 full cycle 래퍼 호출을 허용한다. |
| `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit` | 꺼짐 | 하위 auto-goal/full-cycle 흐름의 Codex 구현
, Codex 리뷰, 커밋 단계를 각각 허용한다. |

먼저 DryRun으로 제한값과 중단 조건을 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRun
```

JSON 출력이 필요하면 `-Json`을 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRun -Json
```

실제 다음 goal 준비까지 수행하려면 `-DryRun`을 제거한다. 이 모드는 goal/queue/state/current-task-prompt 생성까지만 진행하고 ful
l cycle은 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -MaxGoals 1
```

후보 생성 이후 full cycle 래퍼까지 호출하려면 기존 실행 권한 옵션을 명시한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -AllowCodex -AllowReview
Codex -AllowCommit -MaxGoals 1 -MaxTasks 1
```

중단 조건:

- 현재 `state.json`과 `queue.json`이 완료된 goal 상태가 아니면 `current_goal_not_completed`로 중단한다.
- backlog에서 사용할 수 있는 후보를 찾지 못하면 `goal_candidate_not_found`로 중단한다.
- `ai-dev-auto-goal.ps1`가 goal 생성, 검증, 실행 흐름에서 실패하면 `auto_goal_failed`로 중단한다.
- build/lint/review 실패, 반복 revise loop, dirty worktree 안전 검사 실패처럼 하위 full cycle 게이트가 실패하면 해당 실패 
사유를 읽을 수 있게 남기고 중단한다.
- `MaxGoals`, `MaxTasks`, `MaxSteps`가 1보다 작으면 입력 검증 실패로 중단한다.

실패 시 DryRun이 아니면 `state.json`의 `lastCommand`, `lastCommandStatus`, `lastErrorSummary`, `stopReas
on`, `repeatedFailureCount`, `updatedAt`을 갱신하고 `.ai-dev/loop-log.md`에 중단 사유를 남긴다. DryRun은 파일을 수정
하지 않고 예상 결과만 출력한다.

실패 또는 중단 후 확인할 파일:

| 파일 | 확인할 내용 |
| --- | --- |
| `.ai-dev/state.json` | `lastCommand=autopilot`, `lastCommandStatus`, `lastErrorSummary`, `stop
Reason`, `repeatedFailureCount`, `updatedAt` |
| `.ai-dev/loop-log.md` | `Autopilot stopped` 또는 `Autopilot goal prepared` 항목과 중단/준비 사유 |
| `.ai-dev/goal.md` | DryRun이 아닌 goal 준비 성공 시 새 goal 제목과 설명 |
| `.ai-dev/queue.json` | DryRun이 아닌 goal 준비 성공 시 `goalTitle`, `currentTaskId`, 생성된 task 목록 |
| `.ai-dev/current-task-prompt.md` | 다음 task 실행 프롬프트가 새 goal 기준으로 재생성됐는지 여부 |

수동 검증 기준:

- 제한값 확인: `-DryRun -Json` 출력에서 `maxGoals`, `preparedGoals`, 각 step의 `message`를 확인한다. `-MaxGoals 
0 -DryRun -Json`은 실패해야 하며 `stoppedReason`이 `max_goals_must_be_at_least_1`인지 확인한다.
- 현재 goal gate 확인: 현재 goal이 완료되지 않았거나 open task가 남아 있으면 `current_goal_not_completed`로 중단되는지 확인한다
. 이때 `state.json`의 `goalStatus`, `currentTaskId`와 `queue.json`의 미완료 task 상태를 함께 본다.
- 후보 생성 확인: goal이 완료된 상태에서 실행하면 `.ai-dev/backlog.md`의 후보가 `goalCandidate`로 표시되는지 확인한다. 실제 실행에서는 
`.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`, `.ai-dev/current-task-prompt.md`가
 새 goal 기준으로 갱신되는지 확인한다.
- 실패 기록 확인: DryRun이 아닌 실패에서는 `.ai-dev/state.json`의 `lastCommand=autopilot`, `lastCommandStatus=f
ailed`, `lastErrorSummary`, `stopReason`, `repeatedFailureCount`, `updatedAt`을 확인하고, `.ai-dev/lo
op-log.md`에 같은 중단 사유가 남았는지 확인한다.
- 기존 단일 goal 흐름 확인: `scripts/ai-dev-auto-goal.ps1`는 여전히 `GoalTitle`과 `GoalDescription`을 직접 받는 진입
점이다. autopilot 검증 후에도 auto-goal DryRun이 기존처럼 goal/task 계획을 출력하는지 확인한다.
- 실행 권한 확인: `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit`을 주지 않은 autopilot은 다음
 goal 준비까지만 수행하고 full cycle을 실행하지 않아야 한다.

## 운영 원칙

- 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
- 한 번에 하나의 task만 수행한다.
- task 단위로 구현, 검증, 리뷰, 커밋한다.
- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean 상태까
지 확인된 경우로 한다.
- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
- 검증하지 않은 결과를 통과로 기록하지 않는다.
- 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

## 다음 단계

실제 자동 개발 루프 실행기와 상태 갱신 로직은 별도 정책 검토 후 추가한다.

세부 기준은 `docs/ai-dev-loop-policy.md`를 따른다.

codex
정책 문서는 `.ai-dev` 운영 문서 안에 새로 추가하는 것이 가장 작은 변경입니다. 기존 `docs/ai-dev-loop-policy.md`와 충돌하지 않도록 핵심 원
칙만 확인한 뒤 새 문서를 작성하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\docs\\ai-dev-loop-policy.md'" in D:\ai-apps\planpilot-local
 succeeded in 1722ms:
# PlanPilot Local AI ?먮룞 媛쒕컻 猷⑦봽 ?뺤콉

??臾몄꽌???ъ슜?먭? 紐⑺몴瑜??낅젰?섎㈃ AI媛 ?묒뾽??遺꾪빐?섍퀬, 援ы쁽?섍퀬, 寃利앺븯怨? 由щ럭?섍퀬, ?묒뾽 ?⑥쐞濡??먮룞 而ㅻ컠?섎뒗 Level 5 
?먮룞 媛쒕컻 猷⑦봽??湲곗????뺣━?쒕떎.

?꾩옱 臾몄꽌???뺤콉 臾몄꽌?대ŉ, ?ㅼ젣 ?먮룞???ㅽ겕由쏀듃, ?ㅽ뻾湲? 媛먯떆 ?꾨줈?몄뒪, CI ?곕룞? 援ы쁽?섏? ?딅뒗??

## 紐⑹쟻

- ?ъ슜?먮뒗 援ы쁽 ?몃??ы빆蹂대떎 ?ъ꽦??紐⑺몴? ?곗꽑?쒖쐞瑜??낅젰?쒕떎.
- AI??紐⑺몴瑜??묒? ?묒뾽?쇰줈 遺꾪빐?섍퀬 ??踰덉뿉 ?섎굹???덉쟾?섍쾶 泥섎━?쒕떎.
- 媛??묒뾽? 援ы쁽, 寃利? 由щ럭, 而ㅻ컠 寃곌낵瑜??낅┰?곸쑝濡?異붿쟻?????덉뼱???쒕떎.
- ?먮룞?붽? ?μ떆媛??ㅽ뻾?섎뜑?쇰룄 ?꾩옱 ?묒뾽 踰붿쐞瑜?踰쀬뼱?섏? ?딆븘???쒕떎.
- ??μ냼??`AGENTS.md`, 蹂댁븞 ?뺤콉, 湲덉? ?ы빆, ?ъ슜??吏?쒕뒗 ?먮룞 媛쒕컻 猷⑦봽蹂대떎 ??긽 ?곗꽑?쒕떎.

## Level 5 ?먮룞 媛쒕컻 猷⑦봽 ?뺤쓽

Level 5 ?먮룞 媛쒕컻 猷⑦봽???ъ슜?먭? `.ai-dev/goal.md`??紐⑺몴瑜??묒꽦???? AI媛 ?ㅼ쓬 ?묒뾽???ㅼ뒪濡??좏깮?섍퀬 ?꾨즺 ?곹깭源뚯?
 吏꾪뻾?섎뒗 ?댁쁺 諛⑹떇?대떎.

AI媛 ?대떦?섎뒗 踰붿쐞:

- 紐⑺몴 遺꾩꽍
- ?묒뾽 遺꾪빐
- ?ㅽ뻾 ?쒖꽌 寃곗젙
- ?꾩옱 ?묒뾽 援ы쁽
- build, test, lint ?ㅽ뻾
- ?ㅽ뙣 ?먯씤 遺꾩꽍怨??덉슜 踰붿쐞 ???ъ닔??- GPT 湲곕컲 蹂寃?由щ럭
- 由щ럭 吏?곸궗??諛섏쁺
- ?먮룞 而ㅻ컠
- ?ㅼ쓬 ?묒뾽 ?좏깮
- 吏꾪뻾 ?곹깭? 濡쒓렇 湲곕줉

AI??紐⑺몴媛 遺덈챸?뺥븯嫄곕굹 ?덉쟾?섍쾶 ?먮떒?????녿뒗 寃쎌슦 ?꾩쓽濡?踰붿쐞瑜??뺤옣?섏? ?딄퀬 以묐떒?쒕떎.

## 湲곕낯 ?숈옉 ?먮쫫

1. `.ai-dev/goal.md`? `.ai-dev/backlog.md`瑜??쎈뒗??
2. ??μ냼??`AGENTS.md`? ?꾩옱 ?묒뾽 ?몃━ ?곹깭瑜??뺤씤?쒕떎.
3. 紐⑺몴瑜??묒? task濡?遺꾪빐?섍퀬 `.ai-dev/plan.md`? `.ai-dev/queue.json`??媛깆떊?쒕떎.
4. queue?먯꽌 ?곗꽑?쒖쐞媛 媛???믨퀬 ?ㅽ뻾 媛?ν븳 task ?섎굹瑜??좏깮?쒕떎.
5. ?좏깮??task???섏젙 ?덉젙 ?뚯씪, ?꾪뿕?? 寃利?諛⑸쾿??湲곕줉?쒕떎.
6. ?꾩옱 task 踰붿쐞 ?덉뿉?쒕쭔 援ы쁽?쒕떎.
7. task???꾩슂??build, test, lint瑜??ㅽ뻾?쒕떎.
8. ?ㅽ뙣?섎㈃ 媛숈? task 踰붿쐞 ?덉뿉???먯씤???섏젙?섍퀬 ?ㅼ떆 寃利앺븳??
9. 寃利앹씠 ?깃났?섎㈃ ?꾩껜 蹂寃?diff瑜?GPT媛 由щ럭?쒕떎.
10. 由щ럭 吏?곸궗??씠 ?덉쑝硫?媛숈? task 踰붿쐞 ?덉뿉???섏젙?섍퀬 ?ㅼ떆 寃利앺븳??
11. ?먮룞 而ㅻ컠 議곌굔??紐⑤몢 留뚯”?섎㈃ task ?⑥쐞 而ㅻ컠??留뚮뱺??
12. `.ai-dev/state.json`, `.ai-dev/test-result.md`, `.ai-dev/review.md`, `.ai-dev/loop-log.md`瑜?
媛깆떊?쒕떎.
13. ?ㅼ쓬 task瑜??좏깮?섍굅??以묐떒 議곌굔???곕씪 猷⑦봽瑜?醫낅즺?쒕떎.

## ?щ엺???낅젰?섎뒗 ?뚯씪

### `.ai-dev/goal.md`

?ъ슜?먭? ?ъ꽦?섎젮??紐⑺몴瑜??묒꽦?섎뒗 ?뚯씪?대떎.

?ы븿 沅뚯옣 ??ぉ:

- 紐⑺몴
- ?꾨즺 湲곗?
- ?덉슜 踰붿쐞
- 湲덉? 踰붿쐞
- ?곗꽑?쒖쐞
- 李멸퀬 臾몄꽌
- 寃利?諛⑸쾿
- 而ㅻ컠 ?먮뒗 諛고룷 ?쒗븳

紐⑺몴??媛?ν븳 ??寃곌낵 以묒떖?쇰줈 ?묒꽦?쒕떎. 援ы쁽 諛⑹떇? ??μ냼 援ъ“? ?뺤콉??留욎떠 AI媛 ?먮떒?????덈떎.

### `.ai-dev/backlog.md`

?ъ슜?먭? ?먰븯???꾩냽 ?묒뾽, ?꾩씠?붿뼱, ??? ?곗꽑?쒖쐞 ?꾨낫瑜?湲곕줉?섎뒗 ?뚯씪?대떎.

?뺤콉:

- backlog ??ぉ? ?먮룞 ?ㅽ뻾???뺤젙??task媛 ?꾨땲??
- AI???꾩옱 goal怨?吏곸젒 愿?⑤맂 ??ぉ留?queue ?꾨낫濡??щ┛??
- ?꾪뿕?꾧? ?믨굅??踰붿쐞媛 ????ぉ? 臾몄꽌??task濡??꾪솚?????덈떎.
- ?꾩옱 goal怨?臾닿???backlog ??ぉ? ?꾩쓽濡?援ы쁽?섏? ?딅뒗??

## AI媛 ?앹꽦?섍굅???섏젙?섎뒗 ?뚯씪

### `.ai-dev/plan.md`

?꾩옱 goal???대뼡 ?④퀎濡?泥섎━?좎? ?щ엺???쎌쓣 ???덈뒗 ?뺥깭濡??뺣━?쒕떎.

?ы븿 ??ぉ:

- 紐⑺몴 ?붿빟
- ?묒뾽 遺꾪빐 寃곌낵
- ?묒뾽 ?쒖꽌
- ?덉긽 ?섏젙 ?뚯씪
- ?묒뾽蹂??꾪뿕??- 寃利?怨꾪쉷
- 以묐떒 議곌굔

### `.ai-dev/queue.json`

?먮룞 媛쒕컻 猷⑦봽媛 泥섎━??task 紐⑸줉怨??곹깭瑜?援ъ“?뷀빐 ??ν븳??

task ?곹깭 ?꾨낫:

- `pending`
- `in_progress`
- `blocked`
- `completed`
- `skipped`

媛?task??理쒖냼???ㅼ쓬 ?뺣낫瑜??ы븿?댁빞 ?쒕떎.

- 怨좎쑀 id
- ?쒕ぉ
- 紐⑹쟻
- ?곗꽑?쒖쐞
- ?덉슜 ?섏젙 ?뚯씪
- 寃利?紐낅졊
- 而ㅻ컠 硫붿떆吏 ?꾨낫
- ?꾩옱 ?곹깭

### `.ai-dev/state.json`

?먮룞 媛쒕컻 猷⑦봽???꾩옱 ?ㅽ뻾 ?곹깭瑜?湲곕줉?쒕떎.

?ы븿 ??ぉ:

- ?꾩옱 goal
- ?꾩옱 task id
- 留덉?留??꾨즺 task id
- 留덉?留??깃났 寃利??쒓컖
- 留덉?留?而ㅻ컠 hash
- ?ъ떆???잛닔
- 以묐떒 ?ъ쑀

### `.ai-dev/test-result.md`

?묒뾽蹂?build, test, lint ?ㅽ뻾 寃곌낵瑜?湲곕줉?쒕떎.

?뺤콉:

- ?ㅽ뻾?섏? ?딆? 寃利앹? ?듦낵濡?湲곕줉?섏? ?딅뒗??
- ?ㅽ뙣??寃利앹? ?먯씤怨??ъ떆??寃곌낵瑜??④릿??
- 寃利?紐낅졊????μ냼???녾굅???ㅽ뻾???덉슜?섏? ?딆쑝硫?誘몄닔???ъ쑀瑜??④릿??

### `.ai-dev/review.md`

?묒뾽蹂?GPT 由щ럭 寃곌낵瑜?湲곕줉?쒕떎.

寃????ぉ:

- ????ㅻ쪟 媛?μ꽦
- 鍮뚮뱶 ?먮뒗 ?뚯뒪???ㅽ뙣 媛?μ꽦
- ?고????ㅻ쪟 媛?μ꽦
- 湲곗〈 湲곕뒫 ?뚭? 媛?μ꽦
- ?꾩옱 task 踰붿쐞 諛??섏젙 ?щ?
- `AGENTS.md` ?꾨컲 ?щ?
- 蹂댁븞, ?곗씠???먯긽, 媛쒖씤?뺣낫 ?좎텧 ?꾪뿕

### `.ai-dev/loop-log.md`

?먮룞 媛쒕컻 猷⑦봽???ㅽ뻾 ?대젰???쒓컙 ?쒖꽌濡?湲곕줉?쒕떎.

?ы븿 ??ぉ:

- task ?좏깮
- ?섏젙 ?뚯씪
- 寃利?寃곌낵
- 由щ럭 寃곌낵
- 而ㅻ컠 寃곌낵
- 以묐떒 ?먮뒗 ?ъ떆???ъ쑀

## ?묒뾽 ?⑥쐞 ?먯튃

- ??踰덉뿉 ?섎굹??task留??섑뻾?쒕떎.
- ?섎굹??task???섎굹??紐낇솗??紐⑹쟻留?媛?몄빞 ?쒕떎.
- task 踰붿쐞 諛??뚯씪? ?섏젙?섏? ?딅뒗??
- 媛?task???낅┰?곸쑝濡?寃利앺븷 ???덉뼱???쒕떎.
- 媛?task??寃利??깃났 ???섎굹??而ㅻ컠?쇰줈 留뚮뱺??
- 愿?⑥꽦????? 蹂寃쎌쓣 ?섎굹??而ㅻ컠??臾띠? ?딅뒗??
- ??湲곕뒫? 援ы쁽, ?뺤콉 臾몄꽌?? 寃利?蹂닿컯??蹂꾨룄 task濡??섎늿??
- ?洹쒕え 蹂寃쎌씠 ?꾩슂??寃쎌슦 ?묒? ?좏뻾 task濡??ㅼ떆 遺꾪빐?쒕떎.

## ?먮룞???④퀎

### 1. goal 遺꾩꽍

- 紐⑺몴? ?꾨즺 湲곗????뺤씤?쒕떎.
- ?덉슜 踰붿쐞? 湲덉? 踰붿쐞瑜?遺꾨━?쒕떎.
- ??μ냼 ?뺤콉怨?異⑸룎?섎뒗 ?붽뎄媛 ?덈뒗吏 ?뺤씤?쒕떎.
- 遺덈챸?뺥븳 議곌굔???덉쟾?깆뿉 ?곹뼢??二쇰㈃ 以묐떒?섍퀬 ?ъ슜???뺤씤???붿껌?쒕떎.

### 2. queue ?앹꽦

- 紐⑺몴瑜??묒? task濡?遺꾪빐?쒕떎.
- ?꾪뿕?꾧? ??퀬 ?좏뻾 議곌굔??異⑹”??task瑜??욎뿉 ?붾떎.
- DB schema 蹂寃? ?洹쒕え 由ы뙥?곕쭅, ?몃? ?ㅽ듃?뚰겕 ?곕룞? 蹂꾨룄 寃??task濡?遺꾨━?쒕떎.

### 3. current task ?좏깮

- `pending` ?곹깭 以??곗꽑?쒖쐞媛 媛???믪? task ?섎굹瑜??좏깮?쒕떎.
- ?댁쟾 task媛 ?ㅽ뙣?덇굅??寃利앸릺吏 ?딆븯?쇰㈃ ?ㅼ쓬 task濡??섏뼱媛吏 ?딅뒗??
- ?꾩옱 ?묒뾽 ?몃━媛 ?덉긽?섏? 紐삵븳 蹂寃쎌쓣 ?ы븿?섎㈃ ??task瑜??쒖옉?섏? ?딅뒗??

### 4. 援ы쁽

- ?섏젙 ?덉젙 ?뚯씪怨??꾪뿕?꾨? 湲곕줉?쒕떎.
- 湲곗〈 肄붾뱶 ?ㅽ??? ??? store, DB 援ъ“瑜??곗꽑 ?ъ슜?쒕떎.
- task 踰붿쐞 諛?由ы뙥?곕쭅?대굹 湲곕뒫 異붽?瑜??섏? ?딅뒗??

### 5. build/test/lint ?ㅽ뻾

- task???꾩슂??寃利?紐낅졊留??ㅽ뻾?쒕떎.
- ?ㅽ뻾 沅뚰븳怨???μ냼 ?뺤콉??癒쇱? ?뺤씤?쒕떎.
- ?ㅽ뻾?섏? ?딆? 寃利앹? 誘몄닔?됱쑝濡?湲곕줉?쒕떎.

### 6. ?ㅽ뙣 ???ъ닔??
- ?ㅽ뙣 ?먯씤???꾩옱 task 踰붿쐞 ?덉뿉?쒕쭔 ?섏젙?쒕떎.
- 媛숈? 臾몄젣媛 諛섎났?섎㈃ ?ъ떆???잛닔瑜?湲곕줉?쒕떎.
- ?덉슜 踰붿쐞瑜??섏뼱???닿껐?????덉쑝硫?以묐떒?쒕떎.

### 7. GPT 由щ럭

- ?꾩껜 diff瑜?湲곗??쇰줈 蹂寃쎌쓣 寃?좏븳??
- P1 ?섏????곗씠???먯긽, 蹂댁븞, ?고????ㅻ쪟, 二쇱슂 ?뚭? ?꾪뿕???덉쑝硫?而ㅻ컠?섏? ?딅뒗??
- P2/P3 吏?곸궗??? ?꾩옱 task 踰붿쐞 ?덉뿉???덉쟾?섍쾶 ?닿껐?????덉쓣 ?뚮쭔 諛섏쁺?쒕떎.

## ?섎룞 GPT 由щ럭 釉뚮━吏 ?뺤콉

?꾩옱 AI Dev Loop??GPT API ?ㅺ? ?녿뒗 ?섍꼍?먯꽌??ChatGPT ???붾㈃???ъ슜??由щ럭瑜?吏꾪뻾?????덉뼱???쒕떎. ???먮쫫? API ?
먮룞 ?몄텧???꾨땲???щ엺??寃???댁슜????린???섎룞 釉뚮━吏?대ŉ, ?먮룞???ㅽ겕由쏀듃???꾨＼?꾪듃 ?앹꽦, ?대┰蹂대뱶 蹂듭궗, 由щ럭 JSON ???
?덈궡源뚯?留??뺣뒗??

### 湲곕낯 ?먯튃

- GPT API瑜?吏곸젒 ?몄텧?섏? ?딅뒗??
- ChatGPT ???붾㈃???먮룞?쇰줈 ?묒냽?섍굅???낅젰?섏? ?딅뒗??
- `review-prompt.md`??濡쒖뺄?먯꽌 ?앹꽦?쒕떎.
- ?ъ슜?먮뒗 prompt ?댁슜???뺤씤????ChatGPT ???붾㈃??吏곸젒 遺숈뿬?ｋ뒗??
- ChatGPT?먮뒗 由щ럭 寃곌낵瑜?吏?뺣맂 JSON ?뺤떇留?異쒕젰?섎룄濡??붿껌?쒕떎.
- ?ъ슜?먮뒗 ChatGPT媛 諛섑솚??JSON 由щ럭瑜?蹂듭궗?쒕떎.
- 由щ럭 JSON? `ai-dev-save-review.ps1 -FromClipboard` ?먮뒗 蹂꾨룄 ?섎룞 釉뚮━吏 helper瑜??듯빐 ??ν븳??
- 由щ럭 ????ㅼ뿉??湲곗〈 decision 洹쒖튃???곕씪 `pass`, `revise`, `blocked` ?먮쫫??怨꾩냽 吏꾪뻾?쒕떎.

### ?섎룞 由щ럭 ?먮쫫

1. `ai-dev-make-review-prompt.ps1`媛 `.ai-dev/review-prompt.md`瑜??앹꽦?쒕떎.
2. ?ъ슜?먮뒗 `review-prompt.md` ?댁슜???대┰蹂대뱶??蹂듭궗?쒕떎.
3. ?ъ슜?먮뒗 ChatGPT ???붾㈃??prompt瑜?遺숈뿬?ｋ뒗??
4. ChatGPT??JSON 由щ럭留?異쒕젰?댁빞 ?쒕떎.
5. ?ъ슜?먮뒗 JSON 由щ럭 ?꾩껜瑜??대┰蹂대뱶??蹂듭궗?쒕떎.
6. `ai-dev-save-review.ps1 -FromClipboard`媛 ?대┰蹂대뱶??JSON???뚯떛??`.ai-dev/review.md`? `.ai-dev/s
tate.json`??媛깆떊?쒕떎.
7. decision??`pass`?대㈃ complete-task ?먮뒗 commit ?④퀎濡?吏꾪뻾?쒕떎.
8. decision??`revise`?대㈃ revise prompt瑜??앹꽦??Codex/Cline???섎룞?쇰줈 ?꾨떖?쒕떎.
9. decision??`blocked`?대㈃ ?ъ슜???먮떒??湲곕떎由곕떎.

### auto-step怨??섎룞 釉뚮━吏

`ai-dev-auto-step.ps1`??`ask_gpt_review` ?곹깭?먯꽌 GPT API瑜??몄텧?섏? ?딅뒗?? ????섎룞 由щ럭 釉뚮━吏???꾩슂???ㅼ
쓬 ?됰룞???덈궡?댁빞 ?쒕떎.

?덈궡 ?꾨낫:

- `review-prompt.md` ?앹꽦 ?щ? ?뺤씤
- `review-prompt.md` ?대┰蹂대뱶 蹂듭궗 紐낅졊 ?덈궡
- ChatGPT ???붾㈃??遺숈뿬?ｌ쑝?쇰뒗 ?덈궡
- JSON 由щ럭留?諛쏆븘???쒕떎???덈궡
- 由щ럭 JSON??蹂듭궗????`ai-dev-save-review.ps1 -FromClipboard`瑜??ㅽ뻾?섎씪???덈궡

### manual-cycle怨??섎룞 釉뚮━吏

`ai-dev-manual-cycle.ps1`???꾩옱 ?곹깭? ?ㅼ쓬 action???④퍡 蹂댁뿬二쇰뒗 ?섎룞 ?댁쁺 ??쒕낫?쒕떎. ?ъ슜?먮뒗 `manual-cyc
le` 寃곌낵?먯꽌 `ask_gpt_review`瑜??뺤씤?????섎룞 由щ럭 釉뚮━吏濡??꾪솚?쒕떎.

沅뚯옣 ?먮쫫:

1. `ai-dev-manual-cycle.ps1`濡??꾩옱 task, git ?곹깭, test-result, review ?곹깭, next action???뺤씤?쒕떎.
2. next action??`ask_gpt_review`?대㈃ `ai-dev-copy-review-prompt.ps1`濡?`review-prompt.md`瑜??대┰蹂대뱶?
?蹂듭궗?쒕떎.
3. ?ъ슜?먭? ChatGPT ???붾㈃??prompt瑜?遺숈뿬?ｋ뒗??
4. ChatGPT?먮뒗 JSON 由щ럭留?異쒕젰?섎룄濡??붿껌?쒕떎.
5. ?ъ슜?먭? JSON 由щ럭瑜??대┰蹂대뱶??蹂듭궗?쒕떎.
6. `ai-dev-save-review.ps1 -FromClipboard`濡?由щ럭 寃곌낵瑜???ν븳??
7. ??λ맂 decision???곕씪 ?ㅼ쓬 ?④퀎瑜??좏깮?쒕떎.

decision蹂?湲곗?:

- `pass`: ?꾩옱 task ?꾨즺 泥섎━ ?먮뒗 而ㅻ컠 議곌굔 寃?좊줈 吏꾪뻾?쒕떎.
- `revise`: `ai-dev-make-revise-prompt.ps1`濡??ъ닔???꾨＼?꾪듃瑜?留뚮뱾怨?Codex/Cline???섎룞?쇰줈 ?꾨떖?쒕떎.
- `blocked`: ?ъ슜???먮떒???꾩슂?섎?濡?猷⑦봽瑜?以묐떒?섍퀬 ?붽뎄?ы빆, 踰붿쐞, ?꾪뿕?꾨? ?ㅼ떆 ?뺤씤?쒕떎.

???먮쫫? GPT API ?ㅺ? ?놁뼱???숈옉?쒕떎. ?? `review-prompt.md`?먮뒗 diff? ?뚯뒪??寃곌낵媛 ?ы븿?????덉쑝誘濡?ChatGP
T??遺숈뿬?ｊ린 ?꾩뿉 ?ъ슜?먭? 誘쇨컧 ?뺣낫? ???diff ?ы븿 ?щ?瑜??뺤씤?댁빞 ?쒕떎.

### 誘쇨컧 ?뺣낫? 怨듭쑀 踰붿쐞

`review-prompt.md`?먮뒗 git diff, ?뚯뒪??寃곌낵, ?꾩옱 task ?ㅻ챸???ы븿?????덈떎. diff ?덉뿉 誘쇨컧 ?뺣낫, 諛깆뾽 ?곗씠?? 
媛쒖씤?뺣낫, API Key, ????뚯씪 ?댁슜???ы븿?????덉쑝誘濡??ъ슜?먮뒗 ChatGPT??遺숈뿬?ｊ린 ?꾩뿉 prompt ?댁슜???뺤씤?댁빞 ?쒕떎.

?뺤콉:

- API Key, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?곌? ?ы븿??prompt???몃? ChatGPT ?붾㈃??遺숈뿬?ｌ? ?딅뒗??
- `diff.md`? `review-prompt.md`媛 ?덈Т ?щ㈃ 踰붿쐞瑜?以꾩씠嫄곕굹 ?곗텧臾쇱쓣 ?뺣━?????ㅼ떆 ?앹꽦?쒕떎.
- 誘쇨컧 ?뺣낫媛 ?섏떖?섎㈃ 由щ럭 釉뚮━吏 ?먮쫫??以묐떒?섍퀬 ?ъ슜???먮떒??諛쏅뒗??
- ?섎룞 由щ럭 釉뚮━吏???몄쓽 湲곕뒫??肉? 蹂댁븞 ?먮떒???먮룞?뷀븯吏 ?딅뒗??

### 8. 由щ럭 諛섏쁺

- 由щ럭 ?섏젙 ???꾩슂??寃利앹쓣 ?ㅼ떆 ?ㅽ뻾?쒕떎.
- ?섏젙?쇰줈 task 踰붿쐞媛 而ㅼ?硫?以묐떒?섍퀬 queue瑜??ㅼ떆 遺꾪빐?쒕떎.

### 9. ?먮룞 而ㅻ컠

- ?먮룞 而ㅻ컠 議곌굔??紐⑤몢 留뚯”??寃쎌슦?먮쭔 ?섏젙???뚯씪??紐낆떆?곸쑝濡?stage?쒕떎.
- `git add .`???ъ슜?섏? ?딅뒗??
- 而ㅻ컠 硫붿떆吏??吏㏐퀬 紐낇솗???곸뼱 臾몄옣?쇰줈 ?묒꽦?쒕떎.

### 10. ?ㅼ쓬 task ?좏깮

- ?꾩옱 task???곹깭, 寃利?寃곌낵, 由щ럭 寃곌낵, 而ㅻ컠 hash瑜?湲곕줉?쒕떎.
- ?ㅼ쓬 task???좏뻾 議곌굔???뺤씤?쒕떎.
- 以묐떒 議곌굔???놁쓣 ?뚮쭔 ?ㅼ쓬 task瑜??쒖옉?쒕떎.

## auto-step ?숈옉 ?뺤콉

`ai-dev-auto-step.ps1`???꾩옱 queue, state, review, test, git ?곹깭瑜??쎄퀬 ?덉쟾???ㅼ쓬 ???④퀎留?泥섎━?섎뒗 蹂댁“ 
?ㅽ겕由쏀듃?? ?꾩쟾 ?먮룞 媛쒕컻 猷⑦봽 ?ㅽ뻾湲곌? ?꾨땲硫? ?ъ슜???먮떒?대굹 ?몃? AI ?몄텧???꾩슂???쒓컙?먮뒗 以묐떒?섍굅???ㅼ쓬 紐낅졊留??덈궡?쒕
떎.

### 湲곕낯 ?먯튃

- ??踰??ㅽ뻾?????섎굹??action留?泥섎━?쒕떎.
- `ai-dev-next.ps1`媛 ?먮떒?섎뒗 ?ㅼ쓬 action??湲곕컲?쇰줈 ?숈옉?쒕떎.
- ?곹깭 ?뚯씪怨??꾨＼?꾪듃 ?뚯씪??媛깆떊?섎뒗 ?덉쟾??濡쒖뺄 ?ㅽ겕由쏀듃留??먮룞 ?ㅽ뻾?쒕떎.
- Codex, Cline, GPT API, git commit, git push???먮룞 ?ㅽ뻾?섏? ?딅뒗??
- destructive git 紐낅졊, DB ??젣/蹂듭썝/留덉씠洹몃젅?댁뀡, package ?ㅼ튂???먮룞 ?ㅽ뻾?섏? ?딅뒗??
- ?ㅽ뙣?섎㈃ state? 異쒕젰???ㅽ뙣 ?댁쑀瑜??④린怨??ㅼ쓬 action?쇰줈 吏꾪뻾?섏? ?딅뒗??

### ?먮룞 ?ㅽ뻾 ?덉슜 ?꾨낫

珥덇린 auto-step?먯꽌 ?먮룞 ?ㅽ뻾?????덈뒗 ?꾨낫??濡쒖뺄 ?뚯씪 ?앹꽦 ?먮뒗 寃利?蹂댁“ ?묒뾽?쇰줈 ?쒗븳?쒕떎.

- `current-task-prompt.md`媛 ?놁쓣 ??`scripts/ai-dev-make-prompt.ps1` ?ㅽ뻾
- 寃利앹씠 ?꾩슂???곹깭?먯꽌 紐낆떆?곸쑝濡??덉쟾???듭뀡???좏깮??寃쎌슦 `scripts/ai-dev-check.ps1` ?ㅽ뻾
- diff ??μ씠 ?꾩슂???곹깭?먯꽌 `scripts/ai-dev-save-diff.ps1` ?ㅽ뻾
- review prompt ?앹꽦???꾩슂???곹깭?먯꽌 `scripts/ai-dev-make-review-prompt.ps1` ?ㅽ뻾
- revise prompt ?앹꽦???꾩슂???곹깭?먯꽌 ?ъ슜?먭? 紐낆떆?곸쑝濡??덉슜??寃쎌슦 `scripts/ai-dev-make-revise-prompt.ps1`
 ?ㅽ뻾 ?꾨낫 寃??
`ai-dev-check.ps1`???꾨줈?앺듃 紐낅졊???ㅽ뻾?????덉쑝誘濡?湲곕낯 ?먮룞 ?ㅽ뻾 踰붿쐞??蹂댁닔?곸쑝濡??붾떎. 珥덇린 援ы쁽? DryRun ?먮뒗
 紐낆떆???덉쟾 ?듭뀡?먯꽌留?check ?ㅽ뻾???덉슜?쒕떎.

### ?먮룞 ?ㅽ뻾 湲덉? ?먮뒗 以묐떒 ?꾨낫

?ㅼ쓬 ?곹깭?먯꽌??auto-step??吏곸젒 ?묒뾽?섏? ?딄퀬 ?ъ슜?먯뿉寃??ㅼ쓬 ?됰룞???덈궡?섍굅??以묐떒?쒕떎.

- Codex ?먮뒗 Cline???꾩옱 task 援ы쁽???섑뻾?댁빞 ?섎뒗 寃쎌슦
- GPT 由щ럭媛 ?꾩슂??寃쎌슦
- 由щ럭 寃곌낵媛 `blocked`??寃쎌슦
- 由щ럭 寃곌낵媛 `revise`?닿퀬 ?ъ닔??踰붿쐞媛 遺덈챸?뺥븳 寃쎌슦
- git commit???꾩슂??寃쎌슦
- git push, PR ?앹꽦, 諛고룷媛 ?꾩슂??寃쎌슦
- ?ъ슜???곗씠????젣, 蹂듭썝, ??뼱?곌린, 留덉씠洹몃젅?댁뀡 ?꾪뿕???덈뒗 寃쎌슦
- package ?ㅼ튂 ?먮뒗 package ?뚯씪 蹂寃쎌씠 ?꾩슂??寃쎌슦
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠 ?묒뾽 ?몃━???덈뒗 寃쎌슦

?뱁엳 git commit? ?대쾲 紐⑺몴??auto-step ?먮룞 ?ㅽ뻾 踰붿쐞?먯꽌 ?쒖쇅?쒕떎. auto-step? 而ㅻ컠???꾩슂?섎떎???ъ떎怨?異붿쿇 紐낅졊
???덈궡???섎뒗 ?덉?留?`ai-dev-commit.ps1`瑜?吏곸젒 ?ㅽ뻾?섏? ?딅뒗??

### auto-cycle ?숈옉 湲곗?

`ai-dev-auto-cycle.ps1`??auto-step???쒗븳 ?잛닔 ?덉뿉??諛섎났?섎뒗 蹂댁“ ?ㅽ겕由쏀듃??

- `-MaxSteps` 媛숈? 諛섎났 ?쒗븳???붾떎.
- 媛?諛섎났? auto-step ??踰덉쓽 寃곌낵瑜??뺤씤?????ㅼ쓬 諛섎났 ?щ?瑜??먮떒?쒕떎.
- ?ъ슜??媛쒖엯 ?꾩슂 action, blocked, failed, commit ?꾩슂, Codex/GPT ?꾩슂 ?곹깭?먯꽌??以묐떒?쒕떎.
- 媛숈? action??諛섎났?섍굅???곹깭媛 蹂?섏? ?딆쑝硫?臾댄븳 猷⑦봽 ?꾪뿕?쇰줈 以묐떒?쒕떎.
- auto-cycle??Codex/GPT API ?몄텧, git commit, git push瑜??먮룞 ?ㅽ뻾?섏? ?딅뒗??

### 愿??紐낅졊 ??븷 援щ텇

- `ai-dev-next.ps1`: ?꾩옱 ?곹깭瑜??쎄퀬 ?ㅼ쓬 異붿쿇 action怨?紐낅졊留??덈궡?쒕떎. ?뚯씪 ?섏젙?대굹 ?섏쐞 紐낅졊 ?ㅽ뻾???섏? ?딅뒗??
 ?쒕떎?뚯뿉 臾댁뾿???댁빞 ?섏???앸쭔 ?뚭퀬 ?띠쓣 ???ъ슜?쒕떎.
- `ai-dev-manual-cycle.ps1`: ?곹깭 ?붿빟怨??ㅼ쓬 ?됰룞 ?덈궡瑜???踰덉뿉 蹂댁뿬二쇰뒗 ?섎룞 ?댁쁺 ??쒕낫?쒕떎. ?꾩옱 task, 寃利?
 由щ럭, diff ?뚯씪 ?곹깭瑜??④퍡 蹂대ŉ ?щ엺??吏곸젒 ?ㅼ쓬 紐낅졊??怨좊? ???ъ슜?쒕떎.
- `ai-dev-auto-step.ps1`: `next` ?먮떒 寃곌낵瑜?湲곕컲?쇰줈 ?덉쟾?섎떎怨??뺤쓽???ㅼ쓬 ???④퀎瑜??ㅽ뻾?쒕떎. ?꾨＼?꾪듃 ?앹꽦 媛숈? 
濡쒖뺄 蹂댁“ ?묒뾽? ?ㅽ뻾?????덉?留?Codex/GPT/commit ?④퀎?먯꽌??硫덉텣??
- `ai-dev-auto-cycle.ps1`: ?쒗븳 ?잛닔 ?덉뿉??auto-step??諛섎났?쒕떎. ?щ윭 ?덉쟾 ?④퀎瑜??댁뼱媛怨??띠쓣 ???ъ슜?섏?留? ?ъ
슜??媛쒖엯 ?꾩슂 action, ?ㅽ뙣, blocked, commit ?꾩슂 ?곹깭?먯꽌??硫덉텣??

?ъ슜 異붿쿇:

- ?곹솴 ?뚯븙: `ai-dev-manual-cycle.ps1`
- ?ㅼ쓬 ?됰룞留??뺤씤: `ai-dev-next.ps1`
- ?덉쟾???먮룞 1?④퀎 ?ㅽ뻾: `ai-dev-auto-step.ps1`
- ?덉쟾 ?④퀎 諛섎났 ?ㅽ뻾: `ai-dev-auto-cycle.ps1`

`ai-dev-auto-step.ps1`? `ai-dev-auto-cycle.ps1`??Codex/Cline ?ㅽ뻾, GPT 由щ럭 ?붿껌, git commit???먮룞 
?ㅽ뻾?섏? ?딅뒗??

## ?섎룞 ?먮룞??UX 媛쒖꽑 湲곗?

AI Dev Loop??GPT API ?놁씠???щ엺???ㅼ쓬 ?됰룞??鍮좊Ⅴ寃??먮떒?????덉뼱???쒕떎. ?먮룞???ㅽ겕由쏀듃???ㅽ뻾 ?щ?蹂대떎 ?꾩옱 ?곹깭, 以
묐떒 ?댁쑀, 異붿쿇 紐낅졊, ?꾪뿕 ?щ?瑜?紐낇솗??蹂댁뿬二쇰뒗 寃껋쓣 ?곗꽑?쒕떎.

### ?ㅼ쓬 ?됰룞 ?먮떒 ?쒖꽌

?ъ슜?먭? ?꾩옱 ?곹깭瑜??먮떒???뚮뒗 ?꾨옒 紐낅졊???곗꽑 ?뺤씤?쒕떎.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun -MaxSteps 3
```

- `status`: ?꾩옱 goal/task/test/review/git ?곹깭瑜??뺤씤?쒕떎.
- `next`: ?ㅼ쓬 action怨?異붿쿇 紐낅졊留??뺤씤?쒕떎.
- `manual-cycle`: ?곹깭? ?ㅼ쓬 action?????붾㈃?먯꽌 ?뺤씤?쒕떎.
- `auto-step -DryRun`: ?ㅼ젣 ?ㅽ뻾 ?놁씠 auto-step??臾댁뾿???좎? ?뺤씤?쒕떎.
- `auto-cycle -DryRun -MaxSteps 3`: ?쒗븳??諛섎났 ?덉뿉???대뵒?먯꽌 硫덉텧吏 ?뺤씤?쒕떎.

### goal_completed ?곹깭 UX

`goal_completed` ?곹깭?먯꽌?????댁긽 ?ㅽ뻾??task媛 ?놁쓬??紐낇솗???덈궡?댁빞 ?쒕떎.

?뺤콉:

- `auto-step`? ?꾨즺??goal?먯꽌 異붽? ?묒뾽???ㅽ뻾?섏? ?딅뒗??
- `auto-cycle`? ?꾨즺 ?곹깭瑜?諛섎났?섏? ?딄퀬 `completed: true`濡?醫낅즺?댁빞 ?쒕떎.
- 異쒕젰?먮뒗 ??紐⑺몴瑜??쒖옉?섎젮硫?`.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`????goal 湲곗
??쇰줈 珥덇린?뷀빐???쒕떎???덈궡瑜??ы븿?쒕떎.
- ?꾨즺 ?곹깭?먯꽌 build/test/review/commit???먮룞?쇰줈 ?ㅽ뻾?섏? ?딅뒗??

### ask_gpt_review ?곹깭 UX

`ask_gpt_review` ?곹깭???щ엺??ChatGPT ???붾㈃?먯꽌 由щ럭瑜??섑뻾?댁빞 ?섎뒗 吏?먯씠??

?뺤콉:

- `auto-step`怨?`auto-cycle`? GPT API瑜??몄텧?섏? ?딅뒗??
- `auto-cycle`? `ask_gpt_review`?먯꽌 硫덉텧 ???섎룞 由щ럭 釉뚮━吏 紐낅졊???④퍡 蹂댁뿬以섏빞 ?쒕떎.
- JSON 異쒕젰?먮룄 `ai-dev-copy-review-prompt.ps1`? `ai-dev-save-review.ps1 -FromClipboard` 紐낅졊???ы븿
?섏뼱???쒕떎.
- message?먮뒗 review-prompt 蹂듭궗, ChatGPT 遺숈뿬?ｊ린, JSON 由щ럭 蹂듭궗, save-review ?ㅽ뻾 ?먮쫫??吏㏐쾶 ?ㅻ챸?쒕떎.

### save-review ?ㅽ뙣? ?곹깭 ?ㅼ뿼 諛⑹?

由щ럭 JSON ?뚯떛 ?ㅽ뙣???ъ슜?먭? ?섎せ???대┰蹂대뱶 ?댁슜??蹂듭궗?덉쓣 ???먯＜ 諛쒖깮?????덈떎. ???ㅽ뙣媛 ?대? ?꾨즺??goal?대굹 ?뺤긽 
review ?곹깭瑜?遺덊븘?뷀븯寃??ㅼ뿼?쒗궎硫????쒕떎.

媛쒖꽑 諛⑺뼢:

- ?섎せ??JSON ?낅젰? preview瑜??ы븿???먯씤???ㅻ챸?쒕떎.
- 媛?ν븳 寃쎌슦 ?ㅽ뙣 ?낅젰??湲곗〈 `review.md`? `state.json`??利됱떆 ??뼱?곌린 ?꾩뿉 蹂댁〈 ?щ?瑜??좏깮?????덇쾶 ?쒕떎.
- `goalStatus`媛 `completed`???곹깭?먯꽌???ㅽ뙣???꾩떆 由щ럭 ?낅젰留뚯쑝濡??꾨즺 ?곹깭瑜?`blocked`泥섎읆 蹂댁씠寃?留뚮뱾吏 ?딅뒗?
?
- ?뺤긽 JSON ????먮쫫怨??ㅽ뙣 湲곕줉 ?먮쫫??援щ텇?쒕떎.
- ?곹깭 ?뚯씪??媛깆떊?섎뒗 寃쎌슦 ?대뼡 ?꾨뱶瑜?諛붽씀?붿? 異쒕젰 ?먮뒗 臾몄꽌濡??뺤씤?????덉뼱???쒕떎.

### 理쒖쥌 寃利?寃곌낵 湲곕줉 UX

T006 媛숈? 理쒖쥌 寃利?task??build/test/lint ?몄뿉??PowerShell 臾몃쾿 寃利? `auto-step`/`auto-cycle` DryRun,
 `save-review` ?깃났/?ㅽ뙣 ?먮쫫 ?뺤씤???꾩슂?섎떎.

?뺤콉:

- ?ㅽ뻾??寃利?紐낅졊怨?寃곌낵瑜?`test-result.md`???④릿??
- ?ㅽ뻾?섏? ?딆? 寃利앹? ?듦낵濡?湲곕줉?섏? ?딅뒗??
- 理쒖쥌 寃利앹뿉???뺤씤???섎룞 紐낅졊, exit code, 二쇱슂 異쒕젰 ?붿빟??湲곕줉?쒕떎.
- build/test/lint ?먮쫫? 湲곗〈 `ai-dev-check.ps1` ?숈옉怨?異⑸룎?섏? ?딆븘???쒕떎.
- 臾몃쾿 寃利앹씠??DryRun 寃곌낵瑜?湲곕줉???뚮뒗 `ai-dev-check.ps1 -ManualSummaryOnly -ManualSummary "..."`瑜??ъ
슜?????덈떎.
- ?섎룞 ?붿빟 湲곕줉 紐⑤뱶??npm build/test/lint瑜??ㅽ뻾?섏? ?딅뒗??
- ?섎룞 ?붿빟?먮뒗 PowerShell 臾몃쾿 寃利?寃곌낵, `auto-step` DryRun 寃곌낵, `auto-cycle` DryRun 寃곌낵, `save-revi
ew` ?ㅽ뙣/?깃났 ?먮쫫 ?뺤씤, git status ?뺤씤泥섎읆 ?щ엺???ㅼ젣濡??섑뻾????ぉ留??곷뒗??
- ?ㅽ뻾?섏? ?딆? 寃利???ぉ? ?섎룞 ?붿빟???듦낵濡??곸? ?딅뒗??
- ?섎룞 ?붿빟 紐⑤뱶??`state.json.lastCommandStatus`??湲곕줉 ?묒뾽 ?깃났 ?щ?瑜??삵븯硫? 寃利??먯껜???듦낵/?ㅽ뙣/誘몄닔???먮떒?
 `test-result.md` 蹂몃Ц???④릿??

## Codex CLI ?꾩쟾 ?먮룞???뺤콉

AI Dev Loop???ㅼ쓬 ?먮룞???④퀎??Codex CLI瑜?援ы쁽?먯? 由щ럭?대줈 ?ъ슜?쒕떎. GPT API Key, Cline, Copilot CLI, `gh
` ?놁씠 濡쒖뺄 ??μ냼 ?덉뿉??`codex exec` 湲곕컲 ?ㅽ뻾 ?먮쫫??援ъ꽦?쒕떎.

?꾩옱 ?섍꼍 湲곗?:

- Codex CLI: `codex-cli 0.133.0`
- ?ㅽ뻾 諛⑹떇: `codex exec`
- workdir: `D:\ai-apps\planpilot-local`
- approval: `never`
- sandbox: `workspace-write`
- Cline: ??젣?섏뼱 ?ъ슜?섏? ?딆쓬
- Copilot CLI, `gh`: ?꾩옱 ?ъ슜?섏? ?딆쓬

### ??븷 遺꾨━

- 援ы쁽????븷: `current-task-prompt.md`瑜?Codex CLI???꾨떖???꾩옱 task 踰붿쐞 ?덉쓽 肄붾뱶 ?먮뒗 臾몄꽌 ?섏젙???섑뻾?쒕떎.
- 由щ럭????븷: `review-prompt.md`瑜?Codex CLI???꾨떖??吏?뺣맂 JSON ?뺤떇??由щ럭 寃곌낵瑜??앹꽦?쒕떎.
- 由щ럭 ??? Codex 由щ럭 寃곌낵??`.ai-dev/review-response.json`????ν븳 ??`ai-dev-save-review.ps1` ?먮쫫?쇰
줈 `.ai-dev/review.md`? `.ai-dev/state.json`??諛섏쁺?쒕떎.
- 猷⑦봽 湲곕줉: 援ы쁽 寃곌낵, 由щ럭 寃곌낵, ?ㅽ뙣 ?붿빟? `.ai-dev/codex-result.md`, `.ai-dev/review-response.json`
, `.ai-dev/loop-log.md`, `.ai-dev/state.json`???④릿??

### 珥덇린 full auto-cycle ?쒗븳

珥덇린 `ai-dev-auto-cycle-full.ps1`???덉쟾???꾪빐 ?묒? 踰붿쐞?먯꽌留??숈옉?댁빞 ?쒕떎.

- 湲곕낯 寃利??⑥쐞??`MaxTasks 1`濡??쒗븳?쒕떎.
- Codex 援ы쁽 ?ㅽ뻾? 紐낆떆??`AllowCodex` ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- Codex 由щ럭 ?ㅽ뻾? 紐낆떆??`AllowReviewCodex` ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- git commit? 紐낆떆??`AllowCommit` ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- goal ?낅젰 湲곕컲 ?ㅽ뻾? `ai-dev-auto-goal.ps1`?먯꽌 ?쒖옉?섎릺, full cycle ?몄텧? 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 ?섑
뻾?쒕떎.
- git push, PR ?앹꽦, 諛고룷???먮룞??踰붿쐞?먯꽌 ?쒖쇅?쒕떎.

### ?덉슜 紐낅졊怨??덉슜 ?④퀎

紐낆떆??Allow ?듭뀡怨??덉쟾 議곌굔??留뚯”???뚮쭔 ?ㅼ쓬 ?④퀎瑜??먮룞???꾨낫濡??붾떎.

- `ai-dev-make-prompt.ps1`濡??꾩옱 task prompt ?앹꽦
- `ai-dev-run-codex.ps1`濡?Codex 援ы쁽 ?ㅽ뻾
- `ai-dev-check.ps1`濡?build/check ?ㅽ뻾
- `ai-dev-save-diff.ps1`濡?diff ???- `ai-dev-make-review-prompt.ps1`濡?由щ럭 prompt ?앹꽦
- `ai-dev-run-review-codex.ps1`濡?Codex 由щ럭 ?ㅽ뻾
- `ai-dev-save-review.ps1`濡?由щ럭 JSON ???- 由щ럭媛 `pass`?닿퀬 紐⑤뱺 寃뚯씠?몃? ?듦낵??寃쎌슦?먮쭔 `ai-dev-commit
.ps1`? `ai-dev-complete-task.ps1` ?곌껐

### 紐⑺몴 ?낅젰 湲곕컲 ?먮룞 ?ㅽ뻾 ?뺤콉

理쒖쥌 紐⑺몴???ъ슜?먭? `GoalTitle`怨?`GoalDescription`留??낅젰??task ?앹꽦遺??Codex 援ы쁽, 寃利? Codex 由щ럭, pass
 ??而ㅻ컠怨?task ?꾨즺 泥섎━源뚯? ?댁뼱媛????덇쾶 ?섎뒗 寃껋씠??

?덉긽 理쒖쥌 紐낅졊:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "?낅Т 寃??寃곌낵 
?섏씠?쇱씠??異붽?" -GoalDescription "寃?됱뼱? ?쇱튂?섎뒗 ?낅Т ?쒕ぉ/硫붾え/?꾨줈?앺듃紐낆쓣 ?붾㈃?먯꽌 媛뺤“ ?쒖떆?쒕떎." -AllowCo
dex -AllowReviewCodex -AllowCommit -MaxTasks 1
```

`ai-dev-auto-goal.ps1`??梨낆엫:

- `GoalTitle`怨?`GoalDescription` ?꾩닔 ?낅젰 寃利?- Codex CLI瑜??댁슜??goal/queue/state 珥덉븞 ?앹꽦
- ?앹꽦??JSON ?뚯떛怨??꾩닔 ?꾨뱶 寃利?- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json` 媛깆떊
 ?꾨낫 ?쒖떆
- `.ai-dev/current-task-prompt.md` ?앹꽦 ?곌껐
- 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 `ai-dev-auto-cycle-full.ps1` ?몄텧
- DryRun?먯꽌 ?앹꽦??goal/task 怨꾪쉷怨??ㅽ뻾 ?④퀎瑜??쒖떆
- Json 異쒕젰?먯꽌 ?щ엺???쎈뒗 ?띿뒪?몃? ?욎? ?딆쓬

?덉쟾 湲곗?:

- `GoalTitle` ?먮뒗 `GoalDescription`??鍮꾩뼱 ?덉쑝硫?醫낅즺?쒕떎.
- Codex媛 ?앹꽦??goal/queue/state JSON???뚯떛?????놁쑝硫?醫낅즺?쒕떎.
- `queue.json` ?꾩닔 ?꾨뱶? task ?꾩닔 ?꾨뱶媛 ?놁쑝硫?醫낅즺?쒕떎.
- `state.json` ?꾩닔 ?꾨뱶媛 ?놁쑝硫?醫낅즺?쒕떎.
- ?ㅼ젣 full cycle ?ㅽ뻾? `AllowRun` ?먮뒗 洹몄뿉 以?섎뒗 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- `AllowCodex`, `AllowReviewCodex`, `AllowCommit`? 媛곴컖 援ы쁽, 由щ럭, 而ㅻ컠 ?④퀎瑜?蹂꾨룄濡??곕떎.
- package ?뚯씪 蹂寃? build/check ?ㅽ뙣, 由щ럭 decision??`pass`媛 ?꾨땶 寃쎌슦 ?먮룞 而ㅻ컠?섏? ?딅뒗??

### 湲덉? 紐낅졊怨?湲덉? ?④퀎

?ㅼ쓬 ?묒뾽? full auto-cycle?먯꽌 ?먮룞 ?ㅽ뻾?섏? ?딅뒗??

- GPT API 吏곸젒 ?몄텧
- Cline ?ㅽ뻾
- Copilot CLI ?ㅽ뻾
- `gh` ?먮뒗 GitHub PR ?먮룞 ?곕룞
- `git push`
- `git reset`
- `git clean`
- destructive `git checkout` ?먮뒗 ?ъ슜??蹂寃??섎룎由ш린
- `npm install`
- package ???援먯껜
- DB ??젣, 珥덇린?? 蹂듭썝, 留덉씠洹몃젅?댁뀡
- ?ъ슜???곗씠????뼱?곌린

### ?먮룞 而ㅻ컠 寃뚯씠??
?먮룞 而ㅻ컠? ?ㅼ쓬 議곌굔??紐⑤몢 留뚯”?댁빞留?媛?ν븯??

- `AllowCommit`??紐낆떆?곸쑝濡?吏?뺣릺???덈떎.
- build/check媛 ?깃났?덈떎.
- 由щ럭 decision??`pass`??
- `package.json`怨?`package-lock.json`??蹂寃쎈릺吏 ?딆븯??
- ?꾩옱 task 踰붿쐞 諛??뚯씪???ы븿?섏? ?딆븯??
- dirty worktree媛 ?덉긽 蹂寃쎈쭔 ?ы븿?쒕떎.
- `git reset`, `git clean`, `npm install` ?놁씠 ?꾨즺 媛?ν븯??

?ㅼ쓬 寃쎌슦?먮뒗 ?먮룞 而ㅻ컠?섏? ?딅뒗??

- build/check ?ㅽ뙣
- 由щ럭 decision??`revise` ?먮뒗 `blocked`
- 由щ럭 JSON ?뚯떛 ?ㅽ뙣
- package ?뚯씪 蹂寃?媛먯?
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃?媛먯?
- ?꾩옱 task 踰붿쐞 諛??섏젙 媛먯?

### ?덉쟾 以묐떒 議곌굔

Codex CLI ?먮룞?붾뒗 ?꾨옒 議곌굔?먯꽌 利됱떆 以묐떒?쒕떎.

- Codex 援ы쁽 ?ㅽ뻾 ??`git status`媛 dirty??寃쎌슦
- `current-task-prompt.md` ?먮뒗 `review-prompt.md`媛 ?녾굅???꾩옱 task? 留욎? ?딅뒗 寃쎌슦
- Codex ?ㅽ뻾 寃곌낵媛 ?ㅽ뙣?섍굅??異쒕젰??鍮꾩뼱 ?덈뒗 寃쎌슦
- Codex 由щ럭 寃곌낵?먯꽌 JSON 媛앹껜瑜?異붿텧?????녿뒗 寃쎌슦
- build/check媛 ?ㅽ뙣??寃쎌슦
- package ?뚯씪 蹂寃쎌씠 媛먯???寃쎌슦
- 由щ럭 decision??`pass`媛 ?꾨땶 寃쎌슦
- DB schema 蹂寃? ?곗씠????젣, 蹂듭썝, 留덉씠洹몃젅?댁뀡???꾩슂??寃쎌슦
- 媛숈? ?ㅻ쪟媛 諛섎났?섏뼱 ?덉쟾?섍쾶 吏꾪뻾?????녿뒗 寃쎌슦

?ㅽ뙣 ?쒖뿉???ㅽ뙣瑜?由щ럭 寃곌낵濡??ㅼ씤?섏? ?딅룄濡?二쇱쓽?쒕떎. ?뱁엳 ?대? `completed`??goal???꾩떆 ?낅젰 ?ㅻ쪟??Codex ?ㅽ뻾 ?ㅽ뙣
留뚯쑝濡?`blocked`泥섎읆 蹂댁씠寃?留뚮뱾吏 ?딅뒗?? ?꾩슂??寃쎌슦 `state.json`?먮뒗 ?ㅽ뙣 ?붿빟留?湲곕줉?섍퀬, 湲곗〈 ?꾨즺 ?곹깭瑜???뼱?몄?
 ?щ???蹂꾨룄 ?뺤콉怨??ъ슜???먮떒???곕Ⅸ??

## ?먮룞 而ㅻ컠 議곌굔

?ㅼ쓬 議곌굔??紐⑤몢 留뚯”?댁빞 ?먮룞 而ㅻ컠?????덈떎.

- ?꾩옱 task???꾨즺 湲곗???異⑹”?덈떎.
- ?덉슜???뚯씪留??섏젙?섏뿀??
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠 ?녿떎.
- ?꾩슂??build, test, lint媛 ?깃났?덈떎.
- ?ㅽ뻾?섏? 紐삵븳 ?꾩닔 寃利앹씠 ?녿떎.
- GPT 由щ럭?먯꽌 P1 臾몄젣媛 ?녿떎.
- 由щ럭 吏?곸궗??쓣 諛섏쁺?????ш?利앹씠 ?깃났?덈떎.
- `AGENTS.md`? ?ъ슜??吏?쒕? ?꾨컲?섏? ?딆븯??
- lock file, DB schema, 蹂댁븞 愿??蹂寃쎌씠 ?덉슜 踰붿쐞 諛뽰뿉??諛쒖깮?섏? ?딆븯??
- 而ㅻ컠?먮뒗 ?꾩옱 task? 吏곸젒 愿?⑤맂 蹂寃쎈쭔 ?ы븿?쒕떎.

??μ냼 ?뺤콉?대굹 ?ъ슜??吏?쒓? ?먮룞 而ㅻ컠???덉슜?섏? ?딆쑝硫?而ㅻ컠?섏? ?딄퀬 寃곌낵留?湲곕줉?쒕떎.

## `.ai-dev` ?ㅽ뻾 ?곗텧臾?而ㅻ컠/臾댁떆 ?뺤콉

AI Dev Loop???ㅼ젣 湲곕뒫 蹂寃쎄낵 猷⑦봽 ?댁쁺 ?곹깭瑜?遺꾨━?댁꽌 ?ㅻ，?? ?ㅽ뻾 以??앹꽦???뚯씪??議댁옱?쒕떎???댁쑀留뚯쑝濡?湲곕뒫 而ㅻ컠???④
퍡 ?ы븿?섏? ?딅뒗??

### 湲곕뒫 而ㅻ컠

湲곕뒫 而ㅻ컠?먮뒗 ?꾩옱 task???꾨즺 湲곗???異⑹”?섍린 ?꾪빐 ?ㅼ젣濡??섏젙??肄붾뱶? 臾몄꽌留??ы븿?쒕떎.

?ы븿 ?꾨낫:

- ?꾩옱 task??援ы쁽 肄붾뱶
- ?꾩옱 task??吏곸젒 ?꾩슂???뺤콉 臾몄꽌 ?먮뒗 ?섎룞 寃利?泥댄겕由ъ뒪??- ?꾩옱 task媛 紐낆떆?곸쑝濡??앹꽦?섎룄濡??붽뎄???쒗뵆由우씠???덉떆 ?
뚯씪

湲곕뒫 而ㅻ컠?먯꽌 湲곕낯?곸쑝濡??쒖쇅???꾨낫:

- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/review-response.json`

### 猷⑦봽 ?곹깭 而ㅻ컠

猷⑦봽 ?곹깭 而ㅻ컠? goal, queue, state, 寃利? 由щ럭, ?ㅽ뻾 ?대젰????μ냼???④만 ?꾩슂媛 ?덉쓣 ??湲곕뒫 而ㅻ컠怨?蹂꾨룄濡?留뚮뱺??

?ы븿 媛???꾨낫:

- `.ai-dev/goal.md`
- `.ai-dev/backlog.md`
- `.ai-dev/plan.md`
- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`

猷⑦봽 ?곹깭 而ㅻ컠???꾩옱 紐⑺몴? 吏곸젒 愿?⑤맂 ?뚯씪留??좏깮?쒕떎. 紐⑤뱺 ?ㅽ뻾 ?곗텧臾쇱쓣 留ㅻ쾲 而ㅻ컠?섎뒗 寃껋? 湲곕낯媛믪씠 ?꾨땲??

### ????먮뒗 誘쇨컧 ?곗텧臾?
- `.ai-dev/diff.md`? `.ai-dev/review-prompt.md`???꾩껜 diff??臾몄꽌 ?댁슜???ы븿??鍮좊Ⅴ寃?而ㅼ쭏 ???덉쑝誘濡???긽 
而ㅻ컠?섏? ?딅뒗??
- `.ai-dev/review-response.json`? ?몃? 由щ럭 ?묐떟, 誘쇨컧 ?뺣낫, ?λЦ diff瑜??ы븿?????덉쑝誘濡??댁슜???뺤씤?섍린 ?꾩뿉
??而ㅻ컠?섏? ?딅뒗??
- ?ш린媛 ???곗텧臾쇱? ?꾩슂 ???뺣━?섍굅??蹂꾨룄 蹂댁〈 ?뺤콉???곕씪 ?쒖쇅?쒕떎.
- API Key, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?? ?몄쬆 ?뺣낫媛 ?ы븿???곗텧臾쇱? 而ㅻ컠?섏? ?딅뒗??
- ?ㅼ젣 `.gitignore` 蹂寃쎌? 蹂꾨룄 task?먯꽌 ?꾩슂?깃낵 ?곹뼢 踰붿쐞瑜?寃?좏븳 ??吏꾪뻾?쒕떎.

### untracked ?뚯씪怨?由щ럭 ?낅젰

- untracked ?띿뒪???뚯씪???댁슜? ?좉퇋 ?뚯씪 由щ럭瑜??꾪빐 diff ?곗텧臾쇱뿉 ?ы븿?????덈떎.
- 由щ럭???ы븿?덈떎???ъ떎? ?대떦 ?뚯씪??而ㅻ컠?댁빞 ?쒕떎???섎?媛 ?꾨땲??
- untracked ?뚯씪? ?꾩옱 task 踰붿쐞, 誘쇨컧 ?뺣낫, ?뚯씪 ?ш린, ??μ냼 蹂댁〈 ?꾩슂?깆쓣 蹂꾨룄濡??뺤씤????而ㅻ컠 ??곸쓣 寃곗젙?쒕떎.
- 諛붿씠?덈━, ????뚯씪, ?쎄린 ?ㅽ뙣 ?뚯씪? 由щ럭 ?곗텧臾쇱뿉???댁슜???앸왂?????덈떎.

### 而ㅻ컠 ???뺤씤

- 而ㅻ컠 ?꾩뿉??`git status --short`濡?蹂寃??뚯씪???뺤씤?쒕떎.
- 媛?ν븯硫?而ㅻ컠 ?ㅽ겕由쏀듃??`-DryRun` ?먮뒗 ?좏깮 ?뚯씪 而ㅻ컠 諛⑹떇???곗꽑?쒕떎.
- 湲곕뒫 而ㅻ컠怨?猷⑦봽 ?곹깭 而ㅻ컠???욎뿬 ?덉쑝硫?而ㅻ컠??遺꾨━?쒕떎.
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠???꾩옱 task 踰붿쐞 諛??뚯씪???덉쑝硫??먮룞 而ㅻ컠??以묐떒?쒕떎.
- `git add .` ?먮뒗 臾댁“嫄댁쟻???꾩껜 stage???ъ슜?섏? ?딅뒗??

## 以묐떒 議곌굔

?ㅼ쓬 以??섎굹?쇰룄 諛쒖깮?섎㈃ ?꾩옱 task ?먮뒗 ?먮룞 媛쒕컻 猷⑦봽瑜?以묐떒?쒕떎.

- ?꾩옱 釉뚮옖移??먮뒗 ?묒뾽 ?섍꼍???뺤콉怨??ㅻⅤ??
- ?묒뾽 ?몃━???덉긽?섏? 紐삵븳 蹂寃쎌씠 ?덈떎.
- 媛숈? 寃利??ㅽ뙣瑜??덉슜???ъ떆???잛닔 ?덉뿉 ?닿껐?섏? 紐삵븳??
- task 踰붿쐞 諛??뚯씪 ?섏젙???꾩슂?섎떎.
- DB schema 蹂寃쎌씠??migration???꾩슂?섎떎.
- 湲곗〈 ?곗씠???먯긽 媛?μ꽦???덉쟾?섍쾶 ?먮떒?????녿떎.
- ?洹쒕え 由ы뙥?곕쭅 ?먮뒗 愿묐쾾?꾪븳 UI 蹂寃쎌씠 ?꾩슂?섎떎.
- ?덈줈???⑦궎吏 ?ㅼ튂??????⑦궎吏 援먯껜媛 ?꾩슂?섎떎.
- ?몃? ?ㅽ듃?뚰겕, ?쒕쾭 API, ?몄쬆 ?뺣낫, API Key媛 ?꾩슂?섎떎.
- ?뚯뒪???먮뒗 由щ럭 寃곌낵??P1 臾몄젣媛 ?⑥븘 ?덈떎.
- ?ъ슜??吏?쒖? ??μ냼 ?뺤콉??異⑸룎?쒕떎.
- ?ъ슜???쒕룄, 沅뚰븳 ?쒗븳, ?ㅽ듃?뚰겕 ?쒗븳?쇰줈 ?덉쟾?섍쾶 怨꾩냽?????녿떎.

以묐떒 ??`.ai-dev/state.json`怨?`.ai-dev/loop-log.md`??以묐떒 ?ъ쑀? ?ㅼ쓬???꾩슂???ъ슜??寃곗젙??湲곕줉?쒕떎.

## 湲덉? ?ы빆

- ?꾩옱 task 踰붿쐞 諛??뚯씪???꾩쓽濡??섏젙?섏? ?딅뒗??
- ?ъ슜??蹂寃??ы빆???섎룎由ъ? ?딅뒗??
- 寃利??ㅽ뙣 ?곹깭?먯꽌 ?ㅼ쓬 task濡??섏뼱媛吏 ?딅뒗??
- 寃利앺븯吏 ?딆? 寃곌낵瑜??듦낵濡?湲곕줉?섏? ?딅뒗??
- 由щ럭?먯꽌 ?뺤씤?섏? ?딆? 蹂寃쎌쓣 ?먮룞 而ㅻ컠?섏? ?딅뒗??
- `git add .`, 媛뺤젣 push, destructive git 紐낅졊???ъ슜?섏? ?딅뒗??
- ?ъ슜???뱀씤 ?놁씠 諛고룷?섍굅???먭꺽 釉뚮옖移섏뿉 push?섏? ?딅뒗??
- ?ㅼ젣 ?ъ슜???곗씠?곕? ??젣?섍굅??珥덇린?뷀븯吏 ?딅뒗??
- DB schema瑜?怨꾪쉷 ?놁씠 蹂寃쏀븯吏 ?딅뒗??
- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? `localStorage`瑜??꾩쓽濡?異붽??섏? ?딅뒗??
- API Key, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?곕? ?몃?濡??꾩넚?섏? ?딅뒗??
- ?먮룞???몄쓽瑜??꾪빐 蹂댁븞 ?뺤콉?대굹 ??μ냼 洹쒖튃???꾪솕?섏? ?딅뒗??

## 珥덇린 ?ㅽ뿕 踰붿쐞

Level 5 ?먮룞 媛쒕컻 猷⑦봽??珥덇린 ?ㅽ뿕? ?꾪뿕?꾧? ??퀬 ?섎룎由ш린 ?ъ슫 ?묒뾽?쇰줈 ?쒗븳?쒕떎.

?덉슜 ?꾨낫:

- 臾몄꽌 ?뺣━
- ?묒? ?쒖닔 ?좏떥 遺꾨━
- unused import ?먮뒗 helper ?뺣━
- 湲곗〈 湲곕뒫??諛붽씀吏 ?딅뒗 ?묒? 而댄룷?뚰듃 ?뺣━
- ?섎룞 ?뚯뒪??泥댄겕由ъ뒪??蹂닿컯

珥덇린 ?ㅽ뿕?먯꽌 湲덉??섎뒗 ?묒뾽:

- ?ㅼ젣 DB ??젣 ?먮뒗 珥덇린??- DB schema 蹂寃??먮뒗 migration
- ?洹쒕え 由ы뙥?곕쭅
- ?⑦궎吏 ???援먯껜
- ?꾩옱 task 踰붿쐞 諛??섏젙
- ?뚯씪 媛?몄삤湲? 蹂듭썝, ??뼱?곌린, 蹂묓빀泥섎읆 ?곗씠???먯긽 ?꾪뿕???덈뒗 湲곕뒫
- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? ?뚮┝, Capacitor 異붽?
- ?ъ슜???뱀씤 ?녿뒗 push ?먮뒗 諛고룷

## ?꾩엯 ???뺤씤 ?ы빆

?ㅼ젣 ?먮룞???ㅽ겕由쏀듃瑜?留뚮뱾湲??꾩뿉 ?ㅼ쓬 ??ぉ??蹂꾨룄 ?묒뾽?쇰줈 ?뺤젙?쒕떎.

- `.ai-dev` ?뚯씪??JSON schema? ?꾩닔 ?꾨뱶
- task蹂?理쒕? ?ъ떆???잛닔
- build, test, lint 紐낅졊 ?좏깮 湲곗?
- GPT 由щ럭??P1/P2/P3 ?먯젙 湲곗?
- ?먮룞 而ㅻ컠 ?덉슜 踰붿쐞? 釉뚮옖移??뺤콉
- ?ъ슜???쒕룄 ?먮뒗 沅뚰븳 ?쒗븳 諛쒖깮 ??蹂듦뎄 ?덉감
- 濡쒓렇 蹂댁〈 湲곌컙怨?誘쇨컧 ?뺣낫 湲곕줉 湲덉? 湲곗?
- ?щ엺??猷⑦봽瑜?以묒??섍굅???ш컻?섎뒗 諛⑸쾿

codex
이제 새 정책 문서 하나만 추가합니다. 변경 이유는 현재 task가 `.ai-dev` 운영 정책 문서 작성이며, 앱 런타임 코드나 저장 구조 변경이 범위 밖이기 때문입니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\codex-cli-automation-policy.md
diff --git a/.ai-dev/codex-cli-automation-policy.md b/.ai-dev/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..60761ee1e9d5a67db26e459df4b7a7e41f47d354
--- /dev/null
+++ b/.ai-dev/codex-cli-automation-policy.md
@@ -0,0 +1,106 @@
+# Codex CLI 완전 자동화 정책
+
+이 문서는 PlanPilot Local의 로컬 AI Dev Loop에서 Codex CLI 자동화를 사용할 때의 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건을 정
리한다. 자동화는 작은 task를 안전하게 끝내기 위한 보조 흐름이며, 저장소 규칙과 사용자 지시보다 우선하지 않는다.
+
+## 목적
+
+- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 기준으로 현재 task 하나만 구현, 검증, 리뷰, 기
록한다.
+- Codex CLI를 구현자와 리뷰어로 사용할 때 필요한 허용 조건과 중단 조건을 명확히 한다.
+- 자동화가 임의로 기능 범위, 파일 범위, 검증 범위를 넓히지 않도록 상태 파일에 근거를 남긴다.
+- 검증하지 않은 결과를 통과로 기록하지 않고, 사람이 이어서 판단할 수 있는 최소 정보를 남긴다.
+
+## 적용 범위
+
+이 정책은 현재 저장소 `D:\ai-apps\planpilot-local` 안에서 실행되는 로컬 AI Dev Loop에만 적용한다.
+
+적용 대상:
+
+- 현재 goal과 current task 분석
+- `current-task-prompt.md` 생성
+- Codex CLI 기반 현재 task 구현
+- 필요한 build, lint, test 또는 수동 검증 기록
+- diff 저장과 Codex CLI 리뷰
+- 리뷰 pass 이후 task 완료 처리와 필요한 경우 자동 커밋
+- 실패, 중단, 검증 결과를 `.ai-dev` 상태 파일에 기록하는 작업
+
+적용 제외:
+
+- 새 기능을 current task 밖으로 확장하는 작업
+- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
+- DB 삭제, 초기화, 복원, 계획 없는 migration
+- package 설치, package 파일 변경, lock file 변경
+- git push, PR 생성, 배포
+- 사용자 변경 사항 되돌리기
+
+## 작업 단위 기준
+
+- 한 번에 하나의 goal 안에서 하나의 current task만 처리한다.
+- 자동화는 `queue.json`의 current task 목적, scope, verification에 직접 필요한 파일만 수정한다.
+- 현재 task가 문서 작업이면 앱 런타임 코드와 저장 구조를 변경하지 않는다.
+- 현재 task가 앱 기능 작업이면 문서 보강, 리팩터링, 후속 개선을 임의로 함께 묶지 않는다.
+- 큰 변경이 필요하다고 판단되면 현재 task에서 확장하지 않고 별도 task로 분리하거나 중단한다.
+- `src/App.tsx`, `src/db.ts`, package 파일처럼 영향 범위가 큰 파일은 task 요구와 migration 계획이 명확할 때만 다룬다.
+
+## 자동 실행 허용 조건
+
+Codex CLI 자동화는 아래 조건이 충족될 때만 다음 단계로 진행한다.
+
+- 사용자 지시, `AGENTS.md`, 현재 task prompt가 서로 충돌하지 않는다.
+- 작업 경로가 이 저장소 루트이며, 허용된 파일 범위가 명확하다.
+- current task가 존재하고 상태가 `in_progress` 또는 실행 가능한 상태다.
+- 필요한 prompt 파일이 현재 goal과 current task 기준으로 생성되어 있다.
+- dirty worktree가 허용된 자동화 산출물 또는 명시적으로 허용된 변경에 한정된다.
+- build, lint, test, 리뷰, 커밋 같은 위험 단계는 해당 스크립트의 명시 옵션이 있을 때만 실행한다.
+- 자동 커밋은 검증 통과, 리뷰 pass, package 파일 미변경, task 범위 일치가 확인된 경우에만 허용한다.
+
+## 검증 기록 기준
+
+검증 결과는 실제로 수행한 항목만 기록한다.
+
+- build, lint, test를 실행했다면 명령, 결과, 실패 요약을 `.ai-dev/test-result.md`와 필요한 상태 필드에 남긴다.
+- 문서 작업처럼 명령 검증이 불필요하거나 허용되지 않은 경우에는 수동 검토 항목과 미실행 사유를 기록한다.
+- 리뷰를 수행했다면 decision, severity, summary, required changes, next step을 `.ai-dev/review.md`와 `sta
te.json`에 반영한다.
+- 실패한 검증을 통과로 기록하지 않는다.
+- 실행하지 않은 검증은 `미실행` 또는 `사람이 별도 실행`으로 명확히 남긴다.
+- 같은 실패가 반복되면 반복 횟수와 마지막 실패 요약을 `state.json` 또는 `loop-log.md`에 남긴다.
+
+## 상태 기록 기준
+
+자동화는 사람이 이어서 판단할 수 있도록 다음 정보를 남긴다.
+
+- `state.json`: 현재 goal/task, 마지막 명령, 명령 상태, 리뷰 decision, 검증 시각, 중단 사유, 반복 실패 횟수
+- `test-result.md`: 실제 검증 명령 또는 수동 검토 결과
+- `review.md`: Codex CLI 또는 수동 리뷰 결과
+- `loop-log.md`: task 진행, 완료, 중단, 실패, 커밋 결과의 시간 순서 요약
+- `diff.md`와 `review-prompt.md`: 리뷰에 필요한 경우에만 생성하며, 큰 diff나 민감 정보 포함 여부를 주의한다.
+
+상태 파일은 기존 형식과 의미를 유지한다. 자동화 편의를 위해 enum 값이나 JSON 구조를 임의로 바꾸지 않는다.
+
+## 중단 조건
+
+아래 조건 중 하나라도 발생하면 자동화는 다음 단계로 진행하지 않고 중단 사유를 기록한다.
+
+- 사용자 지시, 저장소 규칙, 현재 task 요구사항이 충돌한다.
+- 현재 task 범위 밖 파일 수정이 필요하다.
+- package 추가, package 파일 변경, lock file 변경이 필요하다.
+- DB schema 변경, 데이터 삭제, 복원, migration이 필요하다.
+- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, 리뷰 JSON 파싱 실패가 발생한다.
+- 예상하지 못한 사용자 변경이 작업 트리에 있다.
+- 같은 오류가 반복되어 현재 task 범위 안에서 안전하게 해결할 수 없다.
+- 민감 정보, 개인정보, 백업 데이터, API key가 diff나 prompt에 포함될 위험이 있다.
+- 네트워크, 권한, sandbox 제한 때문에 검증 또는 실행 결과를 신뢰할 수 없다.
+- 자동화가 현재 task 완료 기준을 판단할 근거를 충분히 확보하지 못했다.
+
+중단 시에는 수정 가능한 범위를 임의로 넓히지 않는다. 필요한 다음 결정, 실패한 단계, 사람이 확인할 파일을 기록하고 멈춘다.
+
+## 완료 기준
+
+현재 task는 아래 조건이 충족될 때 완료로 볼 수 있다.
+
+- current task의 성공 기준을 충족했다.
+- 변경 파일이 task 범위 안에 있다.
+- 필요한 검증 또는 수동 검토 결과가 기록됐다.
+- 리뷰가 필요한 경우 pass 또는 사람이 승인한 상태다.
+- 자동 커밋이 요구된 흐름에서는 커밋 hash가 상태에 기록됐다.
+- 자동 커밋이 요구되지 않은 흐름에서는 미커밋 상태와 후속 조치를 명확히 남겼다.
+- 다음 task로 넘어가도 되는지 여부가 `loop-log.md` 또는 최종 작업 요약에 기록됐다.

diff --git a/.ai-dev/codex-cli-automation-policy.md b/.ai-dev/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..60761ee1e9d5a67db26e459df4b7a7e41f47d354
--- /dev/null
+++ b/.ai-dev/codex-cli-automation-policy.md
@@ -0,0 +1,106 @@
+# Codex CLI 완전 자동화 정책
+
+이 문서는 PlanPilot Local의 로컬 AI Dev Loop에서 Codex CLI 자동화를 사용할 때의 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건을 정
리한다. 자동화는 작은 task를 안전하게 끝내기 위한 보조 흐름이며, 저장소 규칙과 사용자 지시보다 우선하지 않는다.
+
+## 목적
+
+- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 기준으로 현재 task 하나만 구현, 검증, 리뷰, 기
록한다.
+- Codex CLI를 구현자와 리뷰어로 사용할 때 필요한 허용 조건과 중단 조건을 명확히 한다.
+- 자동화가 임의로 기능 범위, 파일 범위, 검증 범위를 넓히지 않도록 상태 파일에 근거를 남긴다.
+- 검증하지 않은 결과를 통과로 기록하지 않고, 사람이 이어서 판단할 수 있는 최소 정보를 남긴다.
+
+## 적용 범위
+
+이 정책은 현재 저장소 `D:\ai-apps\planpilot-local` 안에서 실행되는 로컬 AI Dev Loop에만 적용한다.
+
+적용 대상:
+
+- 현재 goal과 current task 분석
+- `current-task-prompt.md` 생성
+- Codex CLI 기반 현재 task 구현
+- 필요한 build, lint, test 또는 수동 검증 기록
+- diff 저장과 Codex CLI 리뷰
+- 리뷰 pass 이후 task 완료 처리와 필요한 경우 자동 커밋
+- 실패, 중단, 검증 결과를 `.ai-dev` 상태 파일에 기록하는 작업
+
+적용 제외:
+
+- 새 기능을 current task 밖으로 확장하는 작업
+- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
+- DB 삭제, 초기화, 복원, 계획 없는 migration
+- package 설치, package 파일 변경, lock file 변경
+- git push, PR 생성, 배포
+- 사용자 변경 사항 되돌리기
+
+## 작업 단위 기준
+
+- 한 번에 하나의 goal 안에서 하나의 current task만 처리한다.
+- 자동화는 `queue.json`의 current task 목적, scope, verification에 직접 필요한 파일만 수정한다.
+- 현재 task가 문서 작업이면 앱 런타임 코드와 저장 구조를 변경하지 않는다.
+- 현재 task가 앱 기능 작업이면 문서 보강, 리팩터링, 후속 개선을 임의로 함께 묶지 않는다.
+- 큰 변경이 필요하다고 판단되면 현재 task에서 확장하지 않고 별도 task로 분리하거나 중단한다.
+- `src/App.tsx`, `src/db.ts`, package 파일처럼 영향 범위가 큰 파일은 task 요구와 migration 계획이 명확할 때만 다룬다.
+
+## 자동 실행 허용 조건
+
+Codex CLI 자동화는 아래 조건이 충족될 때만 다음 단계로 진행한다.
+
+- 사용자 지시, `AGENTS.md`, 현재 task prompt가 서로 충돌하지 않는다.
+- 작업 경로가 이 저장소 루트이며, 허용된 파일 범위가 명확하다.
+- current task가 존재하고 상태가 `in_progress` 또는 실행 가능한 상태다.
+- 필요한 prompt 파일이 현재 goal과 current task 기준으로 생성되어 있다.
+- dirty worktree가 허용된 자동화 산출물 또는 명시적으로 허용된 변경에 한정된다.
+- build, lint, test, 리뷰, 커밋 같은 위험 단계는 해당 스크립트의 명시 옵션이 있을 때만 실행한다.
+- 자동 커밋은 검증 통과, 리뷰 pass, package 파일 미변경, task 범위 일치가 확인된 경우에만 허용한다.
+
+## 검증 기록 기준
+
+검증 결과는 실제로 수행한 항목만 기록한다.
+
+- build, lint, test를 실행했다면 명령, 결과, 실패 요약을 `.ai-dev/test-result.md`와 필요한 상태 필드에 남긴다.
+- 문서 작업처럼 명령 검증이 불필요하거나 허용되지 않은 경우에는 수동 검토 항목과 미실행 사유를 기록한다.
+- 리뷰를 수행했다면 decision, severity, summary, required changes, next step을 `.ai-dev/review.md`와 `sta
te.json`에 반영한다.
+- 실패한 검증을 통과로 기록하지 않는다.
+- 실행하지 않은 검증은 `미실행` 또는 `사람이 별도 실행`으로 명확히 남긴다.
+- 같은 실패가 반복되면 반복 횟수와 마지막 실패 요약을 `state.json` 또는 `loop-log.md`에 남긴다.
+
+## 상태 기록 기준
+
+자동화는 사람이 이어서 판단할 수 있도록 다음 정보를 남긴다.
+
+- `state.json`: 현재 goal/task, 마지막 명령, 명령 상태, 리뷰 decision, 검증 시각, 중단 사유, 반복 실패 횟수
+- `test-result.md`: 실제 검증 명령 또는 수동 검토 결과
+- `review.md`: Codex CLI 또는 수동 리뷰 결과
+- `loop-log.md`: task 진행, 완료, 중단, 실패, 커밋 결과의 시간 순서 요약
+- `diff.md`와 `review-prompt.md`: 리뷰에 필요한 경우에만 생성하며, 큰 diff나 민감 정보 포함 여부를 주의한다.
+
+상태 파일은 기존 형식과 의미를 유지한다. 자동화 편의를 위해 enum 값이나 JSON 구조를 임의로 바꾸지 않는다.
+
+## 중단 조건
+
+아래 조건 중 하나라도 발생하면 자동화는 다음 단계로 진행하지 않고 중단 사유를 기록한다.
+
+- 사용자 지시, 저장소 규칙, 현재 task 요구사항이 충돌한다.
+- 현재 task 범위 밖 파일 수정이 필요하다.
+- package 추가, package 파일 변경, lock file 변경이 필요하다.
+- DB schema 변경, 데이터 삭제, 복원, migration이 필요하다.
+- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, 리뷰 JSON 파싱 실패가 발생한다.
+- 예상하지 못한 사용자 변경이 작업 트리에 있다.
+- 같은 오류가 반복되어 현재 task 범위 안에서 안전하게 해결할 수 없다.
+- 민감 정보, 개인정보, 백업 데이터, API key가 diff나 prompt에 포함될 위험이 있다.
+- 네트워크, 권한, sandbox 제한 때문에 검증 또는 실행 결과를 신뢰할 수 없다.
+- 자동화가 현재 task 완료 기준을 판단할 근거를 충분히 확보하지 못했다.
+
+중단 시에는 수정 가능한 범위를 임의로 넓히지 않는다. 필요한 다음 결정, 실패한 단계, 사람이 확인할 파일을 기록하고 멈춘다.
+
+## 완료 기준
+
+현재 task는 아래 조건이 충족될 때 완료로 볼 수 있다.
+
+- current task의 성공 기준을 충족했다.
+- 변경 파일이 task 범위 안에 있다.
+- 필요한 검증 또는 수동 검토 결과가 기록됐다.
+- 리뷰가 필요한 경우 pass 또는 사람이 승인한 상태다.
+- 자동 커밋이 요구된 흐름에서는 커밋 hash가 상태에 기록됐다.
+- 자동 커밋이 요구되지 않은 흐름에서는 미커밋 상태와 후속 조치를 명확히 남겼다.
+- 다음 task로 넘어가도 되는지 여부가 `loop-log.md` 또는 최종 작업 요약에 기록됐다.

codex
정책 문서 추가가 끝났습니다. 이제 문서에 필수 항목인 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건이 모두 들어갔는지 파일 내용 기준으로 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -Litera
lPath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\codex-cli-automation-policy.md' -Pattern '"'^## 목적
'"','"'^## 적용 범위'"','"'^## 작업 단위 기준'"','"'^## 검증 기록 기준'"','"'^## 중단 조건'"'" in D:\ai-apps\planpil
ot-local
 succeeded in 1410ms:

.ai-dev\codex-cli-automation-policy.md:5:## 목적
.ai-dev\codex-cli-automation-policy.md:12:## 적용 범위
.ai-dev\codex-cli-automation-policy.md:35:## 작업 단위 기준
.ai-dev\codex-cli-automation-policy.md:56:## 검증 기록 기준
.ai-dev\codex-cli-automation-policy.md:79:## 중단 조건



diff --git a/.ai-dev/codex-cli-automation-policy.md b/.ai-dev/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..60761ee1e9d5a67db26e459df4b7a7e41f47d354
--- /dev/null
+++ b/.ai-dev/codex-cli-automation-policy.md
@@ -0,0 +1,106 @@
+# Codex CLI 완전 자동화 정책
+
+이 문서는 PlanPilot Local의 로컬 AI Dev Loop에서 Codex CLI 자동화를 사용할 때의 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건을 정
리한다. 자동화는 작은 task를 안전하게 끝내기 위한 보조 흐름이며, 저장소 규칙과 사용자 지시보다 우선하지 않는다.
+
+## 목적
+
+- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 기준으로 현재 task 하나만 구현, 검증, 리뷰, 기
록한다.
+- Codex CLI를 구현자와 리뷰어로 사용할 때 필요한 허용 조건과 중단 조건을 명확히 한다.
+- 자동화가 임의로 기능 범위, 파일 범위, 검증 범위를 넓히지 않도록 상태 파일에 근거를 남긴다.
+- 검증하지 않은 결과를 통과로 기록하지 않고, 사람이 이어서 판단할 수 있는 최소 정보를 남긴다.
+
+## 적용 범위
+
+이 정책은 현재 저장소 `D:\ai-apps\planpilot-local` 안에서 실행되는 로컬 AI Dev Loop에만 적용한다.
+
+적용 대상:
+
+- 현재 goal과 current task 분석
+- `current-task-prompt.md` 생성
+- Codex CLI 기반 현재 task 구현
+- 필요한 build, lint, test 또는 수동 검증 기록
+- diff 저장과 Codex CLI 리뷰
+- 리뷰 pass 이후 task 완료 처리와 필요한 경우 자동 커밋
+- 실패, 중단, 검증 결과를 `.ai-dev` 상태 파일에 기록하는 작업
+
+적용 제외:
+
+- 새 기능을 current task 밖으로 확장하는 작업
+- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
+- DB 삭제, 초기화, 복원, 계획 없는 migration
+- package 설치, package 파일 변경, lock file 변경
+- git push, PR 생성, 배포
+- 사용자 변경 사항 되돌리기
+
+## 작업 단위 기준
+
+- 한 번에 하나의 goal 안에서 하나의 current task만 처리한다.
+- 자동화는 `queue.json`의 current task 목적, scope, verification에 직접 필요한 파일만 수정한다.
+- 현재 task가 문서 작업이면 앱 런타임 코드와 저장 구조를 변경하지 않는다.
+- 현재 task가 앱 기능 작업이면 문서 보강, 리팩터링, 후속 개선을 임의로 함께 묶지 않는다.
+- 큰 변경이 필요하다고 판단되면 현재 task에서 확장하지 않고 별도 task로 분리하거나 중단한다.
+- `src/App.tsx`, `src/db.ts`, package 파일처럼 영향 범위가 큰 파일은 task 요구와 migration 계획이 명확할 때만 다룬다.
+
+## 자동 실행 허용 조건
+
+Codex CLI 자동화는 아래 조건이 충족될 때만 다음 단계로 진행한다.
+
+- 사용자 지시, `AGENTS.md`, 현재 task prompt가 서로 충돌하지 않는다.
+- 작업 경로가 이 저장소 루트이며, 허용된 파일 범위가 명확하다.
+- current task가 존재하고 상태가 `in_progress` 또는 실행 가능한 상태다.
+- 필요한 prompt 파일이 현재 goal과 current task 기준으로 생성되어 있다.
+- dirty worktree가 허용된 자동화 산출물 또는 명시적으로 허용된 변경에 한정된다.
+- build, lint, test, 리뷰, 커밋 같은 위험 단계는 해당 스크립트의 명시 옵션이 있을 때만 실행한다.
+- 자동 커밋은 검증 통과, 리뷰 pass, package 파일 미변경, task 범위 일치가 확인된 경우에만 허용한다.
+
+## 검증 기록 기준
+
+검증 결과는 실제로 수행한 항목만 기록한다.
+
+- build, lint, test를 실행했다면 명령, 결과, 실패 요약을 `.ai-dev/test-result.md`와 필요한 상태 필드에 남긴다.
+- 문서 작업처럼 명령 검증이 불필요하거나 허용되지 않은 경우에는 수동 검토 항목과 미실행 사유를 기록한다.
+- 리뷰를 수행했다면 decision, severity, summary, required changes, next step을 `.ai-dev/review.md`와 `sta
te.json`에 반영한다.
+- 실패한 검증을 통과로 기록하지 않는다.
+- 실행하지 않은 검증은 `미실행` 또는 `사람이 별도 실행`으로 명확히 남긴다.
+- 같은 실패가 반복되면 반복 횟수와 마지막 실패 요약을 `state.json` 또는 `loop-log.md`에 남긴다.
+
+## 상태 기록 기준
+
+자동화는 사람이 이어서 판단할 수 있도록 다음 정보를 남긴다.
+
+- `state.json`: 현재 goal/task, 마지막 명령, 명령 상태, 리뷰 decision, 검증 시각, 중단 사유, 반복 실패 횟수
+- `test-result.md`: 실제 검증 명령 또는 수동 검토 결과
+- `review.md`: Codex CLI 또는 수동 리뷰 결과
+- `loop-log.md`: task 진행, 완료, 중단, 실패, 커밋 결과의 시간 순서 요약
+- `diff.md`와 `review-prompt.md`: 리뷰에 필요한 경우에만 생성하며, 큰 diff나 민감 정보 포함 여부를 주의한다.
+
+상태 파일은 기존 형식과 의미를 유지한다. 자동화 편의를 위해 enum 값이나 JSON 구조를 임의로 바꾸지 않는다.
+
+## 중단 조건
+
+아래 조건 중 하나라도 발생하면 자동화는 다음 단계로 진행하지 않고 중단 사유를 기록한다.
+
+- 사용자 지시, 저장소 규칙, 현재 task 요구사항이 충돌한다.
+- 현재 task 범위 밖 파일 수정이 필요하다.
+- package 추가, package 파일 변경, lock file 변경이 필요하다.
+- DB schema 변경, 데이터 삭제, 복원, migration이 필요하다.
+- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, 리뷰 JSON 파싱 실패가 발생한다.
+- 예상하지 못한 사용자 변경이 작업 트리에 있다.
+- 같은 오류가 반복되어 현재 task 범위 안에서 안전하게 해결할 수 없다.
+- 민감 정보, 개인정보, 백업 데이터, API key가 diff나 prompt에 포함될 위험이 있다.
+- 네트워크, 권한, sandbox 제한 때문에 검증 또는 실행 결과를 신뢰할 수 없다.
+- 자동화가 현재 task 완료 기준을 판단할 근거를 충분히 확보하지 못했다.
+
+중단 시에는 수정 가능한 범위를 임의로 넓히지 않는다. 필요한 다음 결정, 실패한 단계, 사람이 확인할 파일을 기록하고 멈춘다.
+
+## 완료 기준
+
+현재 task는 아래 조건이 충족될 때 완료로 볼 수 있다.
+
+- current task의 성공 기준을 충족했다.
+- 변경 파일이 task 범위 안에 있다.
+- 필요한 검증 또는 수동 검토 결과가 기록됐다.
+- 리뷰가 필요한 경우 pass 또는 사람이 승인한 상태다.
+- 자동 커밋이 요구된 흐름에서는 커밋 hash가 상태에 기록됐다.
+- 자동 커밋이 요구되지 않은 흐름에서는 미커밋 상태와 후속 조치를 명확히 남겼다.
+- 다음 task로 넘어가도 되는지 여부가 `loop-log.md` 또는 최종 작업 요약에 기록됐다.

codex
필수 섹션은 확인됐습니다. 마지막으로 작성된 문서를 한 번 더 읽어 범위 확장이나 금지된 실행을 유도하는 표현이 없는지 수동 검토하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\codex-cli-automation-policy.md'" in D:\ai-apps\planp
ilot-local
 succeeded in 1363ms:
# Codex CLI ?꾩쟾 ?먮룞???뺤콉

??臾몄꽌??PlanPilot Local??濡쒖뺄 AI Dev Loop?먯꽌 Codex CLI ?먮룞?붾? ?ъ슜???뚯쓽 紐⑹쟻, ?곸슜 踰붿쐞, ?묒뾽 ?⑥쐞, 寃利?
湲곕줉, 以묐떒 議곌굔???뺣━?쒕떎. ?먮룞?붾뒗 ?묒? task瑜??덉쟾?섍쾶 ?앸궡湲??꾪븳 蹂댁“ ?먮쫫?대ŉ, ??μ냼 洹쒖튃怨??ъ슜??吏?쒕낫???곗꽑?섏?
 ?딅뒗??

## 紐⑹쟻

- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`??湲곗??쇰줈 ?꾩옱 task ?섎굹留?援ы쁽, 寃利? 
由щ럭, 湲곕줉?쒕떎.
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
- `src/App.tsx`, `src/db.ts`, package ?뚯씪泥섎읆 ?곹뼢 踰붿쐞媛 ???뚯씪? task ?붽뎄? migration 怨꾪쉷??紐낇솗???뚮
쭔 ?ㅻ，??

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
- 由щ럭瑜??섑뻾?덈떎硫?decision, severity, summary, required changes, next step??`.ai-dev/review.md`? `
state.json`??諛섏쁺?쒕떎.
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

diff --git a/.ai-dev/codex-cli-automation-policy.md b/.ai-dev/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..60761ee1e9d5a67db26e459df4b7a7e41f47d354
--- /dev/null
+++ b/.ai-dev/codex-cli-automation-policy.md
@@ -0,0 +1,106 @@
+# Codex CLI 완전 자동화 정책
+
+이 문서는 PlanPilot Local의 로컬 AI Dev Loop에서 Codex CLI 자동화를 사용할 때의 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건을 정
리한다. 자동화는 작은 task를 안전하게 끝내기 위한 보조 흐름이며, 저장소 규칙과 사용자 지시보다 우선하지 않는다.
+
+## 목적
+
+- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 기준으로 현재 task 하나만 구현, 검증, 리뷰, 기
록한다.
+- Codex CLI를 구현자와 리뷰어로 사용할 때 필요한 허용 조건과 중단 조건을 명확히 한다.
+- 자동화가 임의로 기능 범위, 파일 범위, 검증 범위를 넓히지 않도록 상태 파일에 근거를 남긴다.
+- 검증하지 않은 결과를 통과로 기록하지 않고, 사람이 이어서 판단할 수 있는 최소 정보를 남긴다.
+
+## 적용 범위
+
+이 정책은 현재 저장소 `D:\ai-apps\planpilot-local` 안에서 실행되는 로컬 AI Dev Loop에만 적용한다.
+
+적용 대상:
+
+- 현재 goal과 current task 분석
+- `current-task-prompt.md` 생성
+- Codex CLI 기반 현재 task 구현
+- 필요한 build, lint, test 또는 수동 검증 기록
+- diff 저장과 Codex CLI 리뷰
+- 리뷰 pass 이후 task 완료 처리와 필요한 경우 자동 커밋
+- 실패, 중단, 검증 결과를 `.ai-dev` 상태 파일에 기록하는 작업
+
+적용 제외:
+
+- 새 기능을 current task 밖으로 확장하는 작업
+- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
+- DB 삭제, 초기화, 복원, 계획 없는 migration
+- package 설치, package 파일 변경, lock file 변경
+- git push, PR 생성, 배포
+- 사용자 변경 사항 되돌리기
+
+## 작업 단위 기준
+
+- 한 번에 하나의 goal 안에서 하나의 current task만 처리한다.
+- 자동화는 `queue.json`의 current task 목적, scope, verification에 직접 필요한 파일만 수정한다.
+- 현재 task가 문서 작업이면 앱 런타임 코드와 저장 구조를 변경하지 않는다.
+- 현재 task가 앱 기능 작업이면 문서 보강, 리팩터링, 후속 개선을 임의로 함께 묶지 않는다.
+- 큰 변경이 필요하다고 판단되면 현재 task에서 확장하지 않고 별도 task로 분리하거나 중단한다.
+- `src/App.tsx`, `src/db.ts`, package 파일처럼 영향 범위가 큰 파일은 task 요구와 migration 계획이 명확할 때만 다룬다.
+
+## 자동 실행 허용 조건
+
+Codex CLI 자동화는 아래 조건이 충족될 때만 다음 단계로 진행한다.
+
+- 사용자 지시, `AGENTS.md`, 현재 task prompt가 서로 충돌하지 않는다.
+- 작업 경로가 이 저장소 루트이며, 허용된 파일 범위가 명확하다.
+- current task가 존재하고 상태가 `in_progress` 또는 실행 가능한 상태다.
+- 필요한 prompt 파일이 현재 goal과 current task 기준으로 생성되어 있다.
+- dirty worktree가 허용된 자동화 산출물 또는 명시적으로 허용된 변경에 한정된다.
+- build, lint, test, 리뷰, 커밋 같은 위험 단계는 해당 스크립트의 명시 옵션이 있을 때만 실행한다.
+- 자동 커밋은 검증 통과, 리뷰 pass, package 파일 미변경, task 범위 일치가 확인된 경우에만 허용한다.
+
+## 검증 기록 기준
+
+검증 결과는 실제로 수행한 항목만 기록한다.
+
+- build, lint, test를 실행했다면 명령, 결과, 실패 요약을 `.ai-dev/test-result.md`와 필요한 상태 필드에 남긴다.
+- 문서 작업처럼 명령 검증이 불필요하거나 허용되지 않은 경우에는 수동 검토 항목과 미실행 사유를 기록한다.
+- 리뷰를 수행했다면 decision, severity, summary, required changes, next step을 `.ai-dev/review.md`와 `sta
te.json`에 반영한다.
+- 실패한 검증을 통과로 기록하지 않는다.
+- 실행하지 않은 검증은 `미실행` 또는 `사람이 별도 실행`으로 명확히 남긴다.
+- 같은 실패가 반복되면 반복 횟수와 마지막 실패 요약을 `state.json` 또는 `loop-log.md`에 남긴다.
+
+## 상태 기록 기준
+
+자동화는 사람이 이어서 판단할 수 있도록 다음 정보를 남긴다.
+
+- `state.json`: 현재 goal/task, 마지막 명령, 명령 상태, 리뷰 decision, 검증 시각, 중단 사유, 반복 실패 횟수
+- `test-result.md`: 실제 검증 명령 또는 수동 검토 결과
+- `review.md`: Codex CLI 또는 수동 리뷰 결과
+- `loop-log.md`: task 진행, 완료, 중단, 실패, 커밋 결과의 시간 순서 요약
+- `diff.md`와 `review-prompt.md`: 리뷰에 필요한 경우에만 생성하며, 큰 diff나 민감 정보 포함 여부를 주의한다.
+
+상태 파일은 기존 형식과 의미를 유지한다. 자동화 편의를 위해 enum 값이나 JSON 구조를 임의로 바꾸지 않는다.
+
+## 중단 조건
+
+아래 조건 중 하나라도 발생하면 자동화는 다음 단계로 진행하지 않고 중단 사유를 기록한다.
+
+- 사용자 지시, 저장소 규칙, 현재 task 요구사항이 충돌한다.
+- 현재 task 범위 밖 파일 수정이 필요하다.
+- package 추가, package 파일 변경, lock file 변경이 필요하다.
+- DB schema 변경, 데이터 삭제, 복원, migration이 필요하다.
+- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, 리뷰 JSON 파싱 실패가 발생한다.
+- 예상하지 못한 사용자 변경이 작업 트리에 있다.
+- 같은 오류가 반복되어 현재 task 범위 안에서 안전하게 해결할 수 없다.
+- 민감 정보, 개인정보, 백업 데이터, API key가 diff나 prompt에 포함될 위험이 있다.
+- 네트워크, 권한, sandbox 제한 때문에 검증 또는 실행 결과를 신뢰할 수 없다.
+- 자동화가 현재 task 완료 기준을 판단할 근거를 충분히 확보하지 못했다.
+
+중단 시에는 수정 가능한 범위를 임의로 넓히지 않는다. 필요한 다음 결정, 실패한 단계, 사람이 확인할 파일을 기록하고 멈춘다.
+
+## 완료 기준
+
+현재 task는 아래 조건이 충족될 때 완료로 볼 수 있다.
+
+- current task의 성공 기준을 충족했다.
+- 변경 파일이 task 범위 안에 있다.
+- 필요한 검증 또는 수동 검토 결과가 기록됐다.
+- 리뷰가 필요한 경우 pass 또는 사람이 승인한 상태다.
+- 자동 커밋이 요구된 흐름에서는 커밋 hash가 상태에 기록됐다.
+- 자동 커밋이 요구되지 않은 흐름에서는 미커밋 상태와 후속 조치를 명확히 남겼다.
+- 다음 task로 넘어가도 되는지 여부가 `loop-log.md` 또는 최종 작업 요약에 기록됐다.

codex
변경한 파일: [.ai-dev/codex-cli-automation-policy.md](D:/ai-apps/planpilot-local/.ai-dev/codex-cli-au
tomation-policy.md)

구현 요약: Codex CLI 완전 자동화 정책 문서를 새로 추가했습니다. 목적, 적용 범위, 작업 단위, 자동 실행 허용 조건, 검증 기록, 상태 기록, 중단 조건, 완료
 기준을 한국어로 정리했습니다. 문서 task라서 `src` 밖 `.ai-dev` 문서만 수정했고, 앱 런타임 코드와 저장 구조는 변경하지 않았습니다.

검증 방법: `Select-String`으로 필수 섹션인 `목적`, `적용 범위`, `작업 단위 기준`, `검증 기록 기준`, `중단 조건` 포함 여부를 확인했습니다. 문서
 내용을 수동 검토해 현재 저장소 규칙과 충돌하는 자동 실행, package 변경, DB 변경, 범위 확장 안내가 없도록 확인했습니다.

남은 위험: `npm run build`, `npm run lint`, `npm run test`는 문서 작업이고 프롬프트가 자동 실행을 지시하지 않아 실행하지 않았습니다.
 git 명령도 실행하지 않았습니다.

다음 task로 넘어가도 되는지: 가능합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 완료: .ai-dev/codex-cli-automation-policy.md를 추가해 Codex CLI 완전 자동화 정책의 목적, 적용 범위, 작업 단위, 검증 
기록, 상태 기록, 중단 조건, 완료 기준을 한국어로 문서화함. 앱 코드, 저장 구조, package 파일, git 작업은 변경하지 않음.`
diff --git a/.ai-dev/codex-cli-automation-policy.md b/.ai-dev/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..60761ee1e9d5a67db26e459df4b7a7e41f47d354
--- /dev/null
+++ b/.ai-dev/codex-cli-automation-policy.md
@@ -0,0 +1,106 @@
+# Codex CLI 완전 자동화 정책
+
+이 문서는 PlanPilot Local의 로컬 AI Dev Loop에서 Codex CLI 자동화를 사용할 때의 목적, 적용 범위, 작업 단위, 검증 기록, 중단 조건을 정
리한다. 자동화는 작은 task를 안전하게 끝내기 위한 보조 흐름이며, 저장소 규칙과 사용자 지시보다 우선하지 않는다.
+
+## 목적
+
+- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 기준으로 현재 task 하나만 구현, 검증, 리뷰, 기
록한다.
+- Codex CLI를 구현자와 리뷰어로 사용할 때 필요한 허용 조건과 중단 조건을 명확히 한다.
+- 자동화가 임의로 기능 범위, 파일 범위, 검증 범위를 넓히지 않도록 상태 파일에 근거를 남긴다.
+- 검증하지 않은 결과를 통과로 기록하지 않고, 사람이 이어서 판단할 수 있는 최소 정보를 남긴다.
+
+## 적용 범위
+
+이 정책은 현재 저장소 `D:\ai-apps\planpilot-local` 안에서 실행되는 로컬 AI Dev Loop에만 적용한다.
+
+적용 대상:
+
+- 현재 goal과 current task 분석
+- `current-task-prompt.md` 생성
+- Codex CLI 기반 현재 task 구현
+- 필요한 build, lint, test 또는 수동 검증 기록
+- diff 저장과 Codex CLI 리뷰
+- 리뷰 pass 이후 task 완료 처리와 필요한 경우 자동 커밋
+- 실패, 중단, 검증 결과를 `.ai-dev` 상태 파일에 기록하는 작업
+
+적용 제외:
+
+- 새 기능을 current task 밖으로 확장하는 작업
+- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
+- DB 삭제, 초기화, 복원, 계획 없는 migration
+- package 설치, package 파일 변경, lock file 변경
+- git push, PR 생성, 배포
+- 사용자 변경 사항 되돌리기
+
+## 작업 단위 기준
+
+- 한 번에 하나의 goal 안에서 하나의 current task만 처리한다.
+- 자동화는 `queue.json`의 current task 목적, scope, verification에 직접 필요한 파일만 수정한다.
+- 현재 task가 문서 작업이면 앱 런타임 코드와 저장 구조를 변경하지 않는다.
+- 현재 task가 앱 기능 작업이면 문서 보강, 리팩터링, 후속 개선을 임의로 함께 묶지 않는다.
+- 큰 변경이 필요하다고 판단되면 현재 task에서 확장하지 않고 별도 task로 분리하거나 중단한다.
+- `src/App.tsx`, `src/db.ts`, package 파일처럼 영향 범위가 큰 파일은 task 요구와 migration 계획이 명확할 때만 다룬다.
+
+## 자동 실행 허용 조건
+
+Codex CLI 자동화는 아래 조건이 충족될 때만 다음 단계로 진행한다.
+
+- 사용자 지시, `AGENTS.md`, 현재 task prompt가 서로 충돌하지 않는다.
+- 작업 경로가 이 저장소 루트이며, 허용된 파일 범위가 명확하다.
+- current task가 존재하고 상태가 `in_progress` 또는 실행 가능한 상태다.
+- 필요한 prompt 파일이 현재 goal과 current task 기준으로 생성되어 있다.
+- dirty worktree가 허용된 자동화 산출물 또는 명시적으로 허용된 변경에 한정된다.
+- build, lint, test, 리뷰, 커밋 같은 위험 단계는 해당 스크립트의 명시 옵션이 있을 때만 실행한다.
+- 자동 커밋은 검증 통과, 리뷰 pass, package 파일 미변경, task 범위 일치가 확인된 경우에만 허용한다.
+
+## 검증 기록 기준
+
+검증 결과는 실제로 수행한 항목만 기록한다.
+
+- build, lint, test를 실행했다면 명령, 결과, 실패 요약을 `.ai-dev/test-result.md`와 필요한 상태 필드에 남긴다.
+- 문서 작업처럼 명령 검증이 불필요하거나 허용되지 않은 경우에는 수동 검토 항목과 미실행 사유를 기록한다.
+- 리뷰를 수행했다면 decision, severity, summary, required changes, next step을 `.ai-dev/review.md`와 `sta
te.json`에 반영한다.
+- 실패한 검증을 통과로 기록하지 않는다.
+- 실행하지 않은 검증은 `미실행` 또는 `사람이 별도 실행`으로 명확히 남긴다.
+- 같은 실패가 반복되면 반복 횟수와 마지막 실패 요약을 `state.json` 또는 `loop-log.md`에 남긴다.
+
+## 상태 기록 기준
+
+자동화는 사람이 이어서 판단할 수 있도록 다음 정보를 남긴다.
+
+- `state.json`: 현재 goal/task, 마지막 명령, 명령 상태, 리뷰 decision, 검증 시각, 중단 사유, 반복 실패 횟수
+- `test-result.md`: 실제 검증 명령 또는 수동 검토 결과
+- `review.md`: Codex CLI 또는 수동 리뷰 결과
+- `loop-log.md`: task 진행, 완료, 중단, 실패, 커밋 결과의 시간 순서 요약
+- `diff.md`와 `review-prompt.md`: 리뷰에 필요한 경우에만 생성하며, 큰 diff나 민감 정보 포함 여부를 주의한다.
+
+상태 파일은 기존 형식과 의미를 유지한다. 자동화 편의를 위해 enum 값이나 JSON 구조를 임의로 바꾸지 않는다.
+
+## 중단 조건
+
+아래 조건 중 하나라도 발생하면 자동화는 다음 단계로 진행하지 않고 중단 사유를 기록한다.
+
+- 사용자 지시, 저장소 규칙, 현재 task 요구사항이 충돌한다.
+- 현재 task 범위 밖 파일 수정이 필요하다.
+- package 추가, package 파일 변경, lock file 변경이 필요하다.
+- DB schema 변경, 데이터 삭제, 복원, migration이 필요하다.
+- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, 리뷰 JSON 파싱 실패가 발생한다.
+- 예상하지 못한 사용자 변경이 작업 트리에 있다.
+- 같은 오류가 반복되어 현재 task 범위 안에서 안전하게 해결할 수 없다.
+- 민감 정보, 개인정보, 백업 데이터, API key가 diff나 prompt에 포함될 위험이 있다.
+- 네트워크, 권한, sandbox 제한 때문에 검증 또는 실행 결과를 신뢰할 수 없다.
+- 자동화가 현재 task 완료 기준을 판단할 근거를 충분히 확보하지 못했다.
+
+중단 시에는 수정 가능한 범위를 임의로 넓히지 않는다. 필요한 다음 결정, 실패한 단계, 사람이 확인할 파일을 기록하고 멈춘다.
+
+## 완료 기준
+
+현재 task는 아래 조건이 충족될 때 완료로 볼 수 있다.
+
+- current task의 성공 기준을 충족했다.
+- 변경 파일이 task 범위 안에 있다.
+- 필요한 검증 또는 수동 검토 결과가 기록됐다.
+- 리뷰가 필요한 경우 pass 또는 사람이 승인한 상태다.
+- 자동 커밋이 요구된 흐름에서는 커밋 hash가 상태에 기록됐다.
+- 자동 커밋이 요구되지 않은 흐름에서는 미커밋 상태와 후속 조치를 명확히 남겼다.
+- 다음 task로 넘어가도 되는지 여부가 `loop-log.md` 또는 최종 작업 요약에 기록됐다.

tokens used
66,145
변경한 파일: [.ai-dev/codex-cli-automation-policy.md](D:/ai-apps/planpilot-local/.ai-dev/codex-cli-automation-policy.md)

구현 요약: Codex CLI 완전 자동화 정책 문서를 새로 추가했습니다. 목적, 적용 범위, 작업 단위, 자동 실행 허용 조건, 검증 기록, 상태 기록, 중단 조건, 완료 기준을 한국어로 정리했습니다. 문서 task라서 `src` 밖 `.ai-dev` 문서만 수정했고, 앱 런타임 코드와 저장 구조는 변경하지 않았습니다.

검증 방법: `Select-String`으로 필수 섹션인 `목적`, `적용 범위`, `작업 단위 기준`, `검증 기록 기준`, `중단 조건` 포함 여부를 확인했습니다. 문서 내용을 수동 검토해 현재 저장소 규칙과 충돌하는 자동 실행, package 변경, DB 변경, 범위 확장 안내가 없도록 확인했습니다.

남은 위험: `npm run build`, `npm run lint`, `npm run test`는 문서 작업이고 프롬프트가 자동 실행을 지시하지 않아 실행하지 않았습니다. git 명령도 실행하지 않았습니다.

다음 task로 넘어가도 되는지: 가능합니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 완료: .ai-dev/codex-cli-automation-policy.md를 추가해 Codex CLI 완전 자동화 정책의 목적, 적용 범위, 작업 단위, 검증 기록, 상태 기록, 중단 조건, 완료 기준을 한국어로 문서화함. 앱 코드, 저장 구조, package 파일, git 작업은 변경하지 않음.`

```
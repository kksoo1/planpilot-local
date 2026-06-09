# Codex Implementation Result

## Run

- Started at: 2026-06-09 22:57:17
- Ended at: 2026-06-09 23:00:32
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
session id: 019eacac-5c99-7953-8b94-55b60b2b4afb
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev
\current-task-prompt.md
codex
지정된 작업 프롬프트를 먼저 읽고, 그 안의 범위와 제약을 확인한 뒤 필요한 파일만 추가로 살펴보겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1677ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# Goal

AI Dev Loop Codex CLI 완전 자동화 도입

## Background

Codex CLI를 사용해 AI Dev Loop의 구현, 검증, 리뷰, 커밋, task 완료 처리를 가능한 한 end-to-end로 자동화한다.

`current-task-prompt.md`를 Codex CLI에 전달해 코드 수정을 수행하고, `review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생
성한 뒤, `pass`, `revise`, `blocked` 결과에 따라 자동 분기한다.

초기 버전은 안전을 위해 `MaxTasks 1`, 명시적 Allow 옵션, git status clean 확인, package 변경 감지 중단, build 실패 시 commit 
금지 정책을 적용한다.

## Success Criteria

- Codex CLI 실행 정책이 문서화된다.
- `current-task-prompt.md`를 Codex CLI에 전달하는 `ai-dev-run-codex.ps1`이 추가된다.
- `review-prompt.md`를 Codex CLI에 전달하고 JSON 리뷰를 저장하는 `ai-dev-run-review-codex.ps1`이 추가된다.
- Codex 구현, build/check, diff, Codex 리뷰, save-review 흐름이 연결된다.
- pass 리뷰에서만 자동 커밋과 complete-task를 수행하는 full cycle 초안이 추가된다.
- git status가 dirty이면 Codex 실행을 중단한다.
- package.json 또는 package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build 실패 시 자동 커밋하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- PowerShell 문법 검증이 통과한다.
- 작은 앱 기능 task로 MaxTasks 1 end-to-end 검증이 가능하다.

## Constraints

- Codex CLI는 구현자와 리뷰어로 사용한다.
- GPT API 키 없이 진행한다.
- Cline은 삭제되어 사용하지 않는다.
- Copilot CLI와 gh는 현재 사용하지 않는다.
- 자동화는 명시적 Allow 옵션 없이는 위험한 단계를 실행하지 않는다.
- git status가 dirty이면 Codex 구현 실행을 기본 중단한다.
- package.json/package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
- build/check 실패 시 자동 커밋하지 않는다.
- git reset, git clean, npm install은 자동 실행하지 않는다.
- src 코드는 각 구현 task에서만 수정한다.

## Out of Scope

- GPT API 직접 호출
- Cline 사용
- Copilot CLI 사용
- gh 또는 GitHub PR 자동 연동
- git push 자동화
- git reset/git clean 같은 destructive git 명령
- npm install 자동 실행
- package 대량 교체
- DB 삭제, 초기화, 복원, 마이그레이션 자동화

## Manual Verification

- Codex CLI 실행 정책이 문서화되어 있다.
- Codex 구현 실행 스크립트가 DryRun과 dirty worktree 중단을 지원한다.
- Codex 리뷰 실행 스크립트가 JSON 리뷰를 저장하고 save-review 흐름과 연결된다.
- full auto-cycle DryRun이 전체 단계를 보여준다.
- full auto-cycle은 MaxTasks 1 제한과 Allow 옵션을 가진다.
- pass 리뷰가 아니면 자동 커밋하지 않는다.
- build 실패 시 자동 커밋하지 않는다.
- package 파일 변경 감지 시 자동 커밋하지 않는다.
- PowerShell 문법 검증이 통과한다.
- 작은 task로 MaxTasks 1 end-to-end 검증이 가능하다.


## Current Task

- Task ID: T007
- Title: 목표 입력 기반 자동 goal 실행 스크립트 추가
- Description: 사용자가 GoalTitle과 GoalDescription만 입력하면 Codex CLI를 이용해 goal/queue/state를 생성하고, current
-task-prompt 생성 후 auto-cycle-full을 실행할 수 있게 하는 ai-dev-auto-goal.ps1을 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- T005

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- scripts/ai-dev-auto-goal.ps1
- .ai-dev/README.md

## Verification

- DryRun에서 생성될 goal/task 계획과 실행 단계가 표시되는지 확인
- Json 출력이 가능한지 확인
- goal/queue/state JSON 파싱 검증을 수행하는지 확인
- auto-cycle-full 호출은 -AllowRun 또는 명시적 실행 옵션에서만 수행되는지 확인
- GoalTitle/GoalDescription이 비어 있으면 오류로 종료하는지 확인
- PowerShell 문법 검증

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
작업 범위는 `scripts/ai-dev-auto-goal.ps1` 추가와 `.ai-dev/README.md` 갱신입니다. 기존 자동화 스크립트의 옵션 이름과 JSON 파일 형식
을 맞춰야 하므로 관련 스크립트와 문서만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPa
th 'D:\\ai-apps\\planpilot-local\\scripts' | Select-Object -ExpandProperty Name" in D:\ai-apps\plan
pilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-ChildItem -LiteralPa
th 'D:\\ai-apps\\planpilot-local\\.ai-dev' | Select-Object -ExpandProperty Name" in D:\ai-apps\plan
pilot-local
 succeeded in 2705ms:
ai-dev-auto-cycle-full.ps1
ai-dev-auto-cycle.ps1
ai-dev-auto-goal.ps1
ai-dev-auto-step.ps1
ai-dev-check.ps1
ai-dev-commit.ps1
ai-dev-complete-task.ps1
ai-dev-copy-review-prompt.ps1
ai-dev-current-task.ps1
ai-dev-env.ps1
ai-dev-init.ps1
ai-dev-make-prompt.ps1
ai-dev-make-review-prompt.ps1
ai-dev-make-revise-prompt.ps1
ai-dev-manual-cycle.ps1
ai-dev-next.ps1
ai-dev-run-codex.ps1
ai-dev-run-review-codex.ps1
ai-dev-save-diff.ps1
ai-dev-save-review.ps1
ai-dev-status.ps1
monitor-and-dev-loop.ps1

 succeeded in 2803ms:
# PlanPilot Local AI 개발 입력 폴더

이 폴더는 PlanPilot Local의 Level 5 AI 자동 개발 루프에서 목표와 후속 작업 후보를 관리하기 위한 기본 공간이다.

현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex CLI 완전 자동화 실행기는 다음 목표에서 단계적으로 도입하며, 각 task 전
환 전에는 `goal.md`, `queue.json`, `state.json`을 확인한다.

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
- 현재 단계에서는 AI가 backlog에서 다음 목표를 자동 선택하지 않는다.
- 실행할 항목은 사용자가 검토한 뒤 `goal.md`로 옮긴다.

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

AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 사용자가 매번 `chcp 65001`을 직접 실
행할 필요는 없다.

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

`goal.md`, `queue.json`, `state.json`을 읽어 현재 task만 수행하도록 지시하는 `.ai-dev/current-task-prompt.md` 파일을 
생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
```

프롬프트 생성 스크립트는 기존 `current-task-prompt.md`를 현재 task 기준으로 덮어쓴다. Codex 실행, GPT 리뷰, build/test 실행, git 
commit은 수행하지 않는다.

기본 추가 지시 파일인 `.ai-dev/extra-instructions.md`가 있으면 해당 내용을 프롬프트 끝의 `Extra Instructions` 섹션에 포함한다. 이 파
일이 없으면 기존과 동일하게 goal, queue, state만 사용해 프롬프트를 생성한다.

다른 추가 지시 파일을 사용하려면 `-ExtraInstructionsPath`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1 -ExtraInstructionsPath .ai-
dev/extra-instructions.example.md
```

추가 지시는 goal, queue, state 내용을 덮어쓰지 않는다. `current-task-prompt.md`를 직접 수정하지 말고, 반복해서 필요한 보조 지시는 `.ai-
dev/extra-instructions.md` 또는 별도 파일에 작성한다.

## task 완료 처리

현재 task를 완료 처리하고 다음 pending task로 이동하려면 다음 명령을 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "T001 분석 완
료"
```

특정 task를 완료 처리하려면 `-TaskId`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -TaskId T001 -ResultSumma
ry "분석 완료"
```

다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoNext
```

task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, 
git commit은 수행하지 않는다.

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

T006 같은 최종 검증 task에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 결
과를 사람이 직접 수행했다면 수동 요약만 `test-result.md`에 기록할 수 있다. 이 모드는 npm build/test/lint를 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -ManualSummaryOnly -ManualSummary
 "PowerShell 문법 검증 통과. auto-step DryRun 통과. auto-cycle DryRun 통과. save-review 실패/성공 흐름 확인."
```

수동 요약 모드는 실제 명령 실행 결과를 조작하는 용도가 아니다. 실행하지 않은 검증은 통과로 적지 말고, 수행한 명령과 결과만 요약한다.

이 모드에서 `state.json`의 `lastCommandStatus`는 수동 요약 기록 작업의 성공 여부를 뜻한다. 실제 검증 통과/실패/미수행 판단은 `test-result
.md`의 요약 본문에 명확히 적는다.

## git diff 저장

현재 git 변경사항을 `diff.md`에 저장해 GPT 리뷰 또는 사람 검토에 사용할 수 있게 한다. 기본 동작은 untracked 파일명을 git status에 표시하지만 파
일 내용은 포함하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
```

추적되지 않은 작은 텍스트 파일의 내용도 포함하려면 `-IncludeUntrackedContent` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1 -IncludeUntrackedContent
```

git diff 저장 스크립트는 `diff.md`와 `state.json`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행하지 
않는다.

다음 생성 산출물은 자기 중첩과 과도한 크기 증가를 줄이기 위해 Unstaged/Staged Diff와 Diff Stat 대상에서 기본 제외한다. tracked 변경 파일은 `S
kipped Generated AI Dev Artifact Diffs` 섹션에 파일명만 기록한다. `-IncludeUntrackedContent`를 사용한 경우 untracked
 생성 산출물도 내용 포함에서 제외하고 `Skipped Generated AI Dev Artifacts` 섹션에 파일명만 기록한다.

- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/current-task-prompt.md`
- `.ai-dev/revise-prompt.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/review-response.json`

git diff/stat 명령의 stderr 경고는 diff 본문과 분리한다. git 명령이 실패하면 기존처럼 `state.json`에 실패 결과를 기록하고 종료한다.

`Git Status` 섹션에는 생성 산출물을 포함한 전체 변경 파일을 그대로 표시한다. `.ai-dev/README.md`, `scripts/ai-dev-save-diff.ps
1`처럼 실제 작업 대상 파일은 위 제외 목록에 없으므로 diff 본문에 포함된다.

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

GPT API 키가 없는 환경에서는 ChatGPT 웹 화면을 사용해 리뷰를 수동으로 진행한다. AI Dev Loop는 prompt 생성과 저장 흐름만 돕고, ChatGPT 웹 화
면에 자동 접속하거나 GPT API를 직접 호출하지 않는다.

기본 흐름:

1. `ai-dev-make-review-prompt.ps1 -Strict`로 `.ai-dev/review-prompt.md`를 생성한다.
2. `review-prompt.md` 내용을 클립보드에 복사한다.
3. 사용자가 ChatGPT 웹 화면에 직접 붙여넣는다.
4. ChatGPT가 JSON 리뷰만 출력하도록 한다.
5. 사용자가 JSON 리뷰를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`로 리뷰를 저장한다.
7. 저장된 decision에 따라 `pass`, `revise`, `blocked` 흐름을 계속 진행한다.

현재 task의 다음 단계에서는 `review-prompt.md` 클립보드 복사를 돕는 helper를 추가할 예정이다. 그 전까지는 파일 내용을 직접 복사하거나 운영 환경에 맞는
 안전한 방법으로 클립보드에 옮긴다.

`review-prompt.md`가 이미 있으면 다음 명령으로 내용을 클립보드에 복사한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
```

`review-prompt.md`가 없을 때 생성 후 복사하려면 `-GenerateIfMissing`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissing
```

엄격한 리뷰 프롬프트를 생성한 뒤 복사하려면 `-Strict`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissing -
Strict
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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-
response.json
```

JSON 문자열이나 클립보드 내용을 직접 사용할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewJson '{"decision":"p
ass","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_step":"
complete_task"}'
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

ChatGPT 웹 화면에서 받은 리뷰를 저장할 때는 JSON 리뷰 전체를 클립보드에 복사한 뒤 `-FromClipboard`를 실행한다. 순수 JSON 객체, `json` 코드블
록, 일반 텍스트 안에 포함된 첫 번째 JSON 객체를 최대한 파싱한다.

저장 실패 시 확인할 항목:

- 클립보드가 비어 있지 않은지 확인한다.
- ChatGPT 응답에서 JSON 객체 전체를 다시 복사한다.
- Markdown 코드블록을 포함해도 되지만, 가능하면 JSON만 복사한다.
- 오류 메시지의 입력 preview 앞부분을 보고 다른 설명 문장이나 잘린 JSON이 섞였는지 확인한다.

파싱 실패, 빈 입력, 필수 필드 누락 같은 입력 오류는 기본적으로 `review.md`와 `state.json`을 수정하지 않는다. review-prompt나 명령어를 실수로 
클립보드에 둔 상태에서 `-FromClipboard`를 실행해도 기존 리뷰 상태를 blocked/critical로 덮어쓰지 않기 위한 안전 동작이다.

실패 자체를 리뷰 결과로 기록해야 하는 특별한 경우에만 `-WriteFailureReview`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard -WriteFailur
eReview
```

잘못 실행했다면 ChatGPT가 출력한 JSON 리뷰만 다시 클립보드에 복사한 뒤 `-FromClipboard`를 재실행한다.

리뷰 결과 저장 스크립트는 `pass + complete_task`, `revise + revise_with_codex`, `blocked` 또는 `stop_for_user` 결
과에 맞는 다음 행동을 안내만 한다. GPT API 호출, Codex 실행, build/test 실행, git commit은 수행하지 않는다.

## 리뷰 반영 재수정 프롬프트 생성

`review.md`의 required changes를 반영하도록 Codex 또는 Cline에 전달할 `revise-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
```

optional suggestions도 현재 task 범위 안에서 반영할 수 있게 하려면 `-AllowOptionalSuggestions` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 -AllowOptionalSugges
tions
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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.ps1
,.ai-dev/README.md -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.ps1
,.ai-dev/README.md
```

커밋 메시지를 직접 지정하거나 검증·리뷰 게이트를 명시적으로 우회할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Message "chore(ai-dev): add aut
omation helpers"
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -AllowWithoutPassedCheck -AllowW
ithoutPassedReview
```

`-Files`를 지정하지 않으면 자동 커밋 스크립트는 기존처럼 `git add -A`로 현재 작업 트리의 모든 변경사항을 stage한다. `-Files`를 지정하면 각 파일이 
존재하고 변경사항이 있는지 확인한 뒤 `git add -- <files>`로 지정 파일만 stage한다. 선택 파일 외에 이미 staged 된 파일이 있으면 안전을 위해 중단한다
.

실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 수행하지 않는다.

## 실행 산출물 커밋 기준

AI Dev Loop의 실제 기능 변경과 `.ai-dev` 실행 상태는 가능한 한 별도 커밋으로 관리한다.

- 기능 커밋에는 현재 task의 코드와 직접 관련 문서만 포함한다.
- 루프 상태 커밋에는 필요할 때 `queue.json`, `state.json`, `loop-log.md`, `test-result.md`, `review.md` 등을 포함할 
수 있다.
- `diff.md`와 `review-prompt.md`는 커질 수 있으므로 항상 커밋하지 않는다.
- `review-response.json`은 민감 정보나 장문 내용이 포함될 수 있으므로 내용을 확인한 뒤 커밋 여부를 결정한다.
- untracked 텍스트 파일 내용은 리뷰에 필요할 수 있지만, 리뷰 포함 여부와 커밋 대상 여부는 별도로 판단한다.
- 대형 또는 민감 산출물은 정리하거나 별도 정책에 따라 제외한다.

커밋 전에는 `git status --short`와 `ai-dev-commit.ps1 -DryRun`으로 대상을 먼저 확인한다. 선택 파일 커밋 기능이 준비되면 전체 stage보
다 선택 파일 방식을 우선한다.

세부 기준은 `docs/ai-dev-loop-policy.md`의 `.ai-dev` 실행 산출물 커밋/무시 정책을 따른다. 실제 `.gitignore` 변경은 별도 task에서 
검토한다.

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

수동 사이클 안내 스크립트는 추천 명령과 파일 경로만 보여주며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 
않는다.

`manual-cycle`에서 다음 action이 `ask_gpt_review`로 표시되면 수동 리뷰 브리지를 사용한다. GPT API 키가 없어도 아래 흐름으로 리뷰를 진행할 
수 있다.

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

`ai-dev-auto-step.ps1`는 현재 상태를 보고 안전한 다음 한 단계만 실행하는 보조 스크립트로 도입할 예정이다. `ai-dev-next.ps1`처럼 안내만 하는 명
령과 달리, 허용된 로컬 스크립트는 직접 실행할 수 있다.

명령 선택 기준:

| 상황 | 사용할 명령 | 이유 |
| --- | --- | --- |
| 현재 상태와 다음 행동을 한 화면에서 보고 싶을 때 | `scripts/ai-dev-manual-cycle.ps1` | 상태 요약, 다음 action, 관련 파일 존재 여부를
 함께 보여주는 수동 운영 대시보드다. |
| 다음 action과 추천 명령만 확인하고 싶을 때 | `scripts/ai-dev-next.ps1` | 읽기/안내용 스크립트이며 하위 명령을 자동 실행하지 않는다. |
| 안전한 다음 한 단계만 자동으로 진행하고 싶을 때 | `scripts/ai-dev-auto-step.ps1` | `next` 판단 결과를 기반으로 허용된 로컬 스크립트만 한 
번 실행한다. |
| 여러 안전 단계를 제한 횟수 안에서 이어가고 싶을 때 | `scripts/ai-dev-auto-cycle.ps1` | auto-step 반복용이며 사용자 개입 필요 상태에서 
중단한다. |

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

첫 번째 명령으로 `review-prompt.md`를 클립보드에 복사한 뒤 ChatGPT 웹 화면에 붙여넣는다. ChatGPT가 JSON 리뷰만 출력하면 그 JSON을 다시 클립
보드에 복사하고 두 번째 명령으로 저장한다.

`ai-dev-auto-cycle.ps1`는 제한 횟수 안에서 auto-step을 반복하는 초기 자동화 스크립트다. 사용자 개입이 필요한 action, 실패, 반복 위험, com
mit 필요 상태에서는 중단한다.

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

auto-cycle은 Codex/Cline 작업, GPT 리뷰, revise, commit, blocked, 사용자 개입 필요 action에서 멈춘다. 무한 루프를 피하기 위해 
`-MaxSteps` 제한과 같은 action 반복 감지를 사용한다.

auto-cycle이 `ask_gpt_review`에서 멈추면 `stoppedReason`은 `user_intervention_required:ask_gpt_review`로 표시
된다. 이때 텍스트 출력과 JSON 출력의 step 항목에는 수동 리뷰 브리지 명령이 함께 표시된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

첫 번째 명령으로 `review-prompt.md`를 ChatGPT 웹 화면에 붙여넣을 수 있도록 복사하고, JSON 리뷰를 받은 뒤 두 번째 명령으로 클립보드의 리뷰 JSON을
 저장한다. auto-cycle은 이 단계에서 GPT API를 호출하지 않고 중단한다.

명령 역할 구분:

- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 출력한다. 자동 실행하지 않는다.
- `ai-dev-manual-cycle.ps1`: `status`와 `next`를 함께 보여주는 수동 운영 대시보드다. 자동 실행하지 않는다.
- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전한 action 한 단계만 자동 실행한다. 위험 action은 실행하지 않고 안내 후 중단한다
.
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
- `ask_gpt_review`: `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -FromClipboard`를 사용해 수
동 리뷰 브리지로 진행한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든다.
- `blocked`: 사용자 판단이 필요하므로 자동 진행을 멈춘다.
- `commit`: 자동 실행하지 않고 커밋 조건과 대상 파일을 사람이 확인한다.

`goal_completed` 상태에서 `auto-step`은 추가 작업을 실행하지 않고 현재 goal이 완료되었으며 더 실행할 task가 없다고 안내한다. 추천 명령에는 상태 
확인용 `ai-dev-status.ps1`만 포함한다.

`auto-cycle`이 `goal_completed`로 멈추면 텍스트 출력에서는 “목표 완료로 종료” 의미를 표시하고, JSON 출력에서는 `completed: true`, `
stoppedReason: "goal_completed"`를 유지한다. 다음 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-
dev/state.json`을 새 목표 기준으로 초기화한다.

`save-review` 실패는 잘못된 클립보드 입력 때문에 발생할 수 있다. 실패 시에는 오류 preview를 확인하고 JSON 리뷰만 다시 복사한다. 완료된 goal이나 기존
 정상 상태를 불필요하게 오염시키지 않도록 실패 기록 방식은 별도 정책에 따라 개선한다.

최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 결과를 `tes
t-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.

## Codex CLI 완전 자동화 준비

다음 자동화 단계에서는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI, `gh` 없이 Codex CLI만 사용한다.

현재 전제:

- `codex-cli 0.133.0` 사용 가능
- `codex exec` 동작 확인 완료
- approval: `never`
- sandbox: `workspace-write`
- workdir: `D:\ai-apps\planpilot-local`
- Cline은 삭제되어 사용하지 않음
- Copilot CLI와 `gh`는 현재 사용하지 않음

도입 예정 스크립트:

- `scripts/ai-dev-run-codex.ps1`: `.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 수행한다
.
- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 저
장 흐름에 연결한다.
- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저장, Codex 리뷰, save-review,
 pass 시 commit/complete-task를 연결한다.
- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입력하면 goal/queue/state 생성, cu
rrent-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.

초기 안전 기준:

- full cycle은 처음에 `MaxTasks 1` 중심으로 제한한다.
- Codex 구현 실행은 `AllowCodex`가 있을 때만 수행한다.
- Codex 리뷰 실행은 `AllowReviewCodex`가 있을 때만 수행한다.
- git commit은 `AllowCommit`이 있을 때만 수행한다.
- auto-goal에서 실제 full cycle 실행은 `AllowRun` 또는 명시적 실행 옵션이 있을 때만 수행한다.
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

`.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 실행한다. 실행 전 `git status --short`를 확인하고,
 작업 트리가 dirty이면 기본 중단한다. 단, dirty 파일이 `.ai-dev/current-task-prompt.md`뿐이면 프롬프트 생성 산출물로 보고 진행할 수 있다.

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

dirty worktree에서도 실행해야 하는 특별한 경우에만 `-AllowDirty`를 명시한다. 이 옵션은 사용자 변경과 Codex 변경이 섞일 수 있으므로 full cycl
e에서는 초기 기본값으로 사용하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty
```

이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, npm install, package 파
일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.

### Codex 리뷰 실행

`.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 `.ai-dev/review-response.json`에 저장한다. 실행 전
 `git status --short`를 확인하고, 작업 트리가 dirty이면 기본 중단한다. 리뷰 대상 변경사항이 남아 있는 상태에서 실행해야 하는 경우에만 `-AllowDir
ty`를 명시한다.

실행 예정 정보만 확인하려면 `-DryRun`을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun
```

기본 실행은 `codex exec`를 호출하고 stdout/stderr를 `.ai-dev/codex-review-result.md`에 저장한다. Codex 출력에서 첫 번째 유효
 JSON 리뷰 객체를 추출해 `.ai-dev/review-response.json`에 저장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1
```

`review-prompt.md`가 없을 때 자동 생성까지 허용하려면 `-GenerateReviewPromptIfMissing`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -GenerateReviewPromptI
fMissing
```

리뷰 JSON 저장 후 `ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json` 흐름까지 이어가려면 `-SaveRev
iew`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveRevie
w
```

자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun -Json
```

주의:

- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체만 출력하라는 안전 규칙을 추가한다.
- JSON 리뷰에는 `decision`, `severity`, `summary`, `required_changes`, `optional_suggestions`, `next_st
ep` 필드가 필요하다.
- JSON 추출에 실패하면 출력 preview를 보여주고 종료 코드 1로 종료한다.
- `-AllowDirty`는 구현 변경사항을 리뷰해야 할 때만 사용한다. 사용자 변경과 자동화 산출물이 섞여 있으면 리뷰 결과와 후속 저장 상태가 혼동될 수 있다.
- 이 스크립트는 git add, git commit, build/test/lint, GPT API 호출을 수행하지 않는다.

### full auto-cycle 초안

`ai-dev-auto-cycle-full.ps1`는 현재 task 기준으로 prompt 생성, Codex 구현, build check, diff 저장, strict review
 prompt 생성, Codex JSON 리뷰와 save-review, pass 리뷰 이후의 커밋과 task 완료 처리를 순서대로 연결하는 초안이다.

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

기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이다. `MaxTasks`가 1보다 크면 각
 task가 커밋과 complete-task까지 성공한 경우에만 다음 task로 반복한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -Ma
xSteps 20
```

여러 task 반복 구조를 확인하려면 `MaxTasks`를 늘릴 수 있다. 실제 반복은 각 task의 commit/complete-task가 성공해야 다음 task로 넘어간다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 3 -Ma
xSteps 20
```

`-AllowCodex` 없이 실제 실행하면 prompt 생성 이후 Codex 구현 실행 직전에서 중단하고 추천 명령을 출력한다. Codex 구현까지 허용하려면 명시적으로 `-A
llowCodex`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex
```

Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowReviewCodex`를 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -MaxTasks 1
```

리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 함께 지정한다. 커밋 메시지는 기본적으로 현재 t
ask의 `commitMessage`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -AllowCommit -MaxTasks 1
```

선택 파일만 커밋하려면 `-CommitFiles`를 지정한다. 이 값은 그대로 `ai-dev-commit.ps1 -Files`에 전달된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 1
```

최대 3개 task까지 연속 실행하려면 `MaxTasks 3`을 지정한다. complete-task가 queue/state/loop-log를 갱신하므로, 다음 task 구현 실행
 시 dirty worktree 정책을 별도로 판단해야 한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -AllowCommit -AllowDirty -MaxTasks 3
```

dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-cod
ex.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowRevie
wCodex -AllowDirty -MaxTasks 1
```

리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 complete
-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package-lo
ck.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 `com
mit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.

### 목표 입력 기반 자동 실행

최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게 하는 것이다.

먼저 DryRun으로 생성될 goal/task 계획과 실행 단계를 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 
추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun
```

자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다. JSON 출력은 사람이 읽는 텍스트와 섞지 않는다.
DryRun JSON에는 `plan.goalMarkdown`, `plan.queue`, `plan.state` 미리보기가 포함되므로 파일 작성 전에 생성될 goal/task 계획
을 검토할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 
추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun -Json
```

실제 goal/queue/state 생성과 current-task-prompt 생성까지만 수행하려면 `-DryRun`을 제거한다. 이 모드는 `ai-dev-auto-cycle-f
ull.ps1`을 호출하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 
추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다."
```

생성 후 full auto-cycle 래퍼 호출까지 이어가려면 `-AllowRun` 또는 `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit
` 같은 명시적 실행 옵션을 지정한다. `-AllowRun` 단독은 full-cycle 래퍼 호출만 허용하며 Codex 구현이나 Codex 리뷰 권한을 대신하지 않는다. 실제 구
현까지 허용하려면 `-AllowCodex`, 리뷰까지 허용하려면 `-AllowReviewCodex`, 자동 커밋과 task 완료까지 허용하려면 기존 full cycle과 동일하게
 `-AllowCodex -AllowReviewCodex -AllowCommit`을 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 
추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -Allow
Commit -MaxTasks 1
```

동작:

1. `GoalTitle`과 `GoalDescription`을 검증한다.
2. Codex CLI를 이용해 goal/queue/state 초안을 생성한다.
3. Codex 출력에서 `goalMarkdown`, `queue`, `state` JSON을 추출한다.
4. `queue.json`과 `state.json`의 필수 필드, currentTaskId, task 배열, enum 값을 검증한다.
5. `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 작성한다.
6. `.ai-dev/current-task-prompt.md`를 생성한다.
7. 명시적 실행 옵션이 있을 때만 `ai-dev-auto-cycle-full.ps1`로 이어간다.
8. auto-goal이 생성한 `.ai-dev/goal.md`, `queue.json`, `state.json`, `current-task-prompt.md`, 결과 파일 때문
에 하위 full cycle의 dirty worktree 게이트가 중단되지 않도록 내부적으로 `-AllowDirty`를 전달한다. 초기 dirty worktree 게이트는 aut
o-goal 시작 전에 별도로 유지한다.

안전 기준:

- `GoalTitle` 또는 `GoalDescription`이 비어 있으면 종료한다.
- DryRun에서는 생성될 goal/task 계획과 실행 단계만 표시하고 파일을 수정하지 않는다.
- Json 출력은 사람이 읽는 텍스트와 섞지 않는다.
- 생성된 goal/queue/state JSON 파싱 또는 필드 검증에 실패하면 파일 작성과 full cycle 실행으로 넘어가지 않는다.
- full cycle 호출은 `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit` 중 하나가 있을 때만 수행한다.
- `-AllowRun` 단독은 구현, 리뷰, 커밋을 수행한다는 의미가 아니다. 하위 full cycle은 여전히 `-AllowCodex`, `-AllowReviewCodex`,
 `-AllowCommit` 권한에 따라 각 위험 단계를 허용하거나 중단한다.
- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, dirty worktree 위험이 있으면 자동 커밋하지 않는다.
- `git reset`, `git clean`, `npm install`, `git push`는 실행하지 않는다.

## 운영 원칙

- 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
- 한 번에 하나의 task만 수행한다.
- task 단위로 구현, 검증, 리뷰, 커밋한다.
- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
- 검증하지 않은 결과를 통과로 기록하지 않는다.
- 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

## 다음 단계

실제 자동 개발 루프 실행기와 상태 갱신 로직은 별도 정책 검토 후 추가한다.

세부 기준은 `docs/ai-dev-loop-policy.md`를 따른다.

 succeeded in 2823ms:
backlog.md
codex-result.md
codex-review-result.md
current-task-prompt.md
diff.md
extra-instructions.example.md
goal.md
loop-log.md
plan.md
queue.example.json
queue.json
README.md
review-prompt.md
review-response.json
review.md
state.example.json
state.json
test-result.md

codex
`ai-dev-auto-goal.ps1` 파일이 이미 존재합니다. 새로 만들기보다 현재 구현이 T007 완료 기준을 충족하는지 확인하고, 부족한 부분만 좁게 수정하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-make-prompt.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 3092ms:
param(
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles
)

. $PSScriptRoot\ai-dev-env.ps1

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$reviewResponseRelativePath = ".ai-dev/review-response.json"
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath
$reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath

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

function Read-JsonFile {
    param(
        [string]$Path,
        [string]$RelativePath
    )

    try {
        return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json
    } catch {
        throw "$RelativePath JSON 파싱에 실패했습니다: $($_.Exception.Message)"
    }
}

function Get-CurrentTask {
    param(
        [object]$Queue,
        [object]$State
    )

    $tasks = @($Queue.tasks)
    $currentTaskId = $null

    if (Test-HasValue $State.currentTaskId) {
        $currentTaskId = [string]$State.currentTaskId
    } elseif (Test-HasValue $Queue.currentTaskId) {
        $currentTaskId = [string]$Queue.currentTaskId
    } else {
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -Fi
rst 1

        if ($null -ne $inProgressTask) {
            $currentTaskId = [string]$inProgressTask.id
        } else {
            $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First
 1

            if ($null -ne $pendingTask) {
                $currentTaskId = [string]$pendingTask.id
            }
        }
    }

    if (-not (Test-HasValue $currentTaskId)) {
        return $null
    }

    return $tasks | Where-Object { $_.id -eq $currentTaskId } | Select-Object -First 1
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [string]$Command,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        command = $Command
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
    }
}

function New-CycleResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
    }
}

function Write-CycleResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 20
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Command: $($step.command)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"

}

function Stop-Cycle {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    $result = New-CycleResult $Steps $StoppedReason $Completed $ExitCode
    Write-CycleResult $result
    exit $ExitCode
}

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: 하위 스크립트를
 실행하지 않았습니다."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "완료"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

    if ($exitCode -ne 0) {
        Stop-Cycle $script:steps "$Name`_failed" $false 1
    }
}

function Get-ScriptPath {
    param(
        [string]$Name
    )

    $scriptPath = Join-Path $PSScriptRoot $Name

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "필수 스크립트를 찾을 수 없습니다: scripts/$Name"
    }

    return $scriptPath
}

function Invoke-GitCapture {
    param(
        [string[]]$Arguments,
        [string]$DisplayName
    )

    $output = & git @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        throw "$DisplayName 실행에 실패했습니다. exit code: $exitCode`n$output"
    }

    return $output.TrimEnd()
}

function Test-PackageFileChanged {
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json
") "git status --porcelain -- package.json package-lock.json"
    return -not [string]::IsNullOrWhiteSpace($status)
}

function Get-ReviewGate {
    $state = Read-JsonFile $statePath $stateRelativePath
    $nextStep = $null

    if (Test-Path -LiteralPath $reviewResponsePath -PathType Leaf) {
        $reviewResponse = Read-JsonFile $reviewResponsePath $reviewResponseRelativePath

        if (Test-HasValue $reviewResponse.next_step) {
            $nextStep = [string]$reviewResponse.next_step
        }
    }

    return [PSCustomObject][ordered]@{
        lastCommandStatus = [string]$state.lastCommandStatus
        decision = [string]$state.lastReviewDecision
        nextStep = $nextStep
    }
}

function Get-CommitArguments {
    $arguments = @()

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not 
[string]::IsNullOrWhiteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-Files"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    return $arguments
}

function Get-CommitGate {
    $state = Read-JsonFile $statePath $stateRelativePath

    return [PSCustomObject][ordered]@{
        lastCommand = [string]$state.lastCommand
        lastCommandStatus = [string]$state.lastCommandStatus
        lastCommitHash = [string]$state.lastCommitHash
    }
}

Set-Location $repoRoot

$script:steps = @()

if ($MaxTasks -lt 1) {
    Stop-Cycle $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    Stop-Cycle $script:steps "max_steps_must_be_at_least_1" $false 1
}

try {
    foreach ($requiredPath in @($queuePath, $statePath)) {
        if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
            throw "필수 상태 파일이 없습니다: $requiredPath"
        }
    }

    $queue = Read-JsonFile $queuePath $queueRelativePath
    $state = Read-JsonFile $statePath $stateRelativePath

    if ($state.goalStatus -eq "completed") {
        Stop-Cycle $script:steps "goal_completed" $true 0
    }

    if (-not ($queue.PSObject.Properties.Name -contains "tasks") -or $null -eq $queue.tasks) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    $currentTask = Get-CurrentTask $queue $state

    if ($null -eq $currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($currentTask.status -eq "done") {
        Stop-Cycle $script:steps "current_task_done" $true 0
    }

    $scriptPaths = @{
        makePrompt = Get-ScriptPath "ai-dev-make-prompt.ps1"
        runCodex = Get-ScriptPath "ai-dev-run-codex.ps1"
        check = Get-ScriptPath "ai-dev-check.ps1"
        saveDiff = Get-ScriptPath "ai-dev-save-diff.ps1"
        makeReviewPrompt = Get-ScriptPath "ai-dev-make-review-prompt.ps1"
        runReviewCodex = Get-ScriptPath "ai-dev-run-review-codex.ps1"
        commit = Get-ScriptPath "ai-dev-commit.ps1"
        completeTask = Get-ScriptPath "ai-dev-complete-task.ps1"
    }
} catch {
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messa
ge
    Stop-Cycle $script:steps "prepare_failed" $false 1
}

$plannedSteps = @(
    "make-prompt",
    "run-codex",
    "check",
    "save-diff",
    "make-review-prompt",
    "run-review-codex",
    "review-gate",
    "package-change-gate",
    "commit",
    "commit-result-gate",
    "complete-task"
)

if ($plannedSteps.Count -gt $MaxSteps) {
    Stop-Cycle $script:steps "max_steps_too_small_for_full_cycle" $false 1
}

$stepNumber = 1
$completedTaskCount = 0

while ($completedTaskCount -lt $MaxTasks) {
    try {
        $queue = Read-JsonFile $queuePath $queueRelativePath
        $state = Read-JsonFile $statePath $stateRelativePath
        $currentTask = Get-CurrentTask $queue $state
    } catch {
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1 $_
.Exception.Message
        Stop-Cycle $script:steps "load_task_failed" $false 1
    }

    if ($state.goalStatus -eq "completed") {
        Stop-Cycle $script:steps "goal_completed" $true 0
    }

    if ($null -eq $currentTask) {
        Stop-Cycle $script:steps "no_task" $false 0
    }

    if ($currentTask.status -eq "done") {
        Stop-Cycle $script:steps "current_task_done" $true 0
    }

    $taskLabel = "$($currentTask.id) $($currentTask.title)"
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "
현재 task 실행 시작: $taskLabel"
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts
/ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
    $stepNumber++

    if (-not $AllowCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Al
lowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass
 -File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $comm
and"
        Stop-Cycle $script:steps "allow_codex_required" $false 1
    }

    $runCodexArguments = @()
    if ($AllowDirty) {
        $runCodexArguments += "-AllowDirty"
    }

    Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
    $stepNumber++

    Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-de
v-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
    $stepNumber++

    Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/a
i-dev-save-diff.ps1" $scriptPaths.saveDiff @()
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File 
scripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
    $stepNumber++

    if (-not $AllowReviewCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -Al
lowCodex -AllowReviewCodex -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $command = "$command -AllowDirty"
        }

        if ($AllowCommit) {
            $command = "$command -AllowCommit"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $command = "$command -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "run-review-codex" "powershell -ExecutionPolicy
 Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰
 실행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
        Stop-Cycle $script:steps "allow_review_codex_required" $false 1
    }

    Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File sc
ripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDir
ty", "-SaveReview")
    $stepNumber++

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fa
lse $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -
- package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCom
mitHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy By
pass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰
 pass, 자동 커밋 완료`"" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
        Stop-Cycle $script:steps "dry_run" $false 0
    }

    try {
        $reviewGate = Get-ReviewGate
    } catch {
        $script:steps += New-StepResult $stepNumber "review-gate" "state/review-response 확인" $false
 $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "review_gate_failed" $false 1
    }

    if ($reviewGate.lastCommandStatus -ne "passed") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $fal
se $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fa
lse $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
        Stop-Cycle $script:steps "review_not_pass" $false 0
    }

    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next
_step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($rev
iewGate.nextStep)"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false 
$false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
    $stepNumber++

    try {
        if (Test-PackageFileChanged) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcela
in -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동
 커밋하지 않습니다."
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -
- package.json package-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pa
ckage.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.p
s1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -F
ile scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments
    $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    if ($commitArguments.Count -gt 0) {
        $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
    }

    Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArgument
s
    $stepNumber++

    try {
        $commitGate = Get-CommitGate
    } catch {
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCom
mitHash 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
    }

    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -no
t (Test-HasValue $commitGate.lastCommitHash)) {
        $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastComma
nd), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHas
h)"
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCom
mitHash 확인" $false $true 1 $message
        Stop-Cycle $script:steps "commit_not_confirmed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitH
ash 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
    $stepNumber++

    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File scrip
ts/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`"" $scriptPaths.completeTask @("-Result
Summary", $resultSummary)
    $stepNumber++
    $completedTaskCount++
}

Stop-Cycle $script:steps "max_tasks_reached" $true 0

 succeeded in 3115ms:
param(
    [AllowEmptyString()]
    [string]$GoalTitle,
    [AllowEmptyString()]
    [string]$GoalDescription,
    [int]$MaxTasks = 1,
    [int]$MaxSteps = 20,
    [switch]$DryRun,
    [switch]$Json,
    [switch]$AllowRun,
    [switch]$AllowCodex,
    [switch]$AllowReviewCodex,
    [switch]$AllowCommit,
    [switch]$AllowDirty,
    [string[]]$CommitFiles,
    [string]$ResultPath = ".ai-dev/auto-goal-codex-result.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$codeFence = '```'
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"

function Resolve-RepoPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return Join-Path $repoRoot $Path
}

function ConvertTo-RepoRelativePath {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $Path))
    $rootWithSeparator = $repoRoot.TrimEnd("\") + "\"

    if ($fullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $fullPath.Substring($rootWithSeparator.Length).Replace("\", "/")
    }

    return $fullPath.Replace("\", "/")
}

function Test-HasValue {
    param([object]$Value)

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [string]) {
        return -not [string]::IsNullOrWhiteSpace($Value)
    }

    return $true
}

function New-StepResult {
    param(
        [int]$Step,
        [string]$Name,
        [string]$Command,
        [bool]$Executed,
        [bool]$Skipped,
        [int]$ExitCode,
        [string]$Message
    )

    return [PSCustomObject][ordered]@{
        step = $Step
        name = $Name
        command = $Command
        executed = $Executed
        skipped = $Skipped
        exitCode = $ExitCode
        message = $Message
    }
}

function New-AutoGoalResult {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    return [PSCustomObject][ordered]@{
        steps = @($Steps)
        stoppedReason = $StoppedReason
        completed = $Completed
        exitCode = $ExitCode
        plan = $script:autoGoalPlanPreview
        goalPath = $goalRelativePath
        queuePath = $queueRelativePath
        statePath = $stateRelativePath
        promptPath = $promptRelativePath
        resultPath = (ConvertTo-RepoRelativePath $ResultPath)
    }
}

function Write-AutoGoalResult {
    param([object]$Result)

    if ($Json) {
        $Result | ConvertTo-Json -Depth 30
        return
    }

    foreach ($step in @($Result.steps)) {
        Write-Host "Step $($step.step): $($step.name)"
        Write-Host "  Command: $($step.command)"
        Write-Host "  Executed: $($step.executed)"
        Write-Host "  Skipped: $($step.skipped)"
        Write-Host "  Exit code: $($step.exitCode)"
        Write-Host "  Message: $($step.message)"
    }

    if ($null -ne $Result.plan) {
        Write-Host "Plan preview:"
        Write-Host "  Goal title: $($Result.plan.queue.goalTitle)"
        Write-Host "  Current task id: $($Result.plan.queue.currentTaskId)"

        foreach ($task in @($Result.plan.queue.tasks)) {
            Write-Host "  Task $($task.id): $($task.title)"
            Write-Host "    Type: $($task.type)"
            Write-Host "    Status: $($task.status)"
            Write-Host "    Priority: $($task.priority)"
            Write-Host "    Likely files: $((@($task.filesLikelyToChange) -join ', '))"
            Write-Host "    Verification: $((@($task.verification) -join ' / '))"
        }
    }

    Write-Host "Stopped reason: $($Result.stoppedReason)"
    Write-Host "Completed: $($Result.completed)"
    Write-Host "Exit code: $($Result.exitCode)"
}

function Stop-AutoGoal {
    param(
        [object[]]$Steps,
        [string]$StoppedReason,
        [bool]$Completed,
        [int]$ExitCode
    )

    Write-AutoGoalResult (New-AutoGoalResult $Steps $StoppedReason $Completed $ExitCode)
    exit $ExitCode
}

function Get-InputPreview {
    param([string]$RawInput)

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

function Get-GitStatusLines {
    $statusOutput = & git status --short 2>&1

    if ($LASTEXITCODE -ne 0) {
        $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 
1 "git status failed: $($statusOutput -join "`n")"
        Stop-AutoGoal $script:steps "git_status_failed" $false 1
    }

    return @($statusOutput | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-JsonObjectCandidates {
    param([string]$RawInput)

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

function Get-QueueValidationErrors {
    param([object]$Queue)

    $errors = @()
    $requiredFields = @("goalTitle", "goalSource", "createdAt", "updatedAt", "currentTaskId", "task
s")

    foreach ($field in @(Get-MissingFields $Queue $requiredFields)) {
        $errors += "queue missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Queue.goalTitle)) {
        $errors += "queue.goalTitle must not be empty."
    }

    if ($Queue.goalSource -ne $goalRelativePath) {
        $errors += "queue.goalSource must be $goalRelativePath."
    }

    if ($Queue.tasks -isnot [System.Collections.IEnumerable] -or $Queue.tasks -is [string]) {
        $errors += "queue.tasks must be an array."
        return $errors
    }

    $tasks = @($Queue.tasks)

    if ($tasks.Count -lt 1) {
        $errors += "queue.tasks must contain at least one task."
        return $errors
    }

    if ($tasks.Count -gt 3) {
        $errors += "queue.tasks must contain no more than three tasks."
    }

    $taskIds = @()

    foreach ($task in $tasks) {
        $taskRequiredFields = @("id", "title", "description", "type", "status", "priority", "depend
sOn", "filesLikelyToChange", "verification", "commitMessage")
        $taskMissingFields = @(Get-MissingFields $task $taskRequiredFields)

        foreach ($field in $taskMissingFields) {
            $errors += "task missing field: $field"
        }

        if ($taskMissingFields.Count -gt 0) {
            continue
        }

        if (-not (Test-HasValue $task.id)) {
            $errors += "task.id must not be empty."
        } else {
            $taskIds += [string]$task.id
        }

        if (-not (Test-HasValue $task.title)) {
            $errors += "task.title must not be empty."
        }

        if (-not (Test-HasValue $task.description)) {
            $errors += "task.description must not be empty."
        }

        if (@("analysis", "implementation", "documentation", "verification") -notcontains $task.typ
e) {
            $errors += "invalid task.type: $($task.type)"
        }

        if (@("pending", "in_progress", "done", "blocked") -notcontains $task.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $task.dependsOn -is [string
]) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerable] -or $task.filesLikely
ToChange -is [string]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or $task.verification -is [
string]) {
            $errors += "task.verification must be an array: $($task.id)"
        }
    }

    if ((@($tasks | Where-Object { $_.status -eq "in_progress" })).Count -ne 1) {
        $errors += "queue.tasks must contain exactly one in_progress task."
    }

    if (-not (Test-HasValue $Queue.currentTaskId)) {
        $errors += "queue.currentTaskId must not be empty."
    } elseif ($taskIds -notcontains [string]$Queue.currentTaskId) {
        $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
    }

    return $errors
}

function Get-StateValidationErrors {
    param(
        [object]$State,
        [object]$Queue
    )

    $errors = @()
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxLoopsPerTask", "repeatedF
ailureCount", "lastCommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDecision", "lastRe
viewSeverity", "lastCommitHash", "startedAt", "updatedAt", "stopReason")

    foreach ($field in @(Get-MissingFields $State $requiredFields)) {
        $errors += "state missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("idle", "in_progress", "completed", "blocked") -notcontains $State.goalStatus) {
        $errors += "invalid state.goalStatus: $($State.goalStatus)"
    }

    if ($State.currentTaskId -ne $Queue.currentTaskId) {
        $errors += "state.currentTaskId must match queue.currentTaskId."
    }

    if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
        $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
    }

    if (@("not_started", "pass", "revise", "blocked") -notcontains $State.lastReviewDecision) {
        $errors += "invalid state.lastReviewDecision: $($State.lastReviewDecision)"
    }

    return $errors
}

function Get-AutoGoalValidationErrors {
    param([object]$Plan)

    $errors = @()

    foreach ($field in @(Get-MissingFields $Plan @("goalMarkdown", "queue", "state"))) {
        $errors += "plan missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Plan.goalMarkdown)) {
        $errors += "goalMarkdown must not be empty."
    }

    $errors += @(Get-QueueValidationErrors $Plan.queue)
    $errors += @(Get-StateValidationErrors $Plan.state $Plan.queue)

    return $errors
}

function New-DryRunAutoGoalPlan {
    param(
        [string]$Title,
        [string]$Description
    )

    $now = (Get-Date).ToUniversalTime().ToString("o")
    $safeCommitTitle = $Title.Trim()

    $plan = [PSCustomObject][ordered]@{
        goalMarkdown = @"
# 紐⑺몴

$safeCommitTitle

## 諛곌꼍

$($Description.Trim())

## ?깃났 湲곗?

- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.

## ?쒖빟?ы빆

- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??

## ?쒖쇅 踰붿쐞

- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅

## ?섎룞 ?뺤씤

- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
"@
        queue = [PSCustomObject][ordered]@{
            goalTitle = $safeCommitTitle
            goalSource = $goalRelativePath
            createdAt = $now
            updatedAt = $now
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = $safeCommitTitle
                    description = $Description.Trim()
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @()
                    verification = @(
                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
                    )
                    commitMessage = $null
                }
            )
        }
        state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastCommitHash = $null
            startedAt = $now
            updatedAt = $now
            stopReason = $null
        }
    }

    $plan.goalMarkdown = @"
# 紐⑺몴

$safeCommitTitle

## 諛곌꼍

$($Description.Trim())

## ?깃났 湲곗?

- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.

## ?쒖빟?ы빆

- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??

## ?쒖쇅 踰붿쐞

- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅

## ?섎룞 ?뺤씤

- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
"@

    $dryRunTask = @($plan.queue.tasks)[0]
    $dryRunTask.verification = @(
        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
    )

    return $plan
}

function ConvertFrom-CodexAutoGoalOutput {
    param([string]$RawInput)

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            if (@(Get-AutoGoalValidationErrors $parsed).Count -gt 0) {
                continue
            }

            return [PSCustomObject]@{
                Parsed = $parsed
                JsonText = ($parsed | ConvertTo-Json -Depth 30)
            }
        } catch {
        }
    }

    throw "No valid auto-goal JSON object was found in Codex output."
}

function New-CodexAutoGoalPrompt {
    param(
        [string]$Title,
        [string]$Description
    )

    return @"
You are preparing local AI Dev Loop state files for the repository at $repoRoot.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: $Title
Description: $Description

Create a small, safe goal plan for this repository. The response object must have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증" 섹
션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyToCh
ange, verification, commitMessage.
- type must be one of analysis, implementation, documentation, verification.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB de
letion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.
"@
}

function Invoke-CycleCommand {
    param(
        [int]$StepNumber,
        [string]$Name,
        [string]$Command,
        [string]$ScriptPath,
        [string[]]$Arguments
    )

    if ($DryRun) {
        $script:steps += New-StepResult $StepNumber $Name $Command $false $true 0 "DryRun: child sc
ript was not executed."
        return
    }

    $output = & powershell -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $message = $output.Trim()

    if ([string]::IsNullOrWhiteSpace($message)) {
        $message = "completed"
    }

    $script:steps += New-StepResult $StepNumber $Name $Command $true $false $exitCode $message

    if ($exitCode -ne 0) {
        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
    }
}

function Get-FullCycleArguments {
    $arguments = @("-MaxTasks", ([string]$MaxTasks), "-MaxSteps", ([string]$MaxSteps))

    if ($AllowCodex) {
        $arguments += "-AllowCodex"
    }

    if ($AllowReviewCodex) {
        $arguments += "-AllowReviewCodex"
    }

    if ($AllowCommit) {
        $arguments += "-AllowCommit"
    }

    # auto-goal writes goal/queue/state/current prompt/result files after the initial dirty gate.
    # The downstream full cycle must tolerate those intended artifacts.
    $arguments += "-AllowDirty"

    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not 
[string]::IsNullOrWhiteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-CommitFiles"
            $arguments += ($normalizedFiles -join ",")
        }
    }

    return $arguments
}

Set-Location $repoRoot

$script:steps = @()
$script:autoGoalPlanPreview = $null
$resolvedGoalPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $goalRelativePath))
$resolvedQueuePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $queueRelativePath))
$resolvedStatePath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $stateRelativePath))
$resolvedResultPath = [System.IO.Path]::GetFullPath((Resolve-RepoPath $ResultPath))

if (-not (Test-HasValue $GoalTitle)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalTitle" $false $false 1 "GoalTitle
 must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_title" $false 1
}

if (-not (Test-HasValue $GoalDescription)) {
    $script:steps += New-StepResult 0 "validate-input" "check GoalDescription" $false $false 1 "Goa
lDescription must not be empty."
    Stop-AutoGoal $script:steps "invalid_goal_description" $false 1
}

if ($MaxTasks -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxTasks" $false $false 1 "MaxTasks m
ust be at least 1."
    Stop-AutoGoal $script:steps "max_tasks_must_be_at_least_1" $false 1
}

if ($MaxSteps -lt 1) {
    $script:steps += New-StepResult 0 "validate-input" "check MaxSteps" $false $false 1 "MaxSteps m
ust be at least 1."
    Stop-AutoGoal $script:steps "max_steps_must_be_at_least_1" $false 1
}

$makePromptPath = Join-Path $PSScriptRoot "ai-dev-make-prompt.ps1"
$autoCycleFullPath = Join-Path $PSScriptRoot "ai-dev-auto-cycle-full.ps1"

foreach ($requiredScript in @($makePromptPath, $autoCycleFullPath)) {
    if (-not (Test-Path -LiteralPath $requiredScript -PathType Leaf)) {
        $script:steps += New-StepResult 0 "prepare" "check required scripts" $false $false 1 "Missi
ng required script: $requiredScript"
        Stop-AutoGoal $script:steps "prepare_failed" $false 1
    }
}

$shouldRunFullCycle = [bool]($AllowRun -or $AllowCodex -or $AllowReviewCodex -or $AllowCommit)
$fullCycleArguments = @(Get-FullCycleArguments)
$fullCycleCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps
1 $($fullCycleArguments -join ' ')".Trim()

$script:steps += New-StepResult 1 "validate-input" "check GoalTitle/GoalDescription" $false $false 
0 "Input validation completed: $GoalTitle"

if ($DryRun) {
    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTitle.Trim() $GoalDescription.Trim()
    $previewValidationErrors = @(Get-AutoGoalValidationErrors $script:autoGoalPlanPreview)

    if ($previewValidationErrors.Count -gt 0) {
        $script:steps += New-StepResult 2 "preview-plan" "local dry-run plan preview" $false $false
 1 "DryRun preview plan validation failed: $($previewValidationErrors -join '; ')"
        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $false 1
    }

    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 0 "Dr
yRun: dirty worktree gate was not executed."
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $
true 0 "DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: $GoalTitle
"
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" 
$false $true 0 "DryRun: preview goal/queue/state plan passed local schema validation."
    $script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $
stateRelativePath" $false $true 0 "DryRun: state files were not written."
    $script:steps += New-StepResult 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scrip
ts/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: current-task-prompt.md was not generated."

    if ($shouldRunFullCycle) {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "D
ryRun: explicit run option is present, but full cycle was not executed. -AllowRun only invokes the 
full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    } else {
        $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "D
ryRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full
-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
    }

    Stop-AutoGoal $script:steps "dry_run" $false 0
}

$statusLines = @(Get-GitStatusLines)

if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
    $dirtyText = ($statusLines -join "`n")
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $true 1 "Wo
rktree is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
}

if ($statusLines.Count -gt 0) {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "A
llowDirty is set. DirtyCount: $($statusLines.Count)"
} else {
    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git status --short" $false $false 0 "W
orktree is clean."
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $false $
false 1 "Codex CLI was not found."
    Stop-AutoGoal $script:steps "codex_not_found" $false 1
}

$plannerPrompt = New-CodexAutoGoalPrompt $GoalTitle.Trim() $GoalDescription.Trim()
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$codexOutput = & codex exec $plannerPrompt 2>&1 | Out-String
$codexExitCode = $LASTEXITCODE
$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$resultContent = @"
# Codex Auto Goal Result

## Run

- Started at: $startedAt
- Ended at: $endedAt
- Exit code: $codexExitCode
- Goal title: $($GoalTitle.Trim())
- Command: codex exec <auto-goal planning prompt>

## Output

${codeFence}text
$codexOutput
$codeFence
"@

[System.IO.File]::WriteAllText($resolvedResultPath, $resultContent, $utf8WithBom)

if ($codexExitCode -ne 0) {
    $script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $f
alse 1 "Codex goal planning failed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"
    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
}

$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-goal planning prompt>" $true $false
 0 "Codex goal planning completed. Result: $(ConvertTo-RepoRelativePath $ResultPath)"

try {
    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
} catch {
    $preview = Get-InputPreview $codexOutput
    $script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" 
$false $false 1 "Codex plan JSON extraction failed: $($_.Exception.Message) Output preview: $previe
w"
    Stop-AutoGoal $script:steps "generated_json_invalid" $false 1
}

$script:steps += New-StepResult 4 "validate-generated-json" "goal/queue/state JSON validation" $fal
se $false 0 "goalMarkdown, queue, and state JSON validation completed. currentTaskId: $($autoGoalPl
an.Parsed.queue.currentTaskId)"
$script:autoGoalPlanPreview = $autoGoalPlan.Parsed

$goalMarkdown = [string]$autoGoalPlan.Parsed.goalMarkdown
$queueJson = $autoGoalPlan.Parsed.queue | ConvertTo-Json -Depth 30
$stateJson = $autoGoalPlan.Parsed.state | ConvertTo-Json -Depth 30

[System.IO.File]::WriteAllText($resolvedGoalPath, $goalMarkdown, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedQueuePath, $queueJson, $utf8WithBom)
[System.IO.File]::WriteAllText($resolvedStatePath, $stateJson, $utf8WithBom)

$script:steps += New-StepResult 5 "write-state-files" "$goalRelativePath, $queueRelativePath, $stat
eRelativePath" $true $false 0 "New goal, queue, and state files were written."

Invoke-CycleCommand 6 "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-p
rompt.ps1" $makePromptPath @()

if (-not $shouldRunFullCycle) {
    $script:steps += New-StepResult 7 "auto-cycle-full" $fullCycleCommandText $false $true 0 "Full 
cycle requires -AllowRun or explicit execution options. -AllowRun only invokes the full-cycle wrapp
er; implementation and review still require -AllowCodex and -AllowReviewCodex."
    Stop-AutoGoal $script:steps "prepared_without_full_cycle" $true 0
}

Invoke-CycleCommand 7 "auto-cycle-full" $fullCycleCommandText $autoCycleFullPath $fullCycleArgument
s

Stop-AutoGoal $script:steps "completed" $true 0


 succeeded in 3198ms:
param(
    [string]$ExtraInstructionsPath = ".ai-dev/extra-instructions.md"
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$goalRelativePath = ".ai-dev/goal.md"
$queueRelativePath = ".ai-dev/queue.json"
$stateRelativePath = ".ai-dev/state.json"
$promptRelativePath = ".ai-dev/current-task-prompt.md"

$goalPath = Join-Path $projectRoot $goalRelativePath
$queuePath = Join-Path $projectRoot $queueRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$promptPath = Join-Path $projectRoot $promptRelativePath

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

foreach ($requiredPath in @($goalRelativePath, $queueRelativePath, $stateRelativePath)) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$goalContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $goalPath
$queue = Read-JsonFile $queuePath $queueRelativePath
$state = Read-JsonFile $statePath $stateRelativePath

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
    $pendingTask = $tasks | Where-Object { $_.status -eq "pending" } | Select-Object -First 1

    if ($null -ne $pendingTask) {
        $currentTaskId = [string]$pendingTask.id
    }
}

if (-not (Test-HasValue $currentTaskId)) {
    Stop-WithError "수행할 task가 없습니다."
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
    "filesLikelyToChange",
    "verification"
)

Stop-ForMissingFields "task $currentTaskId" (Get-MissingFields $currentTask $taskRequiredFields)

$dependsOnText = Convert-ToMarkdownList $currentTask.dependsOn
$likelyFilesText = Convert-ToMarkdownList $currentTask.filesLikelyToChange
$verificationText = Convert-ToMarkdownList $currentTask.verification
$extraInstructionsContent = $null

if (-not [string]::IsNullOrWhiteSpace($ExtraInstructionsPath)) {
    $resolvedExtraInstructionsPath = if ([System.IO.Path]::IsPathRooted($ExtraInstructionsPath)) {
        $ExtraInstructionsPath
    } else {
        Join-Path $projectRoot $ExtraInstructionsPath
    }

    if (Test-Path -LiteralPath $resolvedExtraInstructionsPath -PathType Leaf) {
        $extraInstructionsContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $resolvedExtraInst
ructionsPath
    }
}

$promptContent = @"
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

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

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

$likelyFilesText

## Verification

$verificationText

- 필요한 경우 ``npm run build``는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- ``.ai-dev/loop-log.md``에 기록할 작업 요약

## Hard Rules

- ``src`` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- ``package.json``과 ``package-lock.json``은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
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
"@

if (-not [string]::IsNullOrWhiteSpace($extraInstructionsContent)) {
    $promptContent += @"


## Extra Instructions

$extraInstructionsContent
"@
}

$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText($promptPath, $promptContent, $utf8WithBom)

Write-Host "생성된 프롬프트 파일: $promptRelativePath"
Write-Host "Current task id: $($currentTask.id)"
Write-Host "Current task title: $($currentTask.title)"

codex
현재 스크립트는 이미 주요 흐름을 갖고 있지만, DryRun 미리보기의 한국어 문자열이 깨져 있고 생성 JSON 검증이 프롬프트 규칙 일부를 충분히 강제하지 않습니다. 파일 작성
 전에 이 두 부분을 좁게 보강하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPa
th 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1' -Pattern 'New-DryRunAutoGoalPlan',
'Get-QueueValidationErrors','currentTaskId must be' -Context 0,80" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPa
th 'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md' -Pattern '목표 입력 기반 자동 실행' -Context 0,120" in 
D:\ai-apps\planpilot-local
 succeeded in 2293ms:

> scripts\ai-dev-auto-goal.ps1:262:function Get-QueueValidationErrors {
  scripts\ai-dev-auto-goal.ps1:263:    param([object]$Queue)
  scripts\ai-dev-auto-goal.ps1:264:
  scripts\ai-dev-auto-goal.ps1:265:    $errors = @()
  scripts\ai-dev-auto-goal.ps1:266:    $requiredFields = @("goalTitle", "goalSource", "createdAt", 
"updatedAt", "curren
tTaskId", "tasks")
  scripts\ai-dev-auto-goal.ps1:267:
  scripts\ai-dev-auto-goal.ps1:268:    foreach ($field in @(Get-MissingFields $Queue $requiredField
s)) {
  scripts\ai-dev-auto-goal.ps1:269:        $errors += "queue missing field: $field"
  scripts\ai-dev-auto-goal.ps1:270:    }
  scripts\ai-dev-auto-goal.ps1:271:
  scripts\ai-dev-auto-goal.ps1:272:    if ($errors.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:273:        return $errors
  scripts\ai-dev-auto-goal.ps1:274:    }
  scripts\ai-dev-auto-goal.ps1:275:
  scripts\ai-dev-auto-goal.ps1:276:    if (-not (Test-HasValue $Queue.goalTitle)) {
  scripts\ai-dev-auto-goal.ps1:277:        $errors += "queue.goalTitle must not be empty."
  scripts\ai-dev-auto-goal.ps1:278:    }
  scripts\ai-dev-auto-goal.ps1:279:
  scripts\ai-dev-auto-goal.ps1:280:    if ($Queue.goalSource -ne $goalRelativePath) {
  scripts\ai-dev-auto-goal.ps1:281:        $errors += "queue.goalSource must be $goalRelativePath."
  scripts\ai-dev-auto-goal.ps1:282:    }
  scripts\ai-dev-auto-goal.ps1:283:
  scripts\ai-dev-auto-goal.ps1:284:    if ($Queue.tasks -isnot [System.Collections.IEnumerable] -or
 $Queue.tasks -is [s
tring]) {
  scripts\ai-dev-auto-goal.ps1:285:        $errors += "queue.tasks must be an array."
  scripts\ai-dev-auto-goal.ps1:286:        return $errors
  scripts\ai-dev-auto-goal.ps1:287:    }
  scripts\ai-dev-auto-goal.ps1:288:
  scripts\ai-dev-auto-goal.ps1:289:    $tasks = @($Queue.tasks)
  scripts\ai-dev-auto-goal.ps1:290:
  scripts\ai-dev-auto-goal.ps1:291:    if ($tasks.Count -lt 1) {
  scripts\ai-dev-auto-goal.ps1:292:        $errors += "queue.tasks must contain at least one task."
  scripts\ai-dev-auto-goal.ps1:293:        return $errors
  scripts\ai-dev-auto-goal.ps1:294:    }
  scripts\ai-dev-auto-goal.ps1:295:
  scripts\ai-dev-auto-goal.ps1:296:    if ($tasks.Count -gt 3) {
  scripts\ai-dev-auto-goal.ps1:297:        $errors += "queue.tasks must contain no more than three 
tasks."
  scripts\ai-dev-auto-goal.ps1:298:    }
  scripts\ai-dev-auto-goal.ps1:299:
  scripts\ai-dev-auto-goal.ps1:300:    $taskIds = @()
  scripts\ai-dev-auto-goal.ps1:301:
  scripts\ai-dev-auto-goal.ps1:302:    foreach ($task in $tasks) {
  scripts\ai-dev-auto-goal.ps1:303:        $taskRequiredFields = @("id", "title", "description", "t
ype", "status", "pri
ority", "dependsOn", "filesLikelyToChange", "verification", "commitMessage")
  scripts\ai-dev-auto-goal.ps1:304:        $taskMissingFields = @(Get-MissingFields $task $taskRequ
iredFields)
  scripts\ai-dev-auto-goal.ps1:305:
  scripts\ai-dev-auto-goal.ps1:306:        foreach ($field in $taskMissingFields) {
  scripts\ai-dev-auto-goal.ps1:307:            $errors += "task missing field: $field"
  scripts\ai-dev-auto-goal.ps1:308:        }
  scripts\ai-dev-auto-goal.ps1:309:
  scripts\ai-dev-auto-goal.ps1:310:        if ($taskMissingFields.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:311:            continue
  scripts\ai-dev-auto-goal.ps1:312:        }
  scripts\ai-dev-auto-goal.ps1:313:
  scripts\ai-dev-auto-goal.ps1:314:        if (-not (Test-HasValue $task.id)) {
  scripts\ai-dev-auto-goal.ps1:315:            $errors += "task.id must not be empty."
  scripts\ai-dev-auto-goal.ps1:316:        } else {
  scripts\ai-dev-auto-goal.ps1:317:            $taskIds += [string]$task.id
  scripts\ai-dev-auto-goal.ps1:318:        }
  scripts\ai-dev-auto-goal.ps1:319:
  scripts\ai-dev-auto-goal.ps1:320:        if (-not (Test-HasValue $task.title)) {
  scripts\ai-dev-auto-goal.ps1:321:            $errors += "task.title must not be empty."
  scripts\ai-dev-auto-goal.ps1:322:        }
  scripts\ai-dev-auto-goal.ps1:323:
  scripts\ai-dev-auto-goal.ps1:324:        if (-not (Test-HasValue $task.description)) {
  scripts\ai-dev-auto-goal.ps1:325:            $errors += "task.description must not be empty."
  scripts\ai-dev-auto-goal.ps1:326:        }
  scripts\ai-dev-auto-goal.ps1:327:
  scripts\ai-dev-auto-goal.ps1:328:        if (@("analysis", "implementation", "documentation", "ve
rification") -notcon
tains $task.type) {
  scripts\ai-dev-auto-goal.ps1:329:            $errors += "invalid task.type: $($task.type)"
  scripts\ai-dev-auto-goal.ps1:330:        }
  scripts\ai-dev-auto-goal.ps1:331:
  scripts\ai-dev-auto-goal.ps1:332:        if (@("pending", "in_progress", "done", "blocked") -notc
ontains $task.status
) {
  scripts\ai-dev-auto-goal.ps1:333:            $errors += "invalid task.status: $($task.status)"
  scripts\ai-dev-auto-goal.ps1:334:        }
  scripts\ai-dev-auto-goal.ps1:335:
  scripts\ai-dev-auto-goal.ps1:336:        if (@("P0", "P1", "P2") -notcontains $task.priority) {
  scripts\ai-dev-auto-goal.ps1:337:            $errors += "invalid task.priority: $($task.priority)
"
  scripts\ai-dev-auto-goal.ps1:338:        }
  scripts\ai-dev-auto-goal.ps1:339:
  scripts\ai-dev-auto-goal.ps1:340:        if ($task.dependsOn -isnot [System.Collections.IEnumerab
le] -or $task.depend
sOn -is [string]) {
  scripts\ai-dev-auto-goal.ps1:341:            $errors += "task.dependsOn must be an array: $($task
.id)"
  scripts\ai-dev-auto-goal.ps1:342:        }
> scripts\ai-dev-auto-goal.ps1:419:    $errors += @(Get-QueueValidationErrors $Plan.queue)
  scripts\ai-dev-auto-goal.ps1:420:    $errors += @(Get-StateValidationErrors $Plan.state $Plan.que
ue)
  scripts\ai-dev-auto-goal.ps1:421:
  scripts\ai-dev-auto-goal.ps1:422:    return $errors
  scripts\ai-dev-auto-goal.ps1:423:}
  scripts\ai-dev-auto-goal.ps1:424:
> scripts\ai-dev-auto-goal.ps1:425:function New-DryRunAutoGoalPlan {
  scripts\ai-dev-auto-goal.ps1:426:    param(
  scripts\ai-dev-auto-goal.ps1:427:        [string]$Title,
  scripts\ai-dev-auto-goal.ps1:428:        [string]$Description
  scripts\ai-dev-auto-goal.ps1:429:    )
  scripts\ai-dev-auto-goal.ps1:430:
  scripts\ai-dev-auto-goal.ps1:431:    $now = (Get-Date).ToUniversalTime().ToString("o")
  scripts\ai-dev-auto-goal.ps1:432:    $safeCommitTitle = $Title.Trim()
  scripts\ai-dev-auto-goal.ps1:433:
  scripts\ai-dev-auto-goal.ps1:434:    $plan = [PSCustomObject][ordered]@{
  scripts\ai-dev-auto-goal.ps1:435:        goalMarkdown = @"
  scripts\ai-dev-auto-goal.ps1:436:# 紐⑺몴
  scripts\ai-dev-auto-goal.ps1:437:
  scripts\ai-dev-auto-goal.ps1:438:$safeCommitTitle
  scripts\ai-dev-auto-goal.ps1:439:
  scripts\ai-dev-auto-goal.ps1:440:## 諛곌꼍
  scripts\ai-dev-auto-goal.ps1:441:
  scripts\ai-dev-auto-goal.ps1:442:$($Description.Trim())
  scripts\ai-dev-auto-goal.ps1:443:
  scripts\ai-dev-auto-goal.ps1:444:## ?깃났 湲곗?
  scripts\ai-dev-auto-goal.ps1:445:
  scripts\ai-dev-auto-goal.ps1:446:- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
  scripts\ai-dev-auto-goal.ps1:447:- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
  scripts\ai-dev-auto-goal.ps1:448:- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
  scripts\ai-dev-auto-goal.ps1:449:
  scripts\ai-dev-auto-goal.ps1:450:## ?쒖빟?ы빆
  scripts\ai-dev-auto-goal.ps1:451:
  scripts\ai-dev-auto-goal.ps1:452:- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?
섏? ?딅뒗??
  scripts\ai-dev-auto-goal.ps1:453:- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
  scripts\ai-dev-auto-goal.ps1:454:
  scripts\ai-dev-auto-goal.ps1:455:## ?쒖쇅 踰붿쐞
  scripts\ai-dev-auto-goal.ps1:456:
  scripts\ai-dev-auto-goal.ps1:457:- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
  scripts\ai-dev-auto-goal.ps1:458:
  scripts\ai-dev-auto-goal.ps1:459:## ?섎룞 ?뺤씤
  scripts\ai-dev-auto-goal.ps1:460:
  scripts\ai-dev-auto-goal.ps1:461:- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
  scripts\ai-dev-auto-goal.ps1:462:- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
  scripts\ai-dev-auto-goal.ps1:463:- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
  scripts\ai-dev-auto-goal.ps1:464:"@
  scripts\ai-dev-auto-goal.ps1:465:        queue = [PSCustomObject][ordered]@{
  scripts\ai-dev-auto-goal.ps1:466:            goalTitle = $safeCommitTitle
  scripts\ai-dev-auto-goal.ps1:467:            goalSource = $goalRelativePath
  scripts\ai-dev-auto-goal.ps1:468:            createdAt = $now
  scripts\ai-dev-auto-goal.ps1:469:            updatedAt = $now
  scripts\ai-dev-auto-goal.ps1:470:            currentTaskId = "T001"
  scripts\ai-dev-auto-goal.ps1:471:            tasks = @(
  scripts\ai-dev-auto-goal.ps1:472:                [PSCustomObject][ordered]@{
  scripts\ai-dev-auto-goal.ps1:473:                    id = "T001"
  scripts\ai-dev-auto-goal.ps1:474:                    title = $safeCommitTitle
  scripts\ai-dev-auto-goal.ps1:475:                    description = $Description.Trim()
  scripts\ai-dev-auto-goal.ps1:476:                    type = "implementation"
  scripts\ai-dev-auto-goal.ps1:477:                    status = "in_progress"
  scripts\ai-dev-auto-goal.ps1:478:                    priority = "P0"
  scripts\ai-dev-auto-goal.ps1:479:                    dependsOn = @()
  scripts\ai-dev-auto-goal.ps1:480:                    filesLikelyToChange = @()
  scripts\ai-dev-auto-goal.ps1:481:                    verification = @(
  scripts\ai-dev-auto-goal.ps1:482:                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
  scripts\ai-dev-auto-goal.ps1:483:                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
  scripts\ai-dev-auto-goal.ps1:484:                    )
  scripts\ai-dev-auto-goal.ps1:485:                    commitMessage = $null
  scripts\ai-dev-auto-goal.ps1:486:                }
  scripts\ai-dev-auto-goal.ps1:487:            )
  scripts\ai-dev-auto-goal.ps1:488:        }
  scripts\ai-dev-auto-goal.ps1:489:        state = [PSCustomObject][ordered]@{
  scripts\ai-dev-auto-goal.ps1:490:            goalStatus = "in_progress"
  scripts\ai-dev-auto-goal.ps1:491:            currentTaskId = "T001"
  scripts\ai-dev-auto-goal.ps1:492:            currentLoop = 0
  scripts\ai-dev-auto-goal.ps1:493:            maxLoopsPerTask = 2
  scripts\ai-dev-auto-goal.ps1:494:            repeatedFailureCount = 0
  scripts\ai-dev-auto-goal.ps1:495:            lastCommand = $null
  scripts\ai-dev-auto-goal.ps1:496:            lastCommandStatus = "not_started"
  scripts\ai-dev-auto-goal.ps1:497:            lastErrorSummary = $null
  scripts\ai-dev-auto-goal.ps1:498:            lastReviewDecision = "not_started"
  scripts\ai-dev-auto-goal.ps1:499:            lastReviewSeverity = $null
  scripts\ai-dev-auto-goal.ps1:500:            lastCommitHash = $null
  scripts\ai-dev-auto-goal.ps1:501:            startedAt = $now
  scripts\ai-dev-auto-goal.ps1:502:            updatedAt = $now
  scripts\ai-dev-auto-goal.ps1:503:            stopReason = $null
  scripts\ai-dev-auto-goal.ps1:504:        }
  scripts\ai-dev-auto-goal.ps1:505:    }
> scripts\ai-dev-auto-goal.ps1:596:- currentTaskId must be "T001".
  scripts\ai-dev-auto-goal.ps1:597:- tasks must contain one to three tasks.
  scripts\ai-dev-auto-goal.ps1:598:- T001 must be status "in_progress"; later tasks, if any, must b
e "pending".
  scripts\ai-dev-auto-goal.ps1:599:- each task must include id, title, description, type, status, p
riority, dependsOn, 
filesLikelyToChange, verification, commitMessage.
  scripts\ai-dev-auto-goal.ps1:600:- type must be one of analysis, implementation, documentation, v
erification.
  scripts\ai-dev-auto-goal.ps1:601:- priority must be P0, P1, or P2.
  scripts\ai-dev-auto-goal.ps1:602:- dependsOn, filesLikelyToChange, and verification must be array
s.
  scripts\ai-dev-auto-goal.ps1:603:- commitMessage must be null or a short English commit message.
  scripts\ai-dev-auto-goal.ps1:604:
  scripts\ai-dev-auto-goal.ps1:605:state rules:
  scripts\ai-dev-auto-goal.ps1:606:- goalStatus must be "in_progress".
> scripts\ai-dev-auto-goal.ps1:607:- currentTaskId must be "T001".
  scripts\ai-dev-auto-goal.ps1:608:- currentLoop must be 0.
  scripts\ai-dev-auto-goal.ps1:609:- maxLoopsPerTask must be 2.
  scripts\ai-dev-auto-goal.ps1:610:- repeatedFailureCount must be 0.
  scripts\ai-dev-auto-goal.ps1:611:- lastCommand must be null.
  scripts\ai-dev-auto-goal.ps1:612:- lastCommandStatus must be "not_started".
  scripts\ai-dev-auto-goal.ps1:613:- lastErrorSummary must be null.
  scripts\ai-dev-auto-goal.ps1:614:- lastReviewDecision must be "not_started".
  scripts\ai-dev-auto-goal.ps1:615:- lastReviewSeverity must be null.
  scripts\ai-dev-auto-goal.ps1:616:- lastCommitHash must be null.
  scripts\ai-dev-auto-goal.ps1:617:- startedAt and updatedAt must be ISO 8601 strings.
  scripts\ai-dev-auto-goal.ps1:618:- stopReason must be null.
  scripts\ai-dev-auto-goal.ps1:619:
  scripts\ai-dev-auto-goal.ps1:620:Safety rules:
  scripts\ai-dev-auto-goal.ps1:621:- Do not mention server APIs, login, cloud sync, npm install, gi
t reset, git clean, 
git push, DB deletion, or broad rewrites as implementation steps.
  scripts\ai-dev-auto-goal.ps1:622:- Prefer one small implementation task when the goal is small.
  scripts\ai-dev-auto-goal.ps1:623:- Use Korean for user-facing task titles, descriptions, verifica
tion, and goalMarkdo
wn.
  scripts\ai-dev-auto-goal.ps1:624:"@
  scripts\ai-dev-auto-goal.ps1:625:}
  scripts\ai-dev-auto-goal.ps1:626:
  scripts\ai-dev-auto-goal.ps1:627:function Invoke-CycleCommand {
  scripts\ai-dev-auto-goal.ps1:628:    param(
  scripts\ai-dev-auto-goal.ps1:629:        [int]$StepNumber,
  scripts\ai-dev-auto-goal.ps1:630:        [string]$Name,
  scripts\ai-dev-auto-goal.ps1:631:        [string]$Command,
  scripts\ai-dev-auto-goal.ps1:632:        [string]$ScriptPath,
  scripts\ai-dev-auto-goal.ps1:633:        [string[]]$Arguments
  scripts\ai-dev-auto-goal.ps1:634:    )
  scripts\ai-dev-auto-goal.ps1:635:
  scripts\ai-dev-auto-goal.ps1:636:    if ($DryRun) {
  scripts\ai-dev-auto-goal.ps1:637:        $script:steps += New-StepResult $StepNumber $Name $Comma
nd $false $true 0 "D
ryRun: child script was not executed."
  scripts\ai-dev-auto-goal.ps1:638:        return
  scripts\ai-dev-auto-goal.ps1:639:    }
  scripts\ai-dev-auto-goal.ps1:640:
  scripts\ai-dev-auto-goal.ps1:641:    $output = & powershell -ExecutionPolicy Bypass -File $Script
Path @Arguments 2>&1
 | Out-String
  scripts\ai-dev-auto-goal.ps1:642:    $exitCode = $LASTEXITCODE
  scripts\ai-dev-auto-goal.ps1:643:    $message = $output.Trim()
  scripts\ai-dev-auto-goal.ps1:644:
  scripts\ai-dev-auto-goal.ps1:645:    if ([string]::IsNullOrWhiteSpace($message)) {
  scripts\ai-dev-auto-goal.ps1:646:        $message = "completed"
  scripts\ai-dev-auto-goal.ps1:647:    }
  scripts\ai-dev-auto-goal.ps1:648:
  scripts\ai-dev-auto-goal.ps1:649:    $script:steps += New-StepResult $StepNumber $Name $Command $
true $false $exitCod
e $message
  scripts\ai-dev-auto-goal.ps1:650:
  scripts\ai-dev-auto-goal.ps1:651:    if ($exitCode -ne 0) {
  scripts\ai-dev-auto-goal.ps1:652:        Stop-AutoGoal $script:steps "$Name`_failed" $false 1
  scripts\ai-dev-auto-goal.ps1:653:    }
  scripts\ai-dev-auto-goal.ps1:654:}
  scripts\ai-dev-auto-goal.ps1:655:
  scripts\ai-dev-auto-goal.ps1:656:function Get-FullCycleArguments {
  scripts\ai-dev-auto-goal.ps1:657:    $arguments = @("-MaxTasks", ([string]$MaxTasks), "-MaxSteps"
, ([string]$MaxSteps
))
  scripts\ai-dev-auto-goal.ps1:658:
  scripts\ai-dev-auto-goal.ps1:659:    if ($AllowCodex) {
  scripts\ai-dev-auto-goal.ps1:660:        $arguments += "-AllowCodex"
  scripts\ai-dev-auto-goal.ps1:661:    }
  scripts\ai-dev-auto-goal.ps1:662:
  scripts\ai-dev-auto-goal.ps1:663:    if ($AllowReviewCodex) {
  scripts\ai-dev-auto-goal.ps1:664:        $arguments += "-AllowReviewCodex"
  scripts\ai-dev-auto-goal.ps1:665:    }
  scripts\ai-dev-auto-goal.ps1:666:
  scripts\ai-dev-auto-goal.ps1:667:    if ($AllowCommit) {
  scripts\ai-dev-auto-goal.ps1:668:        $arguments += "-AllowCommit"
  scripts\ai-dev-auto-goal.ps1:669:    }
  scripts\ai-dev-auto-goal.ps1:670:
  scripts\ai-dev-auto-goal.ps1:671:    # auto-goal writes goal/queue/state/current prompt/result fi
les after the initia
l dirty gate.
  scripts\ai-dev-auto-goal.ps1:672:    # The downstream full cycle must tolerate those intended art
ifacts.
  scripts\ai-dev-auto-goal.ps1:673:    $arguments += "-AllowDirty"
  scripts\ai-dev-auto-goal.ps1:674:
  scripts\ai-dev-auto-goal.ps1:675:    if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:676:        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ 
-split "," } | Where
-Object { -not [string]::IsNullOrWhiteSpace($_) })
  scripts\ai-dev-auto-goal.ps1:677:
  scripts\ai-dev-auto-goal.ps1:678:        if ($normalizedFiles.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:679:            $arguments += "-CommitFiles"
  scripts\ai-dev-auto-goal.ps1:680:            $arguments += ($normalizedFiles -join ",")
  scripts\ai-dev-auto-goal.ps1:681:        }
  scripts\ai-dev-auto-goal.ps1:682:    }
  scripts\ai-dev-auto-goal.ps1:683:
  scripts\ai-dev-auto-goal.ps1:684:    return $arguments
  scripts\ai-dev-auto-goal.ps1:685:}
  scripts\ai-dev-auto-goal.ps1:686:
  scripts\ai-dev-auto-goal.ps1:687:Set-Location $repoRoot
> scripts\ai-dev-auto-goal.ps1:733:    $script:autoGoalPlanPreview = New-DryRunAutoGoalPlan $GoalTi
tle.Trim() $GoalDesc
ription.Trim()
  scripts\ai-dev-auto-goal.ps1:734:    $previewValidationErrors = @(Get-AutoGoalValidationErrors $s
cript:autoGoalPlanPr
eview)
  scripts\ai-dev-auto-goal.ps1:735:
  scripts\ai-dev-auto-goal.ps1:736:    if ($previewValidationErrors.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:737:        $script:steps += New-StepResult 2 "preview-plan" "local 
dry-run plan preview
" $false $false 1 "DryRun preview plan validation failed: $($previewValidationErrors -join '; ')"
  scripts\ai-dev-auto-goal.ps1:738:        Stop-AutoGoal $script:steps "dry_run_preview_invalid" $f
alse 1
  scripts\ai-dev-auto-goal.ps1:739:    }
  scripts\ai-dev-auto-goal.ps1:740:
  scripts\ai-dev-auto-goal.ps1:741:    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git
 status --short" $fa
lse $true 0 "DryRun: dirty worktree gate was not executed."
  scripts\ai-dev-auto-goal.ps1:742:    $script:steps += New-StepResult 3 "plan-goal" "codex exec <a
uto-goal planning pr
ompt>" $false $true 0 "DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, t
ask: $GoalTitle"
  scripts\ai-dev-auto-goal.ps1:743:    $script:steps += New-StepResult 4 "validate-generated-json" 
"goal/queue/state JS
ON validation" $false $true 0 "DryRun: preview goal/queue/state plan passed local schema validation
."
  scripts\ai-dev-auto-goal.ps1:744:    $script:steps += New-StepResult 5 "write-state-files" "$goal
RelativePath, $queue
RelativePath, $stateRelativePath" $false $true 0 "DryRun: state files were not written."
  scripts\ai-dev-auto-goal.ps1:745:    $script:steps += New-StepResult 6 "make-prompt" "powershell 
-ExecutionPolicy Byp
ass -File scripts/ai-dev-make-prompt.ps1" $false $true 0 "DryRun: current-task-prompt.md was not ge
nerated."
  scripts\ai-dev-auto-goal.ps1:746:
  scripts\ai-dev-auto-goal.ps1:747:    if ($shouldRunFullCycle) {
  scripts\ai-dev-auto-goal.ps1:748:        $script:steps += New-StepResult 7 "auto-cycle-full" $ful
lCycleCommandText $f
alse $true 0 "DryRun: explicit run option is present, but full cycle was not executed. -AllowRun on
ly invokes the full-
cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
  scripts\ai-dev-auto-goal.ps1:749:    } else {
  scripts\ai-dev-auto-goal.ps1:750:        $script:steps += New-StepResult 7 "auto-cycle-full" $ful
lCycleCommandText $f
alse $true 0 "DryRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only i
nvokes the full-cycl
e wrapper; implementation and review still require -AllowCodex and -AllowReviewCodex."
  scripts\ai-dev-auto-goal.ps1:751:    }
  scripts\ai-dev-auto-goal.ps1:752:
  scripts\ai-dev-auto-goal.ps1:753:    Stop-AutoGoal $script:steps "dry_run" $false 0
  scripts\ai-dev-auto-goal.ps1:754:}
  scripts\ai-dev-auto-goal.ps1:755:
  scripts\ai-dev-auto-goal.ps1:756:$statusLines = @(Get-GitStatusLines)
  scripts\ai-dev-auto-goal.ps1:757:
  scripts\ai-dev-auto-goal.ps1:758:if ($statusLines.Count -gt 0 -and -not $AllowDirty) {
  scripts\ai-dev-auto-goal.ps1:759:    $dirtyText = ($statusLines -join "`n")
  scripts\ai-dev-auto-goal.ps1:760:    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git
 status --short" $fa
lse $true 1 "Worktree is dirty. Use -AllowDirty only when this is intentional.`n$dirtyText"
  scripts\ai-dev-auto-goal.ps1:761:    Stop-AutoGoal $script:steps "dirty_worktree" $false 1
  scripts\ai-dev-auto-goal.ps1:762:}
  scripts\ai-dev-auto-goal.ps1:763:
  scripts\ai-dev-auto-goal.ps1:764:if ($statusLines.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:765:    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git
 status --short" $fa
lse $false 0 "AllowDirty is set. DirtyCount: $($statusLines.Count)"
  scripts\ai-dev-auto-goal.ps1:766:} else {
  scripts\ai-dev-auto-goal.ps1:767:    $script:steps += New-StepResult 2 "dirty-worktree-gate" "git
 status --short" $fa
lse $false 0 "Worktree is clean."
  scripts\ai-dev-auto-goal.ps1:768:}
  scripts\ai-dev-auto-goal.ps1:769:
  scripts\ai-dev-auto-goal.ps1:770:$codexCommand = Get-Command codex -ErrorAction SilentlyContinue
  scripts\ai-dev-auto-goal.ps1:771:
  scripts\ai-dev-auto-goal.ps1:772:if ($null -eq $codexCommand) {
  scripts\ai-dev-auto-goal.ps1:773:    $script:steps += New-StepResult 3 "plan-goal" "codex exec <a
uto-goal planning pr
ompt>" $false $false 1 "Codex CLI was not found."
  scripts\ai-dev-auto-goal.ps1:774:    Stop-AutoGoal $script:steps "codex_not_found" $false 1
  scripts\ai-dev-auto-goal.ps1:775:}
  scripts\ai-dev-auto-goal.ps1:776:
  scripts\ai-dev-auto-goal.ps1:777:$plannerPrompt = New-CodexAutoGoalPrompt $GoalTitle.Trim() $Goal
Description.Trim()
  scripts\ai-dev-auto-goal.ps1:778:$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  scripts\ai-dev-auto-goal.ps1:779:$codexOutput = & codex exec $plannerPrompt 2>&1 | Out-String
  scripts\ai-dev-auto-goal.ps1:780:$codexExitCode = $LASTEXITCODE
  scripts\ai-dev-auto-goal.ps1:781:$endedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  scripts\ai-dev-auto-goal.ps1:782:
  scripts\ai-dev-auto-goal.ps1:783:$resultContent = @"
  scripts\ai-dev-auto-goal.ps1:784:# Codex Auto Goal Result
  scripts\ai-dev-auto-goal.ps1:785:
  scripts\ai-dev-auto-goal.ps1:786:## Run
  scripts\ai-dev-auto-goal.ps1:787:
  scripts\ai-dev-auto-goal.ps1:788:- Started at: $startedAt
  scripts\ai-dev-auto-goal.ps1:789:- Ended at: $endedAt
  scripts\ai-dev-auto-goal.ps1:790:- Exit code: $codexExitCode
  scripts\ai-dev-auto-goal.ps1:791:- Goal title: $($GoalTitle.Trim())
  scripts\ai-dev-auto-goal.ps1:792:- Command: codex exec <auto-goal planning prompt>
  scripts\ai-dev-auto-goal.ps1:793:
  scripts\ai-dev-auto-goal.ps1:794:## Output
  scripts\ai-dev-auto-goal.ps1:795:
  scripts\ai-dev-auto-goal.ps1:796:${codeFence}text
  scripts\ai-dev-auto-goal.ps1:797:$codexOutput
  scripts\ai-dev-auto-goal.ps1:798:$codeFence
  scripts\ai-dev-auto-goal.ps1:799:"@
  scripts\ai-dev-auto-goal.ps1:800:
  scripts\ai-dev-auto-goal.ps1:801:[System.IO.File]::WriteAllText($resolvedResultPath, $resultConte
nt, $utf8WithBom)
  scripts\ai-dev-auto-goal.ps1:802:
  scripts\ai-dev-auto-goal.ps1:803:if ($codexExitCode -ne 0) {
  scripts\ai-dev-auto-goal.ps1:804:    $script:steps += New-StepResult 3 "plan-goal" "codex exec <a
uto-goal planning pr
ompt>" $true $false 1 "Codex goal planning failed. Result: $(ConvertTo-RepoRelativePath $ResultPath
)"
  scripts\ai-dev-auto-goal.ps1:805:    Stop-AutoGoal $script:steps "codex_plan_failed" $false 1
  scripts\ai-dev-auto-goal.ps1:806:}
  scripts\ai-dev-auto-goal.ps1:807:
  scripts\ai-dev-auto-goal.ps1:808:$script:steps += New-StepResult 3 "plan-goal" "codex exec <auto-
goal planning prompt
>" $true $false 0 "Codex goal planning completed. Result: $(ConvertTo-RepoRelativePath $ResultPath)
"
  scripts\ai-dev-auto-goal.ps1:809:
  scripts\ai-dev-auto-goal.ps1:810:try {
  scripts\ai-dev-auto-goal.ps1:811:    $autoGoalPlan = ConvertFrom-CodexAutoGoalOutput $codexOutput
  scripts\ai-dev-auto-goal.ps1:812:} catch {
  scripts\ai-dev-auto-goal.ps1:813:    $preview = Get-InputPreview $codexOutput



 succeeded in 2311ms:

> .ai-dev\README.md:750:### 목표 입력 기반 자동 실행
  .ai-dev\README.md:751:
  .ai-dev\README.md:752:최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게 
하는 것이다.
  .ai-dev\README.md:753:
  .ai-dev\README.md:754:먼저 DryRun으로 생성될 goal/task 계획과 실행 단계를 확인한다.
  .ai-dev\README.md:755:
  .ai-dev\README.md:756:```powershell
  .ai-dev\README.md:757:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -Go
alTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun
  .ai-dev\README.md:758:```
  .ai-dev\README.md:759:
  .ai-dev\README.md:760:자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다. JSON 출력은 사람이 읽는 텍스트와 섞지 않는다.
  .ai-dev\README.md:761:DryRun JSON에는 `plan.goalMarkdown`, `plan.queue`, `plan.state` 미리보기가 포함되므로 파
일 작성 전에 생성될 goal/tas
k 계획을 검토할 수 있다.
  .ai-dev\README.md:762:
  .ai-dev\README.md:763:```powershell
  .ai-dev\README.md:764:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -Go
alTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun -Json
  .ai-dev\README.md:765:```
  .ai-dev\README.md:766:
  .ai-dev\README.md:767:실제 goal/queue/state 생성과 current-task-prompt 생성까지만 수행하려면 `-DryRun`을 제거한다. 이 
모드는 `ai-dev-auto-cyc
le-full.ps1`을 호출하지 않는다.
  .ai-dev\README.md:768:
  .ai-dev\README.md:769:```powershell
  .ai-dev\README.md:770:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -Go
alTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다."
  .ai-dev\README.md:771:```
  .ai-dev\README.md:772:
  .ai-dev\README.md:773:생성 후 full auto-cycle 래퍼 호출까지 이어가려면 `-AllowRun` 또는 `-AllowCodex`, `-AllowRev
iewCodex`, `-AllowCo
mmit` 같은 명시적 실행 옵션을 지정한다. `-AllowRun` 단독은 full-cycle 래퍼 호출만 허용하며 Codex 구현이나 Codex 리뷰 권한을 대신하지 않는다. 
실제 구현까지 허용하려면 `-Allo
wCodex`, 리뷰까지 허용하려면 `-AllowReviewCodex`, 자동 커밋과 task 완료까지 허용하려면 기존 full cycle과 동일하게 `-AllowCodex -A
llowReviewCodex -All
owCommit`을 함께 지정한다.
  .ai-dev\README.md:774:
  .ai-dev\README.md:775:```powershell
  .ai-dev\README.md:776:powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -Go
alTitle "업무 검색 결과 하이
라이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -A
llowCommit -MaxTasks
 1
  .ai-dev\README.md:777:```
  .ai-dev\README.md:778:
  .ai-dev\README.md:779:동작:
  .ai-dev\README.md:780:
  .ai-dev\README.md:781:1. `GoalTitle`과 `GoalDescription`을 검증한다.
  .ai-dev\README.md:782:2. Codex CLI를 이용해 goal/queue/state 초안을 생성한다.
  .ai-dev\README.md:783:3. Codex 출력에서 `goalMarkdown`, `queue`, `state` JSON을 추출한다.
  .ai-dev\README.md:784:4. `queue.json`과 `state.json`의 필수 필드, currentTaskId, task 배열, enum 값을 검증한다.
  .ai-dev\README.md:785:5. `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 작성한다.
  .ai-dev\README.md:786:6. `.ai-dev/current-task-prompt.md`를 생성한다.
  .ai-dev\README.md:787:7. 명시적 실행 옵션이 있을 때만 `ai-dev-auto-cycle-full.ps1`로 이어간다.
  .ai-dev\README.md:788:8. auto-goal이 생성한 `.ai-dev/goal.md`, `queue.json`, `state.json`, `current-t
ask-prompt.md`, 결과 파
일 때문에 하위 full cycle의 dirty worktree 게이트가 중단되지 않도록 내부적으로 `-AllowDirty`를 전달한다. 초기 dirty worktree 게이트는
 auto-goal 시작 전에 별도로
 유지한다.
  .ai-dev\README.md:789:
  .ai-dev\README.md:790:안전 기준:
  .ai-dev\README.md:791:
  .ai-dev\README.md:792:- `GoalTitle` 또는 `GoalDescription`이 비어 있으면 종료한다.
  .ai-dev\README.md:793:- DryRun에서는 생성될 goal/task 계획과 실행 단계만 표시하고 파일을 수정하지 않는다.
  .ai-dev\README.md:794:- Json 출력은 사람이 읽는 텍스트와 섞지 않는다.
  .ai-dev\README.md:795:- 생성된 goal/queue/state JSON 파싱 또는 필드 검증에 실패하면 파일 작성과 full cycle 실행으로 넘어가지 않
는다.
  .ai-dev\README.md:796:- full cycle 호출은 `-AllowRun`, `-AllowCodex`, `-AllowReviewCodex`, `-AllowCo
mmit` 중 하나가 있을 때만 수행
한다.
  .ai-dev\README.md:797:- `-AllowRun` 단독은 구현, 리뷰, 커밋을 수행한다는 의미가 아니다. 하위 full cycle은 여전히 `-AllowCode
x`, `-AllowReviewCod
ex`, `-AllowCommit` 권한에 따라 각 위험 단계를 허용하거나 중단한다.
  .ai-dev\README.md:798:- package 파일 변경, build/check 실패, 리뷰 `pass` 아님, dirty worktree 위험이 있으면 자동 커밋
하지 않는다.
  .ai-dev\README.md:799:- `git reset`, `git clean`, `npm install`, `git push`는 실행하지 않는다.
  .ai-dev\README.md:800:
  .ai-dev\README.md:801:## 운영 원칙
  .ai-dev\README.md:802:
  .ai-dev\README.md:803:- 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
  .ai-dev\README.md:804:- 한 번에 하나의 task만 수행한다.
  .ai-dev\README.md:805:- task 단위로 구현, 검증, 리뷰, 커밋한다.
  .ai-dev\README.md:806:- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
  .ai-dev\README.md:807:- 검증하지 않은 결과를 통과로 기록하지 않는다.
  .ai-dev\README.md:808:- 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.
  .ai-dev\README.md:809:
  .ai-dev\README.md:810:## 다음 단계
  .ai-dev\README.md:811:
  .ai-dev\README.md:812:실제 자동 개발 루프 실행기와 상태 갱신 로직은 별도 정책 검토 후 추가한다.
  .ai-dev\README.md:813:
  .ai-dev\README.md:814:세부 기준은 `docs/ai-dev-loop-policy.md`를 따른다.



codex
수정 대상은 자동화 스크립트 하나입니다. README에는 이미 목표 입력 기반 실행 문서가 있어, 스크립트 동작 보강 후 문서와 실제 동작이 어긋나는 부분이 있는지만 다시 확인하
겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath
 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1' | Select-Object -Skip 330 -First 230
" in D:\ai-apps\planpilot-local
 succeeded in 1784ms:

        if (@("pending", "in_progress", "done", "blocked") -notcontains $task.status) {
            $errors += "invalid task.status: $($task.status)"
        }

        if (@("P0", "P1", "P2") -notcontains $task.priority) {
            $errors += "invalid task.priority: $($task.priority)"
        }

        if ($task.dependsOn -isnot [System.Collections.IEnumerable] -or $task.dependsOn -is [string
]) {
            $errors += "task.dependsOn must be an array: $($task.id)"
        }

        if ($task.filesLikelyToChange -isnot [System.Collections.IEnumerable] -or $task.filesLikely
ToChange -is [string]) {
            $errors += "task.filesLikelyToChange must be an array: $($task.id)"
        }

        if ($task.verification -isnot [System.Collections.IEnumerable] -or $task.verification -is [
string]) {
            $errors += "task.verification must be an array: $($task.id)"
        }
    }

    if ((@($tasks | Where-Object { $_.status -eq "in_progress" })).Count -ne 1) {
        $errors += "queue.tasks must contain exactly one in_progress task."
    }

    if (-not (Test-HasValue $Queue.currentTaskId)) {
        $errors += "queue.currentTaskId must not be empty."
    } elseif ($taskIds -notcontains [string]$Queue.currentTaskId) {
        $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
    }

    return $errors
}

function Get-StateValidationErrors {
    param(
        [object]$State,
        [object]$Queue
    )

    $errors = @()
    $requiredFields = @("goalStatus", "currentTaskId", "currentLoop", "maxLoopsPerTask", "repeatedF
ailureCount", "lastCommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDecision", "lastRe
viewSeverity", "lastCommitHash", "startedAt", "updatedAt", "stopReason")

    foreach ($field in @(Get-MissingFields $State $requiredFields)) {
        $errors += "state missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (@("idle", "in_progress", "completed", "blocked") -notcontains $State.goalStatus) {
        $errors += "invalid state.goalStatus: $($State.goalStatus)"
    }

    if ($State.currentTaskId -ne $Queue.currentTaskId) {
        $errors += "state.currentTaskId must match queue.currentTaskId."
    }

    if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
        $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
    }

    if (@("not_started", "pass", "revise", "blocked") -notcontains $State.lastReviewDecision) {
        $errors += "invalid state.lastReviewDecision: $($State.lastReviewDecision)"
    }

    return $errors
}

function Get-AutoGoalValidationErrors {
    param([object]$Plan)

    $errors = @()

    foreach ($field in @(Get-MissingFields $Plan @("goalMarkdown", "queue", "state"))) {
        $errors += "plan missing field: $field"
    }

    if ($errors.Count -gt 0) {
        return $errors
    }

    if (-not (Test-HasValue $Plan.goalMarkdown)) {
        $errors += "goalMarkdown must not be empty."
    }

    $errors += @(Get-QueueValidationErrors $Plan.queue)
    $errors += @(Get-StateValidationErrors $Plan.state $Plan.queue)

    return $errors
}

function New-DryRunAutoGoalPlan {
    param(
        [string]$Title,
        [string]$Description
    )

    $now = (Get-Date).ToUniversalTime().ToString("o")
    $safeCommitTitle = $Title.Trim()

    $plan = [PSCustomObject][ordered]@{
        goalMarkdown = @"
# 紐⑺몴

$safeCommitTitle

## 諛곌꼍

$($Description.Trim())

## ?깃났 湲곗?

- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.

## ?쒖빟?ы빆

- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??

## ?쒖쇅 踰붿쐞

- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅

## ?섎룞 ?뺤씤

- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
"@
        queue = [PSCustomObject][ordered]@{
            goalTitle = $safeCommitTitle
            goalSource = $goalRelativePath
            createdAt = $now
            updatedAt = $now
            currentTaskId = "T001"
            tasks = @(
                [PSCustomObject][ordered]@{
                    id = "T001"
                    title = $safeCommitTitle
                    description = $Description.Trim()
                    type = "implementation"
                    status = "in_progress"
                    priority = "P0"
                    dependsOn = @()
                    filesLikelyToChange = @()
                    verification = @(
                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
                    )
                    commitMessage = $null
                }
            )
        }
        state = [PSCustomObject][ordered]@{
            goalStatus = "in_progress"
            currentTaskId = "T001"
            currentLoop = 0
            maxLoopsPerTask = 2
            repeatedFailureCount = 0
            lastCommand = $null
            lastCommandStatus = "not_started"
            lastErrorSummary = $null
            lastReviewDecision = "not_started"
            lastReviewSeverity = $null
            lastCommitHash = $null
            startedAt = $now
            updatedAt = $now
            stopReason = $null
        }
    }

    $plan.goalMarkdown = @"
# 紐⑺몴

$safeCommitTitle

## 諛곌꼍

$($Description.Trim())

## ?깃났 湲곗?

- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.

## ?쒖빟?ы빆

- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??

## ?쒖쇅 踰붿쐞

- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅

## ?섎룞 ?뺤씤

- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
"@

    $dryRunTask = @($plan.queue.tasks)[0]
    $dryRunTask.verification = @(
        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
    )

    return $plan
}

function ConvertFrom-CodexAutoGoalOutput {
    param([string]$RawInput)

    foreach ($candidate in Get-JsonObjectCandidates $RawInput) {
        try {
            $parsed = $candidate | ConvertFrom-Json

            if ($null -eq $parsed -or $parsed -is [System.Array]) {
                continue
            }

            if (@(Get-AutoGoalValidationErrors $parsed).Count -gt 0) {
                continue
            }

codex
이제 `ai-dev-auto-goal.ps1`만 수정합니다. DryRun 미리보기 텍스트를 정상 한국어로 복구하고, Codex가 만든 queue/state가 `T001` 시작 규
칙을 벗어나면 파일을 쓰지 않도록 검증을 강화합니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-goal.ps1
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..40e87615fb5a517df15ebc3cce7963afb27cf9cd
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..40e87615fb5a517df15ebc3cce7963afb27cf9cd
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }

codex
검증 규칙 보강은 적용했습니다. 이어서 DryRun 계획 생성 함수의 깨진 문자열을 정상 한국어 미리보기로 교체합니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-goal.ps1
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..e2d571744ecdebfdaa1c9c4e5e49c5e79ca82c09
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }
@@ -429,41 +450,44 @@
     )
 
     $now = (Get-Date).ToUniversalTime().ToString("o")
-    $safeCommitTitle = $Title.Trim()
+    $safeTitle = $Title.Trim()
+    $safeDescription = $Description.Trim()
 
     $plan = [PSCustomObject][ordered]@{
         goalMarkdown = @"
-# 紐⑺몴
+# 목표
 
-$safeCommitTitle
+$safeTitle
 
-## 諛곌꼍
+## 배경
 
-$($Description.Trim())
+$safeDescription
 
-## ?깃났 湲곗?
+## 성공 기준
 
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
+- 입력한 목표에서 현재 작업을 준비한다.
+- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
+- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
 
-## ?쒖빟?ы빆
+## 제약사항
 
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
+- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
+- 저장소 정책과 현재 작업 범위를 따른다.
 
-## ?쒖쇅 踰붿쐞
+## 범위 제외
 
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
+- 패키지 변경
+- DB 삭제 또는 초기화
+- 광범위한 리팩터링
 
-## ?섎룞 ?뺤씤
+## 수동 검증
 
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
+- DryRun 계획과 JSON 출력을 검토한다.
+- 현재 작업 프롬프트 생성 여부를 확인한다.
+- 필요한 경우 빌드와 검증은 별도로 실행한다.
 "@
         queue = [PSCustomObject][ordered]@{
-            goalTitle = $safeCommitTitle
+            goalTitle = $safeTitle
             goalSource = $goalRelativePath
             createdAt = $now
             updatedAt = $now
@@ -471,16 +495,16 @@
             tasks = @(
                 [PSCustomObject][ordered]@{
                     id = "T001"
-                    title = $safeCommitTitle
-                    description = $Description.Trim()
+                    title = $safeTitle
+                    description = $safeDescription
                     type = "implementation"
                     status = "in_progress"
                     priority = "P0"
                     dependsOn = @()
                     filesLikelyToChange = @()
                     verification = @(
-                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
+                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
+                        "필요한 경우 npm run build를 별도로 실행한다."
                     )
                     commitMessage = $null
                 }
@@ -503,43 +527,6 @@
             stopReason = $null
         }
     }
-
-    $plan.goalMarkdown = @"
-# 紐⑺몴
-
-$safeCommitTitle
-
-## 諛곌꼍
-
-$($Description.Trim())
-
-## ?깃났 湲곗?
-
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
-
-## ?쒖빟?ы빆
-
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
-
-## ?쒖쇅 踰붿쐞
-
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
-
-## ?섎룞 ?뺤씤
-
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
-"@
-
-    $dryRunTask = @($plan.queue.tasks)[0]
-    $dryRunTask.verification = @(
-        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
-    )
 
     return $plan
 }

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..e2d571744ecdebfdaa1c9c4e5e49c5e79ca82c09
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }
@@ -429,41 +450,44 @@
     )
 
     $now = (Get-Date).ToUniversalTime().ToString("o")
-    $safeCommitTitle = $Title.Trim()
+    $safeTitle = $Title.Trim()
+    $safeDescription = $Description.Trim()
 
     $plan = [PSCustomObject][ordered]@{
         goalMarkdown = @"
-# 紐⑺몴
+# 목표
 
-$safeCommitTitle
+$safeTitle
 
-## 諛곌꼍
+## 배경
 
-$($Description.Trim())
+$safeDescription
 
-## ?깃났 湲곗?
+## 성공 기준
 
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
+- 입력한 목표에서 현재 작업을 준비한다.
+- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
+- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
 
-## ?쒖빟?ы빆
+## 제약사항
 
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
+- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
+- 저장소 정책과 현재 작업 범위를 따른다.
 
-## ?쒖쇅 踰붿쐞
+## 범위 제외
 
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
+- 패키지 변경
+- DB 삭제 또는 초기화
+- 광범위한 리팩터링
 
-## ?섎룞 ?뺤씤
+## 수동 검증
 
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
+- DryRun 계획과 JSON 출력을 검토한다.
+- 현재 작업 프롬프트 생성 여부를 확인한다.
+- 필요한 경우 빌드와 검증은 별도로 실행한다.
 "@
         queue = [PSCustomObject][ordered]@{
-            goalTitle = $safeCommitTitle
+            goalTitle = $safeTitle
             goalSource = $goalRelativePath
             createdAt = $now
             updatedAt = $now
@@ -471,16 +495,16 @@
             tasks = @(
                 [PSCustomObject][ordered]@{
                     id = "T001"
-                    title = $safeCommitTitle
-                    description = $Description.Trim()
+                    title = $safeTitle
+                    description = $safeDescription
                     type = "implementation"
                     status = "in_progress"
                     priority = "P0"
                     dependsOn = @()
                     filesLikelyToChange = @()
                     verification = @(
-                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
+                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
+                        "필요한 경우 npm run build를 별도로 실행한다."
                     )
                     commitMessage = $null
                 }
@@ -503,43 +527,6 @@
             stopReason = $null
         }
     }
-
-    $plan.goalMarkdown = @"
-# 紐⑺몴
-
-$safeCommitTitle
-
-## 諛곌꼍
-
-$($Description.Trim())
-
-## ?깃났 湲곗?
-
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
-
-## ?쒖빟?ы빆
-
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
-
-## ?쒖쇅 踰붿쐞
-
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
-
-## ?섎룞 ?뺤씤
-
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
-"@
-
-    $dryRunTask = @($plan.queue.tasks)[0]
-    $dryRunTask.verification = @(
-        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
-    )
 
     return $plan
 }

codex
수정은 완료되었습니다. 이제 PowerShell 파서로 문법을 확인하고, DryRun/JSON/빈 입력 오류 경로가 요구사항대로 동작하는지 실행 수준에서 검증하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPol
icy Bypass -File .\\scripts\\ai-dev-auto-goal.ps1 -GoalTitle '업무 검색 결과 하이라이트 추가' -GoalDescription '
검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다.' -DryRun" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPol
icy Bypass -File .\\scripts\\ai-dev-auto-goal.ps1 -GoalTitle '업무 검색 결과 하이라이트 추가' -GoalDescription '
검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다.' -DryRun -Json" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPol
icy Bypass -File .\\scripts\\ai-dev-auto-goal.ps1 -GoalTitle '' -GoalDescription '설명' -DryRun -Json
" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens=$null; $errors=$
null; [System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-apps\\planpilot-local\\sc
ripts\\ai-dev-auto-goal.ps1',[ref]"'$tokens,[ref]$errors) > $null; if ($errors.Count -gt 0) { $erro
rs | ForEach-Object { $_.Message }; exit 1 } else { '"'syntax ok' }" in D:\ai-apps\planpilot-local
 succeeded in 3046ms:
syntax ok

 exited 1 in 4136ms:
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-goal.ps1 : Missing an argument for parameter 'GoalTi
tle'. Specify a para
meter of type 'System.String' and try again.
    + CategoryInfo          : InvalidArgument: (:) [ai-dev-auto-goal.ps1], ParentContainsErrorRecor
dException
    + FullyQualifiedErrorId : MissingArgument,ai-dev-auto-goal.ps1
 

2026-06-09T13:59:38.985059Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 4.1 seconds
Output:
D:\ai-apps\planpilot-local\scripts\ai-dev-auto-goal.ps1 : Missing an argument for parameter 'GoalTi
tle'. Specify a para
meter of type 'System.String' and try again.
    + CategoryInfo          : InvalidArgument: (:) [ai-dev-auto-goal.ps1], ParentContainsErrorRecor
dException
    + FullyQualifiedErrorId : MissingArgument,ai-dev-auto-goal.ps1
 

 succeeded in 4962ms:
{
    "steps":  [
                  {
                      "step":  1,
                      "name":  "validate-input",
                      "command":  "check GoalTitle/GoalDescription",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  0,
                      "message":  "Input validation completed: 업무 검색 결과 하이라이트 추가"
                  },
                  {
                      "step":  2,
                      "name":  "dirty-worktree-gate",
                      "command":  "git status --short",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: dirty worktree gate was not executed."
                  },
                  {
                      "step":  3,
                      "name":  "plan-goal",
                      "command":  "codex exec \u003cauto-goal planning prompt\u003e",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: Codex goal planning was not executed. Preview currentTas
kId: T001, task: 업무 검색 결과 하이라이트 추가"
                  },
                  {
                      "step":  4,
                      "name":  "validate-generated-json",
                      "command":  "goal/queue/state JSON validation",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: preview goal/queue/state plan passed local schema valida
tion."
                  },
                  {
                      "step":  5,
                      "name":  "write-state-files",
                      "command":  ".ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: state files were not written."
                  },
                  {
                      "step":  6,
                      "name":  "make-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pro
mpt.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: current-task-prompt.md was not generated."
                  },
                  {
                      "step":  7,
                      "name":  "auto-cycle-full",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cyc
le-full.ps1 -MaxTasks 1 -MaxSteps 20 -AllowDirty",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: full cycle requires -AllowRun or explicit execution opti
ons. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -AllowC
odex and -AllowReviewCodex."
                  }
              ],
    "stoppedReason":  "dry_run",
    "completed":  false,
    "exitCode":  0,
    "plan":  {
                 "goalMarkdown":  "# 목표\n\n업무 검색 결과 하이라이트 추가\n\n## 배경\n\n검색어와 일치하는 업무 제목/메모/프로젝트명을 
화면에서 강조 표시한다.\n\n## 성공 기준\n\n- 입력한 목표에서 현재 작업을 준비한다.\n- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.\n- 
full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.\n\n## 제약사항\n\n- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 gi
t 명령은 사용하지 않는다.\n- 저장소 정책과 현재 작업 범위를 따른다.\n\n## 범위 제외\n\n- 패키지 변경\n- DB 삭제 또는 초기화\n- 광범위한 리팩터링\n\n#
# 수동 검증\n\n- DryRun 계획과 JSON 출력을 검토한다.\n- 현재 작업 프롬프트 생성 여부를 확인한다.\n- 필요한 경우 빌드와 검증은 별도로 실행한다.",
                 "queue":  {
                               "goalTitle":  "업무 검색 결과 하이라이트 추가",
                               "goalSource":  ".ai-dev/goal.md",
                               "createdAt":  "2026-06-09T13:59:38.3307470Z",
                               "updatedAt":  "2026-06-09T13:59:38.3307470Z",
                               "currentTaskId":  "T001",
                               "tasks":  [
                                             {
                                                 "id":  "T001",
                                                 "title":  "업무 검색 결과 하이라이트 추가",
                                                 "description":  "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조
 표시한다.",
                                                 "type":  "implementation",
                                                 "status":  "in_progress",
                                                 "priority":  "P0",
                                                 "dependsOn":  [

                                                               ],
                                                 "filesLikelyToChange":  [

                                                                         ],
                                                 "verification":  [
                                                                      "변경 범위가 현재 목표와 일치하는지 확인한다.",
                                                                      "필요한 경우 npm run build를 별도로 실행
한다."
                                                                  ],
                                                 "commitMessage":  null
                                             }
                                         ]
                           },
                 "state":  {
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
                               "startedAt":  "2026-06-09T13:59:38.3307470Z",
                               "updatedAt":  "2026-06-09T13:59:38.3307470Z",
                               "stopReason":  null
                           }
             },
    "goalPath":  ".ai-dev/goal.md",
    "queuePath":  ".ai-dev/queue.json",
    "statePath":  ".ai-dev/state.json",
    "promptPath":  ".ai-dev/current-task-prompt.md",
    "resultPath":  ".ai-dev/auto-goal-codex-result.md"
}

 succeeded in 5085ms:
Step 1: validate-input
  Command: check GoalTitle/GoalDescription
  Executed: False
  Skipped: False
  Exit code: 0
  Message: Input validation completed: 업무 검색 결과 하이라이트 추가
Step 2: dirty-worktree-gate
  Command: git status --short
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: dirty worktree gate was not executed.
Step 3: plan-goal
  Command: codex exec <auto-goal planning prompt>
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: Codex goal planning was not executed. Preview currentTaskId: T001, task: 업무 검색 결
과 하이라이트 추가
Step 4: validate-generated-json
  Command: goal/queue/state JSON validation
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: preview goal/queue/state plan passed local schema validation.
Step 5: write-state-files
  Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: state files were not written.
Step 6: make-prompt
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: current-task-prompt.md was not generated.
Step 7: auto-cycle-full
  Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 1 
-MaxSteps 20 -AllowDirty
  Executed: False
  Skipped: True
  Exit code: 0
  Message: DryRun: full cycle requires -AllowRun or explicit execution options. -AllowRun only invo
kes the full-cycle wrapper; implementation and review still require -AllowCodex and -AllowReviewCod
ex.
Plan preview:
  Goal title: 업무 검색 결과 하이라이트 추가
  Current task id: T001
  Task T001: 업무 검색 결과 하이라이트 추가
    Type: implementation
    Status: in_progress
    Priority: P0
    Likely files: 
    Verification: 변경 범위가 현재 목표와 일치하는지 확인한다. / 필요한 경우 npm run build를 별도로 실행한다.
Stopped reason: dry_run
Completed: False
Exit code: 0

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..e2d571744ecdebfdaa1c9c4e5e49c5e79ca82c09
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }
@@ -429,41 +450,44 @@
     )
 
     $now = (Get-Date).ToUniversalTime().ToString("o")
-    $safeCommitTitle = $Title.Trim()
+    $safeTitle = $Title.Trim()
+    $safeDescription = $Description.Trim()
 
     $plan = [PSCustomObject][ordered]@{
         goalMarkdown = @"
-# 紐⑺몴
+# 목표
 
-$safeCommitTitle
+$safeTitle
 
-## 諛곌꼍
+## 배경
 
-$($Description.Trim())
+$safeDescription
 
-## ?깃났 湲곗?
+## 성공 기준
 
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
+- 입력한 목표에서 현재 작업을 준비한다.
+- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
+- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
 
-## ?쒖빟?ы빆
+## 제약사항
 
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
+- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
+- 저장소 정책과 현재 작업 범위를 따른다.
 
-## ?쒖쇅 踰붿쐞
+## 범위 제외
 
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
+- 패키지 변경
+- DB 삭제 또는 초기화
+- 광범위한 리팩터링
 
-## ?섎룞 ?뺤씤
+## 수동 검증
 
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
+- DryRun 계획과 JSON 출력을 검토한다.
+- 현재 작업 프롬프트 생성 여부를 확인한다.
+- 필요한 경우 빌드와 검증은 별도로 실행한다.
 "@
         queue = [PSCustomObject][ordered]@{
-            goalTitle = $safeCommitTitle
+            goalTitle = $safeTitle
             goalSource = $goalRelativePath
             createdAt = $now
             updatedAt = $now
@@ -471,16 +495,16 @@
             tasks = @(
                 [PSCustomObject][ordered]@{
                     id = "T001"
-                    title = $safeCommitTitle
-                    description = $Description.Trim()
+                    title = $safeTitle
+                    description = $safeDescription
                     type = "implementation"
                     status = "in_progress"
                     priority = "P0"
                     dependsOn = @()
                     filesLikelyToChange = @()
                     verification = @(
-                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
+                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
+                        "필요한 경우 npm run build를 별도로 실행한다."
                     )
                     commitMessage = $null
                 }
@@ -503,43 +527,6 @@
             stopReason = $null
         }
     }
-
-    $plan.goalMarkdown = @"
-# 紐⑺몴
-
-$safeCommitTitle
-
-## 諛곌꼍
-
-$($Description.Trim())
-
-## ?깃났 湲곗?
-
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
-
-## ?쒖빟?ы빆
-
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
-
-## ?쒖쇅 踰붿쐞
-
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
-
-## ?섎룞 ?뺤씤
-
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
-"@
-
-    $dryRunTask = @($plan.queue.tasks)[0]
-    $dryRunTask.verification = @(
-        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
-    )
 
     return $plan
 }

codex
DryRun과 JSON 출력은 정상입니다. 빈 문자열 테스트는 PowerShell 인수 파서가 `''`를 값 없는 파라미터로 처리해 스크립트 내부 검증까지 들어가지 않았고, 공백
 값과 생략 값 경로로 입력 검증을 다시 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPol
icy Bypass -File .\\scripts\\ai-dev-auto-goal.ps1 -GoalTitle ' ' -GoalDescription '설명' -DryRun -Jso
n" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPol
icy Bypass -File .\\scripts\\ai-dev-auto-goal.ps1 -GoalTitle '업무 검색 결과 하이라이트 추가' -GoalDescription '
검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다.' -DryRun -AllowRun -Json" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "powershell -ExecutionPol
icy Bypass -File .\\scripts\\ai-dev-auto-goal.ps1 -GoalDescription '설명' -DryRun -Json" in D:\ai-app
s\planpilot-local
 exited 1 in 4098ms:
{
    "steps":  [
                  {
                      "step":  0,
                      "name":  "validate-input",
                      "command":  "check GoalTitle",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  1,
                      "message":  "GoalTitle must not be empty."
                  }
              ],
    "stoppedReason":  "invalid_goal_title",
    "completed":  false,
    "exitCode":  1,
    "plan":  null,
    "goalPath":  ".ai-dev/goal.md",
    "queuePath":  ".ai-dev/queue.json",
    "statePath":  ".ai-dev/state.json",
    "promptPath":  ".ai-dev/current-task-prompt.md",
    "resultPath":  ".ai-dev/auto-goal-codex-result.md"
}

2026-06-09T13:59:56.754354Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 4.1 seconds
Output:
{
    "steps":  [
                  {
                      "step":  0,
                      "name":  "validate-input",
                      "command":  "check GoalTitle",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  1,
                      "message":  "GoalTitle must not be empty."
                  }
              ],
    "stoppedReason":  "invalid_goal_title",
    "completed":  false,
    "exitCode":  1,
    "plan":  null,
    "goalPath":  ".ai-dev/goal.md",
    "queuePath":  ".ai-dev/queue.json",
    "statePath":  ".ai-dev/state.json",
    "promptPath":  ".ai-dev/current-task-prompt.md",
    "resultPath":  ".ai-dev/auto-goal-codex-result.md"
}

 exited 1 in 4252ms:
{
    "steps":  [
                  {
                      "step":  0,
                      "name":  "validate-input",
                      "command":  "check GoalTitle",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  1,
                      "message":  "GoalTitle must not be empty."
                  }
              ],
    "stoppedReason":  "invalid_goal_title",
    "completed":  false,
    "exitCode":  1,
    "plan":  null,
    "goalPath":  ".ai-dev/goal.md",
    "queuePath":  ".ai-dev/queue.json",
    "statePath":  ".ai-dev/state.json",
    "promptPath":  ".ai-dev/current-task-prompt.md",
    "resultPath":  ".ai-dev/auto-goal-codex-result.md"
}

 succeeded in 4254ms:
{
    "steps":  [
                  {
                      "step":  1,
                      "name":  "validate-input",
                      "command":  "check GoalTitle/GoalDescription",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  0,
                      "message":  "Input validation completed: 업무 검색 결과 하이라이트 추가"
                  },
                  {
                      "step":  2,
                      "name":  "dirty-worktree-gate",
                      "command":  "git status --short",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: dirty worktree gate was not executed."
                  },
                  {
                      "step":  3,
                      "name":  "plan-goal",
                      "command":  "codex exec \u003cauto-goal planning prompt\u003e",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: Codex goal planning was not executed. Preview currentTas
kId: T001, task: 업무 검색 결과 하이라이트 추가"
                  },
                  {
                      "step":  4,
                      "name":  "validate-generated-json",
                      "command":  "goal/queue/state JSON validation",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: preview goal/queue/state plan passed local schema valida
tion."
                  },
                  {
                      "step":  5,
                      "name":  "write-state-files",
                      "command":  ".ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: state files were not written."
                  },
                  {
                      "step":  6,
                      "name":  "make-prompt",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-pro
mpt.ps1",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: current-task-prompt.md was not generated."
                  },
                  {
                      "step":  7,
                      "name":  "auto-cycle-full",
                      "command":  "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cyc
le-full.ps1 -MaxTasks 1 -MaxSteps 20 -AllowDirty",
                      "executed":  false,
                      "skipped":  true,
                      "exitCode":  0,
                      "message":  "DryRun: explicit run option is present, but full cycle was not e
xecuted. -AllowRun only invokes the full-cycle wrapper; implementation and review still require -Al
lowCodex and -AllowReviewCodex."
                  }
              ],
    "stoppedReason":  "dry_run",
    "completed":  false,
    "exitCode":  0,
    "plan":  {
                 "goalMarkdown":  "# 목표\n\n업무 검색 결과 하이라이트 추가\n\n## 배경\n\n검색어와 일치하는 업무 제목/메모/프로젝트명을 
화면에서 강조 표시한다.\n\n## 성공 기준\n\n- 입력한 목표에서 현재 작업을 준비한다.\n- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.\n- 
full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.\n\n## 제약사항\n\n- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 gi
t 명령은 사용하지 않는다.\n- 저장소 정책과 현재 작업 범위를 따른다.\n\n## 범위 제외\n\n- 패키지 변경\n- DB 삭제 또는 초기화\n- 광범위한 리팩터링\n\n#
# 수동 검증\n\n- DryRun 계획과 JSON 출력을 검토한다.\n- 현재 작업 프롬프트 생성 여부를 확인한다.\n- 필요한 경우 빌드와 검증은 별도로 실행한다.",
                 "queue":  {
                               "goalTitle":  "업무 검색 결과 하이라이트 추가",
                               "goalSource":  ".ai-dev/goal.md",
                               "createdAt":  "2026-06-09T13:59:55.7497650Z",
                               "updatedAt":  "2026-06-09T13:59:55.7497650Z",
                               "currentTaskId":  "T001",
                               "tasks":  [
                                             {
                                                 "id":  "T001",
                                                 "title":  "업무 검색 결과 하이라이트 추가",
                                                 "description":  "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조
 표시한다.",
                                                 "type":  "implementation",
                                                 "status":  "in_progress",
                                                 "priority":  "P0",
                                                 "dependsOn":  [

                                                               ],
                                                 "filesLikelyToChange":  [

                                                                         ],
                                                 "verification":  [
                                                                      "변경 범위가 현재 목표와 일치하는지 확인한다.",
                                                                      "필요한 경우 npm run build를 별도로 실행
한다."
                                                                  ],
                                                 "commitMessage":  null
                                             }
                                         ]
                           },
                 "state":  {
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
                               "startedAt":  "2026-06-09T13:59:55.7497650Z",
                               "updatedAt":  "2026-06-09T13:59:55.7497650Z",
                               "stopReason":  null
                           }
             },
    "goalPath":  ".ai-dev/goal.md",
    "queuePath":  ".ai-dev/queue.json",
    "statePath":  ".ai-dev/state.json",
    "promptPath":  ".ai-dev/current-task-prompt.md",
    "resultPath":  ".ai-dev/auto-goal-codex-result.md"
}

2026-06-09T13:59:56.936113Z ERROR codex_core::tools::router: error=Exit code: 1
Wall time: 4.3 seconds
Output:
{
    "steps":  [
                  {
                      "step":  0,
                      "name":  "validate-input",
                      "command":  "check GoalTitle",
                      "executed":  false,
                      "skipped":  false,
                      "exitCode":  1,
                      "message":  "GoalTitle must not be empty."
                  }
              ],
    "stoppedReason":  "invalid_goal_title",
    "completed":  false,
    "exitCode":  1,
    "plan":  null,
    "goalPath":  ".ai-dev/goal.md",
    "queuePath":  ".ai-dev/queue.json",
    "statePath":  ".ai-dev/state.json",
    "promptPath":  ".ai-dev/current-task-prompt.md",
    "resultPath":  ".ai-dev/auto-goal-codex-result.md"
}

diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..e2d571744ecdebfdaa1c9c4e5e49c5e79ca82c09
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }
@@ -429,41 +450,44 @@
     )
 
     $now = (Get-Date).ToUniversalTime().ToString("o")
-    $safeCommitTitle = $Title.Trim()
+    $safeTitle = $Title.Trim()
+    $safeDescription = $Description.Trim()
 
     $plan = [PSCustomObject][ordered]@{
         goalMarkdown = @"
-# 紐⑺몴
+# 목표
 
-$safeCommitTitle
+$safeTitle
 
-## 諛곌꼍
+## 배경
 
-$($Description.Trim())
+$safeDescription
 
-## ?깃났 湲곗?
+## 성공 기준
 
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
+- 입력한 목표에서 현재 작업을 준비한다.
+- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
+- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
 
-## ?쒖빟?ы빆
+## 제약사항
 
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
+- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
+- 저장소 정책과 현재 작업 범위를 따른다.
 
-## ?쒖쇅 踰붿쐞
+## 범위 제외
 
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
+- 패키지 변경
+- DB 삭제 또는 초기화
+- 광범위한 리팩터링
 
-## ?섎룞 ?뺤씤
+## 수동 검증
 
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
+- DryRun 계획과 JSON 출력을 검토한다.
+- 현재 작업 프롬프트 생성 여부를 확인한다.
+- 필요한 경우 빌드와 검증은 별도로 실행한다.
 "@
         queue = [PSCustomObject][ordered]@{
-            goalTitle = $safeCommitTitle
+            goalTitle = $safeTitle
             goalSource = $goalRelativePath
             createdAt = $now
             updatedAt = $now
@@ -471,16 +495,16 @@
             tasks = @(
                 [PSCustomObject][ordered]@{
                     id = "T001"
-                    title = $safeCommitTitle
-                    description = $Description.Trim()
+                    title = $safeTitle
+                    description = $safeDescription
                     type = "implementation"
                     status = "in_progress"
                     priority = "P0"
                     dependsOn = @()
                     filesLikelyToChange = @()
                     verification = @(
-                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
+                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
+                        "필요한 경우 npm run build를 별도로 실행한다."
                     )
                     commitMessage = $null
                 }
@@ -503,43 +527,6 @@
             stopReason = $null
         }
     }
-
-    $plan.goalMarkdown = @"
-# 紐⑺몴
-
-$safeCommitTitle
-
-## 諛곌꼍
-
-$($Description.Trim())
-
-## ?깃났 湲곗?
-
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
-
-## ?쒖빟?ы빆
-
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
-
-## ?쒖쇅 踰붿쐞
-
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
-
-## ?섎룞 ?뺤씤
-
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
-"@
-
-    $dryRunTask = @($plan.queue.tasks)[0]
-    $dryRunTask.verification = @(
-        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
-    )
 
     return $plan
 }

codex
검증 결과 DryRun은 파일을 쓰지 않고 계획과 단계만 출력했고, JSON 모드는 텍스트와 섞이지 않았습니다. 마지막으로 수정된 함수 주변을 다시 읽어 의도치 않은 중복이나 깨
진 문자열이 남아 있는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPa
th 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1' -Pattern 'queue.currentTaskId must
 be T001','T001 must be in_progress','function New-DryRunAutoGoalPlan' -Context 0,35" in D:\ai-apps
\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Select-String -LiteralPa
th 'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-goal.ps1' -Pattern '紐|諛|쒖|꾩|蹂|湲|젣|뺤|⑦'" in D
:\ai-apps\planpilot-local
 succeeded in 2011ms:
 succeeded in 2149ms:

> scripts\ai-dev-auto-goal.ps1:301:        $errors += "queue.currentTaskId must be T001."
  scripts\ai-dev-auto-goal.ps1:302:    }
  scripts\ai-dev-auto-goal.ps1:303:
  scripts\ai-dev-auto-goal.ps1:304:    $taskIds = @()
  scripts\ai-dev-auto-goal.ps1:305:
  scripts\ai-dev-auto-goal.ps1:306:    foreach ($task in $tasks) {
  scripts\ai-dev-auto-goal.ps1:307:        $taskRequiredFields = @("id", "title", "description", "t
ype", "status", "pri
ority", "dependsOn", "filesLikelyToChange", "verification", "commitMessage")
  scripts\ai-dev-auto-goal.ps1:308:        $taskMissingFields = @(Get-MissingFields $task $taskRequ
iredFields)
  scripts\ai-dev-auto-goal.ps1:309:
  scripts\ai-dev-auto-goal.ps1:310:        foreach ($field in $taskMissingFields) {
  scripts\ai-dev-auto-goal.ps1:311:            $errors += "task missing field: $field"
  scripts\ai-dev-auto-goal.ps1:312:        }
  scripts\ai-dev-auto-goal.ps1:313:
  scripts\ai-dev-auto-goal.ps1:314:        if ($taskMissingFields.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:315:            continue
  scripts\ai-dev-auto-goal.ps1:316:        }
  scripts\ai-dev-auto-goal.ps1:317:
  scripts\ai-dev-auto-goal.ps1:318:        if (-not (Test-HasValue $task.id)) {
  scripts\ai-dev-auto-goal.ps1:319:            $errors += "task.id must not be empty."
  scripts\ai-dev-auto-goal.ps1:320:        } else {
  scripts\ai-dev-auto-goal.ps1:321:            $taskIds += [string]$task.id
  scripts\ai-dev-auto-goal.ps1:322:        }
  scripts\ai-dev-auto-goal.ps1:323:
  scripts\ai-dev-auto-goal.ps1:324:        if (-not (Test-HasValue $task.title)) {
  scripts\ai-dev-auto-goal.ps1:325:            $errors += "task.title must not be empty."
  scripts\ai-dev-auto-goal.ps1:326:        }
  scripts\ai-dev-auto-goal.ps1:327:
  scripts\ai-dev-auto-goal.ps1:328:        if (-not (Test-HasValue $task.description)) {
  scripts\ai-dev-auto-goal.ps1:329:            $errors += "task.description must not be empty."
  scripts\ai-dev-auto-goal.ps1:330:        }
  scripts\ai-dev-auto-goal.ps1:331:
  scripts\ai-dev-auto-goal.ps1:332:        if (@("analysis", "implementation", "documentation", "ve
rification") -notcon
tains $task.type) {
  scripts\ai-dev-auto-goal.ps1:333:            $errors += "invalid task.type: $($task.type)"
  scripts\ai-dev-auto-goal.ps1:334:        }
  scripts\ai-dev-auto-goal.ps1:335:
  scripts\ai-dev-auto-goal.ps1:336:        if (@("pending", "in_progress", "done", "blocked") -notc
ontains $task.status
) {
> scripts\ai-dev-auto-goal.ps1:371:        $errors += "T001 must be in_progress."
  scripts\ai-dev-auto-goal.ps1:372:    }
  scripts\ai-dev-auto-goal.ps1:373:
  scripts\ai-dev-auto-goal.ps1:374:    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "
T001" })) {
  scripts\ai-dev-auto-goal.ps1:375:        if ($laterTask.status -ne "pending") {
  scripts\ai-dev-auto-goal.ps1:376:            $errors += "later tasks must be pending: $($laterTas
k.id)"
  scripts\ai-dev-auto-goal.ps1:377:        }
  scripts\ai-dev-auto-goal.ps1:378:    }
  scripts\ai-dev-auto-goal.ps1:379:
  scripts\ai-dev-auto-goal.ps1:380:    return $errors
  scripts\ai-dev-auto-goal.ps1:381:}
  scripts\ai-dev-auto-goal.ps1:382:
  scripts\ai-dev-auto-goal.ps1:383:function Get-StateValidationErrors {
  scripts\ai-dev-auto-goal.ps1:384:    param(
  scripts\ai-dev-auto-goal.ps1:385:        [object]$State,
  scripts\ai-dev-auto-goal.ps1:386:        [object]$Queue
  scripts\ai-dev-auto-goal.ps1:387:    )
  scripts\ai-dev-auto-goal.ps1:388:
  scripts\ai-dev-auto-goal.ps1:389:    $errors = @()
  scripts\ai-dev-auto-goal.ps1:390:    $requiredFields = @("goalStatus", "currentTaskId", "currentL
oop", "maxLoopsPerTa
sk", "repeatedFailureCount", "lastCommand", "lastCommandStatus", "lastErrorSummary", "lastReviewDec
ision", "lastReviewS
everity", "lastCommitHash", "startedAt", "updatedAt", "stopReason")
  scripts\ai-dev-auto-goal.ps1:391:
  scripts\ai-dev-auto-goal.ps1:392:    foreach ($field in @(Get-MissingFields $State $requiredField
s)) {
  scripts\ai-dev-auto-goal.ps1:393:        $errors += "state missing field: $field"
  scripts\ai-dev-auto-goal.ps1:394:    }
  scripts\ai-dev-auto-goal.ps1:395:
  scripts\ai-dev-auto-goal.ps1:396:    if ($errors.Count -gt 0) {
  scripts\ai-dev-auto-goal.ps1:397:        return $errors
  scripts\ai-dev-auto-goal.ps1:398:    }
  scripts\ai-dev-auto-goal.ps1:399:
  scripts\ai-dev-auto-goal.ps1:400:    if (@("idle", "in_progress", "completed", "blocked") -notcon
tains $State.goalSta
tus) {
  scripts\ai-dev-auto-goal.ps1:401:        $errors += "invalid state.goalStatus: $($State.goalStatu
s)"
  scripts\ai-dev-auto-goal.ps1:402:    }
  scripts\ai-dev-auto-goal.ps1:403:
  scripts\ai-dev-auto-goal.ps1:404:    if ($State.currentTaskId -ne $Queue.currentTaskId) {
  scripts\ai-dev-auto-goal.ps1:405:        $errors += "state.currentTaskId must match queue.current
TaskId."
  scripts\ai-dev-auto-goal.ps1:406:    }
> scripts\ai-dev-auto-goal.ps1:446:function New-DryRunAutoGoalPlan {
  scripts\ai-dev-auto-goal.ps1:447:    param(
  scripts\ai-dev-auto-goal.ps1:448:        [string]$Title,
  scripts\ai-dev-auto-goal.ps1:449:        [string]$Description
  scripts\ai-dev-auto-goal.ps1:450:    )
  scripts\ai-dev-auto-goal.ps1:451:
  scripts\ai-dev-auto-goal.ps1:452:    $now = (Get-Date).ToUniversalTime().ToString("o")
  scripts\ai-dev-auto-goal.ps1:453:    $safeTitle = $Title.Trim()
  scripts\ai-dev-auto-goal.ps1:454:    $safeDescription = $Description.Trim()
  scripts\ai-dev-auto-goal.ps1:455:
  scripts\ai-dev-auto-goal.ps1:456:    $plan = [PSCustomObject][ordered]@{
  scripts\ai-dev-auto-goal.ps1:457:        goalMarkdown = @"
  scripts\ai-dev-auto-goal.ps1:458:# 목표
  scripts\ai-dev-auto-goal.ps1:459:
  scripts\ai-dev-auto-goal.ps1:460:$safeTitle
  scripts\ai-dev-auto-goal.ps1:461:
  scripts\ai-dev-auto-goal.ps1:462:## 배경
  scripts\ai-dev-auto-goal.ps1:463:
  scripts\ai-dev-auto-goal.ps1:464:$safeDescription
  scripts\ai-dev-auto-goal.ps1:465:
  scripts\ai-dev-auto-goal.ps1:466:## 성공 기준
  scripts\ai-dev-auto-goal.ps1:467:
  scripts\ai-dev-auto-goal.ps1:468:- 입력한 목표에서 현재 작업을 준비한다.
  scripts\ai-dev-auto-goal.ps1:469:- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
  scripts\ai-dev-auto-goal.ps1:470:- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
  scripts\ai-dev-auto-goal.ps1:471:
  scripts\ai-dev-auto-goal.ps1:472:## 제약사항
  scripts\ai-dev-auto-goal.ps1:473:
  scripts\ai-dev-auto-goal.ps1:474:- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
  scripts\ai-dev-auto-goal.ps1:475:- 저장소 정책과 현재 작업 범위를 따른다.
  scripts\ai-dev-auto-goal.ps1:476:
  scripts\ai-dev-auto-goal.ps1:477:## 범위 제외
  scripts\ai-dev-auto-goal.ps1:478:
  scripts\ai-dev-auto-goal.ps1:479:- 패키지 변경
  scripts\ai-dev-auto-goal.ps1:480:- DB 삭제 또는 초기화
  scripts\ai-dev-auto-goal.ps1:481:- 광범위한 리팩터링



diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..e2d571744ecdebfdaa1c9c4e5e49c5e79ca82c09
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }
@@ -429,41 +450,44 @@
     )
 
     $now = (Get-Date).ToUniversalTime().ToString("o")
-    $safeCommitTitle = $Title.Trim()
+    $safeTitle = $Title.Trim()
+    $safeDescription = $Description.Trim()
 
     $plan = [PSCustomObject][ordered]@{
         goalMarkdown = @"
-# 紐⑺몴
+# 목표
 
-$safeCommitTitle
+$safeTitle
 
-## 諛곌꼍
+## 배경
 
-$($Description.Trim())
+$safeDescription
 
-## ?깃났 湲곗?
+## 성공 기준
 
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
+- 입력한 목표에서 현재 작업을 준비한다.
+- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
+- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
 
-## ?쒖빟?ы빆
+## 제약사항
 
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
+- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
+- 저장소 정책과 현재 작업 범위를 따른다.
 
-## ?쒖쇅 踰붿쐞
+## 범위 제외
 
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
+- 패키지 변경
+- DB 삭제 또는 초기화
+- 광범위한 리팩터링
 
-## ?섎룞 ?뺤씤
+## 수동 검증
 
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
+- DryRun 계획과 JSON 출력을 검토한다.
+- 현재 작업 프롬프트 생성 여부를 확인한다.
+- 필요한 경우 빌드와 검증은 별도로 실행한다.
 "@
         queue = [PSCustomObject][ordered]@{
-            goalTitle = $safeCommitTitle
+            goalTitle = $safeTitle
             goalSource = $goalRelativePath
             createdAt = $now
             updatedAt = $now
@@ -471,16 +495,16 @@
             tasks = @(
                 [PSCustomObject][ordered]@{
                     id = "T001"
-                    title = $safeCommitTitle
-                    description = $Description.Trim()
+                    title = $safeTitle
+                    description = $safeDescription
                     type = "implementation"
                     status = "in_progress"
                     priority = "P0"
                     dependsOn = @()
                     filesLikelyToChange = @()
                     verification = @(
-                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
+                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
+                        "필요한 경우 npm run build를 별도로 실행한다."
                     )
                     commitMessage = $null
                 }
@@ -503,43 +527,6 @@
             stopReason = $null
         }
     }
-
-    $plan.goalMarkdown = @"
-# 紐⑺몴
-
-$safeCommitTitle
-
-## 諛곌꼍
-
-$($Description.Trim())
-
-## ?깃났 湲곗?
-
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
-
-## ?쒖빟?ы빆
-
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
-
-## ?쒖쇅 踰붿쐞
-
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
-
-## ?섎룞 ?뺤씤
-
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
-"@
-
-    $dryRunTask = @($plan.queue.tasks)[0]
-    $dryRunTask.verification = @(
-        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
-    )
 
     return $plan
 }

codex
완료했습니다.

변경한 파일:
- [scripts/ai-dev-auto-goal.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-goal.ps1:301)

구현 요약:
- DryRun goal/task 미리보기의 깨진 한국어 문자열을 정상 한국어로 복구했습니다.
- Codex가 생성한 `queue/state` 검증을 강화했습니다.
  - `queue.currentTaskId`는 `T001`이어야 함
  - `state.currentTaskId`는 `T001`이어야 함
  - `T001` task가 존재하고 `in_progress`여야 함
  - 이후 task는 `pending`이어야 함
- `.ai-dev/README.md`에는 이미 `ai-dev-auto-goal.ps1` 사용법과 안전 기준이 문서화되어 있어 수정하지 않았습니다.

검증:
- PowerShell 문법 검증 통과
- `-DryRun` 텍스트 출력 확인
- `-DryRun -Json` 순수 JSON 출력 확인
- 공백/누락 `GoalTitle` 오류 종료 확인
- `-DryRun -AllowRun -Json`에서 full-cycle 호출이 실제 실행되지 않고 단계만 표시되는 것 확인

실행하지 않은 검증:
- `npm run build`, `npm run lint`, `npm run test`는 지시 범위상 실행하지 않았습니다.
- 실제 Codex CLI 실행 및 실제 full cycle 실행은 파일 작성/외부 실행을 수반하므로 실행하지 않았습니다.

남은 위험:
- 실제 `codex exec` 출력 품질과 실제 dirty worktree 게이트는 실사용 환경에서 별도 확인이 필요합니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
`T007: ai-dev-auto-goal.ps1 DryRun 미리보기 문자열을 복구하고 goal/queue/state 생성 검증을 T001 시작 규칙에 맞게 강화했다. Powe
rShell 문법, DryRun, Json 출력, 빈 GoalTitle 오류 경로를 확인했다.`
diff --git a/scripts/ai-dev-auto-goal.ps1 b/scripts/ai-dev-auto-goal.ps1
index 21176dc6aaf035988d7455fbb97b39eaff37ac50..e2d571744ecdebfdaa1c9c4e5e49c5e79ca82c09
--- a/scripts/ai-dev-auto-goal.ps1
+++ b/scripts/ai-dev-auto-goal.ps1
@@ -297,6 +297,10 @@
         $errors += "queue.tasks must contain no more than three tasks."
     }
 
+    if ($Queue.currentTaskId -ne "T001") {
+        $errors += "queue.currentTaskId must be T001."
+    }
+
     $taskIds = @()
 
     foreach ($task in $tasks) {
@@ -360,6 +364,19 @@
         $errors += "queue.currentTaskId does not match a task: $($Queue.currentTaskId)"
     }
 
+    $firstTask = $tasks | Where-Object { $_.id -eq "T001" } | Select-Object -First 1
+    if ($null -eq $firstTask) {
+        $errors += "queue.tasks must include T001."
+    } elseif ($firstTask.status -ne "in_progress") {
+        $errors += "T001 must be in_progress."
+    }
+
+    foreach ($laterTask in @($tasks | Where-Object { $_.id -ne "T001" })) {
+        if ($laterTask.status -ne "pending") {
+            $errors += "later tasks must be pending: $($laterTask.id)"
+        }
+    }
+
     return $errors
 }
 
@@ -388,6 +405,10 @@
         $errors += "state.currentTaskId must match queue.currentTaskId."
     }
 
+    if ($State.currentTaskId -ne "T001") {
+        $errors += "state.currentTaskId must be T001."
+    }
+
     if (@("not_started", "passed", "failed", "blocked") -notcontains $State.lastCommandStatus) {
         $errors += "invalid state.lastCommandStatus: $($State.lastCommandStatus)"
     }
@@ -429,41 +450,44 @@
     )
 
     $now = (Get-Date).ToUniversalTime().ToString("o")
-    $safeCommitTitle = $Title.Trim()
+    $safeTitle = $Title.Trim()
+    $safeDescription = $Description.Trim()
 
     $plan = [PSCustomObject][ordered]@{
         goalMarkdown = @"
-# 紐⑺몴
+# 목표
 
-$safeCommitTitle
+$safeTitle
 
-## 諛곌꼍
+## 배경
 
-$($Description.Trim())
+$safeDescription
 
-## ?깃났 湲곗?
+## 성공 기준
 
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븷 ???덈떎.
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
+- 입력한 목표에서 현재 작업을 준비한다.
+- full auto-cycle 실행 전에 현재 작업 프롬프트가 생성된다.
+- full auto-cycle은 명시적인 허용 옵션이 있을 때만 실행된다.
 
-## ?쒖빟?ы빆
+## 제약사항
 
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?뚭눼?곸씤 git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
+- 서버 API, 로그인, 클라우드 동기화, npm install, 위험한 git 명령은 사용하지 않는다.
+- 저장소 정책과 현재 작업 범위를 따른다.
 
-## ?쒖쇅 踰붿쐞
+## 범위 제외
 
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
+- 패키지 변경
+- DB 삭제 또는 초기화
+- 광범위한 리팩터링
 
-## ?섎룞 ?뺤씤
+## 수동 검증
 
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶??寃?щ? 蹂꾨룄濡??ㅽ뻾?쒕떎.
+- DryRun 계획과 JSON 출력을 검토한다.
+- 현재 작업 프롬프트 생성 여부를 확인한다.
+- 필요한 경우 빌드와 검증은 별도로 실행한다.
 "@
         queue = [PSCustomObject][ordered]@{
-            goalTitle = $safeCommitTitle
+            goalTitle = $safeTitle
             goalSource = $goalRelativePath
             createdAt = $now
             updatedAt = $now
@@ -471,16 +495,16 @@
             tasks = @(
                 [PSCustomObject][ordered]@{
                     id = "T001"
-                    title = $safeCommitTitle
-                    description = $Description.Trim()
+                    title = $safeTitle
+                    description = $safeDescription
                     type = "implementation"
                     status = "in_progress"
                     priority = "P0"
                     dependsOn = @()
                     filesLikelyToChange = @()
                     verification = @(
-                        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-                        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
+                        "변경 범위가 현재 목표와 일치하는지 확인한다.",
+                        "필요한 경우 npm run build를 별도로 실행한다."
                     )
                     commitMessage = $null
                 }
@@ -503,43 +527,6 @@
             stopReason = $null
         }
     }
-
-    $plan.goalMarkdown = @"
-# 紐⑺몴
-
-$safeCommitTitle
-
-## 諛곌꼍
-
-$($Description.Trim())
-
-## ?깃났 湲곗?
-
-- ?낅젰??紐⑺몴?먯꽌 ?묒? ?꾩옱 ?묒뾽??以鍮꾪븳??
-- ?꾩껜 ?먮룞 ?ъ씠???ㅽ뻾 ?꾩뿉 ?꾩옱 ?묒뾽 ?꾨＼?꾪듃媛 ?앹꽦?쒕떎.
-- ?꾩껜 ?먮룞 ?ъ씠?댁? 紐낆떆?곸씤 ?덉슜 ?듭뀡???덉쓣 ?뚮쭔 ?ㅽ뻾?쒕떎.
-
-## ?쒖빟?ы빆
-
-- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? npm install, ?꾪뿕??git 紐낅졊? ?ъ슜?섏? ?딅뒗??
-- ??μ냼 ?뺤콉怨??꾩옱 ?묒뾽 踰붿쐞瑜??곕Ⅸ??
-
-## ?쒖쇅 踰붿쐞
-
-- ?⑦궎吏 蹂寃?- DB ??젣 ?먮뒗 珥덇린??- 愿묐쾾?꾪븳 由ы뙥?곕쭅
-
-## ?섎룞 ?뺤씤
-
-- DryRun 怨꾪쉷怨?JSON 異쒕젰??寃?좏븳??
-- ?꾩옱 ?묒뾽 ?꾨＼?꾪듃 ?앹꽦 ?щ?瑜??뺤씤?쒕떎.
-- ?꾩슂??寃쎌슦 鍮뚮뱶? 寃利앹? 蹂꾨룄濡??ㅽ뻾?쒕떎.
-"@
-
-    $dryRunTask = @($plan.queue.tasks)[0]
-    $dryRunTask.verification = @(
-        "蹂寃?踰붿쐞媛 ?꾩옱 紐⑺몴? ?쇱튂?섎뒗吏 ?뺤씤?쒕떎.",
-        "?꾩슂??寃쎌슦 npm run build瑜?蹂꾨룄濡??ㅽ뻾?쒕떎."
-    )
 
     return $plan
 }

tokens used
완료했습니다.

변경한 파일:
- [scripts/ai-dev-auto-goal.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-auto-goal.ps1:301)

구현 요약:
- DryRun goal/task 미리보기의 깨진 한국어 문자열을 정상 한국어로 복구했습니다.
- Codex가 생성한 `queue/state` 검증을 강화했습니다.
  - `queue.currentTaskId`는 `T001`이어야 함
  - `state.currentTaskId`는 `T001`이어야 함
  - `T001` task가 존재하고 `in_progress`여야 함
  - 이후 task는 `pending`이어야 함
- `.ai-dev/README.md`에는 이미 `ai-dev-auto-goal.ps1` 사용법과 안전 기준이 문서화되어 있어 수정하지 않았습니다.

검증:
- PowerShell 문법 검증 통과
- `-DryRun` 텍스트 출력 확인
- `-DryRun -Json` 순수 JSON 출력 확인
- 공백/누락 `GoalTitle` 오류 종료 확인
- `-DryRun -AllowRun -Json`에서 full-cycle 호출이 실제 실행되지 않고 단계만 표시되는 것 확인

실행하지 않은 검증:
- `npm run build`, `npm run lint`, `npm run test`는 지시 범위상 실행하지 않았습니다.
- 실제 Codex CLI 실행 및 실제 full cycle 실행은 파일 작성/외부 실행을 수반하므로 실행하지 않았습니다.

남은 위험:
- 실제 `codex exec` 출력 품질과 실제 dirty worktree 게이트는 실사용 환경에서 별도 확인이 필요합니다.

다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md` 기록용 요약:
`T007: ai-dev-auto-goal.ps1 DryRun 미리보기 문자열을 복구하고 goal/queue/state 생성 검증을 T001 시작 규칙에 맞게 강화했다. PowerShell 문법, DryRun, Json 출력, 빈 GoalTitle 오류 경로를 확인했다.`
71,363

```
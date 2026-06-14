# Codex Implementation Result

## Run

- Started at: 2026-06-14 22:02:58
- Ended at: 2026-06-14 22:04:57
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
session id: 019ec63a-6ef6-7972-be4e-f32d19c7394b
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev\
current-task-prompt.md
codex
작업 프롬프트를 직접 읽어 필요한 범위와 제약을 먼저 확인하겠습니다. 아직 파일 수정이나 빌드/테스트는 실행하지 않습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1109ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.

## 배경

현재 strict 리뷰에서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다. `npm run lint` 스크립트가 존재하는 경우 
BuildOnly 검증과 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 한다. 또한 `package.json`에 test 스크립
트가 없는 경우에는 테스트를 실행하지 않은 사유를 명확히 기록해야 한다.

## 성공 기준

- `package.json`에 lint 스크립트가 있으면 AI Dev Loop 검증 기록에 lint 결과가 포함된다.
- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.
- test 스크립트가 없으면 `test-result.md`에 test 미실행 사유가 명확히 기록된다.
- strict 리뷰에서 lint 미기록으로 반려되지 않는다.

## 제약사항

- 기존 AI Dev Loop 흐름을 크게 바꾸지 않는다.
- 검증 기록 생성 로직의 변경 범위를 작게 유지한다.
- 사용자 변경 사항을 되돌리지 않는다.
- 기존 프로젝트 구조와 TypeScript 스타일을 따른다.

## 범위 제외

- 새로운 테스트 프레임워크 추가는 제외한다.
- 대규모 구조 재작성은 제외한다.
- UI 변경은 제외한다.

## 수동 검증

- lint 스크립트가 있는 상태에서 자동 사이클 결과 파일에 lint 결과가 기록되는지 확인한다.
- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 사유가 기록되는지 확인한다.
- 기존 BuildOnly 검증 기록이 유지되는지 확인한다.


## Current Task

- Task ID: T001
- Title: 검증 기록 흐름 분석 및 lint 기록 개선
- Description: AI Dev Loop의 검증 결과 기록 흐름을 확인하고, lint 스크립트가 있을 때 lint 결과가 test-result.md에 자동 기록되도록 작게 
수정한다. test 스크립트가 없을 때는 테스트 미실행 사유를 명확히 남긴다.
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

- .ai-dev/test-result.md
- .ai-dev 관련 자동 사이클 스크립트

## Verification

- lint 스크립트가 있는 경우 lint 결과 기록 여부 확인
- test 스크립트가 없는 경우 미실행 사유 기록 여부 확인
- BuildOnly 검증 기록과 lint 기록이 구분되는지 확인

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
프롬프트 기준으로 수정 대상은 `.ai-dev` 자동 사이클 기록 로직입니다. `src` 밖 파일을 수정해야 하는 이유는 이 기능이 앱 UI가 아니라 AI Dev Loop의 검증 
결과 파일 생성 흐름에 속하기 때문입니다. 먼저 `.ai-dev` 스크립트와 `package.json`의 스크립트 정의만 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg --files .ai-dev' in D:
\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\package.json'" in D:\ai-apps\planpilot-local
 succeeded in 1316ms:
{
  "name": "planpilot-local",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "eslint .",
    "preview": "vite preview"
  },
  "dependencies": {
    "dexie": "^4.4.2",
    "react": "^19.2.5",
    "react-dom": "^19.2.5",
    "zustand": "^5.0.13"
  },
  "devDependencies": {
    "@eslint/js": "^10.0.1",
    "@types/node": "^24.12.2",
    "@types/react": "^19.2.14",
    "@types/react-dom": "^19.2.3",
    "@vitejs/plugin-react": "^6.0.1",
    "eslint": "^10.2.1",
    "eslint-plugin-react-hooks": "^7.1.1",
    "eslint-plugin-react-refresh": "^0.5.2",
    "globals": "^17.5.0",
    "typescript": "~6.0.2",
    "typescript-eslint": "^8.58.2",
    "vite": "^8.0.10"
  }
}

 succeeded in 1574ms:
.ai-dev\test-result.md
.ai-dev\state.json
.ai-dev\state.example.json
.ai-dev\review.md
.ai-dev\review-response.json
.ai-dev\review-prompt.md
.ai-dev\README.md
.ai-dev\queue.json
.ai-dev\queue.example.json
.ai-dev\plan.md
.ai-dev\loop-log.md
.ai-dev\goal.md
.ai-dev\extra-instructions.example.md
.ai-dev\diff.md
.ai-dev\current-task-prompt.md
.ai-dev\codex-review-result.md
.ai-dev\codex-result.md
.ai-dev\backlog.md
.ai-dev\auto-goal-planning-prompt.md

codex
`package.json`에는 `lint`가 있고 `test`는 없습니다. 이제 `.ai-dev` 안에서 `test-result.md`를 쓰는 지점과 BuildOnly 기록 형식을
 찾아 수정 범위를 좁히겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg "test-result|BuildOnly
|lint|npm run|test script|package.json" .ai-dev' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\.ai-dev\\test-result.md'" in D:\ai-apps\planpilot-local
 succeeded in 1685ms:
# AI Dev Test Result

## 2026-06-14 21:54:01

- Overall result: passed
- Current task: T001
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: skipped

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
dist/assets/index-BCEAFpLX.js   316.26 kB │ gzip: 99.82 kB

[32m✓ built in 230ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
### npm run lint

- Status: skipped
- Exit code: 없음

```text
-BuildOnly 옵션으로 건너뛰었습니다.
```
---

## Manual verification: 업무 목록 빈 상태 안내 문구 개선

### npm scripts

`	ext
{
  "dev": "vite",
  "build": "tsc -b && vite build",
  "lint": "eslint .",
  "preview": "vite preview"
}

`"
"


`	ext

> planpilot-local@0.0.0 lint
> eslint .


`"
"


- 앱 변경 범위는 src/views/TasksView.tsx의 빈 상태 안내 문구 수정으로 제한되었습니다.
- 기능 로직 변경 없이 사용자 안내 문구만 수정되었습니다.
- npm run lint를 수동 실행했고 오류 없이 종료되었습니다.
- npm run test는 package.json에 test 스크립트가 없으면 별도 실행 대상이 아닙니다.

 succeeded in 1726ms:
# PlanPilot Local AI 개발 입력 폴더

이 폴더는 PlanPilot Local의 Level 5 AI 자동 개발 루프에서 목표와 후속 작업 후보를 관리하기 위한 기본 공간이다.

현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex CLI 완전 자동화 실행기는 다음 목표에서 단계적으로 도입하며, 각 task 전환
 전에는 `goal.md`, `queue.json`, `state.json`을 확인한다.

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

AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 사용자가 매번 `chcp 65001`을 직접 실행
할 필요는 없다.

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

`goal.md`, `queue.json`, `state.json`을 읽어 현재 task만 수행하도록 지시하는 `.ai-dev/current-task-prompt.md` 파일을 생
성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
```

프롬프트 생성 스크립트는 기존 `current-task-prompt.md`를 현재 task 기준으로 덮어쓴다. Codex 실행, GPT 리뷰, build/test 실행, git c
ommit은 수행하지 않는다.

기본 추가 지시 파일인 `.ai-dev/extra-instructions.md`가 있으면 해당 내용을 프롬프트 끝의 `Extra Instructions` 섹션에 포함한다. 이 파일
이 없으면 기존과 동일하게 goal, queue, state만 사용해 프롬프트를 생성한다.

다른 추가 지시 파일을 사용하려면 `-ExtraInstructionsPath`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1 -ExtraInstructionsPath .ai-d
ev/extra-instructions.example.md
```

추가 지시는 goal, queue, state 내용을 덮어쓰지 않는다. `current-task-prompt.md`를 직접 수정하지 말고, 반복해서 필요한 보조 지시는 `.ai-d
ev/extra-instructions.md` 또는 별도 파일에 작성한다.

## task 완료 처리

현재 task를 완료 처리하고 다음 pending task로 이동하려면 다음 명령을 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "T001 분석 완료
"
```

특정 task를 완료 처리하려면 `-TaskId`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -TaskId T001 -ResultSummar
y "분석 완료"
```

다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoNext
```

task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, g
it commit은 수행하지 않는다.

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

T006 같은 최종 검증 task에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 결과
를 사람이 직접 수행했다면 수동 요약만 `test-result.md`에 기록할 수 있다. 이 모드는 npm build/test/lint를 실행하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -ManualSummaryOnly -ManualSummary 
"PowerShell 문법 검증 통과. auto-step DryRun 통과. auto-cycle DryRun 통과. save-review 실패/성공 흐름 확인."
```

수동 요약 모드는 실제 명령 실행 결과를 조작하는 용도가 아니다. 실행하지 않은 검증은 통과로 적지 말고, 수행한 명령과 결과만 요약한다.

이 모드에서 `state.json`의 `lastCommandStatus`는 수동 요약 기록 작업의 성공 여부를 뜻한다. 실제 검증 통과/실패/미수행 판단은 `test-result.
md`의 요약 본문에 명확히 적는다.

## git diff 저장

현재 git 변경사항을 `diff.md`에 저장해 GPT 리뷰 또는 사람 검토에 사용할 수 있게 한다. 기본 동작은 untracked 파일명을 git status에 표시하지만 파일
 내용은 포함하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
```

추적되지 않은 작은 텍스트 파일의 내용도 포함하려면 `-IncludeUntrackedContent` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1 -IncludeUntrackedContent
```

git diff 저장 스크립트는 `diff.md`와 `state.json`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행하지 않
는다.

다음 생성 산출물은 자기 중첩과 과도한 크기 증가를 줄이기 위해 Unstaged/Staged Diff와 Diff Stat 대상에서 기본 제외한다. tracked 변경 파일은 `Sk
ipped Generated AI Dev Artifact Diffs` 섹션에 파일명만 기록한다. `-IncludeUntrackedContent`를 사용한 경우 untracked 생
성 산출물도 내용 포함에서 제외하고 `Skipped Generated AI Dev Artifacts` 섹션에 파일명만 기록한다.

- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/current-task-prompt.md`
- `.ai-dev/revise-prompt.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/review-response.json`

git diff/stat 명령의 stderr 경고는 diff 본문과 분리한다. git 명령이 실패하면 기존처럼 `state.json`에 실패 결과를 기록하고 종료한다.

`Git Status` 섹션에는 생성 산출물을 포함한 전체 변경 파일을 그대로 표시한다. `.ai-dev/README.md`, `scripts/ai-dev-save-diff.ps1
`처럼 실제 작업 대상 파일은 위 제외 목록에 없으므로 diff 본문에 포함된다.

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

GPT API 키가 없는 환경에서는 ChatGPT 웹 화면을 사용해 리뷰를 수동으로 진행한다. AI Dev Loop는 prompt 생성과 저장 흐름만 돕고, ChatGPT 웹 화면
에 자동 접속하거나 GPT API를 직접 호출하지 않는다.

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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1 -GenerateIfMissing -S
trict
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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-r
esponse.json
```

JSON 문자열이나 클립보드 내용을 직접 사용할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewJson '{"decision":"pa
ss","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_step":"co
mplete_task"}'
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

ChatGPT 웹 화면에서 받은 리뷰를 저장할 때는 JSON 리뷰 전체를 클립보드에 복사한 뒤 `-FromClipboard`를 실행한다. 순수 JSON 객체, `json` 코드블록
, 일반 텍스트 안에 포함된 첫 번째 JSON 객체를 최대한 파싱한다.

저장 실패 시 확인할 항목:

- 클립보드가 비어 있지 않은지 확인한다.
- ChatGPT 응답에서 JSON 객체 전체를 다시 복사한다.
- Markdown 코드블록을 포함해도 되지만, 가능하면 JSON만 복사한다.
- 오류 메시지의 입력 preview 앞부분을 보고 다른 설명 문장이나 잘린 JSON이 섞였는지 확인한다.

파싱 실패, 빈 입력, 필수 필드 누락 같은 입력 오류는 기본적으로 `review.md`와 `state.json`을 수정하지 않는다. review-prompt나 명령어를 실수로 클
립보드에 둔 상태에서 `-FromClipboard`를 실행해도 기존 리뷰 상태를 blocked/critical로 덮어쓰지 않기 위한 안전 동작이다.

실패 자체를 리뷰 결과로 기록해야 하는 특별한 경우에만 `-WriteFailureReview`를 함께 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard -WriteFailure
Review
```

잘못 실행했다면 ChatGPT가 출력한 JSON 리뷰만 다시 클립보드에 복사한 뒤 `-FromClipboard`를 재실행한다.

리뷰 결과 저장 스크립트는 `pass + complete_task`, `revise + revise_with_codex`, `blocked` 또는 `stop_for_user` 결과
에 맞는 다음 행동을 안내만 한다. GPT API 호출, Codex 실행, build/test 실행, git commit은 수행하지 않는다.

## 리뷰 반영 재수정 프롬프트 생성

`review.md`의 required changes를 반영하도록 Codex 또는 Cline에 전달할 `revise-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
```

optional suggestions도 현재 task 범위 안에서 반영할 수 있게 하려면 `-AllowOptionalSuggestions` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 -AllowOptionalSuggest
ions
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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.ps1,
.ai-dev/README.md -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Files scripts/ai-dev-commit.ps1,
.ai-dev/README.md
```

커밋 메시지를 직접 지정하거나 검증·리뷰 게이트를 명시적으로 우회할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Message "chore(ai-dev): add auto
mation helpers"
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -AllowWithoutPassedCheck -AllowWi
thoutPassedReview
```

`-Files`를 지정하지 않으면 자동 커밋 스크립트는 기존처럼 `git add -A`로 현재 작업 트리의 모든 변경사항을 stage한다. `-Files`를 지정하면 각 파일이 존
재하고 변경사항이 있는지 확인한 뒤 `git add -- <files>`로 지정 파일만 stage한다. 선택 파일 외에 이미 staged 된 파일이 있으면 안전을 위해 중단한다.

실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 수행하지 않는다.

## 실행 산출물 커밋 기준

AI Dev Loop의 실제 기능 변경과 `.ai-dev` 실행 상태는 가능한 한 별도 커밋으로 관리한다.

- 기능 커밋에는 현재 task의 코드와 직접 관련 문서만 포함한다.
- 루프 상태 커밋에는 필요할 때 `queue.json`, `state.json`, `loop-log.md`, `test-result.md`, `review.md` 등을 포함할 수
 있다.
- `diff.md`와 `review-prompt.md`는 커질 수 있으므로 항상 커밋하지 않는다.
- `review-response.json`은 민감 정보나 장문 내용이 포함될 수 있으므로 내용을 확인한 뒤 커밋 여부를 결정한다.
- untracked 텍스트 파일 내용은 리뷰에 필요할 수 있지만, 리뷰 포함 여부와 커밋 대상 여부는 별도로 판단한다.
- 대형 또는 민감 산출물은 정리하거나 별도 정책에 따라 제외한다.

커밋 전에는 `git status --short`와 `ai-dev-commit.ps1 -DryRun`으로 대상을 먼저 확인한다. 선택 파일 커밋 기능이 준비되면 전체 stage보다
 선택 파일 방식을 우선한다.

세부 기준은 `docs/ai-dev-loop-policy.md`의 `.ai-dev` 실행 산출물 커밋/무시 정책을 따른다. 실제 `.gitignore` 변경은 별도 task에서 검
토한다.

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

수동 사이클 안내 스크립트는 추천 명령과 파일 경로만 보여주며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 않
는다.

`manual-cycle`에서 다음 action이 `ask_gpt_review`로 표시되면 수동 리뷰 브리지를 사용한다. GPT API 키가 없어도 아래 흐름으로 리뷰를 진행할 수
 있다.

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

`ai-dev-auto-step.ps1`는 현재 상태를 보고 안전한 다음 한 단계만 실행하는 보조 스크립트로 도입할 예정이다. `ai-dev-next.ps1`처럼 안내만 하는 명령
과 달리, 허용된 로컬 스크립트는 직접 실행할 수 있다.

명령 선택 기준:

| 상황 | 사용할 명령 | 이유 |
| --- | --- | --- |
| 현재 상태와 다음 행동을 한 화면에서 보고 싶을 때 | `scripts/ai-dev-manual-cycle.ps1` | 상태 요약, 다음 action, 관련 파일 존재 여부를 
함께 보여주는 수동 운영 대시보드다. |
| 다음 action과 추천 명령만 확인하고 싶을 때 | `scripts/ai-dev-next.ps1` | 읽기/안내용 스크립트이며 하위 명령을 자동 실행하지 않는다. |
| 안전한 다음 한 단계만 자동으로 진행하고 싶을 때 | `scripts/ai-dev-auto-step.ps1` | `next` 판단 결과를 기반으로 허용된 로컬 스크립트만 한 번
 실행한다. |
| 여러 안전 단계를 제한 횟수 안에서 이어가고 싶을 때 | `scripts/ai-dev-auto-cycle.ps1` | auto-step 반복용이며 사용자 개입 필요 상태에서 중
단한다. |

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

첫 번째 명령으로 `review-prompt.md`를 클립보드에 복사한 뒤 ChatGPT 웹 화면에 붙여넣는다. ChatGPT가 JSON 리뷰만 출력하면 그 JSON을 다시 클립보
드에 복사하고 두 번째 명령으로 저장한다.

`ai-dev-auto-cycle.ps1`는 제한 횟수 안에서 auto-step을 반복하는 초기 자동화 스크립트다. 사용자 개입이 필요한 action, 실패, 반복 위험, comm
it 필요 상태에서는 중단한다.

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

auto-cycle은 Codex/Cline 작업, GPT 리뷰, revise, commit, blocked, 사용자 개입 필요 action에서 멈춘다. 무한 루프를 피하기 위해 `
-MaxSteps` 제한과 같은 action 반복 감지를 사용한다.

auto-cycle이 `ask_gpt_review`에서 멈추면 `stoppedReason`은 `user_intervention_required:ask_gpt_review`로 표시된
다. 이때 텍스트 출력과 JSON 출력의 step 항목에는 수동 리뷰 브리지 명령이 함께 표시된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

첫 번째 명령으로 `review-prompt.md`를 ChatGPT 웹 화면에 붙여넣을 수 있도록 복사하고, JSON 리뷰를 받은 뒤 두 번째 명령으로 클립보드의 리뷰 JSON을 
저장한다. auto-cycle은 이 단계에서 GPT API를 호출하지 않고 중단한다.

명령 역할 구분:

- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 출력한다. 자동 실행하지 않는다.
- `ai-dev-manual-cycle.ps1`: `status`와 `next`를 함께 보여주는 수동 운영 대시보드다. 자동 실행하지 않는다.
- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전한 action 한 단계만 자동 실행한다. 위험 action은 실행하지 않고 안내 후 중단한다.
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
- `ask_gpt_review`: `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -FromClipboard`를 사용해 수동
 리뷰 브리지로 진행한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만든다.
- `blocked`: 사용자 판단이 필요하므로 자동 진행을 멈춘다.
- `commit`: 자동 실행하지 않고 커밋 조건과 대상 파일을 사람이 확인한다.

`goal_completed` 상태에서 `auto-step`은 추가 작업을 실행하지 않고 현재 goal이 완료되었으며 더 실행할 task가 없다고 안내한다. 추천 명령에는 상태 확
인용 `ai-dev-status.ps1`만 포함한다.

`auto-cycle`이 `goal_completed`로 멈추면 텍스트 출력에서는 “목표 완료로 종료” 의미를 표시하고, JSON 출력에서는 `completed: true`, `s
toppedReason: "goal_completed"`를 유지한다. 다음 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-de
v/state.json`을 새 목표 기준으로 초기화한다.

`save-review` 실패는 잘못된 클립보드 입력 때문에 발생할 수 있다. 실패 시에는 오류 preview를 확인하고 JSON 리뷰만 다시 복사한다. 완료된 goal이나 기존 
정상 상태를 불필요하게 오염시키지 않도록 실패 기록 방식은 별도 정책에 따라 개선한다.

최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/실패 흐름 확인 결과를 `test
-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.

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

- `scripts/ai-dev-run-codex.ps1`: `.ai-dev/current-task-prompt.md`를 Codex CLI에 전달해 현재 task 구현을 수행한다.
- `scripts/ai-dev-run-review-codex.ps1`: `.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 저장
 흐름에 연결한다.
- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저장, Codex 리뷰, save-review, 
pass 시 commit/complete-task를 연결한다.
- `scripts/ai-dev-auto-goal.ps1`: 사용자가 `GoalTitle`과 `GoalDescription`만 입력하면 goal/queue/state 생성, cur
rent-task-prompt 생성, full auto-cycle 실행까지 이어지게 한다.

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

dirty worktree에서도 실행해야 하는 특별한 경우에만 `-AllowDirty`를 명시한다. 이 옵션은 사용자 변경과 Codex 변경이 섞일 수 있으므로 full cycle
에서는 초기 기본값으로 사용하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty
```

이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, npm install, package 파일
 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.

### Codex 리뷰 실행

`.ai-dev/review-prompt.md`를 Codex CLI에 전달해 JSON 리뷰를 생성하고 `.ai-dev/review-response.json`에 저장한다. 실행 전 
`git status --short`를 확인하고, 작업 트리가 dirty이면 기본 중단한다. 리뷰 대상 변경사항이 남아 있는 상태에서 실행해야 하는 경우에만 `-AllowDirty
`를 명시한다.

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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -GenerateReviewPromptIf
Missing
```

리뷰 JSON 저장 후 `ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json` 흐름까지 이어가려면 `-SaveRevi
ew`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview
```

자동화에서 결과만 읽고 싶으면 `-Json`을 함께 사용할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-review-codex.ps1 -DryRun -Json
```

주의:

- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체만 출력하라는 안전 규칙을 추가한다.
- JSON 리뷰에는 `decision`, `severity`, `summary`, `required_changes`, `optional_suggestions`, `next_ste
p` 필드가 필요하다.
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
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 1 -Max
Steps 20
```

여러 task 반복 구조를 확인하려면 `MaxTasks`를 늘릴 수 있다. 실제 반복은 각 task의 commit/complete-task가 성공해야 다음 task로 넘어간다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -DryRun -MaxTasks 3 -Max
Steps 20
```

`-AllowCodex` 없이 실제 실행하면 prompt 생성 이후 Codex 구현 실행 직전에서 중단하고 추천 명령을 출력한다. Codex 구현까지 허용하려면 명시적으로 `-Al
lowCodex`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex
```

Codex 구현과 Codex 리뷰까지 이어가려면 `-AllowCodex`와 `-AllowReviewCodex`를 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReview
Codex -MaxTasks 1
```

리뷰가 `pass`이고 package 파일 변경이 없을 때 자동 커밋과 task 완료까지 허용하려면 `-AllowCommit`을 함께 지정한다. 커밋 메시지는 기본적으로 현재 ta
sk의 `commitMessage`를 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReview
Codex -AllowCommit -MaxTasks 1
```

선택 파일만 커밋하려면 `-CommitFiles`를 지정한다. 이 값은 그대로 `ai-dev-commit.ps1 -Files`에 전달된다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReview
Codex -AllowCommit -CommitFiles scripts/ai-dev-auto-cycle-full.ps1,.ai-dev/README.md -MaxTasks 1
```

최대 3개 task까지 연속 실행하려면 `MaxTasks 3`을 지정한다. complete-task가 queue/state/loop-log를 갱신하므로, 다음 task 구현 실행 
시 dirty worktree 정책을 별도로 판단해야 한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReview
Codex -AllowCommit -AllowDirty -MaxTasks 3
```

dirty worktree에서 Codex 구현을 실행해야 하는 특별한 경우에만 `-AllowDirty`를 추가한다. dirty 상태 기본 중단 정책은 `ai-dev-run-code
x.ps1`와 `ai-dev-run-review-codex.ps1`의 안전 게이트가 담당한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -AllowCodex -AllowReview
Codex -AllowDirty -MaxTasks 1
```

리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 complete-
task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `package-lock
.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 기록하지 못하면 `commit
_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.

### 목표 입력 기반 자동 실행

최종 목표는 사용자가 goal 파일과 queue 파일을 직접 편집하지 않고도 한 줄 명령으로 작은 앱 기능 task를 시작할 수 있게 하는 것이다.

먼저 DryRun으로 생성될 goal/task 계획과 실행 단계를 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 추
가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun
```

자동화 도구에서 결과만 파싱해야 하면 `-Json`을 함께 사용한다. JSON 출력은 사람이 읽는 텍스트와 섞지 않는다.
DryRun JSON에는 `plan.goalMarkdown`, `plan.queue`, `plan.state` 미리보기가 포함되므로 파일 작성 전에 생성될 goal/task 계획을
 검토할 수 있다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 추
가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -DryRun -Json
```

실제 goal/queue/state 생성과 current-task-prompt 생성까지만 수행하려면 `-DryRun`을 제거한다. 이 모드는 `ai-dev-auto-cycle-fu
ll.ps1`을 호출하지 않는다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 추
가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다."
```

생성 후 full auto-cycle 래퍼 호출까지 이어가려면 `-AllowRun` 또는 `-AllowCodex`, `-AllowReviewCodex`, `-AllowCommit`
 같은 명시적 실행 옵션을 지정한다. `-AllowRun` 단독은 full-cycle 래퍼 호출만 허용하며 Codex 구현이나 Codex 리뷰 권한을 대신하지 않는다. 실제 구현까
지 허용하려면 `-AllowCodex`, 리뷰까지 허용하려면 `-AllowReviewCodex`, 자동 커밋과 task 완료까지 허용하려면 기존 full cycle과 동일하게 `-
AllowCodex -AllowReviewCodex -AllowCommit`을 함께 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라이트 추
가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex -AllowCo
mmit -MaxTasks 1
```

동작:

1. `GoalTitle`과 `GoalDescription`을 검증한다.
2. Codex CLI를 이용해 goal/queue/state 초안을 생성한다.
3. Codex 출력에서 `goalMarkdown`, `queue`, `state` JSON을 추출한다.
4. `queue.json`과 `state.json`의 필수 필드, currentTaskId, task 배열, enum 값을 검증한다.
5. `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 작성한다.
6. `.ai-dev/current-task-prompt.md`를 생성한다.
7. 명시적 실행 옵션이 있을 때만 `ai-dev-auto-cycle-full.ps1`로 이어간다.
8. auto-goal이 생성한 `.ai-dev/goal.md`, `queue.json`, `state.json`, `current-task-prompt.md`, 결과 파일 때문에
 하위 full cycle의 dirty worktree 게이트가 중단되지 않도록 내부적으로 `-AllowDirty`를 전달한다. 초기 dirty worktree 게이트는 auto-
goal 시작 전에 별도로 유지한다.

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

 succeeded in 2041ms:
.ai-dev\auto-goal-planning-prompt.md:Title: AI Dev Loop lint 검증 자동 기록
.ai-dev\auto-goal-planning-prompt.md:Description: AI Dev Loop 자동 사이클에서 npm run lint 스크립트가 존재하면 Build
Only 검증과 별개로 lint를 실행하거나 결과를 test-result.md에 자동 기록하여 strict 리뷰에서 lint skipped로 반려되지 않도록 개선한다. packag
e.json에 test 스크립트가 없는 경우에는 test 미실행 사유를 명확히 기록한다.
.ai-dev\codex-review-result.md:  - npm run build: passed
.ai-dev\codex-review-result.md:  - npm run test: skipped
.ai-dev\codex-review-result.md:  - npm run lint: skipped
.ai-dev\codex-review-result.md:### npm run build
.ai-dev\codex-review-result.md:### npm run test
.ai-dev\codex-review-result.md:-BuildOnly 옵션으로 건너뛰었습니다.
.ai-dev\codex-review-result.md:### npm run lint
.ai-dev\codex-review-result.md:-BuildOnly 옵션으로 건너뛰었습니다.
.ai-dev\codex-review-result.md:  "lint": "eslint .",
.ai-dev\codex-review-result.md:> planpilot-local@0.0.0 lint
.ai-dev\codex-review-result.md:> eslint .
.ai-dev\codex-review-result.md:- npm run lint를 수동 실행했고 오류 없이 종료되었습니다.
.ai-dev\codex-review-result.md:- npm run test는 package.json에 test 스크립트가 없으면 별도 실행 대상이 아닙니다.
.ai-dev\codex-review-result.md: M .ai-dev/test-result.md
.ai-dev\codex-review-result.md:- .ai-dev/test-result.md
.ai-dev\codex-review-result.md:- package.json 또는 package-lock.json을 불필요하게 수정했는가
.ai-dev\codex-review-result.md:    "lint_passed": true,
.ai-dev\codex-review-result.md:sk":true,"scope_issues":[]},"test_check":{"build_passed":true,"test_p
assed":true,"lint_passed":t
.ai-dev\codex-review-result.md:rue,"issues":["npm run test는 스크립트가 없어 별도 실행되지 않은 것으로 확인됩니다."]},"next_
step":"complete_task"}
.ai-dev\codex-review-result.md:{"decision":"pass","severity":"none","summary":"업무 목록 빈 상태 문구만 자연스러운 
한국어로 변경되었고, 기능 로직이나 범위 외 변경은 확인되지 않았습니다.","required_changes":[],"optional_suggestions":[],"scope_che
ck":{"within_current_task":true,"scope_issues":[]},"test_check":{"build_passed":true,"test_passed":t
rue,"lint_passed":true,"issues":["npm run test는 스크립트가 없어 별도 실행되지 않은 것으로 확인됩니다."]},"next_step":"compl
ete_task"}
.ai-dev\diff.md: M .ai-dev/test-result.md
.ai-dev\diff.md:- .ai-dev/test-result.md
.ai-dev\current-task-prompt.md:AI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.
.ai-dev\current-task-prompt.md:현재 strict 리뷰에서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다
. `npm run lint` 스크립트가 존재하는 경우 BuildOnly 검증과 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 
한다. 또한 `package.json`에 test 스크립트가 없는 경우에는 테스트를 실행하지 않은 사유를 명확히 기록해야 한다.
.ai-dev\current-task-prompt.md:- `package.json`에 lint 스크립트가 있으면 AI Dev Loop 검증 기록에 lint 결과가 포함된다.
.ai-dev\current-task-prompt.md:- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.
.ai-dev\current-task-prompt.md:- test 스크립트가 없으면 `test-result.md`에 test 미실행 사유가 명확히 기록된다.
.ai-dev\current-task-prompt.md:- strict 리뷰에서 lint 미기록으로 반려되지 않는다.
.ai-dev\current-task-prompt.md:- lint 스크립트가 있는 상태에서 자동 사이클 결과 파일에 lint 결과가 기록되는지 확인한다.
.ai-dev\current-task-prompt.md:- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 사유가 기록되는지 확인한다.
.ai-dev\current-task-prompt.md:- 기존 BuildOnly 검증 기록이 유지되는지 확인한다.
.ai-dev\current-task-prompt.md:- Title: 검증 기록 흐름 분석 및 lint 기록 개선
.ai-dev\current-task-prompt.md:- Description: AI Dev Loop의 검증 결과 기록 흐름을 확인하고, lint 스크립트가 있을 때 lint 결
과가 test-result.md에 자동 기록되도록 작게 수정한다. test 스크립트가 없을 때는 테스트 미실행 사유를 명확히 남긴다.
.ai-dev\current-task-prompt.md:- .ai-dev/test-result.md
.ai-dev\current-task-prompt.md:- lint 스크립트가 있는 경우 lint 결과 기록 여부 확인
.ai-dev\current-task-prompt.md:- BuildOnly 검증 기록과 lint 기록이 구분되는지 확인
.ai-dev\current-task-prompt.md:- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
.ai-dev\current-task-prompt.md:- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.
.ai-dev\current-task-prompt.md:- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다
.
.ai-dev\goal.md:AI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.
.ai-dev\goal.md:현재 strict 리뷰에서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다. `npm run lint
` 스크립트가 존재하는 경우 BuildOnly 검증과 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 한다. 또한 `package
.json`에 test 스크립트가 없는 경우에는 테스트를 실행하지 않은 사유를 명확히 기록해야 한다.
.ai-dev\goal.md:- `package.json`에 lint 스크립트가 있으면 AI Dev Loop 검증 기록에 lint 결과가 포함된다.
.ai-dev\goal.md:- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.
.ai-dev\goal.md:- test 스크립트가 없으면 `test-result.md`에 test 미실행 사유가 명확히 기록된다.
.ai-dev\goal.md:- strict 리뷰에서 lint 미기록으로 반려되지 않는다.
.ai-dev\goal.md:- lint 스크립트가 있는 상태에서 자동 사이클 결과 파일에 lint 결과가 기록되는지 확인한다.
.ai-dev\goal.md:- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 사유가 기록되는지 확인한다.
.ai-dev\goal.md:- 기존 BuildOnly 검증 기록이 유지되는지 확인한다.
.ai-dev\loop-log.md:- Result: `goal.md`, `backlog.md`, `queue.json`, `state.json`, `plan.md`, `test-
result.md`, `review.md`, `loop-log.md`를 새 목표 기준으로 초기화함
.ai-dev\loop-log.md:- Verification: PowerShell 문법 검증 예정. 실제 Codex 실행, build/test/lint, git add/commi
t은 수행하지 않음
.ai-dev\loop-log.md:- Excluded: 실제 Codex 실행, build/test/lint, git add/commit은 수행하지 않음
.ai-dev\loop-log.md:- Excluded: build/test/lint, 실제 커밋 생성, git 명령 직접 실행은 수행하지 않음
.ai-dev\loop-log.md:- Result: T001 완료: 업무 목록 빈 상태 안내 문구를 자연스러운 한국어로 개선하고 lint 검증을 통과함
.ai-dev\plan.md:- package.json/package-lock.json 변경이 감지되면 자동 커밋하지 않는다.
.ai-dev\plan.md:- 실행 결과는 `.ai-dev/codex-result.md`, `.ai-dev/review-response.json`, `.ai-dev/review.
md`, `.ai-dev/test-result.md`, `.ai-dev/loop-log.md`, `.ai-dev/state.json`에 기록하는 기준으로 정리했다.
.ai-dev\plan.md:- package.json/package-lock.json 변경이 감지되는 경우
.ai-dev\queue.example.json:        "npm run build"
.ai-dev\queue.example.json:        "npm run build"
.ai-dev\queue.example.json:        "npm run build"
.ai-dev\queue.example.json:        "npm run build",
.ai-dev\queue.json:    "goalTitle":  "AI Dev Loop lint 검증 자동 기록",
.ai-dev\queue.json:                      "title":  "검증 기록 흐름 분석 및 lint 기록 개선",
.ai-dev\queue.json:                      "description":  "AI Dev Loop의 검증 결과 기록 흐름을 확인하고, lint 스크립트가
 있을 때 lint 결과가 test-result.md에 자동 기록되도록 작게 수정한다. test 스크립트가 없을 때는 테스트 미실행 사유를 명확히 남긴다.",
.ai-dev\queue.json:                                                  ".ai-dev/test-result.md",
.ai-dev\queue.json:                                           "lint 스크립트가 있는 경우 lint 결과 기록 여부 확인",
.ai-dev\queue.json:                                           "BuildOnly 검증 기록과 lint 기록이 구분되는지 확인"
.ai-dev\queue.json:                      "commitMessage":  "Record lint validation results"
.ai-dev\README.md:- `test-result.md`
.ai-dev\README.md:`package.json`에 정의된 build, test, lint script를 확인하고 실행 결과를 `test-result.md`와 `state
.json`에 기록한다.
.ai-dev\README.md:build만 실행하려면 `-BuildOnly` 옵션을 사용한다.
.ai-dev\README.md:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
.ai-dev\README.md:T006 같은 최종 검증 task에서 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-revi
ew` 성공/실패 흐름 확인 결과를 사람이 직접 수행했다면 수동 요약만 `test-result.md`에 기록할 수 있다. 이 모드는 npm build/test/lint를 실행하지 
않는다.
.ai-dev\README.md:이 모드에서 `state.json`의 `lastCommandStatus`는 수동 요약 기록 작업의 성공 여부를 뜻한다. 실제 검증 통과/실패/미수행
 판단은 `test-result.md`의 요약 본문에 명확히 적는다.
.ai-dev\README.md:- `.ai-dev/test-result.md`
.ai-dev\README.md:- 루프 상태 커밋에는 필요할 때 `queue.json`, `state.json`, `loop-log.md`, `test-result.md`, `r
eview.md` 등을 포함할 수 있다.
.ai-dev\README.md:최종 검증 task에서는 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save-review` 성공/
실패 흐름 확인 결과를 `test-result.md`에 남기는 것을 원칙으로 한다. 실행하지 않은 검증은 통과로 기록하지 않는다.
.ai-dev\README.md:- `.ai-dev/test-result.md`: check/build 또는 수동 검증 요약
.ai-dev\README.md:이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, npm i
nstall, package 파일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는
다.
.ai-dev\README.md:- Codex 리뷰 실행 프롬프트에는 파일 수정 금지, git 명령 금지, build/test/lint 실행 금지, JSON 객체만 출력하라는 안전
 규칙을 추가한다.
.ai-dev\README.md:- 이 스크립트는 git add, git commit, build/test/lint, GPT API 호출을 수행하지 않는다.
.ai-dev\README.md:3. `ai-dev-check.ps1 -BuildOnly`
.ai-dev\README.md:8. package 파일 변경 게이트 확인: `package.json` 또는 `package-lock.json` 변경이 있으면 자동 커밋하지 않는다
.
.ai-dev\README.md:리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니
면 자동 커밋과 complete-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json
` 또는 `package-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash
를 기록하지 못하면 `commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
.ai-dev\review-prompt.md:  - npm run build: passed
.ai-dev\review-prompt.md:  - npm run test: skipped
.ai-dev\review-prompt.md:  - npm run lint: skipped
.ai-dev\review-prompt.md:### npm run build
.ai-dev\review-prompt.md:### npm run test
.ai-dev\review-prompt.md:-BuildOnly 옵션으로 건너뛰었습니다.
.ai-dev\review-prompt.md:### npm run lint
.ai-dev\review-prompt.md:-BuildOnly 옵션으로 건너뛰었습니다.
.ai-dev\review-prompt.md:  "lint": "eslint .",
.ai-dev\review-prompt.md:> planpilot-local@0.0.0 lint
.ai-dev\review-prompt.md:> eslint .
.ai-dev\review-prompt.md:- npm run lint를 수동 실행했고 오류 없이 종료되었습니다.
.ai-dev\review-prompt.md:- npm run test는 package.json에 test 스크립트가 없으면 별도 실행 대상이 아닙니다.
.ai-dev\review-prompt.md: M .ai-dev/test-result.md
.ai-dev\review-prompt.md:- .ai-dev/test-result.md
.ai-dev\review-prompt.md:- package.json 또는 package-lock.json을 불필요하게 수정했는가
.ai-dev\review-prompt.md:    "lint_passed": true,
.ai-dev\review-response.json:                       "lint_passed":  true,
.ai-dev\review-response.json:                                      "npm run test는 스크립트가 없어 별도 실행되지 않
은 것으로 확인됩니다."
.ai-dev\review.md:                       "lint_passed":  true,
.ai-dev\review.md:                                      "npm run test는 스크립트가 없어 별도 실행되지 않은 것으로 확인됩니다
."
.ai-dev\test-result.md:  - npm run build: passed
.ai-dev\test-result.md:  - npm run test: skipped
.ai-dev\test-result.md:  - npm run lint: skipped
.ai-dev\test-result.md:### npm run build
.ai-dev\test-result.md:### npm run test
.ai-dev\test-result.md:-BuildOnly 옵션으로 건너뛰었습니다.
.ai-dev\test-result.md:### npm run lint
.ai-dev\test-result.md:-BuildOnly 옵션으로 건너뛰었습니다.
.ai-dev\test-result.md:  "lint": "eslint .",
.ai-dev\test-result.md:> planpilot-local@0.0.0 lint
.ai-dev\test-result.md:> eslint .
.ai-dev\test-result.md:- npm run lint를 수동 실행했고 오류 없이 종료되었습니다.
.ai-dev\test-result.md:- npm run test는 package.json에 test 스크립트가 없으면 별도 실행 대상이 아닙니다.
.ai-dev\codex-result.md:- Goal title: AI Dev Loop lint 검증 자동 기록
.ai-dev\codex-result.md:Title: AI Dev Loop lint 검증 자동 기록
.ai-dev\codex-result.md:Description: AI Dev Loop 자동 사이클에서 npm run lint 스크립트가 존재하면 BuildOnly 검증과 별개로 
lint를 실행하거나 결과를 test-res
.ai-dev\codex-result.md:ult.md에 자동 기록하여 strict 리뷰에서 lint skipped로 반려되지 않도록 개선한다. package.json에 test 
스크립트가 없는 경우에는 test 미실행 사
.ai-dev\codex-result.md:{"goalMarkdown":"# 목표\n\nAI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.\n
\n## 배경\n\n현재 strict 리뷰에
.ai-dev\codex-result.md:서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다. `npm run lint` 스크립
트가 존재하는 경우 BuildOnly 검증과
.ai-dev\codex-result.md: 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 한다. 또한 `package.json
`에 test 스크립트가 없는 경우에는 테스
.ai-dev\codex-result.md:트를 실행하지 않은 사유를 명확히 기록해야 한다.\n\n## 성공 기준\n\n- `package.json`에 lint 스크립트가 있으면 
AI Dev Loop 검증 기록에 lint 
.ai-dev\codex-result.md:결과가 포함된다.\n- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.\n- test 스크립트가 없으면 `test-res
ult.md`에 test 미실행 사유가 명확
.ai-dev\codex-result.md:히 기록된다.\n- strict 리뷰에서 lint 미기록으로 반려되지 않는다.\n\n## 제약사항\n\n- 기존 AI Dev Loop 흐
름을 크게 바꾸지 않는다.\n- 검증 기록 
.ai-dev\codex-result.md:새로운 테스트 프레임워크 추가는 제외한다.\n- 대규모 구조 재작성은 제외한다.\n- UI 변경은 제외한다.\n\n## 수동 검증\n\n
- lint 스크립트가 있는 상태에서 자동 
.ai-dev\codex-result.md:사이클 결과 파일에 lint 결과가 기록되는지 확인한다.\n- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 
사유가 기록되는지 확인한다.\n- 기존 Bu
.ai-dev\codex-result.md:ildOnly 검증 기록이 유지되는지 확인한다.\n","queue":{"goalTitle":"AI Dev Loop lint 검증 자동 기
록","goalSource":".ai-dev
.ai-dev\codex-result.md:skId":"T001","tasks":[{"id":"T001","title":"검증 기록 흐름 분석 및 lint 기록 개선","descr
iption":"AI Dev Loop의 검증
.ai-dev\codex-result.md: 결과 기록 흐름을 확인하고, lint 스크립트가 있을 때 lint 결과가 test-result.md에 자동 기록되도록 작게 수정한다. 
test 스크립트가 없을 때는 테스트 미실행
.ai-dev\codex-result.md:ikelyToChange":[".ai-dev/test-result.md",".ai-dev 관련 자동 사이클 스크립트"],"verifica
tion":["lint 스크립트가 있는 경우
.ai-dev\codex-result.md: lint 결과 기록 여부 확인","test 스크립트가 없는 경우 미실행 사유 기록 여부 확인","BuildOnly 검증 기록과 lint
 기록이 구분되는지 확인"],"commitM
.ai-dev\codex-result.md:essage":"Record lint validation results"}]},"state":{"goalStatus":"in_progre
ss","currentTaskId":"T00
.ai-dev\codex-result.md:{"goalMarkdown":"# 목표\n\nAI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.\n
\n## 배경\n\n현재 strict 리뷰에서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다. `npm run lint` 스크립
트가 존재하는 경우 BuildOnly 검증과 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 한다. 또한 `package.json
`에 test 스크립트가 없는 경우에는 테스트를 실행하지 않은 사유를 명확히 기록해야 한다.\n\n## 성공 기준\n\n- `package.json`에 lint 스크립트가 있으면 
AI Dev Loop 검증 기록에 lint 결과가 포함된다.\n- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.\n- test 스크립트가 없으면 `test-res
ult.md`에 test 미실행 사유가 명확히 기록된다.\n- strict 리뷰에서 lint 미기록으로 반려되지 않는다.\n\n## 제약사항\n\n- 기존 AI Dev Loop 흐
름을 크게 바꾸지 않는다.\n- 검증 기록 생성 로직의 변경 범위를 작게 유지한다.\n- 사용자 변경 사항을 되돌리지 않는다.\n- 기존 프로젝트 구조와 TypeScript 스타일
을 따른다.\n\n## 범위 제외\n\n- 새로운 테스트 프레임워크 추가는 제외한다.\n- 대규모 구조 재작성은 제외한다.\n- UI 변경은 제외한다.\n\n## 수동 검증\n\n
- lint 스크립트가 있는 상태에서 자동 사이클 결과 파일에 lint 결과가 기록되는지 확인한다.\n- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 
사유가 기록되는지 확인한다.\n- 기존 BuildOnly 검증 기록이 유지되는지 확인한다.\n","queue":{"goalTitle":"AI Dev Loop lint 검증 자동 기
록","goalSource":".ai-dev/goal.md","createdAt":"2026-06-14T00:00:00+09:00","updatedAt":"2026-06-14T00
:00:00+09:00","currentTaskId":"T001","tasks":[{"id":"T001","title":"검증 기록 흐름 분석 및 lint 기록 개선","descr
iption":"AI Dev Loop의 검증 결과 기록 흐름을 확인하고, lint 스크립트가 있을 때 lint 결과가 test-result.md에 자동 기록되도록 작게 수정한다. 
test 스크립트가 없을 때는 테스트 미실행 사유를 명확히 남긴다.","type":"implementation","status":"in_progress","priority":"P0
","dependsOn":[],"filesLikelyToChange":[".ai-dev/test-result.md",".ai-dev 관련 자동 사이클 스크립트"],"verifica
tion":["lint 스크립트가 있는 경우 lint 결과 기록 여부 확인","test 스크립트가 없는 경우 미실행 사유 기록 여부 확인","BuildOnly 검증 기록과 lint
 기록이 구분되는지 확인"],"commitMessage":"Record lint validation results"}]},"state":{"goalStatus":"in_progre
ss","currentTaskId":"T001","currentLoop":0,"maxLoopsPerTask":2,"repeatedFailureCount":0,"lastCommand
":null,"lastCommandStatus":"not_started","lastErrorSummary":null,"lastReviewDecision":"not_started",
"lastReviewSeverity":null,"lastCommitHash":null,"startedAt":"2026-06-14T00:00:00+09:00","updatedAt":
"2026-06-14T00:00:00+09:00","stopReason":null}}

codex
`README` 기준 실제 기록 생성 로직은 `scripts/ai-dev-check.ps1`에 있습니다. 이 파일은 자동 검증 결과를 만드는 핵심이므로, 해당 스크립트와 이를 호출
하는 full cycle 래퍼만 읽어 BuildOnly 흐름을 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg "ai-dev-check|BuildOnl
y|SkipLint|SkipTest|test-result" scripts' in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-cycle-full.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-check.ps1'" in D:\ai-apps\planpilot-local
 succeeded in 1713ms:
param(
    [switch]$BuildOnly,
    [switch]$SkipBuild,
    [switch]$SkipTest,
    [switch]$SkipLint,
    [switch]$ManualSummaryOnly,
    [string]$ManualSummary
)

. "$PSScriptRoot\ai-dev-env.ps1"

$projectRoot = (Get-Location).Path
$packageRelativePath = "package.json"
$stateRelativePath = ".ai-dev/state.json"
$testResultRelativePath = ".ai-dev/test-result.md"

$packagePath = Join-Path $projectRoot $packageRelativePath
$statePath = Join-Path $projectRoot $stateRelativePath
$testResultPath = Join-Path $projectRoot $testResultRelativePath
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

function Test-HasScript {
    param(
        [object]$Package,
        [string]$Name
    )

    return $null -ne $Package.scripts -and ($Package.scripts.PSObject.Properties.Name -contains $Nam
e)
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

function Invoke-NpmCheck {
    param(
        [string]$Name,
        [bool]$ShouldRun,
        [string]$SkipReason
    )

    $command = "npm run $Name"

    if (-not $ShouldRun) {
        return [PSCustomObject]@{
            Name = $Name
            Command = $command
            Status = "skipped"
            ExitCode = $null
            Log = $SkipReason
        }
    }

    Write-Host "실행 중: $command"
    $output = & npm run $Name 2>&1 | Out-String
    $exitCode = $LASTEXITCODE
    $status = if ($exitCode -eq 0) { "passed" } else { "failed" }

    return [PSCustomObject]@{
        Name = $Name
        Command = $command
        Status = $status
        ExitCode = $exitCode
        Log = $output.TrimEnd()
    }
}

$requiredPaths = if ($ManualSummaryOnly) {
    @($stateRelativePath, $testResultRelativePath)
} else {
    @($packageRelativePath, $stateRelativePath, $testResultRelativePath)
}

foreach ($requiredPath in $requiredPaths) {
    $fullPath = Join-Path $projectRoot $requiredPath

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Stop-WithError "필수 파일이 없습니다: $requiredPath"
    }
}

$state = Read-JsonFile $statePath $stateRelativePath

if ($ManualSummaryOnly) {
    if ([string]::IsNullOrWhiteSpace($ManualSummary)) {
        Stop-WithError "-ManualSummaryOnly를 사용할 때는 -ManualSummary 내용을 입력해야 합니다."
    }

    $currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace([stri
ng]$state.currentTaskId)) {
        [string]$state.currentTaskId
    } else {
        "없음"
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $codeFence = '```'
    $testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: recorded
- Current task: $currentTaskId
- Mode: manual-summary
- Commands:
  - npm run build: skipped
  - npm run test: skipped
  - npm run lint: skipped

### Manual Verification Summary

${codeFence}text
$ManualSummary
$codeFence
"@

    [System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

    $now = [DateTimeOffset]::UtcNow.ToString("o")
    Set-ObjectProperty $state "lastCommand" "manual-summary"
    Set-ObjectProperty $state "lastCommandStatus" "passed"
    Set-ObjectProperty $state "lastErrorSummary" ""
    Set-ObjectProperty $state "updatedAt" $now

    $stateJson = $state | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

    Write-Host "수동 검증 요약 기록 완료: $testResultRelativePath"
    Write-Host "상태 저장 완료: $stateRelativePath"
    exit 0
}

$package = Read-JsonFile $packagePath $packageRelativePath

$hasBuild = Test-HasScript $package "build"
$hasTest = Test-HasScript $package "test"
$hasLint = Test-HasScript $package "lint"

$runBuild = $hasBuild -and -not $SkipBuild
$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly

$buildSkipReason = if (-not $hasBuild) {
    "package.json에 build script가 없습니다."
} elseif ($SkipBuild) {
    "-SkipBuild 옵션으로 건너뛰었습니다."
} else {
    ""
}

$testSkipReason = if ($BuildOnly) {
    "-BuildOnly 옵션으로 건너뛰었습니다."
} elseif (-not $hasTest) {
    "package.json에 test script가 없습니다."
} elseif ($SkipTest) {
    "-SkipTest 옵션으로 건너뛰었습니다."
} else {
    ""
}

$lintSkipReason = if ($BuildOnly) {
    "-BuildOnly 옵션으로 건너뛰었습니다."
} elseif (-not $hasLint) {
    "package.json에 lint script가 없습니다."
} elseif ($SkipLint) {
    "-SkipLint 옵션으로 건너뛰었습니다."
} else {
    ""
}

$results = @(
    Invoke-NpmCheck "build" $runBuild $buildSkipReason
    Invoke-NpmCheck "test" $runTest $testSkipReason
    Invoke-NpmCheck "lint" $runLint $lintSkipReason
)

$failedResults = @($results | Where-Object { $_.Status -eq "failed" })
$executedResults = @($results | Where-Object { $_.Status -ne "skipped" })
$overallResult = if ($failedResults.Count -gt 0) { "failed" } else { "passed" }
$currentTaskId = if ($null -ne $state.currentTaskId -and -not [string]::IsNullOrWhiteSpace([string]$
state.currentTaskId)) {
    [string]$state.currentTaskId
} else {
    "없음"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
$detailSections = @()
$codeFence = '```'

foreach ($result in $results) {
    $logText = if ([string]::IsNullOrWhiteSpace($result.Log)) { "출력 없음" } else { $result.Log }
    $exitCodeText = if ($null -eq $result.ExitCode) { "없음" } else { [string]$result.ExitCode }

    $detailSections += @"
### $($result.Command)

- Status: $($result.Status)
- Exit code: $exitCodeText

${codeFence}text
$logText
$codeFence
"@
}

$testResultContent = @"
# AI Dev Test Result

## $timestamp

- Overall result: $overallResult
- Current task: $currentTaskId
- Commands:
$commandSummary

$($detailSections -join "`r`n")
"@

[System.IO.File]::WriteAllText($testResultPath, $testResultContent, $utf8WithBom)

$now = [DateTimeOffset]::UtcNow.ToString("o")
$lastCommand = if ($executedResults.Count -gt 0) {
    $executedResults[-1].Command
} else {
    "ai-dev-check"
}
$lastCommandStatus = if ($executedResults.Count -eq 0) {
    "skipped"
} else {
    $overallResult
}
$lastErrorSummary = if ($failedResults.Count -gt 0) {
    ($failedResults | ForEach-Object { "$($_.Command) exit code $($_.ExitCode)" }) -join "; "
} else {
    ""
}

Set-ObjectProperty $state "lastCommand" $lastCommand
Set-ObjectProperty $state "lastCommandStatus" $lastCommandStatus
Set-ObjectProperty $state "lastErrorSummary" $lastErrorSummary
Set-ObjectProperty $state "updatedAt" $now

$stateJson = $state | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($statePath, $stateJson, $utf8WithBom)

Write-Host "검증 결과: $overallResult"
foreach ($result in $results) {
    Write-Host "  - $($result.Command): $($result.Status)"
}
Write-Host "기록 완료: $testResultRelativePath"
Write-Host "상태 저장 완료: $stateRelativePath"

if ($overallResult -eq "failed") {
    exit 1
}

exit 0

 succeeded in 1749ms:
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
$aiDevOperationalRoot = ".ai-dev/"
$queuePath = Join-Path $repoRoot $queueRelativePath
$statePath = Join-Path $repoRoot $stateRelativePath
$reviewResponsePath = Join-Path $repoRoot $reviewResponseRelativePath
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)

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

function Write-JsonFile {
    param(
        [string]$Path,
        [object]$Value
    )

    $json = $Value | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($Path, $json, $utf8WithBom)
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
        $inProgressTask = $tasks | Where-Object { $_.status -eq "in_progress" } | Select-Object -Fir
st 1

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
    $status = Invoke-GitCapture @("status", "--porcelain", "--", "package.json", "package-lock.json"
) "git status --porcelain -- package.json package-lock.json"
    return -not [string]::IsNullOrWhiteSpace($status)
}

function Convert-ToChangedPath {
    param(
        [string]$ChangeLine
    )

    if ([string]::IsNullOrWhiteSpace($ChangeLine)) {
        return @()
    }

    $pathText = $ChangeLine

    if ($ChangeLine.Length -ge 4 -and $ChangeLine.Substring(2, 1) -eq " ") {
        $pathText = $ChangeLine.Substring(3)
    }

    if ($pathText.Contains(" -> ")) {
        return @($pathText -split " -> " | Where-Object { Test-HasValue $_ })
    }

    return @($pathText)
}

function Test-IsAiDevOperationalPath {
    param(
        [string]$RelativePath
    )

    $normalizedRelativePath = $RelativePath.Replace('\', '/')
    return $normalizedRelativePath.StartsWith($aiDevOperationalRoot, [System.StringComparison]::Ordi
nalIgnoreCase)
}

function Get-ChangedNonAiDevFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
)

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and -not (Test-IsAiDevOperationalPath $_) } |
            Select-Object -Unique
    )
}

function Get-ChangedAiDevOperationalFiles {
    $status = Invoke-GitCapture @("status", "--porcelain") "git status --porcelain"
    $changeLines = @($status -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
)

    return @(
        $changeLines |
            ForEach-Object { Convert-ToChangedPath $_ } |
            Where-Object { (Test-HasValue $_) -and (Test-IsAiDevOperationalPath $_) } |
            Select-Object -Unique
    )
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
        $normalizedFiles = @($CommitFiles | ForEach-Object { $_ -split "," } | Where-Object { -not [
string]::IsNullOrWhiteSpace($_) })

        if ($normalizedFiles.Count -gt 0) {
            $arguments += "-Files"
            $arguments += ($normalizedFiles -join ",")
        }

        return $arguments
    }

    $implementationFiles = Get-ChangedNonAiDevFiles

    if ($implementationFiles.Count -gt 0) {
        $arguments += "-Files"
        $arguments += ($implementationFiles -join ",")
    }

    return $arguments
}

function Invoke-DirectMetaCommit {
    param(
        [int]$StepNumber
    )

    $command = "direct meta commit: git add scoped .ai-dev files, git commit -m 'chore(ai-dev): reco
rd task completion', git status --short"

    try {
        $changedAiDevFiles = Get-ChangedAiDevOperationalFiles

        if ($changedAiDevFiles.Count -eq 0) {
            $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git
 status --short"

            if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
                throw ".ai-dev 메타 변경사항은 없지만 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
            }

            $script:steps += New-StepResult $StepNumber "meta-commit" $command $false $true 0 ".ai-d
ev 메타 상태 변경사항이 없어 meta commit을 건너뜁니다. worktree clean."
            return
        }

        $addOutput = & git add -- $changedAiDevFiles 2>&1 | Out-String
        $addExitCode = $LASTEXITCODE

        if ($addExitCode -ne 0) {
            throw "git add 실행에 실패했습니다. exit code: $addExitCode`n$addOutput"
        }

        $commitOutput = & git commit -m "chore(ai-dev): record task completion" -- $changedAiDevFile
s 2>&1 | Out-String
        $commitExitCode = $LASTEXITCODE

        if ($commitExitCode -ne 0) {
            throw "git commit 실행에 실패했습니다. exit code: $commitExitCode`n$commitOutput"
        }

        $remainingStatus = Invoke-GitCapture -Arguments @("status", "--short") -DisplayName "git sta
tus --short"

        if (-not [string]::IsNullOrWhiteSpace($remainingStatus)) {
            throw "meta commit 이후 worktree에 변경 파일이 남아 있습니다.`n$remainingStatus"
        }

        $message = ($commitOutput.Trim(), "worktree clean") -join "`n"
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 0 $message
    } catch {
        $script:steps += New-StepResult $StepNumber "meta-commit" $command $true $false 1 $_.Excepti
on.Message
        Stop-Cycle $script:steps "meta_commit_failed" $false 1
    }
}

function Get-CommitGate {
    param(
        [string]$PreviousHeadCommitHash
    )

    $state = Read-JsonFile $statePath $stateRelativePath
    $lastCommitHash = if (Test-HasValue $state.lastCommitHash) { [string]$state.lastCommitHash } els
e { $null }
    $headCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName "git rev-pars
e HEAD"
    $commitHashChanged = (Test-HasValue $headCommitHash) -and $headCommitHash -ne $PreviousHeadCommi
tHash
    $commitHashMatchesHead = (Test-HasValue $lastCommitHash) -and $lastCommitHash -eq $headCommitHas
h

    if ($state.lastCommand -eq "commit" -and $state.lastCommandStatus -eq "passed" -and $commitHashC
hanged -and -not $commitHashMatchesHead) {
        Set-ObjectProperty $state "lastCommitHash" $headCommitHash
        Set-ObjectProperty $state "updatedAt" ([DateTimeOffset]::UtcNow.ToString("o"))
        Write-JsonFile $statePath $state

        $lastCommitHash = $headCommitHash
        $commitHashMatchesHead = $true
    }

    return [PSCustomObject][ordered]@{
        lastCommand = [string]$state.lastCommand
        lastCommandStatus = [string]$state.lastCommandStatus
        lastCommitHash = [string]$lastCommitHash
        commitHashChanged = $commitHashChanged
        commitHashMatchesHead = $commitHashMatchesHead
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
    $script:steps += New-StepResult 0 "prepare" "state/queue 확인" $false $false 1 $_.Exception.Messag
e
    Stop-Cycle $script:steps "prepare_failed" $false 1
}

$plannedSteps = @(
    "task-start",
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
    "complete-task",
    "meta-commit"
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
        $script:steps += New-StepResult $stepNumber "load-task" "state/queue 확인" $false $false 1 $_.
Exception.Message
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
    $script:steps += New-StepResult $stepNumber "task-start" "MaxTasks=$MaxTasks" $false $false 0 "현
재 task 실행 시작: $taskLabel"
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-prompt" "powershell -ExecutionPolicy Bypass -File scripts/
ai-dev-make-prompt.ps1" $scriptPaths.makePrompt @()
    $stepNumber++

    if (-not $AllowCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -All
owCodex -AllowReviewCodex -MaxTasks $MaxTasks"
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
-File scripts/ai-dev-run-codex.ps1" $false $true 1 "Codex 구현 실행에는 -AllowCodex가 필요합니다. 추천 명령: $comman
d"
        Stop-Cycle $script:steps "allow_codex_required" $false 1
    }

    $runCodexArguments = @()
    if ($AllowDirty) {
        $runCodexArguments += "-AllowDirty"
    }

    Invoke-CycleCommand $stepNumber "run-codex" "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-run-codex.ps1" $scriptPaths.runCodex $runCodexArguments
    $stepNumber++

    Invoke-CycleCommand $stepNumber "check" "powershell -ExecutionPolicy Bypass -File scripts/ai-dev
-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
    $stepNumber++

    Invoke-CycleCommand $stepNumber "save-diff" "powershell -ExecutionPolicy Bypass -File scripts/ai
-dev-save-diff.ps1" $scriptPaths.saveDiff @()
    $stepNumber++

    Invoke-CycleCommand $stepNumber "make-review-prompt" "powershell -ExecutionPolicy Bypass -File s
cripts/ai-dev-make-review-prompt.ps1 -Strict" $scriptPaths.makeReviewPrompt @("-Strict")
    $stepNumber++

    if (-not $AllowReviewCodex -and -not $DryRun) {
        $command = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -All
owCodex -AllowReviewCodex -MaxTasks $MaxTasks"
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
Bypass -File scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $false $true 1 "Codex 리뷰 실
행에는 -AllowReviewCodex가 필요합니다. 추천 명령: $command"
        Stop-Cycle $script:steps "allow_review_codex_required" $false 1
    }

    Invoke-CycleCommand $stepNumber "run-review-codex" "powershell -ExecutionPolicy Bypass -File scr
ipts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview" $scriptPaths.runReviewCodex @("-AllowDirty
", "-SaveReview")
    $stepNumber++

    if ($DryRun) {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fal
se $true 0 "DryRun: 리뷰 pass 여부를 실제 상태에서 읽지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain --
 package.json package-lock.json" $false $true 0 "DryRun: package 파일 변경 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-commit.ps1" $false $true 0 "DryRun: git add/commit을 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $true 0 "DryRun: 실제 커밋 생성 여부를 확인하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "complete-task" "powershell -ExecutionPolicy Byp
ass -File scripts/ai-dev-complete-task.ps1 -ResultSummary `"자동 완료: Codex 구현, build/check, Codex 리뷰 p
ass, 자동 커밋 완료`" -CommitHash <commit-hash>" $false $true 0 "DryRun: task 완료 처리를 실행하지 않았습니다."
        $stepNumber++
        $script:steps += New-StepResult $stepNumber "meta-commit" "direct meta commit: git add scope
d .ai-dev files, git commit -m 'chore(ai-dev): record task completion', git status --short" $false $
true 0 "DryRun: .ai-dev 메타 상태 직접 커밋을 실행하지 않았습니다."
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
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastCommandStatus 확인" $fals
e $true 1 "리뷰 저장 또는 직전 명령이 passed가 아니므로 자동 커밋하지 않습니다: $($reviewGate.lastCommandStatus)"
        Stop-Cycle $script:steps "review_save_not_passed" $false 1
    }

    if ($reviewGate.decision -ne "pass") {
        $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $fal
se $true 0 "리뷰 decision이 pass가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($reviewGate.decision)"
        Stop-Cycle $script:steps "review_not_pass" $false 0
    }

    if (Test-HasValue $reviewGate.nextStep -and $reviewGate.nextStep -ne "complete_task") {
        $script:steps += New-StepResult $stepNumber "review-gate" "$reviewResponseRelativePath next_
step 확인" $false $true 0 "리뷰 next_step이 complete_task가 아니므로 자동 커밋과 complete-task를 실행하지 않습니다: $($revie
wGate.nextStep)"
        Stop-Cycle $script:steps "review_next_step_not_complete_task" $false 0
    }

    $script:steps += New-StepResult $stepNumber "review-gate" "state.lastReviewDecision 확인" $false $
false 0 "리뷰 pass 확인. 커밋 게이트로 진행합니다."
    $stepNumber++

    try {
        if (Test-PackageFileChanged) {
            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelai
n -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커
밋하지 않습니다."
            Stop-Cycle $script:steps "package_files_changed" $false 1
        }
    } catch {
        $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain --
 package.json package-lock.json" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "package_change_gate_failed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- pac
kage.json package-lock.json" $false $false 0 "package 파일 변경 없음. 커밋 허용 여부를 확인합니다."
    $stepNumber++

    if (-not $AllowCommit) {
        $commitCommand = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps
1 -AllowCodex -AllowReviewCodex -AllowCommit -MaxTasks $MaxTasks"
        if ($AllowDirty) {
            $commitCommand = "$commitCommand -AllowDirty"
        }

        if ($null -ne $CommitFiles -and $CommitFiles.Count -gt 0) {
            $commitCommand = "$commitCommand -CommitFiles $($CommitFiles -join ',')"
        }

        $script:steps += New-StepResult $stepNumber "commit" "powershell -ExecutionPolicy Bypass -Fi
le scripts/ai-dev-commit.ps1" $false $true 1 "자동 커밋에는 -AllowCommit이 필요합니다. 추천 명령: $commitCommand"
        Stop-Cycle $script:steps "allow_commit_required" $false 1
    }

    $commitArguments = Get-CommitArguments

    if ($commitArguments.Count -eq 0) {
        $script:steps += New-StepResult $stepNumber "commit" "git status --porcelain" $false $true 1
 "커밋할 구현 변경사항이 없어 complete-task를 실행하지 않습니다."
        Stop-Cycle $script:steps "no_implementation_changes" $false 1
    }

    $commitCommandText = "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1"
    if ($commitArguments.Count -gt 0) {
        $commitCommandText = "$commitCommandText $($commitArguments -join ' ')"
    }

    try {
        $preCommitHeadCommitHash = Invoke-GitCapture -Arguments @("rev-parse", "HEAD") -DisplayName 
"git rev-parse HEAD"
    } catch {
        $script:steps += New-StepResult $stepNumber "commit" "git rev-parse HEAD" $false $false 1 $_
.Exception.Message
        Stop-Cycle $script:steps "pre_commit_head_failed" $false 1
    }

    Invoke-CycleCommand $stepNumber "commit" $commitCommandText $scriptPaths.commit $commitArguments
    $stepNumber++

    try {
        $commitGate = Get-CommitGate $preCommitHeadCommitHash
    } catch {
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $false 1 $_.Exception.Message
        Stop-Cycle $script:steps "commit_result_gate_failed" $false 1
    }

    if ($commitGate.lastCommand -ne "commit" -or $commitGate.lastCommandStatus -ne "passed" -or -not
 $commitGate.commitHashChanged -or -not $commitGate.commitHashMatchesHead) {
        $message = "커밋 완료 상태를 확인하지 못해 complete-task를 실행하지 않습니다. lastCommand=$($commitGate.lastComman
d), lastCommandStatus=$($commitGate.lastCommandStatus), lastCommitHash=$($commitGate.lastCommitHash)
"
        $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastComm
itHash 확인" $false $true 1 $message
        Stop-Cycle $script:steps "commit_not_confirmed" $false 1
    }

    $script:steps += New-StepResult $stepNumber "commit-result-gate" "state.lastCommand/lastCommitHa
sh 확인" $false $false 0 "커밋 생성 확인: $($commitGate.lastCommitHash)"
    $stepNumber++

    $resultSummary = "자동 완료: Codex 구현, build/check, Codex 리뷰 pass, 자동 커밋 완료"
    Invoke-CycleCommand $stepNumber "complete-task" "powershell -ExecutionPolicy Bypass -File script
s/ai-dev-complete-task.ps1 -ResultSummary `"$resultSummary`" -CommitHash $($commitGate.lastCommitHas
h)" $scriptPaths.completeTask @("-ResultSummary", $resultSummary, "-CommitHash", $commitGate.lastCom
mitHash)
    $stepNumber++

    Invoke-DirectMetaCommit $stepNumber
    $stepNumber++

    $completedTaskCount++

    $stateAfterComplete = Read-JsonFile $statePath $stateRelativePath

    if ($stateAfterComplete.goalStatus -eq "completed") {
        Stop-Cycle $script:steps "goal_completed" $true 0
    }
}

Stop-Cycle $script:steps "max_tasks_reached" $true 0

 succeeded in 1966ms:
scripts\ai-dev-auto-cycle-full.ps1:        check = Get-ScriptPath "ai-dev-check.ps1"
scripts\ai-dev-auto-cycle-full.ps1:    Invoke-CycleCommand $stepNumber "check" "powershell -Executio
nPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
scripts\ai-dev-auto-step.ps1:        $scriptToRun = "ai-dev-check.ps1"
scripts\ai-dev-auto-step.ps1:        $scriptArguments = @("-BuildOnly")
scripts\ai-dev-auto-step.ps1:            "검증을 실행합니다: ai-dev-check.ps1 -BuildOnly"
scripts\ai-dev-check.ps1:    [switch]$BuildOnly,
scripts\ai-dev-check.ps1:    [switch]$SkipTest,
scripts\ai-dev-check.ps1:    [switch]$SkipLint,
scripts\ai-dev-check.ps1:$testResultRelativePath = ".ai-dev/test-result.md"
scripts\ai-dev-check.ps1:$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
scripts\ai-dev-check.ps1:$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
scripts\ai-dev-check.ps1:$testSkipReason = if ($BuildOnly) {
scripts\ai-dev-check.ps1:    "-BuildOnly 옵션으로 건너뛰었습니다."
scripts\ai-dev-check.ps1:} elseif ($SkipTest) {
scripts\ai-dev-check.ps1:    "-SkipTest 옵션으로 건너뛰었습니다."
scripts\ai-dev-check.ps1:$lintSkipReason = if ($BuildOnly) {
scripts\ai-dev-check.ps1:    "-BuildOnly 옵션으로 건너뛰었습니다."
scripts\ai-dev-check.ps1:} elseif ($SkipLint) {
scripts\ai-dev-check.ps1:    "-SkipLint 옵션으로 건너뛰었습니다."
scripts\ai-dev-check.ps1:    "ai-dev-check"
scripts\ai-dev-make-revise-prompt.ps1:$testResultRelativePath = ".ai-dev/test-result.md"
scripts\ai-dev-init.ps1:    ".ai-dev/test-result.md" = "# AI Dev Test Result`r`n`r`n아직 테스트가 실행되지 않았습
니다.`r`n"
scripts\ai-dev-make-review-prompt.ps1:$testResultRelativePath = ".ai-dev/test-result.md"
scripts\ai-dev-manual-cycle.ps1:    ".ai-dev/test-result.md",
scripts\ai-dev-next.ps1:    ".ai-dev/test-result.md"
scripts\ai-dev-next.ps1:$testResultExists = Test-Path -LiteralPath (Join-Path $projectRoot ".ai-dev/
test-result.md") -PathType Leaf
scripts\ai-dev-next.ps1:        "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -
BuildOnly"
scripts\ai-dev-next.ps1:        $(if (-not $testResultExists) { "test-result.md가 없습니다." } else { "te
st-result.md가 있습니다." })
scripts\ai-dev-status.ps1:$testResultRelativePath = ".ai-dev/test-result.md"

codex
현재 문제의 핵심은 `ai-dev-check.ps1 -BuildOnly`가 build만 실행하고 lint/test를 모두 `BuildOnly`로 skip 기록한다는 점입니다. 자동
 사이클은 이 옵션을 사용하므로, lint가 있어도 strict 리뷰에는 lint 미기록처럼 보일 수 있습니다. 작은 변경으로 `BuildOnly`에서도 lint는 별도 검증으로 
실행/기록하고, test 스크립트가 없을 때는 그 사유를 우선 기록하도록 조정하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath 
'D:\\ai-apps\\planpilot-local\\scripts\\ai-dev-auto-step.ps1'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg -n \"BuildOnly|runTest
|runLint|testSkipReason|lintSkipReason|ai-dev-check\" scripts\\ai-dev-check.ps1 scripts\\ai-dev-auto
-step.ps1 scripts\\ai-dev-auto-cycle-full.ps1 .ai-dev\\README.md" in D:\ai-apps\planpilot-local
 succeeded in 1351ms:
param(
    [switch]$Json,
    [switch]$DryRun,
    [switch]$AllowCheck,
    [switch]$AllowReviewPrompt,
    [switch]$AllowSaveDiff
)

. "$PSScriptRoot\ai-dev-env.ps1"

function Stop-WithJsonError {
    param(
        [string]$Message
    )

    $result = [ordered]@{
        action = "error"
        executed = $false
        dryRun = [bool]$DryRun
        exitCode = 1
        message = $Message
        recommendedCommands = @()
    }

    if ($Json) {
        $result | ConvertTo-Json -Depth 10
    } else {
        Write-Error $Message
    }

    exit 1
}

function New-StepResult {
    param(
        [string]$Action,
        [bool]$Executed,
        [int]$ExitCode,
        [string]$Message,
        [string[]]$RecommendedCommands
    )

    return [ordered]@{
        action = $Action
        executed = $Executed
        dryRun = [bool]$DryRun
        exitCode = $ExitCode
        message = $Message
        recommendedCommands = @($RecommendedCommands)
    }
}

function Invoke-AiDevScript {
    param(
        [string]$ScriptName,
        [string[]]$Arguments
    )

    $scriptPath = Join-Path $PSScriptRoot $ScriptName

    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "스크립트를 찾을 수 없습니다: $ScriptName"
    }

    $output = & powershell -ExecutionPolicy Bypass -File $scriptPath @Arguments 2>&1 | Out-String
    $exitCode = $LASTEXITCODE

    return [PSCustomObject]@{
        ExitCode = $exitCode
        Output = $output.TrimEnd()
    }
}

function Write-StepResult {
    param(
        [object]$Result
    )

    if ($Json) {
        $Result | ConvertTo-Json -Depth 10
        return
    }

    Write-Host "Action: $($Result.action)"
    Write-Host "Executed: $($Result.executed)"
    Write-Host "Dry run: $($Result.dryRun)"
    Write-Host "Exit code: $($Result.exitCode)"
    Write-Host "Message: $($Result.message)"
    Write-Host "Recommended commands:"

    if ($Result.recommendedCommands.Count -eq 0) {
        Write-Host "  - 없음"
    } else {
        foreach ($command in $Result.recommendedCommands) {
            Write-Host "  - $command"
        }
    }
}

try {
    $nextOutput = & powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "ai-dev-next.p
s1") -Json 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Stop-WithJsonError "ai-dev-next.ps1 실행에 실패했습니다: $nextOutput"
    }

    $next = $nextOutput | ConvertFrom-Json
} catch {
    Stop-WithJsonError "다음 action 판단에 실패했습니다: $($_.Exception.Message)"
}

$action = [string]$next.action
$recommendedCommands = @($next.recommendedCommands)
$commandDisplay = if ($recommendedCommands.Count -gt 0) { $recommendedCommands[0] } else { "" }
$scriptToRun = $null
$scriptArguments = @()
$shouldExecute = $false
$message = ""

switch ($action) {
    "make_task_prompt" {
        $scriptToRun = "ai-dev-make-prompt.ps1"
        $shouldExecute = $true
        $message = "현재 task 프롬프트를 생성합니다."
    }
    "run_check" {
        $scriptToRun = "ai-dev-check.ps1"
        $scriptArguments = @("-BuildOnly")
        $shouldExecute = [bool]$AllowCheck
        $message = if ($AllowCheck) {
            "검증을 실행합니다: ai-dev-check.ps1 -BuildOnly"
        } else {
            "검증 단계는 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowCheck를 사용하세요."
        }
    }
    "save_diff" {
        $scriptToRun = "ai-dev-save-diff.ps1"
        $scriptArguments = @("-IncludeUntrackedContent")
        $shouldExecute = [bool]$AllowSaveDiff
        $message = if ($AllowSaveDiff) {
            "diff를 저장합니다: ai-dev-save-diff.ps1 -IncludeUntrackedContent"
        } else {
            "diff 저장은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowSaveDiff를 사용하세요."
        }
    }
    "make_review_prompt" {
        $scriptToRun = "ai-dev-make-review-prompt.ps1"
        $scriptArguments = @("-Strict")
        $shouldExecute = [bool]$AllowReviewPrompt
        $message = if ($AllowReviewPrompt) {
            "리뷰 프롬프트를 생성합니다: ai-dev-make-review-prompt.ps1 -Strict"
        } else {
            "리뷰 프롬프트 생성은 기본 자동 실행 대상이 아닙니다. 실행하려면 -AllowReviewPrompt를 사용하세요."
        }
    }
    default {
        if ($action -eq "ask_gpt_review") {
            $reviewBridgeCommands = @(
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-copy-review-prompt.ps1",
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipbo
ard"
            )
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "GPT API는 호출하지 않습니다. review-prompt를 클립보드에 복사해 ChatGPT 웹 화면에 붙여넣고, JSON 리뷰만 
받은 뒤 JSON 리뷰를 클립보드에 복사해 save-review -FromClipboard를 실행하세요." `
                -RecommendedCommands $reviewBridgeCommands
            Write-StepResult $result
            exit 0
        }

        if ($action -eq "goal_completed") {
            $goalCompletedCommands = @(
                "powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1"
            )
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "현재 goal은 completed 상태입니다. 더 실행할 task가 없습니다. 다음 목표를 시작하려면 .ai-dev/goal.md, 
.ai-dev/queue.json, .ai-dev/state.json을 새 목표로 초기화하세요. 상태 확인 명령: powershell -ExecutionPolicy Bypass -
File scripts/ai-dev-status.ps1" `
                -RecommendedCommands $goalCompletedCommands
            Write-StepResult $result
            exit 0
        }

        $forbiddenActions = @(
            "run_codex_or_cline",
            "ask_gpt_review",
            "make_revise_prompt",
            "commit",
            "complete_task",
            "stop_for_user",
            "blocked",
            "goal_completed",
            "no_task",
            "inspect_status"
        )

        if ($forbiddenActions -contains $action) {
            $result = New-StepResult `
                -Action $action `
                -Executed $false `
                -ExitCode 0 `
                -Message "이 action은 auto-step에서 자동 실행하지 않습니다. 추천 명령 또는 사용자 판단이 필요합니다." `
                -RecommendedCommands $recommendedCommands
            Write-StepResult $result
            exit 0
        }

        $result = New-StepResult `
            -Action $action `
            -Executed $false `
            -ExitCode 0 `
            -Message "알 수 없는 action입니다. 상태를 수동으로 확인하세요." `
            -RecommendedCommands @("powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.p
s1")
        Write-StepResult $result
        exit 0
    }
}

if ($DryRun -or -not $shouldExecute) {
    $result = New-StepResult `
        -Action $action `
        -Executed $false `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $(if ([string]::IsNullOrWhiteSpace($commandDisplay)) { @() } else { @($
commandDisplay) })
    Write-StepResult $result
    exit 0
}

try {
    $childResult = Invoke-AiDevScript -ScriptName $scriptToRun -Arguments $scriptArguments

    if ($childResult.ExitCode -ne 0) {
        $result = New-StepResult `
            -Action $action `
            -Executed $true `
            -ExitCode $childResult.ExitCode `
            -Message "하위 스크립트 실행에 실패했습니다: $($childResult.Output)" `
            -RecommendedCommands $recommendedCommands
        Write-StepResult $result
        exit 1
    }

    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 0 `
        -Message $message `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 0
} catch {
    $result = New-StepResult `
        -Action $action `
        -Executed $true `
        -ExitCode 1 `
        -Message "auto-step 실행에 실패했습니다: $($_.Exception.Message)" `
        -RecommendedCommands $recommendedCommands
    Write-StepResult $result
    exit 1
}

 succeeded in 1569ms:
scripts\ai-dev-auto-step.ps1:127:        $scriptToRun = "ai-dev-check.ps1"
scripts\ai-dev-auto-step.ps1:128:        $scriptArguments = @("-BuildOnly")
scripts\ai-dev-auto-step.ps1:131:            "검증을 실행합니다: ai-dev-check.ps1 -BuildOnly"
scripts\ai-dev-check.ps1:2:    [switch]$BuildOnly,
scripts\ai-dev-check.ps1:172:$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
scripts\ai-dev-check.ps1:173:$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
scripts\ai-dev-check.ps1:183:$testSkipReason = if ($BuildOnly) {
scripts\ai-dev-check.ps1:184:    "-BuildOnly 옵션으로 건너뛰었습니다."
scripts\ai-dev-check.ps1:193:$lintSkipReason = if ($BuildOnly) {
scripts\ai-dev-check.ps1:194:    "-BuildOnly 옵션으로 건너뛰었습니다."
scripts\ai-dev-check.ps1:205:    Invoke-NpmCheck "test" $runTest $testSkipReason
scripts\ai-dev-check.ps1:206:    Invoke-NpmCheck "lint" $runLint $lintSkipReason
scripts\ai-dev-check.ps1:258:    "ai-dev-check"
scripts\ai-dev-auto-cycle-full.ps1:471:        check = Get-ScriptPath "ai-dev-check.ps1"
scripts\ai-dev-auto-cycle-full.ps1:561:    Invoke-CycleCommand $stepNumber "check" "powershell -Exec
utionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly" $scriptPaths.check @("-BuildOnly")
.ai-dev\README.md:137:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1
.ai-dev\README.md:140:build만 실행하려면 `-BuildOnly` 옵션을 사용한다.
.ai-dev\README.md:143:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -BuildOnly
.ai-dev\README.md:153:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-check.ps1 -ManualSumma
ryOnly -ManualSummary "PowerShell 문법 검증 통과. auto-step DryRun 통과. auto-cycle DryRun 통과. save-review 실
패/성공 흐름 확인."
.ai-dev\README.md:456:- 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1`
.ai-dev\README.md:677:3. `ai-dev-check.ps1 -BuildOnly`

codex
`ai-dev-check.ps1`만 수정하면 자동 사이클 호출부를 바꾸지 않고 요구사항을 만족할 수 있습니다. 변경은 `-BuildOnly`일 때 test는 실행하지 않되 test
 스크립트 부재 사유를 명확히 쓰고, lint 스크립트가 있으면 BuildOnly와 별도 섹션으로 실행/기록되게 하는 범위로 제한하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\scripts\ai-dev-check.ps1
diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 8c6fdbd7690662c925dc3ebf80968308c60542ab..024cc3d5bd993759bbc341d6aa43472d38cbaaa0
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -170,7 +170,7 @@
 
 $runBuild = $hasBuild -and -not $SkipBuild
 $runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
-$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
+$runLint = $hasLint -and -not $SkipLint
 
 $buildSkipReason = if (-not $hasBuild) {
     "package.json에 build script가 없습니다."
@@ -180,19 +180,17 @@
     ""
 }
 
-$testSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasTest) {
+$testSkipReason = if (-not $hasTest) {
     "package.json에 test script가 없습니다."
 } elseif ($SkipTest) {
     "-SkipTest 옵션으로 건너뛰었습니다."
+} elseif ($BuildOnly) {
+    "-BuildOnly 옵션으로 건너뛰었습니다."
 } else {
     ""
 }
 
-$lintSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasLint) {
+$lintSkipReason = if (-not $hasLint) {
     "package.json에 lint script가 없습니다."
 } elseif ($SkipLint) {
     "-SkipLint 옵션으로 건너뛰었습니다."
@@ -216,6 +214,7 @@
 }
 
 $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
 $commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
 $detailSections = @()
 $codeFence = '```'
@@ -243,6 +242,7 @@
 
 - Overall result: $overallResult
 - Current task: $currentTaskId
+- Mode: $modeText
 - Commands:
 $commandSummary
 

diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 8c6fdbd7690662c925dc3ebf80968308c60542ab..024cc3d5bd993759bbc341d6aa43472d38cbaaa0
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -170,7 +170,7 @@
 
 $runBuild = $hasBuild -and -not $SkipBuild
 $runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
-$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
+$runLint = $hasLint -and -not $SkipLint
 
 $buildSkipReason = if (-not $hasBuild) {
     "package.json에 build script가 없습니다."
@@ -180,19 +180,17 @@
     ""
 }
 
-$testSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasTest) {
+$testSkipReason = if (-not $hasTest) {
     "package.json에 test script가 없습니다."
 } elseif ($SkipTest) {
     "-SkipTest 옵션으로 건너뛰었습니다."
+} elseif ($BuildOnly) {
+    "-BuildOnly 옵션으로 건너뛰었습니다."
 } else {
     ""
 }
 
-$lintSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasLint) {
+$lintSkipReason = if (-not $hasLint) {
     "package.json에 lint script가 없습니다."
 } elseif ($SkipLint) {
     "-SkipLint 옵션으로 건너뛰었습니다."
@@ -216,6 +214,7 @@
 }
 
 $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
 $commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
 $detailSections = @()
 $codeFence = '```'
@@ -243,6 +242,7 @@
 
 - Overall result: $overallResult
 - Current task: $currentTaskId
+- Mode: $modeText
 - Commands:
 $commandSummary
 

codex
수정은 한 파일에만 적용했습니다. 이제 실제 `npm run build/lint/test`는 실행하지 않고, PowerShell 파서로 스크립트 문법만 확인한 뒤 변경된 핵심 부분
을 다시 읽어 기록 형식이 의도대로 들어갔는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg -n \"runBuild|runTest|
runLint|testSkipReason|lintSkipReason|modeText|Mode:\" scripts\\ai-dev-check.ps1" in D:\ai-apps\plan
pilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$tokens=$null;$errors=$nu
ll;[System.Management.Automation.Language.Parser]::ParseFile('"'D:\\ai-apps\\planpilot-local\\script
s\\ai-dev-check.ps1',[ref]"'$tokens,[ref]$errors) > $null;if($errors.Count -eq 0){'"'PowerShell pars
e: passed'}else{"'$errors | ForEach-Object { $_.Message }}' in D:\ai-apps\planpilot-local
 succeeded in 1266ms:
PowerShell parse: passed

 succeeded in 1549ms:
136:- Mode: manual-summary
171:$runBuild = $hasBuild -and -not $SkipBuild
172:$runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
173:$runLint = $hasLint -and -not $SkipLint
183:$testSkipReason = if (-not $hasTest) {
193:$lintSkipReason = if (-not $hasLint) {
202:    Invoke-NpmCheck "build" $runBuild $buildSkipReason
203:    Invoke-NpmCheck "test" $runTest $testSkipReason
204:    Invoke-NpmCheck "lint" $runLint $lintSkipReason
217:$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
245:- Mode: $modeText

diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 8c6fdbd7690662c925dc3ebf80968308c60542ab..024cc3d5bd993759bbc341d6aa43472d38cbaaa0
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -170,7 +170,7 @@
 
 $runBuild = $hasBuild -and -not $SkipBuild
 $runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
-$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
+$runLint = $hasLint -and -not $SkipLint
 
 $buildSkipReason = if (-not $hasBuild) {
     "package.json에 build script가 없습니다."
@@ -180,19 +180,17 @@
     ""
 }
 
-$testSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasTest) {
+$testSkipReason = if (-not $hasTest) {
     "package.json에 test script가 없습니다."
 } elseif ($SkipTest) {
     "-SkipTest 옵션으로 건너뛰었습니다."
+} elseif ($BuildOnly) {
+    "-BuildOnly 옵션으로 건너뛰었습니다."
 } else {
     ""
 }
 
-$lintSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasLint) {
+$lintSkipReason = if (-not $hasLint) {
     "package.json에 lint script가 없습니다."
 } elseif ($SkipLint) {
     "-SkipLint 옵션으로 건너뛰었습니다."
@@ -216,6 +214,7 @@
 }
 
 $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
 $commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
 $detailSections = @()
 $codeFence = '```'
@@ -243,6 +242,7 @@
 
 - Overall result: $overallResult
 - Current task: $currentTaskId
+- Mode: $modeText
 - Commands:
 $commandSummary
 

codex
문법 검증은 통과했습니다. 추가로 실제 npm 명령은 호출하지 않고 `package.json` 기준의 분기값만 계산해, 현재 저장소에서 `-BuildOnly`일 때 lint가 실행
 대상으로 잡히고 test 미실행 사유가 스크립트 부재로 계산되는지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '$package=Get-Content -Raw
 -Encoding UTF8 -LiteralPath '"'D:\\ai-apps\\planpilot-local\\package.json' | ConvertFrom-Json;"'$Bu
ildOnly=$true;$SkipBuild=$false;$SkipTest=$false;$SkipLint=$false;$hasBuild=$null -ne $package.scrip
ts -and ($package.scripts.PSObject.Properties.Name -contains '"'build');"'$hasTest=$null -ne $packag
e.scripts -and ($package.scripts.PSObject.Properties.Name -contains '"'test');"'$hasLint=$null -ne $
package.scripts -and ($package.scripts.PSObject.Properties.Name -contains '"'lint');"'$runBuild=$has
Build -and -not $SkipBuild;$runTest=$hasTest -and -not $SkipTest -and -not $BuildOnly;$runLint=$hasL
int -and -not $SkipLint;$testSkipReason=if(-not $hasTest){'"'package.json에 test script가 없습니다.'}elsei
f("'$SkipTest){'"'-SkipTest 옵션으로 건너뛰었습니다.'}elseif("'$BuildOnly){'"'-BuildOnly 옵션으로 건너뛰었습니다.'}else{''
};[PSCustomObject]@{hasBuild="'$hasBuild;hasTest=$hasTest;hasLint=$hasLint;runBuild=$runBuild;runTes
t=$runTest;runLint=$runLint;testSkipReason=$testSkipReason} | ConvertTo-Json' in D:\ai-apps\planpilo
t-local
 succeeded in 1063ms:
{
    "hasBuild":  true,
    "hasTest":  false,
    "hasLint":  true,
    "runBuild":  true,
    "runTest":  false,
    "runLint":  true,
    "testSkipReason":  "package.json에 test script가 없습니다."
}

diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 8c6fdbd7690662c925dc3ebf80968308c60542ab..024cc3d5bd993759bbc341d6aa43472d38cbaaa0
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -170,7 +170,7 @@
 
 $runBuild = $hasBuild -and -not $SkipBuild
 $runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
-$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
+$runLint = $hasLint -and -not $SkipLint
 
 $buildSkipReason = if (-not $hasBuild) {
     "package.json에 build script가 없습니다."
@@ -180,19 +180,17 @@
     ""
 }
 
-$testSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasTest) {
+$testSkipReason = if (-not $hasTest) {
     "package.json에 test script가 없습니다."
 } elseif ($SkipTest) {
     "-SkipTest 옵션으로 건너뛰었습니다."
+} elseif ($BuildOnly) {
+    "-BuildOnly 옵션으로 건너뛰었습니다."
 } else {
     ""
 }
 
-$lintSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasLint) {
+$lintSkipReason = if (-not $hasLint) {
     "package.json에 lint script가 없습니다."
 } elseif ($SkipLint) {
     "-SkipLint 옵션으로 건너뛰었습니다."
@@ -216,6 +214,7 @@
 }
 
 $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
 $commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
 $detailSections = @()
 $codeFence = '```'
@@ -243,6 +242,7 @@
 
 - Overall result: $overallResult
 - Current task: $currentTaskId
+- Mode: $modeText
 - Commands:
 $commandSummary
 

codex
변경한 파일: [scripts/ai-dev-check.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-check.ps1:173)

구현 내용:
- `-BuildOnly`에서도 `lint` 스크립트가 있으면 `npm run lint`가 실행/기록되도록 변경했습니다.
- `test` 스크립트가 없는 경우 `-BuildOnly`보다 `package.json에 test script가 없습니다.` 사유가 우선 기록되도록 조정했습니다.
- `test-result.md`에 `Mode: BuildOnly (build + lint when available)`가 남도록 해 BuildOnly 검증과 lint 기록을 구분
했습니다.

검증:
- PowerShell 파서 문법 검증 통과.
- 실제 npm 명령 실행 없이 현재 `package.json` 기준 분기만 확인:
  - `hasLint: true`
  - `hasTest: false`
  - `runLint: true`
  - `testSkipReason: package.json에 test script가 없습니다.`

빌드/lint/test는 프롬프트가 자동 실행을 지시하지 않았고 AGENTS 규칙상 사용자 허용이 필요하므로 실행하지 않았습니다.

남은 위험:
- 실제 `ai-dev-check.ps1 -BuildOnly` 실행 결과 파일 갱신은 아직 미검증입니다. 사람이 허용 후 실행하면 `test-result.md`에 build와 li
nt가 별도 섹션으로 기록되는지 확인할 수 있습니다.

다음 task로 넘어가도 되는지:
- 현재 task 범위의 코드 수정과 비실행 검증은 완료되어 넘어가도 됩니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
```text
- Result: T001 완료: ai-dev-check.ps1의 BuildOnly 검증에서 lint 스크립트가 있으면 lint 결과를 별도 기록하도록 수정하고, test 스크립트
가 없을 때 미실행 사유를 명확히 기록하도록 개선함
- Verification: PowerShell parse 통과. package.json 기준 분기 확인: BuildOnly에서 runLint=true, test 미실행 사유=pa
ckage.json에 test script가 없습니다. 실제 build/test/lint는 실행하지 않음
```
diff --git a/scripts/ai-dev-check.ps1 b/scripts/ai-dev-check.ps1
index 8c6fdbd7690662c925dc3ebf80968308c60542ab..024cc3d5bd993759bbc341d6aa43472d38cbaaa0
--- a/scripts/ai-dev-check.ps1
+++ b/scripts/ai-dev-check.ps1
@@ -170,7 +170,7 @@
 
 $runBuild = $hasBuild -and -not $SkipBuild
 $runTest = $hasTest -and -not $SkipTest -and -not $BuildOnly
-$runLint = $hasLint -and -not $SkipLint -and -not $BuildOnly
+$runLint = $hasLint -and -not $SkipLint
 
 $buildSkipReason = if (-not $hasBuild) {
     "package.json에 build script가 없습니다."
@@ -180,19 +180,17 @@
     ""
 }
 
-$testSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasTest) {
+$testSkipReason = if (-not $hasTest) {
     "package.json에 test script가 없습니다."
 } elseif ($SkipTest) {
     "-SkipTest 옵션으로 건너뛰었습니다."
+} elseif ($BuildOnly) {
+    "-BuildOnly 옵션으로 건너뛰었습니다."
 } else {
     ""
 }
 
-$lintSkipReason = if ($BuildOnly) {
-    "-BuildOnly 옵션으로 건너뛰었습니다."
-} elseif (-not $hasLint) {
+$lintSkipReason = if (-not $hasLint) {
     "package.json에 lint script가 없습니다."
 } elseif ($SkipLint) {
     "-SkipLint 옵션으로 건너뛰었습니다."
@@ -216,6 +214,7 @@
 }
 
 $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
+$modeText = if ($BuildOnly) { "BuildOnly (build + lint when available)" } else { "standard" }
 $commandSummary = ($results | ForEach-Object { "  - $($_.Command): $($_.Status)" }) -join "`r`n"
 $detailSections = @()
 $codeFence = '```'
@@ -243,6 +242,7 @@
 
 - Overall result: $overallResult
 - Current task: $currentTaskId
+- Mode: $modeText
 - Commands:
 $commandSummary
 

tokens used
52,257
변경한 파일: [scripts/ai-dev-check.ps1](D:/ai-apps/planpilot-local/scripts/ai-dev-check.ps1:173)

구현 내용:
- `-BuildOnly`에서도 `lint` 스크립트가 있으면 `npm run lint`가 실행/기록되도록 변경했습니다.
- `test` 스크립트가 없는 경우 `-BuildOnly`보다 `package.json에 test script가 없습니다.` 사유가 우선 기록되도록 조정했습니다.
- `test-result.md`에 `Mode: BuildOnly (build + lint when available)`가 남도록 해 BuildOnly 검증과 lint 기록을 구분했습니다.

검증:
- PowerShell 파서 문법 검증 통과.
- 실제 npm 명령 실행 없이 현재 `package.json` 기준 분기만 확인:
  - `hasLint: true`
  - `hasTest: false`
  - `runLint: true`
  - `testSkipReason: package.json에 test script가 없습니다.`

빌드/lint/test는 프롬프트가 자동 실행을 지시하지 않았고 AGENTS 규칙상 사용자 허용이 필요하므로 실행하지 않았습니다.

남은 위험:
- 실제 `ai-dev-check.ps1 -BuildOnly` 실행 결과 파일 갱신은 아직 미검증입니다. 사람이 허용 후 실행하면 `test-result.md`에 build와 lint가 별도 섹션으로 기록되는지 확인할 수 있습니다.

다음 task로 넘어가도 되는지:
- 현재 task 범위의 코드 수정과 비실행 검증은 완료되어 넘어가도 됩니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
```text
- Result: T001 완료: ai-dev-check.ps1의 BuildOnly 검증에서 lint 스크립트가 있으면 lint 결과를 별도 기록하도록 수정하고, test 스크립트가 없을 때 미실행 사유를 명확히 기록하도록 개선함
- Verification: PowerShell parse 통과. package.json 기준 분기 확인: BuildOnly에서 runLint=true, test 미실행 사유=package.json에 test script가 없습니다. 실제 build/test/lint는 실행하지 않음
```

```
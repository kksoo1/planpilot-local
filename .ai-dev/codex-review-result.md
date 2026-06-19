# Codex Review Result

## Run

- Started at: 2026-06-19 21:53:05
- Ended at: 2026-06-19 21:53:38
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

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
session id: 019edff1-2de4-73c3-83bc-bbb34b4051ad
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.a
i-dev\review-prompt.md
codex
요청하신 리뷰 지침 파일을 먼저 읽고, 그 지침 범위 안에서 코드 리뷰를 진행하겠습니다. 지금은 파일 내용 확인만 합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath \"D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md\"" in D:\ai-apps\planpilot-local
 succeeded in 1049ms:
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

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 
반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 기준 안내 문구 보강
- Description: AI Dev Loop 관련 문서 또는 기존 안내 문구에 완료 기준을 짧게 추가하고, 앱 기능 로직과 UI 동작은 변경하지 않는다.
- Type: documentation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 완료 기준에 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 정리 상태가 포함되는지 확인한다.
- 앱 기능 로직과 UI 동작 파일이 변경되지 않았는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-06-19 21:52:58

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
dist/assets/index-Bc7EYrNn.js   316.52 kB │ gzip: 99.88 kB

[32m✓ built in 232ms[39m
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

2026-06-19 21:53:02

## Git Status

```text
 M .ai-dev/README.md
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/README.md
- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니
다.

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

codex
리뷰 프롬프트상 앱 변경 diff는 비어 있고 `.ai-dev` 운영 산출물만 변경된 상태입니다. 실제로 완료 기준 문구가 들어간 파일을 확인하기 위해 관련 `.ai-dev
` 문서 파일만 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath \"D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath \"D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md\"" in D:\ai-apps\planpilot-l
ocal
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath \"D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md\"" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath \"D:\\ai-apps\\planpilot-local\\.ai-dev\\codex-result.md\"" in D:\ai-apps\planpilot-local
 succeeded in 1956ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 
반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 기준 안내 문구 보강
- Description: AI Dev Loop 관련 문서 또는 기존 안내 문구에 완료 기준을 짧게 추가하고, 앱 기능 로직과 UI 동작은 변경하지 않는다.
- Type: documentation
- Status: in_progress
- Priority: P1
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

## Verification

- 완료 기준에 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 정리 상태가 포함되는지 확인한다.
- 앱 기능 로직과 UI 동작 파일이 변경되지 않았는지 확인한다.

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

 succeeded in 1995ms:
# 목표

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 
반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

 succeeded in 2008ms:
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

 succeeded in 2244ms:
# Codex Implementation Result

## Run

- Started at: 2026-06-19 21:51:51
- Ended at: 2026-06-19 21:52:49
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
session id: 019edff0-0d94-7240-b43c-e0bc978b262b
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-
dev\current-task-prompt.md
codex
지정된 작업 프롬프트만 먼저 읽어서 요구사항과 수정 범위를 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\current-task-prompt.md'" in D:\ai-apps\planpilot-loc
al
 succeeded in 993ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 
반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: 완료 기준 안내 문구 보강
- Description: AI Dev Loop 관련 문서 또는 기존 안내 문구에 완료 기준을 짧게 추가하고, 앱 기능 로직과 UI 동작은 변경하지 않는다.
- Type: documentation
- Status: in_progress
- Priority: P1
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

## Verification

- 완료 기준에 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 정리 상태가 포함되는지 확인한다.
- 앱 기능 로직과 UI 동작 파일이 변경되지 않았는지 확인한다.

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
작업은 문서 보강으로 한정되어 있습니다. 후보 파일의 기존 구조를 읽고, 가장 작은 한 파일 변경으로 성공 기준을 담을 위치를 고르겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\queue.json'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\goal.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\state.json'" in D:\ai-apps\planpilot-local
 succeeded in 1716ms:
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
    "startedAt":  "2026-06-19T00:00:00+09:00",
    "updatedAt":  "2026-06-19T00:00:00+09:00",
    "stopReason":  null
}

 succeeded in 1734ms:
# 목표

AI Dev Loop의 완료 기준을 문서 또는 기존 안내 문구에 짧게 보강한다.

## 배경

현재 AI Dev Loop의 완료 조건을 더 명확히 안내할 필요가 있다. 사용자가 작업 종료 시 기대하는 기준을 빠르게 확인할 수 있도록 기존 문서나 안내 문구에 간결하게 
반영한다.

## 성공 기준

- 완료 기준에 build/lint 통과가 포함된다.
- 리뷰 pass가 완료 기준에 포함된다.
- 구현 커밋이 완료 기준에 포함된다.
- complete-task 수행이 완료 기준에 포함된다.
- .ai-dev 메타 커밋이 완료 기준에 포함된다.
- 최종 git 상태가 깨끗해야 함을 명확히 적는다.
- 앱 기능 로직과 UI 동작은 변경하지 않는다.

## 제약사항

- 문서 또는 기존 안내 문구만 짧게 보강한다.
- 한 번에 하나의 작은 변경으로 처리한다.
- 기존 표현과 문서 구조를 최대한 유지한다.
- 앱 코드, 저장소 구조, 사용자 데이터 처리 방식은 변경하지 않는다.

## 범위 제외

- 앱 기능 로직 변경
- UI 동작 변경
- 새 화면 추가
- 대규모 문서 재작성
- 저장 구조 변경

## 수동 검증

- 변경된 문구가 완료 기준을 빠짐없이 포함하는지 확인한다.
- 앱 기능 또는 UI 동작 관련 파일이 변경되지 않았는지 확인한다.
- 문구가 짧고 기존 안내 흐름을 해치지 않는지 확인한다.

 succeeded in 1805ms:
{
    "goalTitle":  "AI Dev Loop 완료 기준 문서 보강",
    "goalSource":  ".ai-dev/goal.md",
    "createdAt":  "2026-06-19T00:00:00+09:00",
    "updatedAt":  "2026-06-19T00:00:00+09:00",
    "currentTaskId":  "T001",
    "tasks":  [
                  {
                      "id":  "T001",
                      "title":  "완료 기준 안내 문구 보강",
                      "description":  "AI Dev Loop 관련 문서 또는 기존 안내 문구에 완료 기준을 짧게 추가하고, 앱 기능 로직과 U
I 동작은 변경하지 않는다.",
                      "type":  "documentation",
                      "status":  "in_progress",
                      "priority":  "P1",
                      "dependsOn":  [

                                    ],
                      "filesLikelyToChange":  [
                                                  ".ai-dev/goal.md",
                                                  ".ai-dev/queue.json",
                                                  ".ai-dev/state.json"
                                              ],
                      "verification":  [
                                           "완료 기준에 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task,
 .ai-dev 메타 커밋, 최종 정리 상태가 포함되는지 확인한다.",
                                           "앱 기능 로직과 UI 동작 파일이 변경되지 않았는지 확인한다."
                                       ],
                      "commitMessage":  "Document AI dev loop completion criteria"
                  }
              ]
}

codex
`.ai-dev/goal.md`는 현재 작업 목표 자체라 이미 성공 기준을 담고 있습니다. 실제 사용자가 반복해서 보는 AI Dev Loop 안내 문구가 있는지 `.ai-d
ev` 안에서 관련 문서만 찾아보겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'rg --files .ai-dev' i
n D:\ai-apps\planpilot-local
 succeeded in 1330ms:
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

exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\README.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\plan.md'" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath 'D:\\ai-apps\\planpilot-local\\.ai-dev\\loop-log.md'" in D:\ai-apps\planpilot-local
 succeeded in 1617ms:
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

 succeeded in 1978ms:
# AI Dev Plan

## Goal

AI Dev Loop Codex CLI ?꾩쟾 ?먮룞???꾩엯

## 紐⑺몴 踰붿쐞

- Codex CLI瑜?援ы쁽?먯? 由щ럭?대줈 ?ъ슜??AI Dev Loop瑜?end-to-end ?먮룞?뷀븯??珥덉븞??留뚮뱺??
- `current-task-prompt.md`瑜?Codex CLI???꾨떖???꾩옱 task 援ы쁽???섑뻾?쒕떎.
- `review-prompt.md`瑜?Codex CLI???꾨떖??JSON 由щ럭瑜??앹꽦?쒕떎.
- Codex 援ы쁽, check/build, diff ??? Codex 由щ럭, save-review, pass ??commit/complete-task ?먮쫫???곌껐
?쒕떎.
- 珥덇린 踰꾩쟾? `MaxTasks 1`, 紐낆떆??Allow ?듭뀡, dirty worktree 以묐떒, package 蹂寃?媛먯?, build ?ㅽ뙣 ??commi
t 湲덉?瑜??곸슜?쒕떎.
- 理쒖쥌?곸쑝濡??ъ슜?먭? `GoalTitle`怨?`GoalDescription`留??낅젰??goal ?앹꽦, task 遺꾪빐, prompt ?앹꽦, full auto-
cycle ?ㅽ뻾源뚯? ??踰덉뿉 ?쒖옉?????덈뒗 `ai-dev-auto-goal.ps1`???꾩엯?쒕떎.

## 踰붿쐞 ?쒗븳

- GPT API瑜?吏곸젒 ?몄텧?섏? ?딅뒗??
- Cline? ??젣?섏뼱 ?ъ슜?섏? ?딅뒗??
- Copilot CLI? gh???꾩옱 ?ъ슜?섏? ?딅뒗??
- git push ?먮룞?붾뒗 援ы쁽?섏? ?딅뒗??
- git reset, git clean, npm install? ?먮룞 ?ㅽ뻾?섏? ?딅뒗??
- package.json/package-lock.json 蹂寃쎌씠 媛먯??섎㈃ ?먮룞 而ㅻ컠?섏? ?딅뒗??
- build/check ?ㅽ뙣 ???먮룞 而ㅻ컠?섏? ?딅뒗??
- scripts/src/package ?뚯씪? 媛?task 踰붿쐞?먯꽌留??섏젙?쒕떎.

## ?묒뾽 ?쒖꽌

### T001 Codex CLI ?꾩쟾 ?먮룞???뺤콉 臾몄꽌??
- Codex CLI瑜?援ы쁽?먯? 由щ럭?대줈 ?ъ슜?섎뒗 ?뺤콉??臾몄꽌?뷀븳??
- `codex exec` ?ъ슜 踰붿쐞? ?덉쟾 湲곗????뺣━?쒕떎.
- dirty worktree, package 蹂寃? build ?ㅽ뙣, 由щ럭 blocked/revise ?곹솴??以묐떒 議곌굔???뺣━?쒕떎.
- Cline/Copilot/GPT API ?놁씠 吏꾪뻾?섎뒗 援ъ“瑜?紐낇솗???쒕떎.

?꾨즺 湲곗?:

- Codex CLI ?ъ슜 諛⑹떇??臾몄꽌?붾릺???덈떎.
- ?먮룞 ?ㅽ뻾 ?덉슜/湲덉? 紐낅졊 湲곗???臾몄꽌?붾릺???덈떎.
- git reset, git clean, npm install 湲덉?媛 紐낇솗?섎떎.
- package 蹂寃?媛먯?? build ?ㅽ뙣 ???먮룞 commit 湲덉?媛 紐낇솗?섎떎.

T001 臾몄꽌??寃곌낵:

- Codex CLI??援ы쁽????븷?먯꽌 `.ai-dev/current-task-prompt.md`瑜??낅젰?쇰줈 ?ъ슜?쒕떎.
- Codex CLI??由щ럭????븷?먯꽌 `.ai-dev/review-prompt.md`瑜??낅젰?쇰줈 ?ъ슜?섍퀬 JSON 由щ럭瑜??앹꽦?쒕떎.
- GPT API, Cline, Copilot CLI, `gh` ?놁씠 Codex CLI留뚯쑝濡?援ы쁽/由щ럭 ?먮쫫??援ъ꽦?쒕떎.
- 珥덇린 full auto-cycle? `MaxTasks 1`怨?紐낆떆??Allow ?듭뀡??湲곗??쇰줈 ?쒗븳?쒕떎.
- Codex 援ы쁽? `AllowCodex`, Codex 由щ럭??`AllowReviewCodex`, git commit? `AllowCommit`???덉쓣 ?뚮쭔 ?
ㅽ뻾?쒕떎.
- git status dirty, package ?뚯씪 蹂寃? build/check ?ㅽ뙣, 由щ럭 decision??`pass`媛 ?꾨땶 寃쎌슦 ?먮룞 而ㅻ컠?섏? 
?딅뒗??
- `git reset`, `git clean`, `npm install`, `git push`, DB ??젣/蹂듭썝/留덉씠洹몃젅?댁뀡? ?먮룞 ?ㅽ뻾?섏? ?딅뒗??
- ?ㅽ뻾 寃곌낵??`.ai-dev/codex-result.md`, `.ai-dev/review-response.json`, `.ai-dev/review.md`, `.ai-
dev/test-result.md`, `.ai-dev/loop-log.md`, `.ai-dev/state.json`??湲곕줉?섎뒗 湲곗??쇰줈 ?뺣━?덈떎.
- T002?먯꽌?????뺤콉??諛뷀깢?쇰줈 `scripts/ai-dev-run-codex.ps1`??異붽??????덈떎.

### T002 Codex 援ы쁽 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?

- `scripts/ai-dev-run-codex.ps1`??異붽??쒕떎.
- `current-task-prompt.md`瑜?Codex CLI???꾨떖?쒕떎.
- DryRun??吏?먰븳??
- `current-task-prompt.md`媛 ?놁쑝硫?紐낇솗???덈궡?쒕떎.
- git status dirty ?곹깭?먯꽌??湲곕낯 以묐떒?쒕떎.
- PowerShell 臾몃쾿 寃利앹쓣 ?섑뻾?쒕떎.

### T003 Codex 由щ럭 ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?

- `scripts/ai-dev-run-review-codex.ps1`??異붽??쒕떎.
- `review-prompt.md`瑜?Codex CLI???꾨떖?쒕떎.
- Codex 異쒕젰?먯꽌 JSON 媛앹껜瑜?異붿텧??`.ai-dev/review-response.json`????ν븳??
- `ai-dev-save-review.ps1` ?먮쫫怨??곌껐?쒕떎.
- DryRun怨?PowerShell 臾몃쾿 寃利앹쓣 吏?먰븳??

蹂듦뎄 硫붾え:

- `queue.json`?먯꽌 T003??`done`?쇰줈 ?쒖떆?섏뼱 ?덉뿀吏留??ㅼ젣 `scripts/ai-dev-run-review-codex.ps1` ?뚯씪??議
댁옱?섏? ?딆븯??
- T004 full auto-cycle? T003 ?곗텧臾쇱뿉 ?섏〈?섎?濡?T003??`in_progress`濡??섎룎由ш퀬 T004瑜?`pending`?쇰줈 ?섎룎由
곕떎.
- ?ㅼ쓬 ?묒뾽? T003 ?곗텧臾쇱쓣 ?ㅼ젣濡?異붽??섍퀬 寃利앺븳 ??T004濡?吏꾪뻾?쒕떎.

### T004 full auto-cycle 珥덉븞 異붽?

- `scripts/ai-dev-auto-cycle-full.ps1` 珥덉븞??異붽??쒕떎.
- make-prompt, run-codex, check, save-diff, make-review-prompt, run-review-codex瑜??곌껐?쒕떎.
- `MaxTasks`, `AllowCodex`, `AllowReviewCodex`, `AllowCommit` 媛숈? 紐낆떆???듭뀡???붾떎.
- DryRun?먯꽌 ?꾩껜 ?④퀎媛 ?쒖떆?섎룄濡??쒕떎.

### T005 ?먮룞 而ㅻ컠怨?task ?꾨즺 ?곌껐

- 由щ럭 寃곌낵媛 pass???뚮쭔 commit怨?complete-task瑜??섑뻾?섎룄濡??곌껐?쒕떎.
- pass媛 ?꾨땲硫?commit?섏? ?딅뒗??
- build ?ㅽ뙣 ??commit?섏? ?딅뒗??
- package ?뚯씪 蹂寃?媛먯? ??以묐떒?쒕떎.
- complete-task??pass ?댄썑?먮쭔 ?ㅽ뻾?쒕떎.

### T006 ?묒? ??task濡?end-to-end 寃利?
- ?묒? 臾몄꽌 ?먮뒗 UI 蹂寃?task瑜?`MaxTasks 1`濡??ㅽ뻾?쒕떎.
- Codex 援ы쁽 濡쒓렇瑜??뺤씤?쒕떎.
- Codex 由щ럭 JSON ??μ쓣 ?뺤씤?쒕떎.
- pass ??而ㅻ컠怨?complete-task媛 ?섑뻾?섎뒗吏 ?뺤씤?쒕떎.
- 理쒖쥌 git status clean ?щ?瑜??뺤씤?쒕떎.

### T007 紐⑺몴 ?낅젰 湲곕컲 ?먮룞 goal ?ㅽ뻾 ?ㅽ겕由쏀듃 異붽?

- `scripts/ai-dev-auto-goal.ps1`??異붽??쒕떎.
- ?ъ슜?먭? `GoalTitle`怨?`GoalDescription`留??낅젰?섎㈃ Codex CLI瑜??댁슜??goal, queue, state 珥덉븞???앹꽦?????
덇쾶 ?쒕떎.
- ?앹꽦??goal/queue/state JSON ?뚯떛 寃利앹쓣 ?섑뻾?쒕떎.
- current-task-prompt ?앹꽦 ??`ai-dev-auto-cycle-full.ps1` ?ㅽ뻾?쇰줈 ?댁뼱吏????덇쾶 ?쒕떎.
- ?ㅼ젣 full cycle ?ㅽ뻾? `-AllowRun` ?먮뒗 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- DryRun?먯꽌 ?앹꽦??goal/task 怨꾪쉷怨??ㅽ뻾 ?④퀎瑜??쒖떆?쒕떎.
- Json 異쒕젰怨?PowerShell 臾몃쾿 寃利앹쓣 吏?먰븳??

?덉긽 理쒖쥌 紐낅졊:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "?낅Т 寃??寃곌낵 
?섏씠?쇱씠??異붽?" -GoalDescription "寃?됱뼱? ?쇱튂?섎뒗 ?낅Т ?쒕ぉ/硫붾え/?꾨줈?앺듃紐낆쓣 ?붾㈃?먯꽌 媛뺤“ ?쒖떆?쒕떎." -AllowCo
dex -AllowReviewCodex -AllowCommit -MaxTasks 1
```

## Stop Conditions

- Codex CLI ?ㅽ뻾???꾩옱 ?섍꼍?먯꽌 ?ㅽ뙣?섎뒗 寃쎌슦
- git status媛 dirty?몃뜲 紐낆떆?곸쑝濡??덉슜?섏? ?딆? 寃쎌슦
- `GoalTitle` ?먮뒗 `GoalDescription`??鍮꾩뼱 ?덈뒗 寃쎌슦
- Codex媛 ?앹꽦??goal/queue/state JSON???뚯떛?????녿뒗 寃쎌슦
- package.json/package-lock.json 蹂寃쎌씠 媛먯??섎뒗 寃쎌슦
- build/check ?ㅽ뙣媛 諛쒖깮?섎뒗 寃쎌슦
- 由щ럭 decision??pass媛 ?꾨땶 寃쎌슦
- git reset, git clean, npm install???꾩슂?댁???寃쎌슦
- DB ??젣, 珥덇린?? 蹂듭썝, 留덉씠洹몃젅?댁뀡 ?꾪뿕???앷린??寃쎌슦
- 媛숈? ?ㅻ쪟媛 諛섎났?섏뼱 ?먮룞 猷⑦봽媛 ?덉쟾?섍쾶 吏꾪뻾?????녿뒗 寃쎌슦

 succeeded in 2025ms:
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

codex
기존 안내 흐름상 `.ai-dev/README.md`의 운영 원칙이 가장 적합합니다. 앱 코드와 상태 JSON은 건드리지 않고, 완료 기준 한 줄만 문서에 추가하겠습니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\.ai-dev\README.md
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 8bf4b1a5309fa1ec6590a636a60ca9093d065cc2..b07d63241a0dc15fd90062dae39bbc63c9f134ea
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -803,6 +803,7 @@
 - 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
 - 한 번에 하나의 task만 수행한다.
 - task 단위로 구현, 검증, 리뷰, 커밋한다.
+- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean 상태
까지 확인된 경우로 한다.
 - 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
 - 검증하지 않은 결과를 통과로 기록하지 않는다.
 - 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 8bf4b1a5309fa1ec6590a636a60ca9093d065cc2..b07d63241a0dc15fd90062dae39bbc63c9f134ea
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -803,6 +803,7 @@
 - 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
 - 한 번에 하나의 task만 수행한다.
 - task 단위로 구현, 검증, 리뷰, 커밋한다.
+- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean 상태
까지 확인된 경우로 한다.
 - 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
 - 검증하지 않은 결과를 통과로 기록하지 않는다.
 - 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

codex
문구는 한 줄로 반영했습니다. 이제 해당 완료 기준이 빠짐없이 들어갔는지, 수정 파일이 문서 파일 하나인지 확인하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg -n \"task 완료 기준|bu
ild/lint|리뷰 pass|complete-task|메타 커밋|git clean\" .ai-dev\\README.md" in D:\ai-apps\planpilot-loc
al
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "rg -n \"task 완료 기준\" 
.ai-dev\\README.md" in D:\ai-apps\planpilot-local
 succeeded in 1675ms:
115:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "T0
01 분석 완료"
121:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -TaskId T001 -Resu
ltSummary "분석 완료"
127:powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoNext
420:- `pass`: `ai-dev-complete-task.ps1` 실행 또는 커밋 조건을 검토한다.
568:- `scripts/ai-dev-auto-cycle-full.ps1`: prompt 생성, Codex 구현, check, diff 저장, Codex 리뷰, save-
review, pass 시 commit/complete-task를 연결한다.
580:- `git reset`, `git clean`, `npm install`, `git push`는 자동 실행하지 않는다.
625:이 스크립트는 Codex에 전달하는 프롬프트 끝에 추가 안전 규칙을 붙인다. git commit, git reset, git clean, npm install, pa
ckage 파일 수정, 현재 task 범위 밖 작업을 금지한다. 스크립트 자체도 build/test/lint, git add, git commit을 실행하지 않는다.
685:11. 커밋 성공 후에만 `ai-dev-complete-task.ps1`을 실행한다.
686:12. `MaxTasks`가 1보다 크면 complete-task 성공 후 다음 task를 다시 읽고 같은 흐름을 반복한다.
700:기본값은 `MaxTasks 1`, `MaxSteps 20`이다. `MaxTasks`와 `MaxSteps`는 무한 반복을 막기 위한 제한이다. `MaxTasks`가 1
보다 크면 각 task가 커밋과 complete-task까지 성공한 경우에만 다음 task로 반복한다.
706:여러 task 반복 구조를 확인하려면 `MaxTasks`를 늘릴 수 있다. 실제 반복은 각 task의 commit/complete-task가 성공해야 다음 task로
 넘어간다.
736:최대 3개 task까지 연속 실행하려면 `MaxTasks 3`을 지정한다. complete-task가 queue/state/loop-log를 갱신하므로, 다음 tas
k 구현 실행 시 dirty worktree 정책을 별도로 판단해야 한다.
748:리뷰 decision이 `pass`가 아니거나 `review-response.json`의 `next_step`이 `complete_task`가 아니면 자동 커밋과 c
omplete-task를 실행하지 않는다. build/check 실패는 하위 check 단계 실패로 중단되므로 커밋까지 진행되지 않는다. `package.json` 또는 `
package-lock.json` 변경이 감지되면 `package_files_changed`로 중단한다. 커밋 스크립트가 변경사항 없음 등으로 실제 commit hash를 
기록하지 못하면 `commit_not_confirmed`로 중단하고 complete-task를 실행하지 않는다.
799:- `git reset`, `git clean`, `npm install`, `git push`는 실행하지 않는다.
806:- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean
 상태까지 확인된 경우로 한다.

 succeeded in 1707ms:
806:- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean
 상태까지 확인된 경우로 한다.

diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 8bf4b1a5309fa1ec6590a636a60ca9093d065cc2..b07d63241a0dc15fd90062dae39bbc63c9f134ea
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -803,6 +803,7 @@
 - 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
 - 한 번에 하나의 task만 수행한다.
 - task 단위로 구현, 검증, 리뷰, 커밋한다.
+- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean 상태
까지 확인된 경우로 한다.
 - 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
 - 검증하지 않은 결과를 통과로 기록하지 않는다.
 - 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

codex
확인 결과 보강 문구에는 요청된 완료 기준 6개가 모두 포함되어 있습니다. 검증 명령은 문구 검색만 수행했고, build/lint/git 명령은 사용자 허용 범위 밖이라 실
행하지 않았습니다.
codex
변경한 파일: [.ai-dev/README.md](D:/ai-apps/planpilot-local/.ai-dev/README.md:806)

구현 요약: AI Dev Loop 운영 원칙에 task 완료 기준 한 줄을 추가했습니다. 포함 항목은 `build/lint 통과`, `리뷰 pass`, `구현 커밋`, `c
omplete-task 수행`, `.ai-dev 메타 커밋`, `최종 git clean 상태`입니다. 앱 기능 로직과 UI 동작 파일은 수정하지 않았습니다.

검증 방법: `rg`로 추가 문구를 확인해 요구된 완료 기준이 모두 포함됐는지 점검했습니다. `npm run build`, `npm run lint`, `git status
`는 지시상 허용되지 않아 실행하지 않았습니다.

남은 위험: 실제 git clean 상태는 git 명령 금지 때문에 확인하지 못했습니다. 문서 변경만 있어 다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 완료: .ai-dev/README.md 운영 원칙에 AI Dev Loop task 완료 기준(build/lint 통과, 리뷰 pass, 구현 커밋, complet
e-task, .ai-dev 메타 커밋, 최종 git clean)을 한 줄로 보강함.`
diff --git a/.ai-dev/README.md b/.ai-dev/README.md
index 8bf4b1a5309fa1ec6590a636a60ca9093d065cc2..b07d63241a0dc15fd90062dae39bbc63c9f134ea
--- a/.ai-dev/README.md
+++ b/.ai-dev/README.md
@@ -803,6 +803,7 @@
 - 저장소의 `AGENTS.md`, 사용자 지시, 보안 정책이 자동 개발 루프보다 우선한다.
 - 한 번에 하나의 task만 수행한다.
 - task 단위로 구현, 검증, 리뷰, 커밋한다.
+- task 완료 기준은 build/lint 통과, 리뷰 pass, 구현 커밋, complete-task 수행, `.ai-dev` 메타 커밋, 최종 git clean 상태
까지 확인된 경우로 한다.
 - 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
 - 검증하지 않은 결과를 통과로 기록하지 않는다.
 - 실제 DB 삭제, 초기화, 복원, 대규모 리팩터링은 초기 실험 범위에서 제외한다.

tokens used
48,057
변경한 파일: [.ai-dev/README.md](D:/ai-apps/planpilot-local/.ai-dev/README.md:806)

구현 요약: AI Dev Loop 운영 원칙에 task 완료 기준 한 줄을 추가했습니다. 포함 항목은 `build/lint 통과`, `리뷰 pass`, `구현 커밋`, `c
omplete-task 수행`, `.ai-dev 메타 커밋`, `최종 git clean 상태`입니다. 앱 기능 로직과 UI 동작 파일은 수정하지 않았습니다.

검증 방법: `rg`로 추가 문구를 확인해 요구된 완료 기준이 모두 포함됐는지 점검했습니다. `npm run build`, `npm run lint`, `git status
`는 지시상 허용되지 않아 실행하지 않았습니다.

남은 위험: 실제 git clean 상태는 git 명령 금지 때문에 확인하지 못했습니다. 문서 변경만 있어 다음 task로 넘어가도 됩니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
`T001 완료: .ai-dev/README.md 운영 원칙에 AI Dev Loop task 완료 기준(build/lint 통과, 리뷰 pass, 구현 커밋, complet
e-task, .ai-dev 메타 커밋, 최종 git clean)을 한 줄로 보강함.`

```

codex
{
  "decision": "pass",
  "severity": "none",
  "summary": ".ai-dev/README.md 운영 원칙에 요청된 완료 기준이 짧게 추가되었고 앱 변경 파일은 없습니다.",
  "required_changes": [],
  "optional_suggestions": [],
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
  "next_step": "complete_task"
}
tokens used
50,276
{
  "decision": "pass",
  "severity": "none",
  "summary": ".ai-dev/README.md 운영 원칙에 요청된 완료 기준이 짧게 추가되었고 앱 변경 파일은 없습니다.",
  "required_changes": [],
  "optional_suggestions": [],
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
  "next_step": "complete_task"
}

```
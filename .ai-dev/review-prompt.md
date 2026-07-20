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

Copilot CLI 또는 gh 연동 재검토 항목을 현재 로컬 앱 구조에서 바로 실행 가능한 최소 개발 목표로 정리한다.

## 배경

PlanPilot Local은 privacy-first 로컬 웹앱이며, 외부 연동은 사용자의 명시적 의도와 로컬 동작 범위를 기준으로 신중하게 판단해야 한다. 이번 목표는 Copilot CLI 또는 gh 연동을 실제 구현하기 전에 현재 프로젝트에 필요한지, 어떤 사용자 흐름에서 의미가 있는지, MVP 범위에 맞는 최소 검토 결과를 남기는 것이다.

## 성공 기준

- 현재 앱 제약사항에 맞춰 Copilot CLI 또는 gh 연동의 필요성과 제외 조건을 정리한다.
- 구현 여부를 판단할 수 있는 최소 기준을 문서화한다.
- 당장 코드 변경 없이도 다음 작업자가 이어받을 수 있는 짧은 결론을 남긴다.

## 제약사항

- 로컬 우선 동작과 개인정보 보호 방향을 유지한다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 현재 MVP 범위를 넘는 기능 확장은 포함하지 않는다.
- 기존 앱 구조를 크게 바꾸지 않는다.

## 범위 제외

- 실제 연동 기능 구현
- 인증 흐름 추가
- 원격 저장소 조작 자동화
- 대규모 설정 화면 재구성

## 수동 검증

- 작성된 검토 결과가 현재 앱 제약사항과 충돌하지 않는지 확인한다.
- 다음 구현 후보가 하나의 작고 명확한 작업으로 분리되어 있는지 확인한다.

## 연동 필요성 검토

현재 MVP에서는 Copilot CLI 또는 gh 연동을 바로 구현하지 않는다. PlanPilot Local의 핵심 가치는 사용자의 일정, 업무, 프로젝트 정보를 외부 서버로 보내지 않고 로컬에서 관리하는 것이며, Copilot CLI나 gh 연동은 인증, 외부 프로세스 실행, 원격 저장소 상태 확인 같은 별도 위험과 복잡도를 만든다.

연동이 의미 있으려면 사용자가 명시적으로 "현재 계획을 개발 작업으로 넘기기"를 원하고, 전송되는 내용과 실행되는 명령을 작업 직전에 확인할 수 있어야 한다. 단순한 일정 관리, 프로젝트 메모, 로컬 업무 정리 흐름에는 외부 개발 도구 연동이 필수 기능이 아니다.

## 구현 판단 기준

- 사용자가 특정 업무를 GitHub issue, PR, 로컬 CLI 작업으로 연결하려는 반복 흐름이 확인된다.
- 전송 대상 데이터가 제목, 설명, 체크리스트 등 사용자가 선택한 최소 항목으로 제한된다.
- 인증 토큰, 계정 정보, 원격 저장소 정보는 앱이 저장하지 않거나, 저장이 필요하면 별도 보안 검토를 먼저 한다.
- 연동 실행 전 사용자에게 실행 대상, 명령 또는 전송 내용을 한국어로 명확히 보여준다.
- 실패해도 기존 로컬 데이터와 IndexedDB 저장 상태에 영향을 주지 않는다.

## 제외 조건

- 자동 git 조작, 자동 push, 자동 PR 생성처럼 원격 저장소를 사용자의 즉시 확인 없이 변경하는 기능은 제외한다.
- 로그인, 계정 연결, 토큰 저장, 클라우드 동기화가 필요한 흐름은 현재 MVP에서 제외한다.
- 알림, 백그라운드 실행, Android 권한 요청, Capacitor 추가가 필요한 흐름은 제외한다.
- 앱 내부 데이터를 외부 서비스에 일괄 전송하는 기능은 제외한다.

## 결론

Copilot CLI 또는 gh 연동은 현재 로컬 우선 MVP의 필수 기능이 아니다. 다음 단계로 구현을 검토한다면 "선택한 업무 1개를 사용자가 복사해 외부 CLI에 붙여넣을 수 있는 한국어 작업 요약 생성" 정도가 가장 작은 후보 작업이다. 이 후보는 인증, 원격 조작, 패키지 추가 없이 로컬 앱 내부의 표시 기능으로 분리할 수 있다.

## 다음 후보 작업

- 선택한 업무 1개를 개발 작업 요약 텍스트로 변환하는 UI 문구와 데이터 범위를 먼저 정의한다.


## Current Task

- Task ID: T001
- Title: 연동 필요성 검토 문서 작성
- Description: Copilot CLI 또는 gh 연동이 현재 PlanPilot Local의 로컬 우선 방향과 MVP 범위에 맞는지 검토하고, 구현 전 판단 기준을 짧은 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- 없음
- Verification:
- 문서에 목표, 배경, 성공 기준, 제약사항, 범위 제외, 수동 검증 섹션이 포함되어 있는지 확인한다.
- 연동 구현을 바로 시작하지 않고 검토 결론과 다음 후보 작업만 남겼는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-21 00:18:19

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

[32m✓ built in 669ms[39m
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

2026-07-21 00:18:28

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/copilot-cli-gh-integration-review.md
?? .ai-dev/copilot-gh-documentation-revise-prompt.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/copilot-cli-gh-integration-review.md
- .ai-dev/copilot-gh-documentation-revise-prompt.md

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

## Untracked File Content

내용을 포함할 추적되지 않은 텍스트 파일이 없습니다.

## Skipped Generated AI Dev Artifacts

- .ai-dev/copilot-cli-gh-integration-review.md
- .ai-dev/copilot-gh-documentation-revise-prompt.md

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
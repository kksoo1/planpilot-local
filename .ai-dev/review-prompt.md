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
장기 실행 자동화 작업의 진행 상태를 사용자가 확인할 수 있도록 최소한의 모니터링 정책을 정리하고 적용한다.

## 배경
현재 로컬 앱은 작업과 프로젝트를 중심으로 동작하지만, 오래 걸리는 자동화 흐름을 다룰 때 사용자가 상태와 중단 기준을 명확히 파악하기 어렵다. 우선 작은 범위에서 상태 표현과 검증 기준을 정해 이후 구현의 기준으로 삼는다.

## 성공 기준
- 장기 실행 자동화 모니터링 정책의 최소 동작 범위가 명확히 정의된다.
- 진행 중, 완료, 실패, 중단 상태의 사용자 표시 기준이 정리된다.
- 사용자가 수동으로 확인할 수 있는 검증 절차가 포함된다.

## 제약사항
- 기존 앱 구조와 상태 관리 방식을 우선 따른다.
- 한 번에 하나의 작은 변경만 진행한다.
- 사용자 화면에 표시되는 문구는 한국어를 사용한다.
- 로컬 우선 동작 원칙을 유지한다.

## 범위 제외
- 복잡한 실행 스케줄러 구현은 제외한다.
- 외부 연동 기반의 모니터링은 제외한다.
- 대규모 화면 재구성은 제외한다.

## 수동 검증
- 장기 실행 자동화 상태가 진행 중인지 구분되는지 확인한다.
- 완료, 실패, 중단 상태를 사용자가 이해할 수 있는 문구로 확인한다.
- 기존 작업과 프로젝트 흐름에 영향이 없는지 주요 화면을 살펴본다.

## 모니터링 정책 초안

### 변경 위치 이유
- 이 작업은 기능 구현이 아니라 장기 실행 자동화 상태 표현 기준을 정리하는 문서화 작업이다.
- 따라서 앱 소스가 아닌 `.ai-dev/goal.md`에 최소 정책을 기록하고, 실제 화면 구현은 이후 작업에서 별도로 다룬다.

### 최소 동작 범위
- 장기 실행 자동화는 사용자가 결과를 기다리는 동안 현재 상태를 확인할 수 있어야 한다.
- 상태 표시는 진행 중, 완료, 실패, 중단의 네 가지를 기본으로 한다.
- 각 상태는 로컬 앱 내부 데이터 기준으로만 판단하며, 외부 서버나 클라우드 상태 확인에 의존하지 않는다.
- MVP 범위에서는 실행 스케줄러, 백그라운드 알림, 외부 연동 모니터링을 포함하지 않는다.

### 상태 표시 기준
- 진행 중: 자동화 작업이 시작되었고 아직 최종 결과가 확정되지 않은 상태다. 사용자 표시 문구는 `진행 중`을 사용한다.
- 완료: 자동화 작업이 요구된 절차를 끝내고 사용자가 확인할 결과가 준비된 상태다. 사용자 표시 문구는 `완료`를 사용한다.
- 실패: 자동화 작업이 오류로 더 이상 계속 진행할 수 없는 상태다. 사용자 표시 문구는 `실패`를 사용하고, 가능한 경우 실패 원인을 함께 보여준다.
- 중단: 사용자가 직접 멈췄거나 사전에 정한 중단 기준에 도달해 작업을 멈춘 상태다. 사용자 표시 문구는 `중단`을 사용한다.

### 중단 기준
- 같은 오류가 반복되어 자동 재시도가 의미 없다고 판단되는 경우 중단한다.
- 현재 작업 범위를 벗어난 변경, 패키지 추가, 데이터 삭제 또는 마이그레이션이 필요한 경우 중단한다.
- 사용자가 명시적으로 중지, 보류, 범위 변경을 요청한 경우 중단한다.
- 중단 상태에서는 완료나 실패로 오해되지 않도록 사용자가 다음 조치를 결정해야 함을 분명히 표시한다.

### 사용자 확인 절차
- 사용자는 자동화 작업 목록 또는 상세 화면에서 현재 상태 라벨을 확인한다.
- 진행 중 상태에서는 아직 결과가 확정되지 않았음을 확인한다.
- 완료 상태에서는 결과 요약과 수동 검증 항목을 확인한다.
- 실패 상태에서는 실패 원인 요약과 다시 시도하기 전에 필요한 조치를 확인한다.
- 중단 상태에서는 중단 사유와 사용자가 이어서 진행할지 여부를 확인한다.


## Current Task

- Task ID: T001
- Title: 모니터링 정책 초안 작성
- Description: 장기 실행 자동화의 상태 표시, 중단 기준, 사용자 확인 절차를 현재 앱 범위에 맞게 작은 정책으로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- 없음
- Verification:
- 정책 문서에 상태 기준과 수동 검증 항목이 포함되어 있는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-21 15:27:43

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

[32m✓ built in 504ms[39m
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

2026-07-21 15:27:52

## Git Status

```text
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

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

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
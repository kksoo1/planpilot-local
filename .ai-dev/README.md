# PlanPilot Local AI 개발 입력 폴더

이 폴더는 PlanPilot Local의 Level 5 AI 자동 개발 루프에서 목표와 후속 작업 후보를 관리하기 위한 기본 공간이다.

현재 단계에서는 사용자 입력 템플릿과 수동 AI Dev 루프 보조 스크립트를 제공한다. Codex 또는 GPT를 직접 호출하는 자동 개발 루프 실행기는 아직 구현하지 않는다.

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

AI Dev PowerShell 스크립트의 UTF-8 콘솔 설정은 `scripts/ai-dev-env.ps1`에서 자동 처리한다. 사용자가 매번 `chcp 65001`을 직접 실행할 필요는 없다.

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

`goal.md`, `queue.json`, `state.json`을 읽어 현재 task만 수행하도록 지시하는 `.ai-dev/current-task-prompt.md` 파일을 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1
```

프롬프트 생성 스크립트는 기존 `current-task-prompt.md`를 현재 task 기준으로 덮어쓴다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행하지 않는다.

## task 완료 처리

현재 task를 완료 처리하고 다음 pending task로 이동하려면 다음 명령을 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -ResultSummary "T001 분석 완료"
```

특정 task를 완료 처리하려면 `-TaskId`를 지정한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -TaskId T001 -ResultSummary "분석 완료"
```

다음 task로 자동 이동하지 않으려면 `-NoNext` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-complete-task.ps1 -NoNext
```

task 완료 처리 스크립트는 `queue.json`, `state.json`, `loop-log.md`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행하지 않는다.

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

## git diff 저장

현재 git 변경사항을 `diff.md`에 저장해 GPT 리뷰 또는 사람 검토에 사용할 수 있게 한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
```

추적되지 않은 작은 텍스트 파일의 내용도 포함하려면 `-IncludeUntrackedContent` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1 -IncludeUntrackedContent
```

git diff 저장 스크립트는 `diff.md`와 `state.json`만 갱신한다. Codex 실행, GPT 리뷰, build/test 실행, git commit은 수행하지 않는다.

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

## GPT 리뷰 결과 저장

GPT Chat 또는 외부 리뷰어가 반환한 리뷰 JSON을 `review.md`에 저장하고, decision과 severity를 `state.json`에 반영한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewFile .ai-dev/review-response.json
```

JSON 문자열이나 클립보드 내용을 직접 사용할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -ReviewJson '{"decision":"pass","severity":"none","summary":"OK","required_changes":[],"optional_suggestions":[],"next_step":"complete_task"}'
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-review.ps1 -FromClipboard
```

리뷰 결과 저장 스크립트는 `pass + complete_task`, `revise + revise_with_codex`, `blocked` 또는 `stop_for_user` 결과에 맞는 다음 행동을 안내만 한다. GPT API 호출, Codex 실행, build/test 실행, git commit은 수행하지 않는다.

## 리뷰 반영 재수정 프롬프트 생성

`review.md`의 required changes를 반영하도록 Codex 또는 Cline에 전달할 `revise-prompt.md`를 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1
```

optional suggestions도 현재 task 범위 안에서 반영할 수 있게 하려면 `-AllowOptionalSuggestions` 옵션을 사용한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 -AllowOptionalSuggestions
```

재수정 프롬프트 생성 스크립트는 Codex 실행, GPT API 호출, build/test 실행, git commit을 수행하지 않는다.

## task 단위 자동 커밋

검증과 리뷰를 통과한 현재 변경사항을 task 단위로 커밋한다. 먼저 `-DryRun`으로 커밋 대상과 메시지를 확인하는 것을 권장한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1
```

커밋 메시지를 직접 지정하거나 검증·리뷰 게이트를 명시적으로 우회할 수도 있다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -Message "chore(ai-dev): add automation helpers"
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-commit.ps1 -AllowWithoutPassedCheck -AllowWithoutPassedReview
```

자동 커밋 스크립트는 `git add -A`로 현재 작업 트리의 모든 변경사항을 stage한다. 실행 전 예상하지 못한 사용자 변경이 없는지 반드시 확인한다. Codex 실행, GPT API 호출, build/test 실행은 수행하지 않는다.

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

수동 사이클 안내 스크립트는 추천 명령과 파일 경로만 보여주며, Codex 실행, GPT API 호출, build/test 실행, git add, git commit을 수행하지 않는다.

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

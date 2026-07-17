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
package 변경 감지 메시지를 사용자가 더 쉽게 이해하고 다음 행동을 판단할 수 있도록 개선한다.

## 배경
현재 package 변경 감지 메시지는 변경 사실을 전달하지만, 어떤 의미인지와 사용자가 무엇을 확인하면 되는지 충분히 명확하지 않을 수 있다. 기존 동작을 유지하면서 안내 문구만 작게 개선한다.

## 성공 기준
- package 변경 감지 메시지가 한국어로 자연스럽고 구체적으로 표시된다.
- 사용자가 변경 감지 상황에서 확인해야 할 내용을 이해할 수 있다.
- 기존 감지 조건과 저장 구조는 변경하지 않는다.
- 수정 범위는 관련 메시지 표시 코드에 한정한다.

## 제약사항
- 한 번에 하나의 작은 구현 작업만 진행한다.
- 기존 타입, 상태, 저장 구조를 우선 사용한다.
- 사용자-facing UI 문자열은 한국어를 사용한다.
- src/App.css는 수정하지 않는다.
- lock file은 수정하지 않는다.

## 범위 제외
- package 변경 감지 로직 자체 변경
- 새 화면 추가
- 대규모 컴포넌트 분리
- 저장 스키마 변경
- 알림 기능 추가

## 수동 검증
- package 변경 감지 메시지가 표시되는 경로를 확인한다.
- 변경 후 문구가 기존 화면 안에서 깨지지 않는지 확인한다.
- 관련 없는 UI 문구와 동작이 바뀌지 않았는지 확인한다.

## Current Task

- Task ID: T001
- Title: package 변경 감지 메시지 문구 개선
- Description: 현재 package 변경 감지 메시지가 정의된 위치를 확인하고, 감지 조건은 유지한 채 사용자-facing 한국어 안내 문구만 더 명확하게 조정한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음
- Verification:
- 관련 메시지 표시 위치를 확인한다.
- 문구 변경 후 JSX 구조 중복이 없는지 확인한다.
- 필요 시 사용자가 허용하면 빌드 검증을 실행한다.

## Test Result

# AI Dev Test Result

## 2026-07-17 20:19:45

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

[32m✓ built in 212ms[39m
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

2026-07-17 20:19:53

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-auto-cycle-full.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-auto-cycle-full.ps1

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
 scripts/ai-dev-auto-cycle-full.ps1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-auto-cycle-full.ps1 b/scripts/ai-dev-auto-cycle-full.ps1
index 5d3fa84..350b1b2 100644
--- a/scripts/ai-dev-auto-cycle-full.ps1
+++ b/scripts/ai-dev-auto-cycle-full.ps1
@@ -1284,7 +1284,7 @@ while ($script:completedTaskCount -lt $MaxTasks) {
 
     try {
         if (Test-PackageFileChanged) {
-            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커밋하지 않습니다."
+            $script:steps += New-StepResult $stepNumber "package-change-gate" "git status --porcelain -- package.json package-lock.json" $false $true 1 "package.json 또는 package-lock.json 변경이 감지되어 자동 커밋을 중단합니다. 의도한 패키지 변경인지, lock file 변경이 필요한지 확인한 뒤 별도 작업으로 처리하세요."
             Stop-Cycle $script:steps "package_files_changed" $false 1
         }
     } catch {
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
# AI Dev Revise Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.
이전 리뷰에서 지적된 사항만 수정한다.

## Goal

# 목표
Codex 구현 실행 스크립트 추가

## 배경
현재 저장소의 P0 백로그 항목인 "Codex 구현 실행 스크립트 추가"를 현재 구조에 맞는 가장 작은 실행 가능한 개발 목표로 준비한다. 목표는 로컬 AI Dev Loop에서 Codex 구현 단계를 일관되게 실행할 수 있는 스크립트 초안을 추가하는 것이다.

## 성공 기준
- 저장소의 기존 스크립트/설정 구조를 확인한다.
- Codex 구현 실행에 필요한 최소 스크립트를 추가하거나 기존 설정에 연결한다.
- 실행 방법이 명확하게 드러나도록 필요한 최소 문서를 함께 정리한다.
- 변경 범위는 스크립트 추가와 직접 관련된 파일로 제한한다.

## 제약사항
- 한 번에 하나의 기능만 구현한다.
- 기존 프로젝트 구조와 명명 규칙을 따른다.
- 사용자-facing 문구는 한국어를 기본으로 한다.
- 불필요한 대규모 재작성이나 추상화를 하지 않는다.
- lock file은 수정하지 않는다.

## 범위 제외
- 앱 UI 변경은 포함하지 않는다.
- 데이터베이스 스키마 변경은 포함하지 않는다.
- 알림, 동기화, 인증 기능은 포함하지 않는다.
- 배포 자동화나 외부 연동 확장은 포함하지 않는다.

## 수동 검증
- 추가된 스크립트 파일 또는 package script가 의도한 명령을 가리키는지 확인한다.
- 스크립트 실행 전 필요한 입력 파일 경로가 저장소 기준으로 올바른지 확인한다.
- 변경된 파일만 검토하여 범위가 과도하게 넓어지지 않았는지 확인한다.

## Current Task

- Task ID: T001
- Title: Codex 구현 실행 스크립트 추가
- Description: 현재 저장소의 스크립트 구조를 확인하고, Codex 구현 단계를 실행하기 위한 최소 스크립트 또는 설정 연결을 추가한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Verification:
- 변경 파일을 확인해 스크립트 경로와 명령이 저장소 구조와 일치하는지 검토한다.
- 허용된 경우에만 관련 스크립트를 수동으로 실행해 동작을 확인한다.

## Review Result

- Decision: revise
- Severity: medium
- Next step: revise_with_codex
- Summary: 현재 diff는 Codex 실행 스크립트 자체 추가/연결보다 프롬프트 안전 문구 보강에만 가깝고, test script가 없어 테스트가 skippe
d 상태입니다.

## Required Changes

- File: scripts/ai-dev-run-codex.ps1
  - Reason: 현재 task의 핵심은 Codex 구현 실행을 위한 최소 스크립트 또는 설정 연결 추가인데, 제공된 diff는 기존 New-CodexPromp
t 반환 문구만 확장합니다. 이 변경만으로는 task 성공 기준을 충족했는지 불확실합니다.
  - Suggestion: 현재 저장소 기준에서 이 파일이 실제 실행 진입점임을 명확히 하거나, 필요한 경우 실행 방법 문서/스크립트 연결을 최소 범위로 보강하세
요.
- File: unknown
  - Reason: npm run test가 package.json에 test script가 없어 skipped 되었습니다. Strict Criteria상 테스트
가 없거나 skipped이면 revise 후보입니다.
  - Suggestion: 이번 task가 스크립트 변경만이라면 수동 검증 결과를 명확히 남기고, 테스트 부재가 허용 가능한 범위인지 리뷰 산출물에 기록하세요.

## Optional Suggestions

- optional_suggestions는 참고만 하며 구현하지 않는다.
- File: scripts/ai-dev-run-codex.ps1
  - Suggestion: 추가 안전 규칙 중 package.json 수정 금지는 향후 task가 package script 연결을 요구할 때 충돌할 수 있으므로
, 이 제한이 현재 AI Dev Loop 정책상 의도된 것인지 주석이나 프롬프트 생성 위치에서 명확히 하는 편이 좋습니다.

## Diff Context

# AI Dev Diff

## Generated At

2026-07-09 22:58:36

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-run-codex.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-run-codex.ps1

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
 scripts/ai-dev-run-codex.ps1 | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-run-codex.ps1 b/scripts/ai-dev-run-codex.ps1
index d91e711..60f9658 100644
--- a/scripts/ai-dev-run-codex.ps1
+++ b/scripts/ai-dev-run-codex.ps1
@@ -118,7 +118,16 @@ function New-CodexPrompt {
         [string]$PromptFilePath
     )
 
-    return "Read and follow the full task prompt at this absolute file path: $PromptFilePath"
+    return @"
+Read and follow the full task prompt at this absolute file path: $PromptFilePath
+
+Additional safety rules for this local AI Dev Loop run:
+- Do not run git commit, git reset, git checkout, git clean, git rebase, git merge, or git push.
+- Do not run npm install.
+- Do not modify package.json, package-lock.json, node_modules, dist, or .git.
+- Do not broaden the current task scope beyond the prompt file.
+- If the task requirements conflict with repository rules, stop and report the conflict.
+"@
 }
 
 Set-Location $repoRoot
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Test Result

# AI Dev Test Result

## 2026-07-09 22:58:29

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

[32m✓ built in 251ms[39m
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

## Allowed Scope

- required_changes에 필요한 최소 수정만 허용한다.
- 현재 task 범위를 벗어나지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 새 기능 추가보다 리뷰 지적사항 해결을 우선한다.

## Hard Rules

- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.
- optional_suggestions는 기본적으로 구현하지 않는다.

## Required Output

- 반영한 required_changes 목록
- 수정한 파일 목록
- 검증 방법
- 반영하지 못한 항목과 이유
- 남은 위험
- `.ai-dev/loop-log.md`에 기록할 재수정 요약
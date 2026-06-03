# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# Goal

JSON 백업 파일 import 시 실제 복원은 하지 않고, 파일 검증과 미리보기까지만 제공하는 기능을 추가한다.

## Background

PlanPilot Local은 `tasks`, `projects`, `appSettings`를 포함한 JSON 백업 파일을 내보낼 수 있다.

현재 JSON import/복원 정책과 순수 검증 유틸은 준비되어 있지만, 사용자가 파일을 선택하고 검증 결과를 확인할 수 있는 흐름은 아직 없다.

데이터 손상 위험을 줄이기 위해 실제 IndexedDB 반영보다 파일 검증과 영향 범위 미리보기를 먼저 제공한다.

## Success Criteria

- 사용자가 PlanPilot Local JSON 백업 파일을 선택할 수 있다.
- `format`이 `planpilot-local-backup`인지 확인한다.
- `schemaVersion`이 `1`인지 확인한다.
- `exportedAt`, `tasks`, `projects`, `appSettings` 필수 항목을 확인한다.
- 검증 실패 시 사용자에게 실패 이유를 표시한다.
- 검증 성공 시 `tasks` 개수, `projects` 개수, `appSettings` 포함 여부를 표시한다.
- 파일 검증과 미리보기 과정에서 IndexedDB 데이터는 변경되지 않는다.
- `docs/manual-test-checklist.md`에 검증과 미리보기 수동 테스트 항목을 반영한다.
- `npm run build`가 성공한다.

## Constraints

- 실제 DB 반영을 하지 않는다.
- 복원, 덮어쓰기, 병합을 구현하지 않는다.
- `format`은 `planpilot-local-backup`만 허용한다.
- `schemaVersion`은 `1`만 허용한다.
- `exportedAt`, `tasks`, `projects`, `appSettings`를 필수로 확인한다.
- 검증 실패 이유를 사용자에게 표시한다.
- 검증 성공 시 데이터 개수와 설정 포함 여부를 표시한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화를 추가하지 않는다.
- DB schema를 변경하지 않는다.
- `App.css`를 수정하지 않는다.
- 현재 task 범위 밖 파일을 수정하지 않는다.

## Out of Scope

- JSON 백업 데이터를 IndexedDB에 저장하는 기능
- 전체 덮어쓰기 복원
- 기존 데이터와의 병합
- 중복 ID 자동 수정
- 프로젝트 참조 자동 복구
- appSettings 자동 덮어쓰기
- 복원 전 자동 백업
- JSON export 구조 변경

## Manual Verification

- 정상 백업 파일을 선택하면 검증 성공 상태가 표시된다.
- 정상 백업 파일의 `tasks`와 `projects` 개수가 표시된다.
- 정상 백업 파일에 `appSettings`가 포함되어 있는지 표시된다.
- 잘못된 JSON 파일을 선택하면 검증 실패 이유가 표시된다.
- `format`이 다른 파일은 거부된다.
- `schemaVersion`이 `1`이 아닌 파일은 거부된다.
- 필수 항목이 누락된 파일은 거부된다.
- 파일을 선택하거나 검증한 뒤에도 기존 업무, 프로젝트, 설정 데이터가 유지된다.
- `npm run build`가 성공한다.


## Current Task

- Task ID: T001
- Title: 기존 백업 export/import 관련 문서와 코드 위치 확인
- Description: JSON 백업 구조, import 정책, 기존 검증 유틸, SettingsView 연결 지점을 확인하고 구현 범위를 확정한다.
- Type: analysis
- Status: pending
- Priority: P0
- Depends on:
- 없음
- Verification:
- 관련 문서와 코드 위치 확인
- 실제 DB 반영이 범위에서 제외되었는지 확인

## Test Result

# AI Dev Test Result

아직 테스트가 실행되지 않았습니다.


## Diff To Review

# AI Dev Diff

## Generated At

2026-06-03 22:53:50

## Git Status

```text
 M ROADMAP.md
 M docs/data-import-restore-policy.md
 M docs/manual-test-checklist.md
 M memory-bank/progress.md
?? .ai-dev/
?? docs/ai-dev-loop-policy.md
?? scripts/ai-dev-check.ps1
?? scripts/ai-dev-commit.ps1
?? scripts/ai-dev-complete-task.ps1
?? scripts/ai-dev-current-task.ps1
?? scripts/ai-dev-env.ps1
?? scripts/ai-dev-init.ps1
?? scripts/ai-dev-make-prompt.ps1
?? scripts/ai-dev-make-review-prompt.ps1
?? scripts/ai-dev-make-revise-prompt.ps1
?? scripts/ai-dev-manual-cycle.ps1
?? scripts/ai-dev-next.ps1
?? scripts/ai-dev-save-diff.ps1
?? scripts/ai-dev-save-review.ps1
?? scripts/ai-dev-status.ps1
?? src/utils/importValidation.ts
```

## Unstaged Diff Stat

```text
git.exe : warning: in the working copy of 'ROADMAP.md', LF will be replaced by CRLF the next time Git touches it
At D:\ai-apps\planpilot-local\scripts\ai-dev-save-diff.ps1:73 char:15
+     $output = & git @Arguments 2>&1 | Out-String
+               ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (warning: in the... Git touches it:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
warning: in the working copy of 'docs/data-import-restore-policy.md', LF will be replaced by CRLF the next time Git tou
ches it
warning: in the working copy of 'docs/manual-test-checklist.md', LF will be replaced by CRLF the next time Git touches 
it
warning: in the working copy of 'memory-bank/progress.md', LF will be replaced by CRLF the next time Git touches it
 ROADMAP.md                         | 13 ++++++++++---
 docs/data-import-restore-policy.md |  9 ++++++++-
 docs/manual-test-checklist.md      |  1 +
 memory-bank/progress.md            | 11 ++++++-----
 4 files changed, 25 insertions(+), 9 deletions(-)
```

## Unstaged Diff

```text
git.exe : warning: in the working copy of 'ROADMAP.md', LF will be replaced by CRLF the next time Git touches it
At D:\ai-apps\planpilot-local\scripts\ai-dev-save-diff.ps1:73 char:15
+     $output = & git @Arguments 2>&1 | Out-String
+               ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (warning: in the... Git touches it:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
warning: in the working copy of 'docs/data-import-restore-policy.md', LF will be replaced by CRLF the next time Git tou
ches it
warning: in the working copy of 'docs/manual-test-checklist.md', LF will be replaced by CRLF the next time Git touches 
it
warning: in the working copy of 'memory-bank/progress.md', LF will be replaced by CRLF the next time Git touches it
diff --git a/ROADMAP.md b/ROADMAP.md
index 0257f96..eb0d930 100644
--- a/ROADMAP.md
+++ b/ROADMAP.md
@@ -2342,10 +2342,17 @@ JSON import/복원은 아직 구현하지 않는다. 데이터 손상 위험이
 1차 구현 후보:
 
 - 바로 DB에 반영하지 않는다.
-- 먼저 파일 검증 유틸만 구현한다.
+- 먼저 파일 검증 유틸만 구현한다. [완료]
 - 그 다음 검증 결과와 영향 범위 미리보기 UI를 구현한다.
 - 실제 전체 덮어쓰기 복원은 별도 작업으로 분리한다.
 
+현재 구현 상태:
+
+- `src/utils/importValidation.ts`에 `validateBackupData(input: unknown)` 순수 검증 함수를 추가했다.
+- 검증 함수는 `valid`, `errors`, `warnings`, `summary`를 반환한다.
+- 검증 함수는 UI에서 아직 호출하지 않는다.
+- 검증 함수는 IndexedDB 쓰기, 복원, 덮어쓰기, 병합을 수행하지 않는다.
+
 필수 검증 기준:
 
 - JSON 파싱 가능 여부
@@ -2378,7 +2385,7 @@ JSON import/복원은 아직 구현하지 않는다. 데이터 손상 위험이
 
 다음 단계:
 
-1. import 파일 검증 유틸 구현 여부 검토
-2. 검증 결과 미리보기 UI 정책 구체화
+1. 검증 결과 미리보기 UI 정책 구체화
+2. 검증 유틸 수동/자동 테스트 도입 여부 검토
 3. 전체 덮어쓰기 복원 정책 확정
 4. 병합 복원은 이후 별도 검토
diff --git a/docs/data-import-restore-policy.md b/docs/data-import-restore-policy.md
index 26a3a58..2be968b 100644
--- a/docs/data-import-restore-policy.md
+++ b/docs/data-import-restore-policy.md
@@ -100,6 +100,13 @@
 4. 실제 복원을 구현할 때는 병합보다 전체 덮어쓰기를 먼저 검토한다.
 5. 병합 복원은 1차 복원이 안정화된 뒤 별도 정책으로 다룬다.
 
+현재 구현 상태:
+
+- `src/utils/importValidation.ts`에 `validateBackupData(input: unknown)` 순수 검증 유틸을 추가했다.
+- 이 유틸은 백업 JSON 구조, task/project/appSettings 필수 필드, status/priority 허용 값, project 참조 무결성을 검사한다.
+- 이 유틸은 UI에서 아직 호출하지 않는다.
+- 이 유틸은 IndexedDB에 쓰지 않으며, 복원/덮어쓰기/병합을 수행하지 않는다.
+
 ## 데이터 검증 기준
 
 파일 수준 검증:
@@ -226,7 +233,7 @@ appSettings 검증:
 ## 다음 단계 제안
 
 1. import/복원 정책 문서화
-2. import 파일 검증 유틸만 구현
+2. import 파일 검증 유틸만 구현 [완료]
 3. 검증 결과 미리보기 UI 구현
 4. 전체 덮어쓰기 복원 구현
 5. 병합 복원은 이후 별도 검토
diff --git a/docs/manual-test-checklist.md b/docs/manual-test-checklist.md
index 86e934b..26f7b23 100644
--- a/docs/manual-test-checklist.md
+++ b/docs/manual-test-checklist.md
@@ -460,6 +460,7 @@ AI Provider 확장은 현재 구현 범위가 아니며, `aiProvider` 타입이
 
 JSON import/복원은 아직 구현하지 않는다. 다음 항목은 향후 검증 유틸 또는 미리보기 UI를 구현한 뒤 확인한다.
 
+- [ ] `validateBackupData` 유틸은 입력값 검증만 수행하고 IndexedDB를 수정하지 않는다.
 - [ ] 정상 백업 파일은 `format`, `schemaVersion`, `exportedAt`, `tasks`, `projects`, `appSettings` 기준을 통과한다.
 - [ ] 잘못된 JSON 파일은 검증 실패로 처리되고 기존 데이터가 유지된다.
 - [ ] `format`이 `planpilot-local-backup`이 아니면 거부된다.
diff --git a/memory-bank/progress.md b/memory-bank/progress.md
index 6bbd674..1584027 100644
--- a/memory-bank/progress.md
+++ b/memory-bank/progress.md
@@ -78,10 +78,11 @@
 - JSON export 실패 상황은 수동 재현하지 못해 보류/확인 필요로 유지
 - JSON export 실패 경로 후보와 재현/기록 기준을 문서화하고, 일반 브라우저 수동 테스트에서는 실패 경로를 보류로 유지하기로 정리
 - JSON import/복원 정책을 문서화하고, 1차 구현은 실제 DB 반영 없이 파일 검증 또는 미리보기부터 시작하는 방향으로 정리
+- `src/utils/importValidation.ts`에 JSON 백업 파일 구조를 확인하는 순수 검증 유틸을 추가하고, UI/DB 반영 없이 build 통과 기준으로 확인
 
 ### Next
-1. JSON import 파일 검증 유틸 구현 여부 검토
-2. 검증 결과 미리보기 UI 정책 구체화
-3. exportData/import validation 유틸 단위 테스트 또는 테스트 도구 도입 정책 문서화
-4. 업무 필터/정렬 UX 개선 후보 정리
-5. DB migration 규칙 문서화
+1. 검증 결과 미리보기 UI 정책 구체화
+2. import validation 유틸 단위 테스트 또는 테스트 도구 도입 정책 문서화
+3. 업무 필터/정렬 UX 개선 후보 정리
+4. DB migration 규칙 문서화
+5. export 성공 메시지 문구가 서버 전송/클라우드 백업으로 오해되지 않는지 UX 확인
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
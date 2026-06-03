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
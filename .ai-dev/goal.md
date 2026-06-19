# 목표
AI Dev Loop의 review revise 자동 재시도 흐름에서 재시도 중단 사유가 일반화되지 않도록 보강한다.

## 배경
현재 재수정 후 재리뷰 결과가 계속 decision=revise인 경우, next_step 값에 따라 최신 리뷰 사유가 충분히 보존되지 않을 수 있다. 특히 revise_with_codex 반복 제한 상황에서도 사용자가 최신 review summary, severity, next_step, lastReviewDecision을 확인할 수 있어야 한다.

## 성공 기준
- 재수정 후 재리뷰 결과가 계속 decision=revise이면 next_step 값과 관계없이 최신 review summary, severity, next_step, lastReviewDecision을 포함한 명확한 중단 메시지와 상태를 남긴다.
- next_step=revise_with_codex가 반복된 경우 기존 1회 재시도 제한 메시지를 유지하면서 최신 리뷰 사유를 함께 포함한다.
- DryRun은 Codex, check, review, commit, complete-task를 실행하지 않고 상태 변경 없이 preview만 출력한다.
- 기존 pass 처리, completed final clean, AllowCommit 처리, non-.ai-dev dirty 실패 동작은 유지한다.
- 앱 src 파일은 변경하지 않는다.
- build/lint 검증, DryRun no-mutation 검증 기록, 리뷰 pass, 구현 커밋, complete-task, .ai-dev 메타 커밋, 최종 clean 상태 확인까지 완료한다.

## 제약사항
- 변경 범위는 AI Dev Loop 스크립트와 관련 메타 파일로 제한한다.
- 기존 동작을 보존하면서 revise 중단 상태 기록만 좁게 보강한다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- 앱 src 파일 변경은 제외한다.
- AI Dev Loop 전체 구조 재작성은 제외한다.
- 신규 기능 추가나 UI 변경은 제외한다.

## 수동 검증
- DryRun 실행 시 실행 예정 작업만 preview되고 실제 상태 변경이 없는지 확인한다.
- 재리뷰 revise 반복 시 최신 리뷰 사유가 상태와 메시지에 남는지 확인한다.
- 기존 pass 및 commit 허용 흐름이 유지되는지 확인한다.
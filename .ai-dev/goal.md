# 목표
AI Dev Loop의 review-gate에서 `decision=revise`, `next_step=revise_with_codex`가 반환될 때 실패로 즉시 중단하지 않고, 자동 revise 재시도 흐름으로 연결되도록 자동화 스크립트를 보강한다.

## 배경
현재 auto-cycle-full 실행 중 리뷰 결과가 revise_with_codex인 경우 review-gate failed로 멈추며, 수정 프롬프트 생성부터 재검증, 재리뷰까지의 자동 흐름이 이어지지 않는다. 이번 작업은 앱 기능 개발이 아니라 자동 개발 루프의 검증 자동화 안정성 개선이 목적이다.

## 성공 기준
- review-gate가 revise_with_codex를 만나면 실패 종료하지 않고 revise 프롬프트 생성, Codex revise 실행, 검증, diff 저장, review prompt 생성, review Codex 재실행, review 저장까지 자동 수행한다.
- 재리뷰가 pass이면 구현 커밋, task 완료 처리, 메타 정보 커밋, 다음 task 진행 흐름이 이어진다.
- 재리뷰가 계속 revise이면 최신 summary, severity, next_step, required_changes를 state와 로그에 남기고 명확히 실패 종료한다.
- pass 전 완료 차단, stale/missing implementation 차단, completed final 정리 상태 확인, DryRun no-mutation 동작은 유지된다.
- DryRun에서는 변경 작업을 실행하지 않고 preview만 출력한다.
- 앱 src 파일은 변경하지 않는다.

## 제약사항
- 작업 중심 파일은 ai-dev 자동화 스크립트로 제한한다.
- 기존 자동화 흐름과 상태 파일 형식을 최대한 유지한다.
- 앱 소스 파일은 수정하지 않는다.
- DryRun 동작은 실제 변경 없이 확인 가능한 출력만 제공해야 한다.

## 범위 제외
- 앱 UI 또는 기능 변경은 제외한다.
- 데이터 저장 구조 변경은 제외한다.
- 대규모 자동화 구조 재작성은 제외한다.

## 수동 검증
- revise_with_codex 리뷰 결과를 재현해 자동 revise 재시도 흐름이 이어지는지 확인한다.
- 재리뷰 pass 시 구현 커밋, task 완료 처리, 메타 커밋 단계가 순서대로 수행되는지 확인한다.
- 재리뷰 revise 반복 시 상태와 로그에 필요한 실패 정보가 남고 완료 처리가 차단되는지 확인한다.
- DryRun에서 Codex 실행, 검증, review, commit, complete-task 같은 변경 작업이 실행되지 않는지 확인한다.
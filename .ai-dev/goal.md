# 목표
AI Dev 자동화의 반복 실패 유형을 분류하고, 안전하게 자동 복구 가능한 경우 task별 최대 1회 재시도하도록 강화한다.

## 배경
현재 AI Dev 흐름에서는 test_failed, review_json_extraction_failed, review_revise_repeated, stale_review_required_file_missing, missing_implementation, package_files_changed 같은 실패가 반복될 수 있다. 각 실패 유형을 명확히 구분하고, 이미 구현 커밋과 최신 검증 결과가 있는 재개 흐름은 불필요하게 Codex를 다시 실행하지 않도록 한다.

## 성공 기준
- test_failed 발생 시 실패 항목과 test-result를 포함한 수정 프롬프트로 Codex 재수정을 최대 1회 수행한다.
- review_json_extraction_failed 발생 시 원본 리뷰 응답을 보존하고 JSON 추출 또는 리뷰 생성을 최대 1회 재시도한다.
- review_revise_repeated와 stale_review_required_file_missing 발생 시 최신 required_changes와 실제 changedFiles를 비교해 누락 파일만 대상으로 재시도한다.
- 최신 review가 pass이고 검증 결과가 current이며 task 구현 커밋이 존재하면 Codex 재실행 없이 다음 흐름으로 진행한다.
- package.json의 scripts 필드만 변경되고 dependencies, devDependencies, package-lock.json이 변경되지 않은 경우에만 안전한 변경으로 허용한다.
- missing_implementation은 Codex 결과와 실제 diff가 모두 없을 때만 발생한다.
- task별 복구 횟수와 최종 stopped reason을 기록해 무한 반복을 방지한다.
- 기존 영어 판정 토큰, expected_non_work 처리, baseline 사용자 변경 보존, PowerShell 5.1 호환성을 유지한다.
- npm run build, npm test 20개 이상, npm run lint가 모두 통과한다.

## 제약사항
- 한 번에 하나의 복구 흐름만 작게 구현한다.
- 기존 AI Dev 상태 파일과 queue/state 형식을 유지한다.
- 사용자 변경 사항과 baseline 변경 사항을 보존한다.
- package 의존성 및 lock file 변경은 안전 복구 대상으로 보지 않는다.
- PowerShell 5.1에서 동작하는 명령 형식을 유지한다.

## 범위 제외
- 새로운 실행 환경 도입은 제외한다.
- 대규모 구조 재작성은 제외한다.
- 알림 기능 추가는 제외한다.
- UI 화면 변경은 제외한다.

## 수동 검증
- 실패 유형별 샘플 상태를 사용해 자동 복구 횟수가 task별 최대 1회로 제한되는지 확인한다.
- 최신 review pass, current 검증, 구현 커밋 존재 조건에서 Codex 재실행 없이 이어지는지 확인한다.
- package.json scripts 단독 변경과 의존성 변경 케이스가 각각 허용/차단되는지 확인한다.
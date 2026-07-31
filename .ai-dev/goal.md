# 목표

AI Dev 자동화 테스트 체계를 추가한다.

## 배경

현재 `package.json`에 `test` 스크립트가 없어 `ai-dev-check.ps1` 실행 시 테스트 단계가 항상 skipped 처리된다. PowerShell 5.1에서 실행 가능한 자동화 검증을 추가해 AI Dev Loop의 핵심 동작을 반복 확인할 수 있게 한다.

## 성공 기준

- `npm test`로 실행되는 테스트 스크립트가 추가된다.
- PowerShell 5.1에서 실행 가능한 단위 및 통합 smoke test가 포함된다.
- 테스트는 임시 Git worktree 또는 임시 디렉터리를 사용해 실제 저장소를 오염시키지 않는다.
- auto-goal MaxSteps 기본값과 사용자 지정 값 전달을 검증한다.
- `all_goal_candidates_excluded`의 `expected_non_work` 분류를 검증한다.
- `dirty_worktree`와 `baseline_output_conflict` 상황에서 baseline 사용자 변경이 보존되는지 검증한다.
- 실행 후 새로운 staged 또는 dirty 운영 파일이 남지 않는지 검증한다.
- 테스트 실패 시 0이 아닌 종료 코드를 반환한다.
- 성공 및 실패 항목이 명확히 출력된다.
- 기존 build와 lint 흐름은 유지된다.

## 제약사항

- PowerShell 5.1 호환성을 유지한다.
- 저장소 운영 파일을 테스트 과정에서 오염시키지 않는다.
- 기존 스크립트 구조와 파일 배치를 우선 따른다.
- 한 번에 필요한 최소 파일만 변경한다.
- 기존 build와 lint 동작을 변경하지 않는다.

## 범위 제외

- 앱 기능 변경은 포함하지 않는다.
- UI 변경은 포함하지 않는다.
- 데이터 저장 구조 변경은 포함하지 않는다.
- 대규모 스크립트 재작성은 포함하지 않는다.

## 수동 검증

- `npm test` 실행 결과가 성공하는지 확인한다.
- `ai-dev-check.ps1` 실행 시 테스트 단계가 skipped되지 않는지 확인한다.
- 테스트 실행 후 작업 트리에 의도하지 않은 운영 파일 변경이 남지 않는지 확인한다.
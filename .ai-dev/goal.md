# 목표

auto-cycle 전체 테스트 실행과 MaxSteps 전달 검증을 보강한다.

## 배경

현재 `scripts/ai-dev-auto-cycle-full.ps1`은 implementation 및 verification task의 check와 check-revise 단계에서 `ai-dev-check.ps1`을 항상 `-BuildOnly`로 실행해 `npm test` 결과가 skipped로 덮어써질 수 있다. 또한 `scripts/ai-dev-test.ps1`의 MaxSteps 사용자 지정 검증은 정규식 확인에 머물러 실제 하위 호출 인수 전달을 충분히 검증하지 못한다.

## 성공 기준

- implementation 및 verification task의 check/check-revise 단계에서 package.json에 test script가 있으면 build, test, lint 전체 검증을 실행한다.
- documentation 또는 analysis task에서 필요한 경우에만 BuildOnly 흐름을 사용한다.
- MaxSteps 사용자 지정 검증은 격리된 임시 작업 공간에서 fake `ai-dev-auto-cycle-full.ps1`을 사용해 `ai-dev-auto-goal.ps1`이 지정된 MaxSteps 값을 실제 하위 호출 인수로 전달했는지 동작 기반으로 확인한다.
- 예시로 MaxSteps 57 지정 시 하위 스크립트가 받은 인수에 57이 기록되는지 검증한다.
- 기존 17개 expected_non_work 테스트와 baseline 보존 테스트를 유지한다.
- 전체 `npm test`가 Failed=0으로 종료되어야 한다.

## 제약사항

- 변경 범위는 관련 PowerShell 스크립트와 테스트에 한정한다.
- 기존 테스트 의도를 유지하고 필요한 검증만 보강한다.
- 로컬 저장소 구조와 기존 AI Dev Loop 상태 파일 형식을 존중한다.
- 큰 구조 변경은 피하고 작은 수정으로 해결한다.

## 범위 제외

- 신규 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 데이터 저장 구조 변경은 제외한다.
- 배포 관련 변경은 제외한다.

## 수동 검증

- 허용된 경우 `npm test`를 실행해 Failed=0인지 확인한다.
- MaxSteps 57 전달 검증 로그 또는 결과가 실제 하위 호출 인수 기반인지 확인한다.
# 목표

AI Dev Loop Autopilot이 이미 준비했거나 완료한 backlog goal title을 다음 실행에서 다시 선택하지 않도록 개선한다.

## 배경

현재 `scripts/ai-dev-autopilot.ps1`은 현재 goal, 직전 goal, 현재 프로세스의 `usedTitles`만 제외한다. 이 때문에 이전 Autopilot 실행에서 이미 완료한 backlog 항목이 이후 실행에서 다시 후보로 선택될 수 있다.

## 성공 기준

- Autopilot은 과거 prepared 로그, 완료된 queue/goal 상태, 또는 별도 history 파일을 기준으로 이미 준비했거나 완료한 goal title을 후보에서 제외한다.
- 중복 후보를 제외한 뒤 남은 후보가 없으면 중단 사유와 제외된 title 목록을 state, loop-log, 출력 중 적절한 위치에 남긴다.
- 정상 한국어 backlog title은 계속 후보로 허용된다.
- 기존 mojibake fallback 로직은 유지된다.
- DryRun 실행에서는 파일을 수정하지 않는다.
- AllowCommit이 있는 성공 실행은 작업 종료 상태를 명확히 검증할 수 있다.

## 제약사항

- 앱 `src` 파일은 수정하지 않는다.
- 변경 범위는 Autopilot 스크립트와 AI Dev Loop 상태 파일에 한정한다.
- 기존 backlog 선택 흐름과 fallback 동작을 불필요하게 재작성하지 않는다.
- 한 번에 하나의 작은 구현 단위로 진행한다.

## 범위 제외

- 앱 UI 변경은 하지 않는다.
- IndexedDB schema 변경은 하지 않는다.
- 새로운 외부 의존성은 추가하지 않는다.
- 알림, 계정, 원격 동기화 기능은 다루지 않는다.

## 수동 검증

- 과거 완료 title이 있는 상태에서 Autopilot 후보 선택을 실행해 해당 title이 제외되는지 확인한다.
- 제외 후 후보가 없을 때 중단 사유와 제외 title 목록이 남는지 확인한다.
- DryRun에서 상태 파일이 변경되지 않는지 확인한다.
- 한국어 backlog title과 mojibake fallback 처리가 기존처럼 동작하는지 확인한다.

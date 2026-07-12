# 목표

AI Dev Loop Autopilot에 durable goal history를 도입해 이미 선택되었거나 처리된 goal title이 다음 실행에서 다시 후보로 선택되지 않도록 한다.

## 배경

현재 Autopilot은 과거 prepared 로그와 현재 queue/state의 completed goalTitle만 제외하기 때문에, 실패 후 수동 완료된 backlog goal이나 prepared 로그에 남지 않은 goal이 다음 실행에서 다시 선택될 수 있다. 실제로 수동 완료한 backlog goal이 다음 Autopilot 실행에서 다시 선택된 사례가 있었다.

## 성공 기준

- `scripts/ai-dev-autopilot.ps1`에서 Autopilot이 선택/준비/완료한 goal title을 durable history로 보존한다.
- history에 저장된 정상적인 한국어 goal title이 깨지지 않는다.
- 기존 prepared 로그 기반 제외와 현재 completed queue/state goalTitle 제외는 유지한다.
- task title을 goal title로 잘못 취급하지 않는다.
- auto-goal 실패 후 해당 goal이 수동 완료되어도 다음 실행에서 같은 goal title이 다시 선택되지 않는다.
- DryRun 실행은 history, state, loop-log 등 어떤 파일도 수정하지 않는다.
- 모든 후보가 history 때문에 제외되면 `all_goal_candidates_excluded`로 중단하고 제외 title 목록과 후보 title 목록을 state, loop-log, output에 남긴다.
- 앱 `src` 파일은 수정하지 않는다.
- AllowCommit이 있는 성공 실행은 최종 작업 트리가 깨끗한 상태로 끝난다.

## 제약사항

- 변경 범위는 Autopilot 스크립트와 AI Dev Loop 상태/기록 파일 처리에 한정한다.
- 한국어 goal title 보존을 위해 파일 인코딩과 JSON 직렬화 방식을 안전하게 유지한다.
- 기존 로그 기반 제외 로직과 현재 완료 goal 제외 로직을 제거하지 않는다.
- DryRun 경로에서는 파일 쓰기 동작을 추가하지 않는다.

## 범위 제외

- 앱 화면, React 컴포넌트, Zustand 상태, Dexie 저장 구조 변경은 제외한다.
- 알림, 동기화, 인증 같은 제품 기능 추가는 제외한다.
- Autopilot 외 다른 개발 루프 정책의 대규모 재작성은 제외한다.

## 수동 검증

- history가 없는 상태에서 새 goal을 선택하면 durable history에 goal title이 기록되는지 확인한다.
- auto-goal 실패 후 같은 title이 다음 실행 후보에서 제외되는지 확인한다.
- DryRun 실행 전후 관련 파일의 변경이 없는지 확인한다.
- 모든 후보가 history로 제외되는 경우 state, loop-log, output에 후보 title과 제외 title이 남는지 확인한다.
- 한국어 goal title이 history 파일에서 깨지지 않는지 확인한다.
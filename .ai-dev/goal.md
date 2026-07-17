# 목표
Autopilot durable history 기록 이후 nested auto-goal dirty-worktree-gate가 `.ai-dev/autopilot-goal-history.json` 때문에 중단되는 문제를 수정한다.

## 배경
현재 Autopilot 연속 실행 중 selected/prepared/completed durable history가 기록된 직후 nested `ai-dev-auto-goal.ps1` 호출에서 작업 트리가 dirty로 판단되어 `auto_goal_failed`로 중단된다. 특히 `.ai-dev/autopilot-goal-history.json`이 새로 생성되거나 변경된 상태가 dirty gate에 걸린다.

## 성공 기준
- Autopilot이 durable history를 기록해도 nested auto-goal dirty gate가 자기 자신의 history 파일만으로 실패하지 않는다.
- `AllowRun + AllowCommit` 경로에서 history/loop-log가 필요한 시점에 안전하게 meta commit되거나 nested auto-goal 호출 전 작업 트리가 깨끗하게 유지된다.
- DryRun에서는 파일 변경이 발생하지 않는다.
- durable history 중복 방지 기능이 유지된다.
- `.ai-dev/autopilot-goal-history.json`이 장기 추적 대상이면 자동화 commit 대상에 포함된다.
- 실제 Autopilot 연속 실행 명령이 최소 1개 goal을 준비/실행 단계로 넘길 수 있다.
- 앱 `src` 파일은 수정하지 않는다.
- build/lint 검증을 통과한다.

## 제약사항
- 변경은 Autopilot/auto-goal 스크립트와 `.ai-dev` 자동화 상태 파일 범위로 제한한다.
- 기존 durable history 중복 방지 로직을 제거하지 않는다.
- DryRun 경로는 어떤 파일도 쓰지 않도록 유지한다.
- 앱 UI와 `src` 파일은 변경하지 않는다.

## 범위 제외
- 앱 기능 변경
- 대규모 스크립트 재작성
- 저장소 구조 변경
- 알림 또는 외부 연동 추가

## 수동 검증
- DryRun 실행 후 파일 변경이 없는지 확인한다.
- `AllowRun + AllowCommit` Autopilot 연속 실행이 최소 1개 goal을 준비/실행 단계로 넘기는지 확인한다.
- build와 lint를 실행해 통과 여부를 확인한다.
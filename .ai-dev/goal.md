# 목표
AI Dev Loop에서 커밋 완료 후 `.ai-dev/state.json`의 `lastCommitHash`가 항상 최신 커밋 해시로 기록되도록 개선한다.

## 배경
현재 자동 또는 수동 커밋 흐름이 끝난 뒤 `lastCommitHash`가 비어 있을 수 있어, 후속 단계에서 커밋 결과를 일관되게 추적하기 어렵다. `ai-dev-commit`, `commit-result-gate`, `complete-task` 흐름에서 동일한 기준으로 최신 커밋 해시를 남기도록 정리한다.

## 성공 기준
- 커밋이 성공한 뒤 `.ai-dev/state.json`의 `lastCommitHash`가 null 또는 빈 값으로 남지 않는다.
- `ai-dev-commit`, `commit-result-gate`, `complete-task` 흐름에서 최신 커밋 해시 기록 방식이 일관된다.
- 커밋이 없는 상태나 실패 상태에서는 기존 상태 흐름을 깨뜨리지 않는다.
- 변경 범위가 AI Dev Loop 상태 갱신 로직에 한정된다.

## 제약사항
- 기존 작업 큐와 상태 파일 구조를 유지한다.
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 사용자가 만든 변경 사항은 되돌리지 않는다.
- 불필요한 대규모 구조 변경은 하지 않는다.

## 범위 제외
- 새로운 기능 화면 추가는 하지 않는다.
- 상태 파일 포맷의 전면 변경은 하지 않는다.
- AI Dev Loop와 직접 관련 없는 앱 기능은 수정하지 않는다.

## 수동 검증
- 커밋 완료 흐름 이후 `.ai-dev/state.json`의 `lastCommitHash`에 최신 커밋 해시가 기록되는지 확인한다.
- 커밋 실패 또는 커밋 없음 상황에서 상태 값이 부정확하게 갱신되지 않는지 확인한다.
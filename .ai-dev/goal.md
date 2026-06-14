# 목표
AI Dev Loop auto-goal pass 이후 완료 재시도 흐름을 수정한다.

## 배경
ai-dev-auto-goal 실행 중 리뷰 결과가 pass이고 next_step이 complete_task인 상태에서도 구현 커밋, complete-task -CommitHash 처리, .ai-dev 메타 커밋으로 이어지지 않고 멈추는 문제가 있다. 또한 auto-cycle-full이 미완료 상태로 끝났을 때 auto-goal이 성공으로 오판하지 않도록 보완이 필요하다.

## 성공 기준
- 리뷰 결과 pass 이후 next_step 값이 complete_task 또는 complete-task인 경우 모두 완료 처리 흐름으로 이어진다.
- 구현 커밋 해시가 complete-task -CommitHash 단계에 정상 전달된다.
- complete-task 처리 후 .ai-dev 메타 변경 커밋 흐름이 누락되지 않는다.
- auto-cycle-full이 미완료 상태로 끝난 경우 auto-goal이 성공으로 판단하지 않는다.
- 기존 자동 루프의 정상 완료 경로는 유지된다.

## 제약사항
- 한 번에 하나의 작은 구현 변경으로 처리한다.
- 기존 스크립트 구조와 상태 파일 형식을 우선 유지한다.
- 불필요한 대규모 재작성은 하지 않는다.
- 사용자 변경 사항은 되돌리지 않는다.

## 범위 제외
- 새로운 기능 추가는 제외한다.
- UI 변경은 제외한다.
- 저장소 구조 변경은 제외한다.
- 자동 루프 전체 설계 변경은 제외한다.

## 수동 검증
- pass와 complete_task 조합에서 완료 처리 단계가 이어지는지 확인한다.
- pass와 complete-task 조합에서도 동일하게 처리되는지 확인한다.
- auto-cycle-full이 미완료 상태로 끝난 경우 실패 또는 재시도 대상으로 남는지 확인한다.
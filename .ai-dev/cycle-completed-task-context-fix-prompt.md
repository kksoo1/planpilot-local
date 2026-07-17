현재 작업은 "full auto-cycle 로그 구조 개선"의 T001 "full auto-cycle 로그 구조 확인 및 최소 개선"입니다.

현재 재리뷰 required_changes:
- scripts/ai-dev-auto-cycle-full.ps1에서 task 완료 후 $script:currentTask를 다음 상태로 갱신한 뒤 Complete-Cycle을 호출한다.
- 이 때문에 goal_completed 같은 성공 종료 로그의 context.task가 실제 방금 완료한 task가 아니라 다음 task 또는 null을 가리킬 수 있다.
- full auto-cycle 로그의 후속 분석 목적과 충돌한다.

수정 요구사항:
1. scripts/ai-dev-auto-cycle-full.ps1만 수정한다.
2. complete-task 실행 직전 또는 직후에 "방금 완료한 task" 정보를 별도 변수로 보존한다.
3. Complete-Cycle 또는 cycle result context에는 최소한 다음을 구분해 기록한다.
   - completedTask: 방금 완료된 task
   - currentTask: complete-task 이후 현재 task
   - nextTask: 다음 task가 있으면 다음 task
4. 기존 context.task 필드를 유지해야 한다면 backward compatibility를 위해 남기되, goal_completed 로그에서는 stale 값이 되지 않게 한다.
5. goal_completed / task completed / no next task 경로에서 완료된 task 정보가 사라지지 않아야 한다.
6. 기존 implementation/verification revise 처리 동작은 유지한다.
7. package.json/package-lock.json 보호 정책은 변경하지 않는다.
8. 앱 src 파일은 수정하지 않는다.
9. npm run build와 npm run lint가 통과해야 한다.
10. 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- 로그 분석에서 "방금 완료한 작업"과 "완료 후 현재 작업"을 혼동하지 않도록 한다.
- complete-task가 queue/state를 갱신하더라도 cycle result에는 completedTask가 안정적으로 남아야 한다.

현재 작업은 "full auto-cycle 로그 구조 개선"의 T001 "full auto-cycle 로그 구조 확인 및 최소 개선"입니다.

현재 재리뷰 required_changes:
- scripts/ai-dev-auto-cycle-full.ps1에서 complete-task 실행이 성공한 뒤 final-status까지 성공해야만 $script:completedTask와 $script:completedTaskCount가 갱신된다.
- final-status가 실패하면 실제로 task는 완료됐는데 cycle result context에는 completedTask=null, completedTaskCount=0으로 기록될 수 있다.
- 이는 full auto-cycle 로그 구조 개선 목표와 충돌한다.

수정 요구사항:
1. scripts/ai-dev-auto-cycle-full.ps1만 수정한다.
2. 다른 gate, required file path normalization, review required file 비교 로직은 건드리지 않는다.
3. complete-task Invoke-CycleCommand가 성공한 직후, final-status 실행 전에 completedTask/completedTaskCount를 갱신한다.
4. complete-task 성공 직후 currentTask/nextTask도 가능하면 최신 queue/state 기준으로 갱신한다.
5. final-status가 실패하더라도 cycle result context에는 방금 완료된 completedTask가 남아야 한다.
6. goal_completed / task completed / no next task 경로에서 completedTask와 currentTask/nextTask가 구분되어야 한다.
7. 기존 context.task backward compatibility는 유지하되, stale task를 기록하지 않게 한다.
8. 기존 implementation/verification revise 처리 동작은 유지한다.
9. package.json/package-lock.json 보호 정책은 변경하지 않는다.
10. 앱 src 파일은 수정하지 않는다.
11. npm run build와 npm run lint가 통과해야 한다.
12. 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- complete-task가 성공한 순간 이미 task 완료는 확정이다.
- final-status는 후속 상태 출력일 뿐이므로, final-status 실패가 completedTask 기록을 지우거나 누락시키면 안 된다.
- 로그 분석용 context에는 "방금 완료한 task"가 안정적으로 남아야 한다.

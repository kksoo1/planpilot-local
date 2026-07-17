현재 작업은 "build/check 실패 후 revise 흐름 자동 안내"의 T001 "build/check 실패 후 revise 안내 추가"입니다.

현재 재리뷰 required_changes:
1. scripts/ai-dev-next.ps1에서 build/check 실패 안내가 $hasImplementationGitChanges 조건에 묶여 있다.
   - lastCommand가 check/build/lint이고 lastCommandStatus가 failed여도
   - 구현 변경이 없거나 git 상태 확인에 실패하면 inspect_status 등으로 떨어질 수 있다.
2. build/check 실패 직후 recommendedCommands에 ai-dev-auto-cycle-full.ps1이 포함되어 있다.
   - 이는 작고 안전한 다음 행동 안내 요구보다 과하다.
   - 실패 분기에서는 test-result 확인, save-diff, review prompt 생성, review 저장, revise prompt 생성/실행 안내까지만 추천해야 한다.

수정 요구사항:
1. scripts/ai-dev-next.ps1만 수정한다.
2. build/check 실패 판정은 우선 state.json 기준으로 한다.
   - lastCommand가 check, build, lint, check-revise, build-revise, lint-revise 중 하나이거나 check 계열로 판단 가능한 값이고
   - lastCommandStatus가 passed가 아니면 build/check 실패 상태로 본다.
3. $hasImplementationGitChanges는 build/check 실패 상태 판정 조건으로 사용하지 않는다.
4. 구현 변경 존재 여부는 notes에서 보조 설명으로만 사용한다.
5. build/check 실패 분기 recommendedCommands에서 ai-dev-auto-cycle-full.ps1 추천을 제거한다.
6. build/check 실패 분기 recommendedCommands에는 아래 안전한 수동 복구 흐름만 포함한다.
   - .ai-dev/test-result.md 확인
   - scripts/ai-dev-save-diff.ps1
   - scripts/ai-dev-make-review-prompt.ps1 -Strict
   - scripts/ai-dev-run-review-codex.ps1 -AllowDirty -SaveReview
   - 리뷰 결과가 revise이면 scripts/ai-dev-make-revise-prompt.ps1
   - 그 후 scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md
7. 위 revise 관련 명령은 "리뷰 결과가 revise인 경우"의 조건부 다음 단계임을 한국어 note에 분명히 적는다.
8. 기존 review revise 상태에서는 state.json의 lastReviewDecision=revise 기준 make-revise-prompt 안내를 유지한다.
9. review-response.json이 없거나 stale이라는 이유만으로 기존 state 기반 revise 안내를 막지 않는다.
10. pass/complete_task 상태 안내는 유지한다.
11. 정상/완료/대기 상태 안내는 깨지지 않아야 한다.
12. package.json/package-lock.json 보호 정책은 변경하지 않는다.
13. 앱 src 파일은 수정하지 않는다.
14. npm run build와 npm run lint가 통과해야 한다.
15. .ai-dev/test-result.md에는 build/check 실패 상태, pass 상태, review revise 상태의 scripts/ai-dev-next.ps1 -Json 출력 확인 결과가 기록되어야 한다.

핵심 의도:
- check 실패 직후에는 먼저 작은 안전 단계로 diff/review를 만든다.
- auto-cycle-full 재실행은 ai-dev-next의 실패 분기 추천 명령에 넣지 않는다.
- review가 revise로 나온 뒤에만 make-revise-prompt와 Codex revise 실행으로 이어진다.

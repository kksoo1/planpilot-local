현재 작업은 "build/check 실패 후 revise 흐름 자동 안내"의 T001 "build/check 실패 후 revise 안내 추가"입니다.

현재 재리뷰 required_changes:
- scripts/ai-dev-next.ps1의 prepare_review_after_check_failure 분기에서 recommendedCommands가 과하다.
- build/check 실패 직후에는 .ai-dev/test-result.md 확인, diff 저장, review prompt 생성까지가 안전한 다음 행동이다.
- 현재 recommendedCommands에 save-review -FromClipboard와 make-revise-prompt가 포함되어 있어 사용자가 리뷰 결과를 받기 전에도 실행할 명령처럼 노출된다.

수정 요구사항:
1. scripts/ai-dev-next.ps1만 수정한다.
2. prepare_review_after_check_failure의 recommendedCommands는 아래까지만 남긴다.
   - .ai-dev/test-result.md 확인 안내
   - powershell -ExecutionPolicy Bypass -File scripts/ai-dev-save-diff.ps1
   - powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-review-prompt.ps1 -Strict
3. prepare_review_after_check_failure의 recommendedCommands에서 아래 명령은 제거한다.
   - ai-dev-auto-cycle-full.ps1
   - ai-dev-run-review-codex.ps1
   - ai-dev-save-review.ps1 -FromClipboard
   - ai-dev-make-revise-prompt.ps1
   - ai-dev-run-codex.ps1 -PromptPath .ai-dev/revise-prompt.md
4. 단, notes에는 다음 흐름을 한국어로 명확히 설명한다.
   - review prompt를 만든 뒤 Codex 리뷰를 실행하거나 리뷰 결과를 저장해야 한다.
   - 리뷰 결과를 받은 뒤 decision이 revise이면 ai-dev-make-revise-prompt.ps1를 실행한다.
   - revise-prompt가 생성된 뒤 ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md로 재수정할 수 있다.
   - 이 revise 단계는 리뷰 결과가 revise인 경우에만 해당한다.
5. build/check 실패 판정은 state.json의 lastCommand/check 계열 + lastCommandStatus failed 기준을 유지한다.
6. $hasImplementationGitChanges는 실패 판정 조건으로 사용하지 말고 notes 보조 설명으로만 사용한다.
7. 기존 review revise 상태에서는 state.json의 lastReviewDecision=revise 기준 make-revise-prompt 안내를 유지한다.
8. review-response.json이 없거나 stale이라는 이유만으로 기존 state 기반 revise 안내를 막지 않는다.
9. pass/complete_task 상태 안내는 유지한다.
10. 정상/완료/대기 상태 안내는 깨지지 않아야 한다.
11. package.json/package-lock.json 보호 정책은 변경하지 않는다.
12. 앱 src 파일은 수정하지 않는다.
13. npm run build와 npm run lint가 통과해야 한다.
14. 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- build/check 실패 직후 recommendedCommands는 “작고 안전한 선행 단계”까지만 제안한다.
- 리뷰 실행/저장과 revise 실행은 notes에서 조건부 후속 흐름으로 설명한다.
- 리뷰 결과가 revise로 확정되기 전에는 make-revise-prompt를 실행 명령처럼 노출하지 않는다.

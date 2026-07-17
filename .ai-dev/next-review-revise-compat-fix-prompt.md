현재 작업은 "build/check 실패 후 revise 흐름 자동 안내"의 T001 "build/check 실패 후 revise 안내 추가"입니다.

현재 재리뷰 required_changes:
- scripts/ai-dev-next.ps1에서 make_revise_prompt 안내 조건이 너무 강해졌다.
- 기존에는 state.json의 lastReviewDecision이 revise이면 make_revise_prompt를 안내했다.
- 변경 후에는 .ai-dev/review-response.json의 decision/next_step까지 revise/revise_with_codex여야 한다.
- 하지만 ai-dev-save-review.ps1은 상황에 따라 review.md와 state.json만 갱신할 수 있으므로, 정상적인 기존 review revise 상태에서도 review-response.json이 없거나 stale이면 make_revise_prompt 안내가 사라질 수 있다.

수정 요구사항:
1. scripts/ai-dev-next.ps1만 수정한다.
2. check 실패 직후 분기에서는 make-revise-prompt를 바로 추천하지 않는다.
3. check 실패 직후 분기에서는 test-result 확인, save-diff, make-review-prompt -Strict, run-review-codex -AllowDirty -SaveReview 선행 안내를 유지한다.
4. 기존 review revise 상태에서는 state.json의 lastReviewDecision=revise를 기준으로 make-revise-prompt 안내를 유지한다.
5. review-response.json은 stale review 방지용 보조 조건으로만 사용하고, 파일이 없다는 이유만으로 기존 state 기반 revise 안내를 막지 않는다.
6. review.md, diff.md, test-result.md 존재 여부가 필요하면 안내 문구에 선행 단계로 설명하되, 기존 정상 review revise 흐름을 차단하지 않는다.
7. pass/complete_task 상태 안내는 유지한다.
8. 정상/완료/대기 상태 안내는 깨지지 않아야 한다.
9. package.json/package-lock.json 보호 정책은 변경하지 않는다.
10. 앱 src 파일은 수정하지 않는다.
11. npm run build와 npm run lint가 통과해야 한다.
12. 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- check 실패 직후에는 먼저 diff와 review를 만들도록 안내한다.
- review revise 상태가 이미 저장되어 있으면 기존처럼 make-revise-prompt 흐름을 안내한다.
- review-response.json이 없거나 오래됐다는 이유만으로 state.json 기반 기존 revise 안내를 깨뜨리지 않는다.

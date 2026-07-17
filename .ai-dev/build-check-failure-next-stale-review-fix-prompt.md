현재 작업은 "build/check 실패 후 revise 흐름 자동 안내"의 T001 "build/check 실패 후 revise 안내 추가"입니다.

현재 재리뷰 required_changes:
1. scripts/ai-dev-next.ps1의 check 실패 분기에서 $canMakeRevisePrompt가 파일 존재만 보고 판단한다.
2. 이전 pass 리뷰나 stale review.md가 남아 있으면 실패 원인을 반영한 리뷰 없이 make-revise-prompt / Codex 재수정 실행을 추천할 수 있다.
3. 상태별 ai-dev-next.ps1 -Json 출력 검증 결과가 .ai-dev/test-result.md에 없다.

수정 요구사항:
1. scripts/ai-dev-next.ps1만 수정한다.
2. check 실패 분기에서는 .ai-dev/test-result.md 확인 안내를 유지한다.
3. check 실패 분기에서는 기본적으로 다음 선행 흐름을 안내한다.
   - save-diff
   - make-review-prompt -Strict
   - run-review-codex -AllowDirty -SaveReview
   - 그 다음 ai-dev-next.ps1 재실행 또는 auto-cycle-full 재실행
4. check 실패 분기에서는 stale/pass review.md만 보고 make-revise-prompt 또는 Codex revise 실행을 추천하지 않는다.
5. make-revise-prompt 추천은 review decision이 revise이고 next_step이 revise_with_codex인 현재 리뷰 상태에서만 유지한다.
6. 기존 review revise 상태의 make_revise_prompt 안내는 유지한다.
7. 기존 정상/완료/대기 상태 안내는 깨지지 않아야 한다.
8. package.json/package-lock.json 보호 정책은 변경하지 않는다.
9. 앱 src 파일은 수정하지 않는다.
10. npm run build와 npm run lint가 통과해야 한다.
11. .ai-dev/test-result.md에는 다음 상태별 검증 계획과 기대 결과를 명확히 남긴다.
    - build/check 실패 상태: test-result 확인 + save-diff + make-review-prompt + run-review-codex 선행 안내가 나와야 함
    - pass 상태: complete_task 또는 완료 흐름 안내가 유지되어야 함
    - review revise 상태: make-revise-prompt / Codex revise 안내가 유지되어야 함

핵심 의도:
- check 실패 직후에는 실패 원인을 반영한 리뷰가 아직 없을 수 있으므로, revise 명령을 바로 던지면 안 된다.
- 먼저 diff/review를 생성하고, 리뷰 결과가 revise일 때만 revise 프롬프트 생성으로 이어가야 한다.

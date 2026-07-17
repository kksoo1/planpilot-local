현재 작업은 "build/check 실패 후 revise 흐름 자동 안내"의 T001 "build/check 실패 후 revise 안내 추가"입니다.

현재 재리뷰 required_changes:
1. build/check 실패 안내가 리뷰 생성 뒤 다음 실행에서 make_revise_prompt로 이어진다고 설명하지만, 성공 기준의 "필요한 재수정 프롬프트 생성 흐름"을 추천 명령에서 직접 확인하기 어렵다.
2. build/check 실패 상태, pass 상태, review revise 상태의 scripts/ai-dev-next.ps1 -Json 출력 확인 결과가 test-result에 충분히 제시되지 않았다.

수정 요구사항:
1. scripts/ai-dev-next.ps1만 수정한다.
2. build/check 실패 직후 분기에서는 바로 revise 실행을 추천하지 않는다.
3. build/check 실패 직후 분기에서는 다음 선행 흐름을 recommendedCommands 또는 notes에 명확히 포함한다.
   - test-result 확인
   - save-diff
   - make-review-prompt -Strict
   - run-review-codex -AllowDirty -SaveReview
   - 그 다음 ai-dev-next.ps1 재실행 또는 auto-cycle-full 재실행
4. build/check 실패 안내의 notes 또는 recommendedCommands에 다음 조건부 다음 단계를 명확히 포함한다.
   - "리뷰 결과가 revise이면 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-revise-prompt.ps1 를 실행한다."
   - "그 후 powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty -PromptPath .ai-dev/revise-prompt.md 를 실행한다."
5. 단, 위 revise 단계는 리뷰 결과가 revise인 경우의 다음 단계라고 한국어 note로 분명히 표현한다.
6. 기존 review revise 상태에서는 state.json의 lastReviewDecision=revise 기준 make-revise-prompt 안내를 유지한다.
7. review-response.json이 없거나 stale이라는 이유만으로 기존 state 기반 revise 안내를 막지 않는다.
8. pass/complete_task 상태 안내는 유지한다.
9. 정상/완료/대기 상태 안내는 깨지지 않아야 한다.
10. package.json/package-lock.json 보호 정책은 변경하지 않는다.
11. 앱 src 파일은 수정하지 않는다.
12. npm run build와 npm run lint가 통과해야 한다.
13. .ai-dev/test-result.md에는 아래 검증 결과를 명확히 남긴다.
    - build/check 실패 상태의 ai-dev-next.ps1 -Json 출력 기대 결과
    - pass 상태의 ai-dev-next.ps1 -Json 출력 기대 결과
    - review revise 상태의 ai-dev-next.ps1 -Json 출력 기대 결과

핵심 의도:
- check 실패 직후에는 먼저 diff와 review를 만든다.
- review가 revise로 나온 뒤에는 make-revise-prompt와 Codex revise 실행으로 이어진다.
- 이 흐름이 Json 안내에 드러나야 한다.

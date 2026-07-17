현재 작업은 "build/check 실패 후 revise 흐름 자동 안내"의 T001 "build/check 실패 후 revise 안내 추가"입니다.

현재 재리뷰 required_changes:
- scripts/ai-dev-next.ps1에서 build/check 실패 직후 안내가 부족하다.
- build/check 실패 직후에는 보통 .ai-dev/review.md와 .ai-dev/diff.md가 아직 없을 수 있다.
- 현재 구현은 이 경우 .ai-dev/test-result.md 확인만 추천하고, revise 프롬프트 생성 또는 재수정 실행으로 이어질 실질적인 다음 흐름을 추천하지 않는다.

수정 요구사항:
1. scripts/ai-dev-next.ps1만 수정한다.
2. build/check 실패 상태에서 test-result 확인 안내는 유지한다.
3. review.md 또는 diff.md가 없는 경우에도 사용자가 다음에 실행할 수 있는 안전한 복구 흐름을 안내한다.
4. 기존 ai-dev-make-revise-prompt.ps1가 review.md를 요구한다면, 바로 make-revise-prompt만 안내하지 말고 필요한 선행 단계를 함께 안내한다.
5. build/check 실패 직후 일반 상태에서는 다음 흐름을 명확히 제안한다.
   - .ai-dev/test-result.md 확인
   - 필요하면 현재 실패 결과 기준으로 Codex 재수정 프롬프트를 만들기 위한 선행 단계
   - diff/review가 아직 없을 때 생성해야 하는 단계
   - 이후 revise 실행 단계
6. 기존 review revise 상태에서 make_revise_prompt 안내가 유지되어야 한다.
7. 기존 정상/완료/대기 상태 안내는 깨지지 않아야 한다.
8. package.json/package-lock.json 보호 정책은 변경하지 않는다.
9. 앱 src 파일은 수정하지 않는다.
10. npm run build와 npm run lint가 통과해야 한다.
11. 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- check 실패 직후에도 사용자가 막히지 않고 다음 자동 복구 단계로 이어질 수 있어야 한다.
- review.md/diff.md가 없다는 이유로 안내가 test-result 확인에서 끝나면 안 된다.
- 단, 없는 파일을 전제로 실패할 명령만 던지지 말고, 필요한 선행 단계까지 함께 안내해야 한다.

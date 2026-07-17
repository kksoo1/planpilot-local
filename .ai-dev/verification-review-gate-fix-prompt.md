현재 작업은 "Verification task revise 자동 처리"의 T001 "verification revise 분기 수정"입니다.

현재 재리뷰 required_changes:
- scripts/ai-dev-auto-cycle-full.ps1에서 verification task + review decision=revise + next_step=revise_with_codex 케이스는 non_implementation_revise는 피했지만,
- 같은 Get-ReviewImplementationGate 안의 missing_implementation 또는 stale_review_required_file_missing 검사로 여전히 중단될 수 있다.

수정 요구사항:
1. scripts/ai-dev-auto-cycle-full.ps1만 수정한다.
2. verification task에서 review decision=revise, next_step=revise_with_codex인 경우에는 구현 완료 검증용 missing_implementation / stale_review_required_file_missing 검사로 중단하지 않는다.
3. 이 경우는 자동 revise 흐름으로 계속 갈 수 있도록 명시적으로 허용한다.
4. implementation task의 기존 revise 검증, required_changes 검증, stale review 검증 동작은 유지한다.
5. complete_task/pass 경로의 검증 안전장치는 약화하지 않는다.
6. package.json/package-lock.json 보호 정책은 변경하지 않는다.
7. 앱 src 파일은 수정하지 않는다.
8. 변경 후 npm run build와 npm run lint가 통과해야 한다.
9. 리뷰가 이해할 수 있도록 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- verification task는 구현 파일 변경이 없는 것이 정상일 수 있다.
- verification task의 revise_with_codex는 "구현 누락"이 아니라 "검증 증거 보강 또는 검증 산출물 갱신" 흐름으로 처리해야 한다.
- 따라서 implementation 전용 requiredFiles/changedFiles 검사는 verification revise_with_codex 경로에 적용하지 않는다.

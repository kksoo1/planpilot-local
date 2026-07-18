현재 작업은 "Codex 리뷰 JSON 추출 실패 처리 보강"의 T001 "리뷰 JSON 추출 실패 처리 보강"입니다.

현재 재리뷰 required_changes:
1. scripts/ai-dev-run-review-codex.ps1의 Write-ReviewExtractionFailureState가 기존 stopReason과 무관하게 repeatedFailureCount를 항상 1 증가시킨다.
2. 다른 실패 원인 뒤에 리뷰 JSON 추출 실패가 처음 발생해도 반복 실패로 계산되어 루프 재시도/중단 판단이 왜곡될 수 있다.
3. .ai-dev/test-result.md에 정상 JSON / JSON 없음 / 깨진 JSON 응답 경로 검증 결과가 최종적으로 남아 있어야 한다.

수정 요구사항:
1. scripts/ai-dev-run-review-codex.ps1만 수정한다.
2. Write-ReviewExtractionFailureState에서 repeatedFailureCount 갱신 로직을 수정한다.
3. 기존 state.stopReason이 review_json_extraction_failed일 때만 repeatedFailureCount를 1 증가시킨다.
4. 기존 state.stopReason이 비어 있거나 review_json_extraction_failed가 아니면 repeatedFailureCount를 1로 초기화한다.
5. lastCommandStatus, lastErrorSummary, lastReviewDecision, lastReviewSeverity, stopReason 기록은 유지한다.
6. 정상 JSON 리뷰 응답 처리 흐름은 깨지면 안 된다.
7. JSON 없음/깨진 JSON 응답은 성공처럼 처리되면 안 된다.
8. 앱 src 파일은 수정하지 않는다.
9. package.json/package-lock.json 보호 정책은 변경하지 않는다.
10. npm run build와 npm run lint가 통과해야 한다.
11. 변경 의도를 codex-result에 명확히 남긴다.

핵심 의도:
- 같은 review_json_extraction_failed가 연속될 때만 repeatedFailureCount를 증가시킨다.
- 다른 실패 원인에서 처음 review_json_extraction_failed로 바뀌는 경우는 repeatedFailureCount=1부터 시작한다.

현재 작업은 "Codex 리뷰 JSON 추출 실패 처리 보강"의 T001 "리뷰 JSON 추출 실패 처리 보강"입니다.

현재 재리뷰 required_changes:
- .ai-dev/test-result.md에 JSON 추출 성공/실패 경로 검증 결과가 부족하다.
- 정상 JSON 리뷰 응답과 JSON이 없거나 잘못된 리뷰 응답 각각에서 decision/severity 처리와 state.json 실패 요약 기록 여부를 수동 검증하고 결과를 기록해야 한다.

수행 요구사항:
1. 가능한 경우 실제 임시 검증으로 scripts/ai-dev-run-review-codex.ps1의 JSON 추출 경로를 확인한다.
2. 정상 JSON 리뷰 응답 경로를 확인한다.
   - decision, severity, next_step이 .ai-dev/review-response.json에 정상 반영되는지 확인한다.
   - SaveReview 흐름이 깨지지 않는지 확인한다.
3. JSON이 없는 리뷰 응답 경로를 확인한다.
   - review-response.json 추출 실패가 성공처럼 처리되지 않아야 한다.
   - state.json에 실패 상태 또는 실패 요약이 기록되는지 확인한다.
4. 깨진 JSON 리뷰 응답 경로를 확인한다.
   - 파싱 실패가 성공처럼 처리되지 않아야 한다.
   - state.json에 실패 상태 또는 실패 요약이 기록되는지 확인한다.
5. 검증 결과를 .ai-dev/test-result.md에 명확히 추가한다.
6. scripts/ai-dev-run-review-codex.ps1에 실제 버그가 남아 있으면 그 파일만 최소 수정한다.
7. 앱 src 파일은 수정하지 않는다.
8. package.json/package-lock.json 보호 정책은 변경하지 않는다.
9. npm run build와 npm run lint가 통과해야 한다.

기록 형식:
.ai-dev/test-result.md에 다음 섹션을 추가한다.

## Review JSON extraction verification

- Normal JSON review response:
  - Result:
  - Evidence:
- Missing JSON review response:
  - Result:
  - Evidence:
- Malformed JSON review response:
  - Result:
  - Evidence:
- state.json failure summary behavior:
  - Result:
  - Evidence:

핵심 의도:
- 리뷰 JSON 추출 성공 경로와 실패 경로가 모두 검증되었음을 reviewer가 볼 수 있어야 한다.
- 검증하지 못한 항목이 있으면 미검증이라고 쓰지 말고, 가능한 범위에서 임시 입력 또는 코드 경로 기반으로 실제 확인한 근거를 남긴다.

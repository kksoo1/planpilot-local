현재 작업은 "full auto-cycle 로그 구조 개선"의 T001 "full auto-cycle 로그 구조 확인 및 최소 개선"입니다.

현재 중단 원인:
- auto-cycle-full의 review-gate에서 stale_review_required_file_missing 발생
- 출력상 missingRequiredFiles와 changedFiles가 모두 scripts/ai-dev-auto-cycle-full.ps1로 동일하다.
- 즉, required_changes가 요구한 파일이 실제 diff에 있는데도 missing으로 판정했다.

수정 요구사항:
1. scripts/ai-dev-auto-cycle-full.ps1만 수정한다.
2. review required file 목록과 changed file 목록 비교 전에 경로를 동일한 방식으로 정규화한다.
3. 비교 기준은 다음을 만족해야 한다.
   - 역슬래시와 슬래시 차이를 무시한다.
   - 앞의 ./ 차이를 무시한다.
   - 대소문자 차이를 Windows 기준으로 안전하게 처리한다.
   - 줄바꿈, 공백, 따옴표, 쉼표 등 리뷰 JSON 파싱 흔적을 제거한다.
4. required file이 changed file에 실제 포함되어 있으면 stale_review_required_file_missing으로 중단하지 않는다.
5. changedFiles와 missingRequiredFiles가 같은 경로인데도 missing 처리되는 현재 버그를 수정한다.
6. implementation task의 기존 required_changes 안전장치는 유지한다.
7. verification revise 자동 처리 흐름은 유지한다.
8. complete_task/pass 경로의 검증 안전장치는 약화하지 않는다.
9. package.json/package-lock.json 보호 정책은 변경하지 않는다.
10. 앱 src 파일은 수정하지 않는다.
11. npm run build와 npm run lint가 통과해야 한다.
12. 변경 의도를 .ai-dev/test-result.md 또는 codex-result에 명확히 남긴다.

핵심 의도:
- required_changes.file 과 git diff changed files가 같은 파일을 가리키면 누락으로 판단하지 않는다.
- stale review 방지 기능은 유지하되, 정상 변경 파일을 오탐하지 않게 한다.

You are preparing local AI Dev Loop state files for the repository at D:\ai-apps\planpilot-local.

Return exactly one JSON object and no markdown fences or commentary.

The user supplied this new goal:
Title: AI Software Company 무인 개발을 위한 commit 및 비구현 task 자동화 보강
Description: AI Software Company GUI와 Supervisor 구축 전에 사람이 개입하게 만드는 두 가지 자동화 결함을 제거한다.

첫째, scripts/ai-dev-commit.ps1과 scripts/ai-dev-auto-cycle-full.ps1의 -Files 처리에서 .ai-company/, .ai-company/reports/, ai-software-company/ 같은 디렉터리 경로가 전달되면 해당 경로 아래 실제 변경 파일 목록으로 안전하게 확장해야 한다. 선택 디렉터리 내부 파일을 '선택 파일 외 staged 파일'로 잘못 판정하지 않아야 한다. 디렉터리 밖에 staged 파일이 존재하면 기존처럼 차단한다. 파일 경로와 디렉터리 경로 혼합 입력, 신규 untracked 파일, 수정 파일, 삭제 파일을 모두 지원한다. Git pathspec 의미를 무분별하게 확장하지 말고 repo root 밖 경로와 .. traversal을 차단한다. commit 대상이 비어 있으면 기존 안전 실패를 유지한다.

둘째, documentation, analysis, verification 등 implementation이 아닌 task에서도 strict review가 decision=revise, next_step=revise_with_codex를 반환하면 required_changes가 명확하고 허용된 파일 범위 안일 때 Codex 자동 재수정을 최대 1회 수행하고 재검증/재리뷰할 수 있게 한다. documentation task는 BuildOnly 검증 정책을 유지할 수 있으며 npm test skipped 자체를 실패로 보지 않는다. implementation task의 전체 build/test/lint 정책은 유지한다. 비구현 task의 revise가 무한 반복되지 않도록 task별 recovery 횟수를 기록하고 두 번째 revise는 명확한 stopped reason으로 중단한다.

scripts/ai-dev-test.ps1에 실제 임시 Git 저장소/worktree 기반 테스트를 추가한다.

필수 테스트:
- -Files .ai-company/ 로 여러 파일 commit 성공
- -Files .ai-company/reports/ 로 하위 문서 commit 성공
- 디렉터리 내부 untracked 파일 포함
- 디렉터리 내부 삭제 파일 포함
- 디렉터리 밖 staged 파일 존재 시 차단
- 파일+디렉터리 혼합 scope 정상 처리
- repo 외부 및 traversal 경로 차단
- documentation review revise → Codex 1회 수정 → review pass → commit/complete
- documentation revise 두 번 → 추가 Codex 실행 없이 중단
- documentation BuildOnly에서 npm test skipped 허용
- implementation task의 전체 test 정책은 변하지 않음
- 기존 package/baseline/expected_non_work/recovery 안전장치 유지

기존 테스트를 삭제하거나 약화하지 않는다.
PowerShell 5.1과 UTF-8 호환성을 유지한다.
최종적으로 build, 전체 npm test, lint가 모두 통과하고 strict review pass가 되어야 한다.

Create a small, safe goal plan for this repository. The response object must have these fields:
- goalMarkdown: .ai-dev/goal.md에 작성할 마크다운 문자열입니다. "# 목표", "배경", "성공 기준", "제약사항", "범위 제외", "수동 검증" 섹션을 한국어로 포함해야 합니다.
- queue: an object for .ai-dev/queue.json.
- state: an object for .ai-dev/state.json.

queue rules:
- goalTitle must equal the supplied title.
- goalSource must be ".ai-dev/goal.md".
- createdAt and updatedAt are required and must be ISO 8601 strings.
- currentTaskId must be "T001".
- tasks must contain one to three tasks.
- T001 must be status "in_progress"; later tasks, if any, must be "pending".
- each task must include id, title, description, type, status, priority, dependsOn, filesLikelyToChange, verification, commitMessage.
- type must be one of analysis, implementation, documentation, verification.
- priority must be P0, P1, or P2.
- dependsOn, filesLikelyToChange, and verification must be arrays.
- commitMessage must be null or a short English commit message.

state rules:
- goalStatus must be "in_progress".
- currentTaskId must be "T001".
- currentLoop must be 0.
- maxLoopsPerTask must be 2.
- repeatedFailureCount must be 0.
- lastCommand must be null.
- lastCommandStatus must be "not_started".
- lastErrorSummary must be null.
- lastReviewDecision must be "not_started".
- lastReviewSeverity must be null.
- lastCommitHash must be null.
- startedAt and updatedAt must be ISO 8601 strings.
- stopReason must be null.

Safety rules:
- Do not mention server APIs, login, cloud sync, npm install, git reset, git clean, git push, DB deletion, or broad rewrites as implementation steps.
- Prefer one small implementation task when the goal is small.
- Use Korean for user-facing task titles, descriptions, verification, and goalMarkdown.
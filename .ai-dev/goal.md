# 목표
AI Software Company 무인 개발 흐름에서 사람이 개입하게 만드는 commit scope 처리와 비구현 task revise 자동화를 보강한다.

## 배경
현재 자동 commit 스크립트는 디렉터리 경로가 -Files로 전달될 때 해당 디렉터리 아래의 실제 변경 파일 범위를 안정적으로 해석하지 못할 수 있다. 또한 documentation, analysis, verification task에서 strict review가 revise를 요구하는 경우 허용 범위 안의 명확한 수정임에도 자동 복구가 끊길 수 있다.

## 성공 기준
- -Files에 .ai-company/, .ai-company/reports/, ai-software-company/ 같은 디렉터리 경로가 전달되면 해당 디렉터리 아래 변경 파일로 안전하게 확장된다.
- 파일 경로와 디렉터리 경로 혼합 입력, untracked 파일, 수정 파일, 삭제 파일이 정상 처리된다.
- 선택 디렉터리 내부 변경은 선택 파일 외 staged 파일로 오판하지 않는다.
- 선택 범위 밖 staged 파일은 기존처럼 차단한다.
- repo root 밖 경로와 .. traversal 경로는 차단된다.
- 비구현 task에서 strict review가 revise를 요구하면 조건이 명확하고 파일 범위가 허용될 때 Codex 자동 재수정을 최대 1회 수행한다.
- 비구현 task의 두 번째 revise는 추가 자동 수정 없이 명확한 stopped reason으로 중단된다.
- documentation task의 BuildOnly 검증 정책에서 npm test skipped는 실패로 보지 않는다.
- implementation task의 기존 build/test/lint 정책은 유지된다.
- scripts/ai-dev-test.ps1에 실제 임시 Git 저장소 또는 worktree 기반 테스트가 추가되고 기존 안전장치는 약화되지 않는다.
- 최종 검증에서 build, 전체 npm test, lint, strict review가 통과한다.

## 제약사항
- PowerShell 5.1 호환성을 유지한다.
- UTF-8 호환성을 유지한다.
- 기존 테스트를 삭제하거나 약화하지 않는다.
- Git pathspec 의미를 무분별하게 확장하지 않는다.
- 한 번에 필요한 범위의 스크립트와 테스트만 수정한다.

## 범위 제외
- GUI 또는 Supervisor 신규 구현은 포함하지 않는다.
- 데이터 저장 구조 변경은 포함하지 않는다.
- 알림, 동기화, 인증 관련 기능은 포함하지 않는다.
- 대규모 구조 재작성은 포함하지 않는다.

## 수동 검증
- scripts/ai-dev-test.ps1 실행 결과를 확인한다.
- build, 전체 npm test, lint 결과를 확인한다.
- strict review 결과가 pass인지 확인한다.
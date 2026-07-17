# 목표

Autopilot DryRun 실행 후 `.ai-dev/codex-result.md`가 dirty로 남지 않도록 수정한다.

## 배경

현재 다음 DryRun 명령 실행 후 `.ai-dev/codex-result.md`가 수정된 상태로 남는다.

`powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRun -Json -MaxGoals 2 -MaxTasks 3`

DryRun은 실제 실행이 아니므로 운영 산출물을 포함해 어떤 파일도 변경하지 않아야 한다. 단, `-Json` 출력은 기존처럼 유지되어야 한다.

## 성공 기준

- DryRun 실행 중 `.ai-dev/codex-result.md`를 포함한 어떤 파일도 수정되지 않는다.
- DryRun `-Json` 출력은 유지된다.
- auto-goal DryRun 내부 호출 결과가 운영 산출물 파일에 저장되지 않는다.
- 실제 실행 모드의 Codex 결과 저장 동작은 유지된다.
- 동일 DryRun 명령 실행 후 `git status --short` 결과가 비어 있다.
- 앱 `src` 파일은 수정하지 않는다.
- 허용된 검증에서 build/lint를 통과한다.

## 제약사항

- 변경 범위는 Autopilot DryRun과 Codex 결과 저장 흐름에 한정한다.
- 앱 `src` 파일은 수정하지 않는다.
- DryRun과 실제 실행 모드의 동작 차이를 명확히 유지한다.
- 불필요한 구조 변경이나 대규모 재작성은 하지 않는다.

## 범위 제외

- UI 변경
- 앱 기능 변경
- 데이터 저장 구조 변경
- Autopilot 전체 동작 재설계

## 수동 검증

- `powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-autopilot.ps1 -DryRun -Json -MaxGoals 2 -MaxTasks 3` 실행
- 실행 후 `git status --short`가 비어 있는지 확인
- 실제 실행 모드에서 Codex 결과 저장 동작이 유지되는지 관련 경로 확인
- 허용된 경우 build/lint 실행
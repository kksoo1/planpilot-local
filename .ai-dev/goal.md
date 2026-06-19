# 목표
AI Dev Loop의 전체 자동 사이클 스크립트가 리뷰 결과 `decision=revise`, `next_step=revise_with_codex` 상태에서 멈추지 않고 제한된 범위의 자동 수정 루프를 수행하도록 보강한다.

## 배경
현재 `ai-dev-auto-cycle-full.ps1`는 리뷰가 수정 요청 상태로 끝나는 경우 후속 revise 흐름을 자동으로 이어가지 못한다. 저장된 리뷰 결과를 기반으로 revise prompt 생성, Codex 수정, 검증, diff 기록, 리뷰 재실행까지 한 번의 사이클 안에서 처리해야 한다.

## 성공 기준
- 리뷰 결과가 `revise` 및 `revise_with_codex`인 경우 자동 revise 흐름이 실행된다.
- revise 후 build/lint 검증 결과가 `.ai-dev/test-result.md`에 기록된다.
- 검증 후 diff가 저장되고 리뷰가 재실행된다.
- 리뷰가 `pass`로 바뀌면 기존 pass 처리 흐름이 유지된다.
- 리뷰가 계속 `revise`이면 최신 사유를 남기고 명확히 중단한다.
- 기존 pass 처리, completed final clean, DryRun 동작은 깨지지 않는다.

## 제약사항
- 앱 `src` 파일은 변경하지 않는다.
- 변경 범위는 AI Dev Loop 관련 스크립트와 `.ai-dev` 메타 파일로 제한한다.
- 기존 동작을 대체하기보다 현재 흐름에 revise 분기만 작게 추가한다.
- 검증 명령 실행 여부와 결과는 명확히 기록한다.

## 범위 제외
- 앱 기능 변경 및 UI 변경은 포함하지 않는다.
- 저장소 구조의 대규모 재작성은 포함하지 않는다.
- 새로운 외부 의존성 추가는 포함하지 않는다.

## 수동 검증
- DryRun 모드에서 revise 분기가 실제 수정 실행 없이 의도한 단계만 출력되는지 확인한다.
- 저장된 리뷰 결과가 revise인 샘플 상태에서 revise prompt 생성, 검증 기록, diff 저장, 리뷰 재실행 흐름을 확인한다.
- pass 리뷰 결과에서는 기존 완료 흐름이 유지되는지 확인한다.
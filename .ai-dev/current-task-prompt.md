# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

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

## Current Task

- Task ID: T001
- Title: review revise 자동 재시도 흐름 보강
- Description: `ai-dev-auto-cycle-full.ps1`의 저장된 리뷰 결과 처리 흐름에 revise 분기를 추가해 prompt 생성, Codex 수정, 검증 기록, diff 저장, 리뷰 재실행까지 제한된 자동 루프를 수행하도록 구현한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/state.json
- ai-dev-auto-cycle-full.ps1
- .ai-dev/test-result.md

## Verification

- DryRun 모드에서 revise 분기 단계가 안전하게 표시되는지 확인
- revise 결과 상태에서 `.ai-dev/test-result.md`에 검증 기록이 남는지 확인
- pass 결과 상태에서 기존 완료 흐름이 유지되는지 확인

- 필요한 경우 `npm run build`는 사람이 별도로 실행한다.
- 이 프롬프트는 자동으로 build, test, lint를 실행하라고 지시하지 않는다.

## Required Output

- 변경한 파일 목록
- 구현 또는 분석 내용 요약
- 검증 방법
- 남은 위험
- 다음 task로 넘어가도 되는지 여부
- `.ai-dev/loop-log.md`에 기록할 작업 요약

## Hard Rules

- `src` 외 파일을 수정해야 하는 경우 이유를 기록한다.
- `package.json`과 `package-lock.json`은 수정하지 않는다. 꼭 필요하면 중단하고 이유만 기록한다.
- 실제 DB 삭제 또는 초기화를 하지 않는다.
- 사용자 데이터 복원 또는 덮어쓰기를 하지 않는다.
- 현재 task와 무관한 UI 전면 개편을 하지 않는다.
- 대규모 리팩터링을 하지 않는다.
- git commit을 실행하지 않는다.
- git reset, git checkout, git clean을 실행하지 않는다.
- npm install을 실행하지 않는다.

## Stop Conditions

- 요구사항이 충돌하는 경우
- 현재 task 범위 밖 수정이 필요한 경우
- 패키지 추가가 필요한 경우
- 데이터 삭제 또는 마이그레이션이 필요한 경우
- 같은 오류가 반복되는 경우
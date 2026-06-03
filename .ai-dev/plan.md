# AI Dev Plan

## Goal

AI Dev Loop 운영 품질 개선 및 자동화 준비

## 목표 범위

- `.ai-dev` 실행 산출물의 커밋/무시 기준을 먼저 문서화한다.
- diff 생성, untracked 텍스트 파일 처리, 선택 커밋, 추가 지시 분리, already-satisfied task 처리 기준을 작은 task로 개선한다.
- 완전 자동화된 auto-step/auto-cycle 구현 전 운영 안정성을 높인다.

## 범위 제한

- 앱 기능과 `src` 코드는 수정하지 않는다.
- `package.json`, `package-lock.json`은 수정하지 않는다.
- GPT API 호출, 자동 push, 완전 자동 실행은 구현하지 않는다.
- 각 task는 현재 범위만 수행하고 task 단위로 검증한다.

## 작업 순서

### T001 `.ai-dev` 실행 산출물 커밋/무시 정책 정리

- 기능 변경과 루프 운영 상태 변경의 커밋 경계를 문서화한다.
- 민감하거나 거대한 산출물을 항상 커밋하지 않도록 기준을 정한다.

### T002 save-diff 기본 동작 개선

- 신규 untracked 텍스트 파일을 리뷰 가능한 형태로 포함한다.
- `diff.md`, `review-prompt.md` 등 실행 산출물의 자기 중첩을 제한한다.

### T003 선택 파일 커밋 옵션 추가

- 기존 기본 동작과 호환성을 유지하면서 지정 파일만 stage/commit할 수 있게 한다.
- DryRun에서 실제 대상 파일을 확인할 수 있어야 한다.

### T004 추가 지시 별도 파일 지원

- `current-task-prompt.md`를 직접 수정하지 않고 별도 추가 지시 파일을 합칠 수 있게 한다.
- goal과 queue 원본 내용은 유지한다.

### T005 already-satisfied task 처리 정책 추가

- 이전 task에서 요구사항이 이미 충족된 경우 코드 수정 없이 완료 처리할 기준을 정한다.
- 확인 내용, 검증 방법, 미수정 이유를 기록하도록 한다.

### T006 최종 검증 및 요약

- 수정된 PowerShell 스크립트의 문법을 검증한다.
- 전체 diff를 리뷰하고 auto-step/auto-cycle 구현 준비 여부를 정리한다.

## Stop Conditions

- 앱 기능 또는 `src` 코드 수정이 필요해지는 경우
- package 변경이나 새 의존성이 필요한 경우
- 기존 AI Dev Loop 상태 판단 로직을 대규모로 재작성해야 하는 경우
- 민감 정보가 실행 산출물에 포함될 위험이 해결되지 않은 경우

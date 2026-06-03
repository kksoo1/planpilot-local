# Goal

AI Dev Loop 운영 품질 개선 및 자동화 준비

## Background

AI Dev Loop를 더 안정적으로 운영하기 위해 diff 생성, 리뷰 프롬프트 크기, untracked 파일 처리, 선택 커밋, 추가 지시 분리, already-satisfied task 처리 기준을 개선한다.

이번 목표는 완전 자동화를 바로 구현하기 전 운영 품질을 높이는 준비 단계다. 앱 기능, `src` 코드, package 설정은 변경하지 않는다.

## Success Criteria

- `.ai-dev` 실행 산출물과 커밋 대상 정책이 문서화된다.
- `ai-dev-save-diff.ps1` 개선 방향이 task로 정리된다.
- untracked 텍스트 파일 내용 포함 정책이 task로 정리된다.
- `ai-dev-commit.ps1`에 선택 파일 커밋 옵션을 추가하는 task가 정리된다.
- `current-task-prompt.md`를 직접 수정하지 않고 추가 지시를 별도 파일로 관리하는 task가 정리된다.
- 이미 요구사항을 충족한 task를 코드 수정 없이 완료 처리하는 기준이 정리된다.
- 최종 검증 task가 포함된다.

## Constraints

- 이번 목표는 AI Dev Loop 스크립트와 운영 정책 개선에 한정한다.
- 한 번에 하나의 task만 수행하고 task 단위로 검증한다.
- scripts 코드는 각 구현 task에서만 수정한다.
- `src` 코드는 수정하지 않는다.
- `package.json`, `package-lock.json`은 수정하지 않는다.
- 앱 데이터, DB schema, 사용자 기능을 변경하지 않는다.
- 완전 자동 실행, GPT API 호출, 자동 push는 구현하지 않는다.

## Out of Scope

- 앱 기능 추가 또는 UI 변경
- `src` 코드 리팩터링
- package 추가 또는 교체
- 완전 자동화된 auto-step/auto-cycle 구현
- GPT API 직접 호출
- 자동 push 또는 PR 생성

## Manual Verification

- 운영 산출물 커밋/무시 정책이 문서에서 명확히 구분된다.
- untracked 텍스트 파일이 리뷰 가능한 diff에 포함되는지 확인한다.
- diff/review 산출물이 자기 자신을 과도하게 중첩하지 않는지 확인한다.
- 선택 파일 커밋 옵션의 DryRun과 기본 호환성을 확인한다.
- 추가 지시 파일이 task 프롬프트에 별도 섹션으로 포함되는지 확인한다.
- already-satisfied task를 코드 수정 없이 완료 처리할 때 필요한 기록이 남는지 확인한다.
- 수정된 PowerShell 스크립트가 문법 오류 없이 파싱되는지 확인한다.

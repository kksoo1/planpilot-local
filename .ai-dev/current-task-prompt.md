# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표

build/check 실패 후 revise 흐름 자동 안내를 추가한다.

## 배경

현재 full auto-cycle은 build/check 실패 시 중단되지만, 이후 사용자가 어떤 파일을 확인하고 어떤 revise 흐름으로 이어가야 하는지 안내가 충분히 명확하지 않다. 실패 원인을 확인한 뒤 재수정 프롬프트 생성 또는 Codex 재수정 실행으로 이어질 수 있는 다음 행동을 작고 안전하게 안내해야 한다.

## 성공 기준

- build/check 실패 상태에서 다음 행동 안내가 revise 흐름을 명확히 제안한다.
- 안내에는 `.ai-dev/test-result.md` 확인과 필요한 재수정 프롬프트 생성 흐름이 포함된다.
- 기존 pass, review revise, commit, complete-task 흐름은 변경하지 않는다.
- 자동으로 위험한 명령을 실행하지 않고 추천 명령만 제공한다.

## 제약사항

- 한 번에 하나의 작은 구현 변경만 수행한다.
- 기존 자동화 스크립트 구조를 우선 사용한다.
- 사용자-facing 안내 문구는 한국어로 작성한다.
- 서버 API, 로그인, 클라우드 동기화, 대규모 재작성은 포함하지 않는다.
- 검증 명령은 사용자가 허용한 경우에만 실행한다.

## 범위 제외

- 실제 build/check 재실행 자동화 확대는 제외한다.
- 리뷰 JSON 포맷 변경은 제외한다.
- task queue schema 변경은 제외한다.
- 앱 화면 UI 변경은 제외한다.

## 수동 검증

- build/check 실패 상태를 가정한 `state.json` 값에서 `scripts/ai-dev-next.ps1 -Json` 출력의 action, reason, recommendedCommands, notes를 확인한다.
- pass 상태와 review revise 상태의 기존 다음 행동 안내가 유지되는지 확인한다.
- 사용자가 허용하면 관련 PowerShell 스크립트의 문법 또는 DryRun 검증을 실행한다.

## Current Task

- Task ID: T001
- Title: build/check 실패 후 revise 안내 추가
- Description: 현재 다음 행동 안내 스크립트의 실패 상태 판정 흐름을 확인하고, build/check 실패 상태에서 사용자가 `.ai-dev/test-result.md`를 확인한 뒤 revise 흐름으로 이어갈 수 있도록 한국어 안내와 추천 명령을 보강한다.
- Type: implementation
- Status: in_progress
- Priority: P1
- Depends on:
- 없음

## Task Scope

- 현재 task만 수행한다.
- 현재 task 범위를 벗어나는 리팩터링을 하지 않는다.
- 다음 task를 미리 구현하지 않는다.
- 현재 task의 완료 기준과 검증 방법을 먼저 확인한다.

## Likely Files

- scripts/ai-dev-next.ps1

## Verification

- build/check 실패 상태에서 다음 행동 안내가 test-result 확인과 revise 흐름을 제안하는지 확인한다.
- 기존 review revise 상태의 make_revise_prompt 안내가 유지되는지 확인한다.
- 사용자가 허용하면 관련 스크립트 DryRun 또는 문법 검증을 실행한다.

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
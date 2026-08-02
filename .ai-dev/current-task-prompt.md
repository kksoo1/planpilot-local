# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
AI Dev PowerShell UTF-8 출력 표준화

## 배경
Windows PowerShell 5.1에서 AI Dev 관련 PowerShell 스크립트와 하위 스크립트 실행 중 한글 출력이 깨지는 문제가 있다. 공통 UTF-8 초기화 방식을 적용해 콘솔 출력, PowerShell 출력, 파일 읽기와 쓰기, 자식 PowerShell 프로세스 및 npm 실행 결과 캡처에서 한글 메시지가 일관되게 보이도록 개선한다.

## 성공 기준
- `ai-dev-autopilot.ps1`, `ai-dev-auto-goal.ps1`, `ai-dev-auto-cycle-full.ps1` 및 관련 하위 스크립트에서 한글 출력이 깨지지 않는다.
- Console OutputEncoding과 PowerShell OutputEncoding이 PowerShell 5.1 호환 방식으로 UTF-8 처리된다.
- 파일 읽기와 쓰기 인코딩이 UTF-8 기준으로 일관되게 처리된다.
- 자식 powershell 프로세스와 npm 실행 결과를 캡처할 때 한글 메시지가 유지된다.
- 기존 영어 고정 토큰 `Stopped reason`, `Outcome category`, `expected_non_work`는 변경하지 않는다.
- 기존 build, test 20개, lint가 모두 통과한다.

## 제약사항
- PowerShell 5.1 호환성을 유지한다.
- UTF-8 적용을 위해 기존 사용자 파일 내용을 불필요하게 전체 재작성하지 않는다.
- 줄바꿈 형식을 대량 변경하지 않는다.
- 한 번에 변경 범위를 작게 유지하고, 기존 스크립트 구조를 우선 따른다.

## 범위 제외
- AI Dev 워크플로우 자체의 기능 변경은 포함하지 않는다.
- 출력 메시지의 의미 변경이나 영어 고정 토큰 변경은 포함하지 않는다.
- 관련 없는 파일 정리나 대규모 리팩터링은 포함하지 않는다.

## 수동 검증
- PowerShell 5.1에서 주요 AI Dev 스크립트를 실행해 한글 출력이 정상 표시되는지 확인한다.
- 자식 PowerShell 실행 결과와 npm 실행 결과 캡처 로그에서 한글이 깨지지 않는지 확인한다.
- 허용된 경우 build, test 20개, lint를 실행해 모두 통과하는지 확인한다.

## Current Task

- Task ID: T001
- Title: PowerShell UTF-8 처리 흐름 점검 및 최소 수정
- Description: AI Dev PowerShell 스크립트의 출력 인코딩 초기화, 파일 입출력 인코딩, 자식 PowerShell 및 npm 결과 캡처 흐름을 확인하고 PowerShell 5.1 호환 방식으로 필요한 최소 변경을 적용한다.
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

- .ai-dev/ai-dev-autopilot.ps1
- .ai-dev/ai-dev-auto-goal.ps1
- .ai-dev/ai-dev-auto-cycle-full.ps1

## Verification

- PowerShell 5.1에서 한글 출력이 깨지지 않는지 주요 스크립트 실행 결과를 확인한다.
- 자식 powershell 프로세스와 npm 실행 결과 캡처에서 한글 메시지가 유지되는지 확인한다.
- 기존 영어 고정 토큰 `Stopped reason`, `Outcome category`, `expected_non_work`가 유지되는지 확인한다.

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
# 목표
AI Dev Loop의 `auto-cycle-full` 완료 종료 경로에서 운영 산출물 변경을 최종 정리하도록 보강한다.

## 배경
기존 `in_progress` 목표를 이어 실행했을 때 모든 task가 `done`이 되어 `goalStatus`가 `completed`가 되었지만 `.ai-dev` 운영 산출물이 작업 트리에 남는 문제가 있다. 완료 상태 재실행 시에도 운영 산출물만 남아 있으면 최종 메타 커밋으로 정리되어야 한다.

## 성공 기준
- `ai-dev-auto-cycle-full.ps1`의 completed 종료 경로에서 남은 변경을 최종 분류한다.
- 남은 변경이 `.ai-dev` 운영 파일뿐이고 커밋 허용 옵션이 켜져 있으면 final meta commit을 생성한다.
- final meta commit 후 작업 트리 상태가 비어 있는지 검증한다.
- `.ai-dev` 외 변경이 남아 있거나 커밋 허용 옵션이 꺼져 있으면 completed 성공으로 종료하지 않고 실패로 처리한다.
- 이미 `goalStatus`가 `completed`인 상태에서 `.ai-dev` 운영 변경만 남아 있는 경우에도 재실행 시 최종 메타 커밋 후 정리된다.
- 앱 `src` 파일은 변경하지 않는다.
- build/lint 통과, 리뷰 pass, 구현 커밋, complete-task, `.ai-dev` 메타 커밋, 최종 작업 트리 정리 검증까지 완료한다.

## 제약사항
- 앱 `src` 파일은 변경하지 않는다.
- 한 번에 하나의 작은 구현 변경으로 제한한다.
- 기존 AI Dev Loop 상태 파일 형식과 스크립트 흐름을 유지한다.
- 사용자가 만든 변경 사항을 되돌리지 않는다.

## 범위 제외
- 앱 기능 변경
- IndexedDB 또는 데이터 모델 변경
- 대규모 스크립트 재작성
- 알림, 동기화, 인증 관련 기능

## 수동 검증
- 완료 상태에서 `.ai-dev` 운영 산출물만 남은 상황을 만든 뒤 `-AllowCommit` 옵션으로 재실행해 final meta commit이 생성되는지 확인한다.
- `.ai-dev` 외 변경이 남은 상황에서는 completed 성공으로 처리되지 않는지 확인한다.
- 최종 작업 트리 상태가 비어 있는지 확인한다.
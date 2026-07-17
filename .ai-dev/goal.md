# 목표

Verification task revise 자동 처리 문제를 수정한다.

## 배경

auto-cycle-full이 verification task에서 review decision=revise, next_step=revise_with_codex를 받는 경우, 실제로는 Codex 수정 루프로 이어져야 하지만 현재 non_implementation_revise로 중단되는 문제가 있다.

## 성공 기준

- verification task에서 revise_with_codex가 반환되어도 자동 수정 흐름이 중단되지 않는다.
- implementation task가 아닌 verification task에서도 의도된 수정 경로가 선택된다.
- 기존 중단 조건은 필요한 경우에만 유지된다.
- 변경 범위는 자동 루프의 분기 처리에 한정된다.

## 제약사항

- 기존 작업 큐와 상태 파일 형식을 유지한다.
- 현재 자동 루프의 기존 decision 및 next_step 의미를 보존한다.
- 불필요한 구조 변경은 하지 않는다.
- 한 번에 하나의 작은 수정으로 처리한다.

## 범위 제외

- 자동 루프 전체 구조 재설계
- 새로운 작업 유형 추가
- UI 변경
- 저장소 구조 변경

## 수동 검증

- verification task에서 review decision=revise, next_step=revise_with_codex가 발생하는 흐름을 재현한다.
- 해당 흐름이 non_implementation_revise로 중단되지 않는지 확인한다.
- 정상적인 중단 조건이 기존처럼 동작하는지 확인한다.
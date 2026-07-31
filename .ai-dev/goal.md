# 목표

auto-goal 실행 시 `ai-dev-auto-goal.ps1`이 full-cycle을 안정적으로 호출할 수 있도록 MaxSteps 기본값 및 전달 흐름을 정리한다.

## 배경

현재 auto-goal 흐름에서 내부적으로 `ai-dev-auto-cycle-full.ps1`을 호출할 때 전달되는 MaxSteps 값이 full-cycle의 최소 요구 단계보다 작아 `max_steps_too_small_for_full_cycle`로 중단될 수 있다. 이로 인해 auto-goal이 생성한 task가 별도 수동 재실행 없이 full-cycle까지 이어지지 못한다.

## 성공 기준

- `ai-dev-auto-goal.ps1`의 기본 MaxSteps가 full-cycle 최소 요구 단계보다 작지 않다.
- 사용자가 MaxSteps를 지정한 경우 full-cycle 호출 시 의도한 값이 안전하게 반영된다.
- 기존 `AllowCodex`, `AllowReviewCodex`, `AllowCommit`, `AllowDirty` 전달 흐름은 유지된다.
- auto-goal이 생성한 task가 기본 설정으로 full-cycle 단계까지 진행 가능하다.

## 제약사항

- 변경 범위는 auto-goal과 full-cycle 호출부 확인 및 최소 수정으로 제한한다.
- 기존 플래그 전달 방식은 유지한다.
- 관련 PowerShell 스크립트의 현재 구조를 우선 따른다.

## 범위 제외

- AI Dev Loop 전체 구조 재설계는 하지 않는다.
- unrelated 스크립트 동작 변경은 하지 않는다.
- UI나 앱 런타임 코드는 변경하지 않는다.

## 수동 검증

- `ai-dev-auto-goal.ps1`의 MaxSteps 기본값과 full-cycle 호출 인자를 확인한다.
- 기본 MaxSteps가 full-cycle 최소 요구 단계 이상인지 확인한다.
- 사용자가 MaxSteps를 지정했을 때 해당 값이 full-cycle 호출에 반영되는지 확인한다.
- 기존 허용 플래그들이 기존 이름과 의미로 전달되는지 확인한다.

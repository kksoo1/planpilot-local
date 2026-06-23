# 목표
AI Dev Loop에서 구현 없는 revise 반복을 실패로 중단하도록 자동화 검증을 보강한다.

## 배경
현재 자동 실행 중 현재 task가 implementation이 아니거나 실제 구현 대상 파일 변경이 없는데도 review decision=revise가 반복될 수 있다. 또한 review-response.json이 특정 구현 파일 수정을 요구했지만 diff에 해당 파일 변경이 없으면 이전 리뷰 결과를 다시 소비하거나 구현 누락을 놓칠 위험이 있다.

## 성공 기준
- auto-goal 또는 auto-cycle 흐름에서 implementation task가 아닌 상태의 revise 반복을 성공 처리하지 않는다.
- review-response.json이 요구한 구현 파일 변경이 현재 diff에 없으면 stale review 또는 missing implementation으로 판정한다.
- 위 판정 시 후속 완료 처리와 목표 완료 처리를 막고 명확한 실패 사유를 남긴다.
- 자동화 스크립트 변경만으로 동작을 보강한다.
- 빌드와 린트가 통과하고 리뷰가 pass 상태가 된다.

## 제약사항
- 이 목표는 implementation task 1개로만 처리한다.
- 앱 src 파일은 변경하지 않는다.
- 필요한 자동화 스크립트만 최소 범위로 수정한다.
- 기존 상태 파일 형식과 자동화 흐름을 최대한 유지한다.

## 범위 제외
- 앱 기능, 화면, 저장소 구조 변경은 제외한다.
- 분석 전용 task나 문서 전용 task를 별도로 만들지 않는다.
- 자동화 흐름 전체 재작성은 제외한다.

## 수동 검증
- review-response.json이 구현 파일 변경을 요구하지만 diff에 해당 파일이 없는 상황을 확인한다.
- implementation이 아닌 task에서 revise가 반복되는 상황을 확인한다.
- 두 상황 모두 성공이나 완료로 진행되지 않고 실패 사유가 기록되는지 확인한다.
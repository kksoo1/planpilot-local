# 목표

AI Dev Loop 자동 사이클에서 lint 검증 결과를 자동으로 기록하도록 개선한다.

## 배경

현재 strict 리뷰에서 lint 실행 여부가 명확히 기록되지 않으면 `lint skipped`로 판단되어 반려될 수 있다. `npm run lint` 스크립트가 존재하는 경우 BuildOnly 검증과 별개로 lint를 실행하거나 그 결과를 `test-result.md`에 남겨 리뷰 기준을 만족해야 한다. 또한 `package.json`에 test 스크립트가 없는 경우에는 테스트를 실행하지 않은 사유를 명확히 기록해야 한다.

## 성공 기준

- `package.json`에 lint 스크립트가 있으면 AI Dev Loop 검증 기록에 lint 결과가 포함된다.
- BuildOnly 검증과 lint 검증 기록이 구분되어 남는다.
- test 스크립트가 없으면 `test-result.md`에 test 미실행 사유가 명확히 기록된다.
- strict 리뷰에서 lint 미기록으로 반려되지 않는다.

## 제약사항

- 기존 AI Dev Loop 흐름을 크게 바꾸지 않는다.
- 검증 기록 생성 로직의 변경 범위를 작게 유지한다.
- 사용자 변경 사항을 되돌리지 않는다.
- 기존 프로젝트 구조와 TypeScript 스타일을 따른다.

## 범위 제외

- 새로운 테스트 프레임워크 추가는 제외한다.
- 대규모 구조 재작성은 제외한다.
- UI 변경은 제외한다.

## 수동 검증

- lint 스크립트가 있는 상태에서 자동 사이클 결과 파일에 lint 결과가 기록되는지 확인한다.
- test 스크립트가 없는 상태에서 `test-result.md`에 미실행 사유가 기록되는지 확인한다.
- 기존 BuildOnly 검증 기록이 유지되는지 확인한다.

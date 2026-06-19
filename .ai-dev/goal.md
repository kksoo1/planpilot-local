# 목표

AI Dev Loop 운영 기준을 `docs/ai-dev-loop-operation.md`에 짧게 보강한다.

## 배경

Goal 입력 후 자동 계획부터 최종 작업 완료 확인까지 이어지는 운영 순서를 문서에 명확히 남긴다.

## 성공 기준

- `docs/ai-dev-loop-operation.md`에 운영 완료 순서가 3~5줄로 추가 또는 보강된다.
- 포함 순서: Goal 입력 후 자동 계획, Codex 구현, build/lint 검증, 리뷰 pass, 구현 커밋, complete-task, `.ai-dev` 메타 커밋, 최종 git clean 확인.
- 기존 문서 흐름을 해치지 않고 짧고 명확한 한국어 문장으로 정리된다.

## 제약사항

- 앱 기능 로직, UI, `src` 파일은 변경하지 않는다.
- `.ai-dev/README.md`는 변경하지 않는다.
- 변경 범위는 문서 보강에 한정한다.

## 범위 제외

- 앱 기능 추가 또는 수정.
- UI 문구 변경.
- 데이터 구조나 저장 로직 변경.

## 수동 검증

- `docs/ai-dev-loop-operation.md` 변경 내용을 읽어 운영 순서가 누락 없이 포함되었는지 확인한다.
- 변경 파일이 문서 파일로만 제한되는지 확인한다.
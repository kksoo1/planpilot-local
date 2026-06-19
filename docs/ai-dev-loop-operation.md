# AI Dev Loop 운영 순서

Goal을 입력하면 AI Dev Loop가 자동으로 계획을 세우고, Codex가 현재 task 범위 안에서 구현한다.
구현 후에는 필요한 build/lint 검증을 통과시키고, 리뷰 pass 상태를 확인한다.
리뷰 pass 후 구현 변경을 커밋하고, `complete-task`를 실행해 task 완료 메타데이터를 갱신한다.
마지막으로 `.ai-dev` 메타 변경을 별도 커밋한 뒤 최종 `git clean` 상태를 확인한다.

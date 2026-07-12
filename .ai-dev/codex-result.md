# Codex Implementation Result

## Run

- Started at: 2026-07-12 21:57:12
- Ended at: 2026-07-12 21:58:44
- Exit code: 0
- Prompt: .ai-dev/current-task-prompt.md
- Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-run-codex.ps1 -AllowDirty

## Output

```text
node.exe : OpenAI Codex v0.133.0
At C:\Users\SECUI\AppData\Roaming\npm\codex.ps1:24 char:5
+     & "node$exe"  "$basedir/node_modules/@openai/codex/bin/codex.js"  ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (OpenAI Codex v0.133.0:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
--------
workdir: D:\ai-apps\planpilot-local
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, $TMPDIR]
reasoning effort: medium
reasoning summaries: none
session id: 019f5667-3804-7f00-ba3c-1e4cd1cc8229
--------
user
Read and follow the full task prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-
dev\current-task-prompt.md

Additional safety rules for this local AI Dev Loop run:
- Do not run git commit, git reset, git checkout, git clean, git rebase, git merge, or git push.
- Do not run npm install.
- Do not modify package.json, package-lock.json, node_modules, dist, or .git.
- Do not broaden the current task scope beyond the prompt file.
- If the task requirements conflict with repository rules, stop and report the conflict.
codex
작업 프롬프트 파일만 먼저 읽어서 요구 범위와 저장소 규칙 충돌 여부를 확인하겠습니다. 이후 필요한 파일을 최소 범위로 열어 변경하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath .ai-dev\\current-task-prompt.md" in D:\ai-apps\planpilot-local
 succeeded in 1853ms:
# Current Task Prompt

## Role

너는 이 저장소의 자동 개발 에이전트다.

## Goal

# 목표
Codex CLI 완전 자동화 정책을 현재 로컬 프로젝트 운영 방식에 맞춰 문서화한다.

## 배경
PlanPilot Local은 로컬 우선 React + Vite + TypeScript 앱이며, AI Dev Loop가 반복 작업을 수행할 때 따라야 할 자동화 범위와 중단
 기준이 명확해야 한다. 이번 목표는 P0 백로그 항목인 Codex CLI 완전 자동화 정책 문서화를 가장 작은 실행 단위로 정리하는 것이다.

## 성공 기준
- Codex CLI 자동화가 수행할 수 있는 작업 범위가 한국어로 명확히 문서화된다.
- 자동화 중 사용자 확인이 필요한 상황과 중단 기준이 포함된다.
- 저장소의 기존 제약사항과 로컬 우선 원칙을 벗어나지 않는다.
- 문서는 작고 독립적인 변경으로 작성된다.

## 제약사항
- 한 번에 하나의 문서화 작업만 진행한다.
- 기존 앱 구조나 런타임 동작은 변경하지 않는다.
- 사용자-facing 문구는 한국어로 작성한다.
- 자동화 정책은 현재 저장소의 로컬 개발 흐름을 기준으로 작성한다.

## 범위 제외
- 앱 기능 구현은 포함하지 않는다.
- 화면 UI 변경은 포함하지 않는다.
- 데이터 스키마 변경은 포함하지 않는다.
- 배포 자동화 구현은 포함하지 않는다.

## 수동 검증
- 작성된 문서를 읽고 자동화 허용 범위, 중단 기준, 사용자 확인 지점이 이해 가능한지 확인한다.
- 문서 내용이 현재 프로젝트 규칙과 충돌하지 않는지 확인한다.

## Current Task

- Task ID: T001
- Title: Codex CLI 자동화 정책 문서 초안 작성
- Description: 현재 저장소의 로컬 개발 규칙을 기준으로 Codex CLI가 자동으로 진행할 수 있는 범위, 사용자 확인이 필요한 상황, 중단 기준을 작고 명확한
 문서로 정리한다.
- Type: documentation
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

- docs/codex-cli-automation-policy.md

## Verification

- 문서에 자동화 범위가 한국어로 정리되어 있는지 확인한다.
- 사용자 확인이 필요한 상황과 중단 기준이 포함되어 있는지 확인한다.
- 현재 프로젝트 제약사항과 충돌하는 내용이 없는지 확인한다.

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

codex
프롬프트상 작업은 문서 1개 작성이고 앱 동작 변경은 없습니다. `src` 밖의 `docs` 파일 수정이 필요하지만, 프롬프트의 Likely Files가 `docs/code
x-cli-automation-policy.md`로 지정되어 있어 이 범위 안에서만 진행하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command 'if (Test-Path -Litera
lPath docs) { Get-ChildItem -LiteralPath docs -File | Select-Object -ExpandProperty Name }' in D
:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "if (Test-Path -Litera
lPath docs\\codex-cli-automation-policy.md) { Get-Content -LiteralPath docs\\codex-cli-automatio
n-policy.md }" in D:\ai-apps\planpilot-local
 succeeded in 2281ms:
 succeeded in 2355ms:
ai-dev-loop-operation.md
ai-dev-loop-policy.md
data-backup-export-policy.md
data-import-restore-policy.md
error-loading-state-policy.md
manual-regression-test-result.md
manual-test-checklist.md

codex
기존 정책 문서의 톤과 구조를 맞추기 위해 관련 AI Dev Loop 문서만 확인하겠습니다. 새 문서는 같은 `docs` 폴더 안에 작고 독립적인 정책 초안으로 추가합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath docs\\ai-dev-loop-policy.md" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath docs\\ai-dev-loop-operation.md" in D:\ai-apps\planpilot-local
 succeeded in 2136ms:
# AI Dev Loop ?댁쁺 ?쒖꽌

Goal???낅젰?섎㈃ AI Dev Loop媛 ?먮룞?쇰줈 怨꾪쉷???몄슦怨? Codex媛 ?꾩옱 task 踰붿쐞 ?덉뿉??援ы쁽?쒕떎.
援ы쁽 ?꾩뿉???꾩슂??build/lint 寃利앹쓣 ?듦낵?쒗궎怨? 由щ럭 pass ?곹깭瑜??뺤씤?쒕떎.
由щ럭 pass ??援ы쁽 蹂寃쎌쓣 而ㅻ컠?섍퀬, `complete-task`瑜??ㅽ뻾??task ?꾨즺 硫뷀??곗씠?곕? 媛깆떊?쒕떎.
留덉?留됱쑝濡?`.ai-dev` 硫뷀? 蹂寃쎌쓣 蹂꾨룄 而ㅻ컠????理쒖쥌 `git clean` ?곹깭瑜??뺤씤?쒕떎.

 succeeded in 2807ms:
# PlanPilot Local AI ?먮룞 媛쒕컻 猷⑦봽 ?뺤콉

??臾몄꽌???ъ슜?먭? 紐⑺몴瑜??낅젰?섎㈃ AI媛 ?묒뾽??遺꾪빐?섍퀬, 援ы쁽?섍퀬, 寃利앺븯怨? 由щ럭?섍퀬, ?묒뾽 ?⑥쐞濡??먮룞 而ㅻ컠?섎뒗 Level 5 
?먮룞 媛쒕컻 猷⑦봽??湲곗????뺣━?쒕떎.

?꾩옱 臾몄꽌???뺤콉 臾몄꽌?대ŉ, ?ㅼ젣 ?먮룞???ㅽ겕由쏀듃, ?ㅽ뻾湲? 媛먯떆 ?꾨줈?몄뒪, CI ?곕룞? 援ы쁽?섏? ?딅뒗??

## 紐⑹쟻

- ?ъ슜?먮뒗 援ы쁽 ?몃??ы빆蹂대떎 ?ъ꽦??紐⑺몴? ?곗꽑?쒖쐞瑜??낅젰?쒕떎.
- AI??紐⑺몴瑜??묒? ?묒뾽?쇰줈 遺꾪빐?섍퀬 ??踰덉뿉 ?섎굹???덉쟾?섍쾶 泥섎━?쒕떎.
- 媛??묒뾽? 援ы쁽, 寃利? 由щ럭, 而ㅻ컠 寃곌낵瑜??낅┰?곸쑝濡?異붿쟻?????덉뼱???쒕떎.
- ?먮룞?붽? ?μ떆媛??ㅽ뻾?섎뜑?쇰룄 ?꾩옱 ?묒뾽 踰붿쐞瑜?踰쀬뼱?섏? ?딆븘???쒕떎.
- ??μ냼??`AGENTS.md`, 蹂댁븞 ?뺤콉, 湲덉? ?ы빆, ?ъ슜??吏?쒕뒗 ?먮룞 媛쒕컻 猷⑦봽蹂대떎 ??긽 ?곗꽑?쒕떎.

## Level 5 ?먮룞 媛쒕컻 猷⑦봽 ?뺤쓽

Level 5 ?먮룞 媛쒕컻 猷⑦봽???ъ슜?먭? `.ai-dev/goal.md`??紐⑺몴瑜??묒꽦???? AI媛 ?ㅼ쓬 ?묒뾽???ㅼ뒪濡??좏깮?섍퀬 ?꾨즺 ?곹깭源뚯?
 吏꾪뻾?섎뒗 ?댁쁺 諛⑹떇?대떎.

AI媛 ?대떦?섎뒗 踰붿쐞:

- 紐⑺몴 遺꾩꽍
- ?묒뾽 遺꾪빐
- ?ㅽ뻾 ?쒖꽌 寃곗젙
- ?꾩옱 ?묒뾽 援ы쁽
- build, test, lint ?ㅽ뻾
- ?ㅽ뙣 ?먯씤 遺꾩꽍怨??덉슜 踰붿쐞 ???ъ닔??- GPT 湲곕컲 蹂寃?由щ럭
- 由щ럭 吏?곸궗??諛섏쁺
- ?먮룞 而ㅻ컠
- ?ㅼ쓬 ?묒뾽 ?좏깮
- 吏꾪뻾 ?곹깭? 濡쒓렇 湲곕줉

AI??紐⑺몴媛 遺덈챸?뺥븯嫄곕굹 ?덉쟾?섍쾶 ?먮떒?????녿뒗 寃쎌슦 ?꾩쓽濡?踰붿쐞瑜??뺤옣?섏? ?딄퀬 以묐떒?쒕떎.

## 湲곕낯 ?숈옉 ?먮쫫

1. `.ai-dev/goal.md`? `.ai-dev/backlog.md`瑜??쎈뒗??
2. ??μ냼??`AGENTS.md`? ?꾩옱 ?묒뾽 ?몃━ ?곹깭瑜??뺤씤?쒕떎.
3. 紐⑺몴瑜??묒? task濡?遺꾪빐?섍퀬 `.ai-dev/plan.md`? `.ai-dev/queue.json`??媛깆떊?쒕떎.
4. queue?먯꽌 ?곗꽑?쒖쐞媛 媛???믨퀬 ?ㅽ뻾 媛?ν븳 task ?섎굹瑜??좏깮?쒕떎.
5. ?좏깮??task???섏젙 ?덉젙 ?뚯씪, ?꾪뿕?? 寃利?諛⑸쾿??湲곕줉?쒕떎.
6. ?꾩옱 task 踰붿쐞 ?덉뿉?쒕쭔 援ы쁽?쒕떎.
7. task???꾩슂??build, test, lint瑜??ㅽ뻾?쒕떎.
8. ?ㅽ뙣?섎㈃ 媛숈? task 踰붿쐞 ?덉뿉???먯씤???섏젙?섍퀬 ?ㅼ떆 寃利앺븳??
9. 寃利앹씠 ?깃났?섎㈃ ?꾩껜 蹂寃?diff瑜?GPT媛 由щ럭?쒕떎.
10. 由щ럭 吏?곸궗??씠 ?덉쑝硫?媛숈? task 踰붿쐞 ?덉뿉???섏젙?섍퀬 ?ㅼ떆 寃利앺븳??
11. ?먮룞 而ㅻ컠 議곌굔??紐⑤몢 留뚯”?섎㈃ task ?⑥쐞 而ㅻ컠??留뚮뱺??
12. `.ai-dev/state.json`, `.ai-dev/test-result.md`, `.ai-dev/review.md`, `.ai-dev/loop-log.md`瑜?
媛깆떊?쒕떎.
13. ?ㅼ쓬 task瑜??좏깮?섍굅??以묐떒 議곌굔???곕씪 猷⑦봽瑜?醫낅즺?쒕떎.

## ?щ엺???낅젰?섎뒗 ?뚯씪

### `.ai-dev/goal.md`

?ъ슜?먭? ?ъ꽦?섎젮??紐⑺몴瑜??묒꽦?섎뒗 ?뚯씪?대떎.

?ы븿 沅뚯옣 ??ぉ:

- 紐⑺몴
- ?꾨즺 湲곗?
- ?덉슜 踰붿쐞
- 湲덉? 踰붿쐞
- ?곗꽑?쒖쐞
- 李멸퀬 臾몄꽌
- 寃利?諛⑸쾿
- 而ㅻ컠 ?먮뒗 諛고룷 ?쒗븳

紐⑺몴??媛?ν븳 ??寃곌낵 以묒떖?쇰줈 ?묒꽦?쒕떎. 援ы쁽 諛⑹떇? ??μ냼 援ъ“? ?뺤콉??留욎떠 AI媛 ?먮떒?????덈떎.

### `.ai-dev/backlog.md`

?ъ슜?먭? ?먰븯???꾩냽 ?묒뾽, ?꾩씠?붿뼱, ??? ?곗꽑?쒖쐞 ?꾨낫瑜?湲곕줉?섎뒗 ?뚯씪?대떎.

?뺤콉:

- backlog ??ぉ? ?먮룞 ?ㅽ뻾???뺤젙??task媛 ?꾨땲??
- AI???꾩옱 goal怨?吏곸젒 愿?⑤맂 ??ぉ留?queue ?꾨낫濡??щ┛??
- ?꾪뿕?꾧? ?믨굅??踰붿쐞媛 ????ぉ? 臾몄꽌??task濡??꾪솚?????덈떎.
- ?꾩옱 goal怨?臾닿???backlog ??ぉ? ?꾩쓽濡?援ы쁽?섏? ?딅뒗??

## AI媛 ?앹꽦?섍굅???섏젙?섎뒗 ?뚯씪

### `.ai-dev/plan.md`

?꾩옱 goal???대뼡 ?④퀎濡?泥섎━?좎? ?щ엺???쎌쓣 ???덈뒗 ?뺥깭濡??뺣━?쒕떎.

?ы븿 ??ぉ:

- 紐⑺몴 ?붿빟
- ?묒뾽 遺꾪빐 寃곌낵
- ?묒뾽 ?쒖꽌
- ?덉긽 ?섏젙 ?뚯씪
- ?묒뾽蹂??꾪뿕??- 寃利?怨꾪쉷
- 以묐떒 議곌굔

### `.ai-dev/queue.json`

?먮룞 媛쒕컻 猷⑦봽媛 泥섎━??task 紐⑸줉怨??곹깭瑜?援ъ“?뷀빐 ??ν븳??

task ?곹깭 ?꾨낫:

- `pending`
- `in_progress`
- `blocked`
- `completed`
- `skipped`

媛?task??理쒖냼???ㅼ쓬 ?뺣낫瑜??ы븿?댁빞 ?쒕떎.

- 怨좎쑀 id
- ?쒕ぉ
- 紐⑹쟻
- ?곗꽑?쒖쐞
- ?덉슜 ?섏젙 ?뚯씪
- 寃利?紐낅졊
- 而ㅻ컠 硫붿떆吏 ?꾨낫
- ?꾩옱 ?곹깭

### `.ai-dev/state.json`

?먮룞 媛쒕컻 猷⑦봽???꾩옱 ?ㅽ뻾 ?곹깭瑜?湲곕줉?쒕떎.

?ы븿 ??ぉ:

- ?꾩옱 goal
- ?꾩옱 task id
- 留덉?留??꾨즺 task id
- 留덉?留??깃났 寃利??쒓컖
- 留덉?留?而ㅻ컠 hash
- ?ъ떆???잛닔
- 以묐떒 ?ъ쑀

### `.ai-dev/test-result.md`

?묒뾽蹂?build, test, lint ?ㅽ뻾 寃곌낵瑜?湲곕줉?쒕떎.

?뺤콉:

- ?ㅽ뻾?섏? ?딆? 寃利앹? ?듦낵濡?湲곕줉?섏? ?딅뒗??
- ?ㅽ뙣??寃利앹? ?먯씤怨??ъ떆??寃곌낵瑜??④릿??
- 寃利?紐낅졊????μ냼???녾굅???ㅽ뻾???덉슜?섏? ?딆쑝硫?誘몄닔???ъ쑀瑜??④릿??

### `.ai-dev/review.md`

?묒뾽蹂?GPT 由щ럭 寃곌낵瑜?湲곕줉?쒕떎.

寃????ぉ:

- ????ㅻ쪟 媛?μ꽦
- 鍮뚮뱶 ?먮뒗 ?뚯뒪???ㅽ뙣 媛?μ꽦
- ?고????ㅻ쪟 媛?μ꽦
- 湲곗〈 湲곕뒫 ?뚭? 媛?μ꽦
- ?꾩옱 task 踰붿쐞 諛??섏젙 ?щ?
- `AGENTS.md` ?꾨컲 ?щ?
- 蹂댁븞, ?곗씠???먯긽, 媛쒖씤?뺣낫 ?좎텧 ?꾪뿕

### `.ai-dev/loop-log.md`

?먮룞 媛쒕컻 猷⑦봽???ㅽ뻾 ?대젰???쒓컙 ?쒖꽌濡?湲곕줉?쒕떎.

?ы븿 ??ぉ:

- task ?좏깮
- ?섏젙 ?뚯씪
- 寃利?寃곌낵
- 由щ럭 寃곌낵
- 而ㅻ컠 寃곌낵
- 以묐떒 ?먮뒗 ?ъ떆???ъ쑀

## ?묒뾽 ?⑥쐞 ?먯튃

- ??踰덉뿉 ?섎굹??task留??섑뻾?쒕떎.
- ?섎굹??task???섎굹??紐낇솗??紐⑹쟻留?媛?몄빞 ?쒕떎.
- task 踰붿쐞 諛??뚯씪? ?섏젙?섏? ?딅뒗??
- 媛?task???낅┰?곸쑝濡?寃利앺븷 ???덉뼱???쒕떎.
- 媛?task??寃利??깃났 ???섎굹??而ㅻ컠?쇰줈 留뚮뱺??
- 愿?⑥꽦????? 蹂寃쎌쓣 ?섎굹??而ㅻ컠??臾띠? ?딅뒗??
- ??湲곕뒫? 援ы쁽, ?뺤콉 臾몄꽌?? 寃利?蹂닿컯??蹂꾨룄 task濡??섎늿??
- ?洹쒕え 蹂寃쎌씠 ?꾩슂??寃쎌슦 ?묒? ?좏뻾 task濡??ㅼ떆 遺꾪빐?쒕떎.

## ?먮룞???④퀎

### 1. goal 遺꾩꽍

- 紐⑺몴? ?꾨즺 湲곗????뺤씤?쒕떎.
- ?덉슜 踰붿쐞? 湲덉? 踰붿쐞瑜?遺꾨━?쒕떎.
- ??μ냼 ?뺤콉怨?異⑸룎?섎뒗 ?붽뎄媛 ?덈뒗吏 ?뺤씤?쒕떎.
- 遺덈챸?뺥븳 議곌굔???덉쟾?깆뿉 ?곹뼢??二쇰㈃ 以묐떒?섍퀬 ?ъ슜???뺤씤???붿껌?쒕떎.

### 2. queue ?앹꽦

- 紐⑺몴瑜??묒? task濡?遺꾪빐?쒕떎.
- ?꾪뿕?꾧? ??퀬 ?좏뻾 議곌굔??異⑹”??task瑜??욎뿉 ?붾떎.
- DB schema 蹂寃? ?洹쒕え 由ы뙥?곕쭅, ?몃? ?ㅽ듃?뚰겕 ?곕룞? 蹂꾨룄 寃??task濡?遺꾨━?쒕떎.

### 3. current task ?좏깮

- `pending` ?곹깭 以??곗꽑?쒖쐞媛 媛???믪? task ?섎굹瑜??좏깮?쒕떎.
- ?댁쟾 task媛 ?ㅽ뙣?덇굅??寃利앸릺吏 ?딆븯?쇰㈃ ?ㅼ쓬 task濡??섏뼱媛吏 ?딅뒗??
- ?꾩옱 ?묒뾽 ?몃━媛 ?덉긽?섏? 紐삵븳 蹂寃쎌쓣 ?ы븿?섎㈃ ??task瑜??쒖옉?섏? ?딅뒗??

### 4. 援ы쁽

- ?섏젙 ?덉젙 ?뚯씪怨??꾪뿕?꾨? 湲곕줉?쒕떎.
- 湲곗〈 肄붾뱶 ?ㅽ??? ??? store, DB 援ъ“瑜??곗꽑 ?ъ슜?쒕떎.
- task 踰붿쐞 諛?由ы뙥?곕쭅?대굹 湲곕뒫 異붽?瑜??섏? ?딅뒗??

### 5. build/test/lint ?ㅽ뻾

- task???꾩슂??寃利?紐낅졊留??ㅽ뻾?쒕떎.
- ?ㅽ뻾 沅뚰븳怨???μ냼 ?뺤콉??癒쇱? ?뺤씤?쒕떎.
- ?ㅽ뻾?섏? ?딆? 寃利앹? 誘몄닔?됱쑝濡?湲곕줉?쒕떎.

### 6. ?ㅽ뙣 ???ъ닔??
- ?ㅽ뙣 ?먯씤???꾩옱 task 踰붿쐞 ?덉뿉?쒕쭔 ?섏젙?쒕떎.
- 媛숈? 臾몄젣媛 諛섎났?섎㈃ ?ъ떆???잛닔瑜?湲곕줉?쒕떎.
- ?덉슜 踰붿쐞瑜??섏뼱???닿껐?????덉쑝硫?以묐떒?쒕떎.

### 7. GPT 由щ럭

- ?꾩껜 diff瑜?湲곗??쇰줈 蹂寃쎌쓣 寃?좏븳??
- P1 ?섏????곗씠???먯긽, 蹂댁븞, ?고????ㅻ쪟, 二쇱슂 ?뚭? ?꾪뿕???덉쑝硫?而ㅻ컠?섏? ?딅뒗??
- P2/P3 吏?곸궗??? ?꾩옱 task 踰붿쐞 ?덉뿉???덉쟾?섍쾶 ?닿껐?????덉쓣 ?뚮쭔 諛섏쁺?쒕떎.

## ?섎룞 GPT 由щ럭 釉뚮━吏 ?뺤콉

?꾩옱 AI Dev Loop??GPT API ?ㅺ? ?녿뒗 ?섍꼍?먯꽌??ChatGPT ???붾㈃???ъ슜??由щ럭瑜?吏꾪뻾?????덉뼱???쒕떎. ???먮쫫? API ?
먮룞 ?몄텧???꾨땲???щ엺??寃???댁슜????린???섎룞 釉뚮━吏?대ŉ, ?먮룞???ㅽ겕由쏀듃???꾨＼?꾪듃 ?앹꽦, ?대┰蹂대뱶 蹂듭궗, 由щ럭 JSON ???
?덈궡源뚯?留??뺣뒗??

### 湲곕낯 ?먯튃

- GPT API瑜?吏곸젒 ?몄텧?섏? ?딅뒗??
- ChatGPT ???붾㈃???먮룞?쇰줈 ?묒냽?섍굅???낅젰?섏? ?딅뒗??
- `review-prompt.md`??濡쒖뺄?먯꽌 ?앹꽦?쒕떎.
- ?ъ슜?먮뒗 prompt ?댁슜???뺤씤????ChatGPT ???붾㈃??吏곸젒 遺숈뿬?ｋ뒗??
- ChatGPT?먮뒗 由щ럭 寃곌낵瑜?吏?뺣맂 JSON ?뺤떇留?異쒕젰?섎룄濡??붿껌?쒕떎.
- ?ъ슜?먮뒗 ChatGPT媛 諛섑솚??JSON 由щ럭瑜?蹂듭궗?쒕떎.
- 由щ럭 JSON? `ai-dev-save-review.ps1 -FromClipboard` ?먮뒗 蹂꾨룄 ?섎룞 釉뚮━吏 helper瑜??듯빐 ??ν븳??
- 由щ럭 ????ㅼ뿉??湲곗〈 decision 洹쒖튃???곕씪 `pass`, `revise`, `blocked` ?먮쫫??怨꾩냽 吏꾪뻾?쒕떎.

### ?섎룞 由щ럭 ?먮쫫

1. `ai-dev-make-review-prompt.ps1`媛 `.ai-dev/review-prompt.md`瑜??앹꽦?쒕떎.
2. ?ъ슜?먮뒗 `review-prompt.md` ?댁슜???대┰蹂대뱶??蹂듭궗?쒕떎.
3. ?ъ슜?먮뒗 ChatGPT ???붾㈃??prompt瑜?遺숈뿬?ｋ뒗??
4. ChatGPT??JSON 由щ럭留?異쒕젰?댁빞 ?쒕떎.
5. ?ъ슜?먮뒗 JSON 由щ럭 ?꾩껜瑜??대┰蹂대뱶??蹂듭궗?쒕떎.
6. `ai-dev-save-review.ps1 -FromClipboard`媛 ?대┰蹂대뱶??JSON???뚯떛??`.ai-dev/review.md`? `.ai-dev/s
tate.json`??媛깆떊?쒕떎.
7. decision??`pass`?대㈃ complete-task ?먮뒗 commit ?④퀎濡?吏꾪뻾?쒕떎.
8. decision??`revise`?대㈃ revise prompt瑜??앹꽦??Codex/Cline???섎룞?쇰줈 ?꾨떖?쒕떎.
9. decision??`blocked`?대㈃ ?ъ슜???먮떒??湲곕떎由곕떎.

### auto-step怨??섎룞 釉뚮━吏

`ai-dev-auto-step.ps1`??`ask_gpt_review` ?곹깭?먯꽌 GPT API瑜??몄텧?섏? ?딅뒗?? ????섎룞 由щ럭 釉뚮━吏???꾩슂???ㅼ
쓬 ?됰룞???덈궡?댁빞 ?쒕떎.

?덈궡 ?꾨낫:

- `review-prompt.md` ?앹꽦 ?щ? ?뺤씤
- `review-prompt.md` ?대┰蹂대뱶 蹂듭궗 紐낅졊 ?덈궡
- ChatGPT ???붾㈃??遺숈뿬?ｌ쑝?쇰뒗 ?덈궡
- JSON 由щ럭留?諛쏆븘???쒕떎???덈궡
- 由щ럭 JSON??蹂듭궗????`ai-dev-save-review.ps1 -FromClipboard`瑜??ㅽ뻾?섎씪???덈궡

### manual-cycle怨??섎룞 釉뚮━吏

`ai-dev-manual-cycle.ps1`???꾩옱 ?곹깭? ?ㅼ쓬 action???④퍡 蹂댁뿬二쇰뒗 ?섎룞 ?댁쁺 ??쒕낫?쒕떎. ?ъ슜?먮뒗 `manual-cyc
le` 寃곌낵?먯꽌 `ask_gpt_review`瑜??뺤씤?????섎룞 由щ럭 釉뚮━吏濡??꾪솚?쒕떎.

沅뚯옣 ?먮쫫:

1. `ai-dev-manual-cycle.ps1`濡??꾩옱 task, git ?곹깭, test-result, review ?곹깭, next action???뺤씤?쒕떎.
2. next action??`ask_gpt_review`?대㈃ `ai-dev-copy-review-prompt.ps1`濡?`review-prompt.md`瑜??대┰蹂대뱶?
?蹂듭궗?쒕떎.
3. ?ъ슜?먭? ChatGPT ???붾㈃??prompt瑜?遺숈뿬?ｋ뒗??
4. ChatGPT?먮뒗 JSON 由щ럭留?異쒕젰?섎룄濡??붿껌?쒕떎.
5. ?ъ슜?먭? JSON 由щ럭瑜??대┰蹂대뱶??蹂듭궗?쒕떎.
6. `ai-dev-save-review.ps1 -FromClipboard`濡?由щ럭 寃곌낵瑜???ν븳??
7. ??λ맂 decision???곕씪 ?ㅼ쓬 ?④퀎瑜??좏깮?쒕떎.

decision蹂?湲곗?:

- `pass`: ?꾩옱 task ?꾨즺 泥섎━ ?먮뒗 而ㅻ컠 議곌굔 寃?좊줈 吏꾪뻾?쒕떎.
- `revise`: `ai-dev-make-revise-prompt.ps1`濡??ъ닔???꾨＼?꾪듃瑜?留뚮뱾怨?Codex/Cline???섎룞?쇰줈 ?꾨떖?쒕떎.
- `blocked`: ?ъ슜???먮떒???꾩슂?섎?濡?猷⑦봽瑜?以묐떒?섍퀬 ?붽뎄?ы빆, 踰붿쐞, ?꾪뿕?꾨? ?ㅼ떆 ?뺤씤?쒕떎.

???먮쫫? GPT API ?ㅺ? ?놁뼱???숈옉?쒕떎. ?? `review-prompt.md`?먮뒗 diff? ?뚯뒪??寃곌낵媛 ?ы븿?????덉쑝誘濡?ChatGP
T??遺숈뿬?ｊ린 ?꾩뿉 ?ъ슜?먭? 誘쇨컧 ?뺣낫? ???diff ?ы븿 ?щ?瑜??뺤씤?댁빞 ?쒕떎.

### 誘쇨컧 ?뺣낫? 怨듭쑀 踰붿쐞

`review-prompt.md`?먮뒗 git diff, ?뚯뒪??寃곌낵, ?꾩옱 task ?ㅻ챸???ы븿?????덈떎. diff ?덉뿉 誘쇨컧 ?뺣낫, 諛깆뾽 ?곗씠?? 
媛쒖씤?뺣낫, API Key, ????뚯씪 ?댁슜???ы븿?????덉쑝誘濡??ъ슜?먮뒗 ChatGPT??遺숈뿬?ｊ린 ?꾩뿉 prompt ?댁슜???뺤씤?댁빞 ?쒕떎.

?뺤콉:

- API Key, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?곌? ?ы븿??prompt???몃? ChatGPT ?붾㈃??遺숈뿬?ｌ? ?딅뒗??
- `diff.md`? `review-prompt.md`媛 ?덈Т ?щ㈃ 踰붿쐞瑜?以꾩씠嫄곕굹 ?곗텧臾쇱쓣 ?뺣━?????ㅼ떆 ?앹꽦?쒕떎.
- 誘쇨컧 ?뺣낫媛 ?섏떖?섎㈃ 由щ럭 釉뚮━吏 ?먮쫫??以묐떒?섍퀬 ?ъ슜???먮떒??諛쏅뒗??
- ?섎룞 由щ럭 釉뚮━吏???몄쓽 湲곕뒫??肉? 蹂댁븞 ?먮떒???먮룞?뷀븯吏 ?딅뒗??

### 8. 由щ럭 諛섏쁺

- 由щ럭 ?섏젙 ???꾩슂??寃利앹쓣 ?ㅼ떆 ?ㅽ뻾?쒕떎.
- ?섏젙?쇰줈 task 踰붿쐞媛 而ㅼ?硫?以묐떒?섍퀬 queue瑜??ㅼ떆 遺꾪빐?쒕떎.

### 9. ?먮룞 而ㅻ컠

- ?먮룞 而ㅻ컠 議곌굔??紐⑤몢 留뚯”??寃쎌슦?먮쭔 ?섏젙???뚯씪??紐낆떆?곸쑝濡?stage?쒕떎.
- `git add .`???ъ슜?섏? ?딅뒗??
- 而ㅻ컠 硫붿떆吏??吏㏐퀬 紐낇솗???곸뼱 臾몄옣?쇰줈 ?묒꽦?쒕떎.

### 10. ?ㅼ쓬 task ?좏깮

- ?꾩옱 task???곹깭, 寃利?寃곌낵, 由щ럭 寃곌낵, 而ㅻ컠 hash瑜?湲곕줉?쒕떎.
- ?ㅼ쓬 task???좏뻾 議곌굔???뺤씤?쒕떎.
- 以묐떒 議곌굔???놁쓣 ?뚮쭔 ?ㅼ쓬 task瑜??쒖옉?쒕떎.

## auto-step ?숈옉 ?뺤콉

`ai-dev-auto-step.ps1`???꾩옱 queue, state, review, test, git ?곹깭瑜??쎄퀬 ?덉쟾???ㅼ쓬 ???④퀎留?泥섎━?섎뒗 蹂댁“ 
?ㅽ겕由쏀듃?? ?꾩쟾 ?먮룞 媛쒕컻 猷⑦봽 ?ㅽ뻾湲곌? ?꾨땲硫? ?ъ슜???먮떒?대굹 ?몃? AI ?몄텧???꾩슂???쒓컙?먮뒗 以묐떒?섍굅???ㅼ쓬 紐낅졊留??덈궡?쒕
떎.

### 湲곕낯 ?먯튃

- ??踰??ㅽ뻾?????섎굹??action留?泥섎━?쒕떎.
- `ai-dev-next.ps1`媛 ?먮떒?섎뒗 ?ㅼ쓬 action??湲곕컲?쇰줈 ?숈옉?쒕떎.
- ?곹깭 ?뚯씪怨??꾨＼?꾪듃 ?뚯씪??媛깆떊?섎뒗 ?덉쟾??濡쒖뺄 ?ㅽ겕由쏀듃留??먮룞 ?ㅽ뻾?쒕떎.
- Codex, Cline, GPT API, git commit, git push???먮룞 ?ㅽ뻾?섏? ?딅뒗??
- destructive git 紐낅졊, DB ??젣/蹂듭썝/留덉씠洹몃젅?댁뀡, package ?ㅼ튂???먮룞 ?ㅽ뻾?섏? ?딅뒗??
- ?ㅽ뙣?섎㈃ state? 異쒕젰???ㅽ뙣 ?댁쑀瑜??④린怨??ㅼ쓬 action?쇰줈 吏꾪뻾?섏? ?딅뒗??

### ?먮룞 ?ㅽ뻾 ?덉슜 ?꾨낫

珥덇린 auto-step?먯꽌 ?먮룞 ?ㅽ뻾?????덈뒗 ?꾨낫??濡쒖뺄 ?뚯씪 ?앹꽦 ?먮뒗 寃利?蹂댁“ ?묒뾽?쇰줈 ?쒗븳?쒕떎.

- `current-task-prompt.md`媛 ?놁쓣 ??`scripts/ai-dev-make-prompt.ps1` ?ㅽ뻾
- 寃利앹씠 ?꾩슂???곹깭?먯꽌 紐낆떆?곸쑝濡??덉쟾???듭뀡???좏깮??寃쎌슦 `scripts/ai-dev-check.ps1` ?ㅽ뻾
- diff ??μ씠 ?꾩슂???곹깭?먯꽌 `scripts/ai-dev-save-diff.ps1` ?ㅽ뻾
- review prompt ?앹꽦???꾩슂???곹깭?먯꽌 `scripts/ai-dev-make-review-prompt.ps1` ?ㅽ뻾
- revise prompt ?앹꽦???꾩슂???곹깭?먯꽌 ?ъ슜?먭? 紐낆떆?곸쑝濡??덉슜??寃쎌슦 `scripts/ai-dev-make-revise-prompt.ps1`
 ?ㅽ뻾 ?꾨낫 寃??
`ai-dev-check.ps1`???꾨줈?앺듃 紐낅졊???ㅽ뻾?????덉쑝誘濡?湲곕낯 ?먮룞 ?ㅽ뻾 踰붿쐞??蹂댁닔?곸쑝濡??붾떎. 珥덇린 援ы쁽? DryRun ?먮뒗
 紐낆떆???덉쟾 ?듭뀡?먯꽌留?check ?ㅽ뻾???덉슜?쒕떎.

### ?먮룞 ?ㅽ뻾 湲덉? ?먮뒗 以묐떒 ?꾨낫

?ㅼ쓬 ?곹깭?먯꽌??auto-step??吏곸젒 ?묒뾽?섏? ?딄퀬 ?ъ슜?먯뿉寃??ㅼ쓬 ?됰룞???덈궡?섍굅??以묐떒?쒕떎.

- Codex ?먮뒗 Cline???꾩옱 task 援ы쁽???섑뻾?댁빞 ?섎뒗 寃쎌슦
- GPT 由щ럭媛 ?꾩슂??寃쎌슦
- 由щ럭 寃곌낵媛 `blocked`??寃쎌슦
- 由щ럭 寃곌낵媛 `revise`?닿퀬 ?ъ닔??踰붿쐞媛 遺덈챸?뺥븳 寃쎌슦
- git commit???꾩슂??寃쎌슦
- git push, PR ?앹꽦, 諛고룷媛 ?꾩슂??寃쎌슦
- ?ъ슜???곗씠????젣, 蹂듭썝, ??뼱?곌린, 留덉씠洹몃젅?댁뀡 ?꾪뿕???덈뒗 寃쎌슦
- package ?ㅼ튂 ?먮뒗 package ?뚯씪 蹂寃쎌씠 ?꾩슂??寃쎌슦
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠 ?묒뾽 ?몃━???덈뒗 寃쎌슦

?뱁엳 git commit? ?대쾲 紐⑺몴??auto-step ?먮룞 ?ㅽ뻾 踰붿쐞?먯꽌 ?쒖쇅?쒕떎. auto-step? 而ㅻ컠???꾩슂?섎떎???ъ떎怨?異붿쿇 紐낅졊
???덈궡???섎뒗 ?덉?留?`ai-dev-commit.ps1`瑜?吏곸젒 ?ㅽ뻾?섏? ?딅뒗??

### auto-cycle ?숈옉 湲곗?

`ai-dev-auto-cycle.ps1`??auto-step???쒗븳 ?잛닔 ?덉뿉??諛섎났?섎뒗 蹂댁“ ?ㅽ겕由쏀듃??

- `-MaxSteps` 媛숈? 諛섎났 ?쒗븳???붾떎.
- 媛?諛섎났? auto-step ??踰덉쓽 寃곌낵瑜??뺤씤?????ㅼ쓬 諛섎났 ?щ?瑜??먮떒?쒕떎.
- ?ъ슜??媛쒖엯 ?꾩슂 action, blocked, failed, commit ?꾩슂, Codex/GPT ?꾩슂 ?곹깭?먯꽌??以묐떒?쒕떎.
- 媛숈? action??諛섎났?섍굅???곹깭媛 蹂?섏? ?딆쑝硫?臾댄븳 猷⑦봽 ?꾪뿕?쇰줈 以묐떒?쒕떎.
- auto-cycle??Codex/GPT API ?몄텧, git commit, git push瑜??먮룞 ?ㅽ뻾?섏? ?딅뒗??

### 愿??紐낅졊 ??븷 援щ텇

- `ai-dev-next.ps1`: ?꾩옱 ?곹깭瑜??쎄퀬 ?ㅼ쓬 異붿쿇 action怨?紐낅졊留??덈궡?쒕떎. ?뚯씪 ?섏젙?대굹 ?섏쐞 紐낅졊 ?ㅽ뻾???섏? ?딅뒗??
 ?쒕떎?뚯뿉 臾댁뾿???댁빞 ?섏???앸쭔 ?뚭퀬 ?띠쓣 ???ъ슜?쒕떎.
- `ai-dev-manual-cycle.ps1`: ?곹깭 ?붿빟怨??ㅼ쓬 ?됰룞 ?덈궡瑜???踰덉뿉 蹂댁뿬二쇰뒗 ?섎룞 ?댁쁺 ??쒕낫?쒕떎. ?꾩옱 task, 寃利?
 由щ럭, diff ?뚯씪 ?곹깭瑜??④퍡 蹂대ŉ ?щ엺??吏곸젒 ?ㅼ쓬 紐낅졊??怨좊? ???ъ슜?쒕떎.
- `ai-dev-auto-step.ps1`: `next` ?먮떒 寃곌낵瑜?湲곕컲?쇰줈 ?덉쟾?섎떎怨??뺤쓽???ㅼ쓬 ???④퀎瑜??ㅽ뻾?쒕떎. ?꾨＼?꾪듃 ?앹꽦 媛숈? 
濡쒖뺄 蹂댁“ ?묒뾽? ?ㅽ뻾?????덉?留?Codex/GPT/commit ?④퀎?먯꽌??硫덉텣??
- `ai-dev-auto-cycle.ps1`: ?쒗븳 ?잛닔 ?덉뿉??auto-step??諛섎났?쒕떎. ?щ윭 ?덉쟾 ?④퀎瑜??댁뼱媛怨??띠쓣 ???ъ슜?섏?留? ?ъ
슜??媛쒖엯 ?꾩슂 action, ?ㅽ뙣, blocked, commit ?꾩슂 ?곹깭?먯꽌??硫덉텣??

?ъ슜 異붿쿇:

- ?곹솴 ?뚯븙: `ai-dev-manual-cycle.ps1`
- ?ㅼ쓬 ?됰룞留??뺤씤: `ai-dev-next.ps1`
- ?덉쟾???먮룞 1?④퀎 ?ㅽ뻾: `ai-dev-auto-step.ps1`
- ?덉쟾 ?④퀎 諛섎났 ?ㅽ뻾: `ai-dev-auto-cycle.ps1`

`ai-dev-auto-step.ps1`? `ai-dev-auto-cycle.ps1`??Codex/Cline ?ㅽ뻾, GPT 由щ럭 ?붿껌, git commit???먮룞 
?ㅽ뻾?섏? ?딅뒗??

## ?섎룞 ?먮룞??UX 媛쒖꽑 湲곗?

AI Dev Loop??GPT API ?놁씠???щ엺???ㅼ쓬 ?됰룞??鍮좊Ⅴ寃??먮떒?????덉뼱???쒕떎. ?먮룞???ㅽ겕由쏀듃???ㅽ뻾 ?щ?蹂대떎 ?꾩옱 ?곹깭, 以
묐떒 ?댁쑀, 異붿쿇 紐낅졊, ?꾪뿕 ?щ?瑜?紐낇솗??蹂댁뿬二쇰뒗 寃껋쓣 ?곗꽑?쒕떎.

### ?ㅼ쓬 ?됰룞 ?먮떒 ?쒖꽌

?ъ슜?먭? ?꾩옱 ?곹깭瑜??먮떒???뚮뒗 ?꾨옒 紐낅졊???곗꽑 ?뺤씤?쒕떎.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun -MaxSteps 3
```

- `status`: ?꾩옱 goal/task/test/review/git ?곹깭瑜??뺤씤?쒕떎.
- `next`: ?ㅼ쓬 action怨?異붿쿇 紐낅졊留??뺤씤?쒕떎.
- `manual-cycle`: ?곹깭? ?ㅼ쓬 action?????붾㈃?먯꽌 ?뺤씤?쒕떎.
- `auto-step -DryRun`: ?ㅼ젣 ?ㅽ뻾 ?놁씠 auto-step??臾댁뾿???좎? ?뺤씤?쒕떎.
- `auto-cycle -DryRun -MaxSteps 3`: ?쒗븳??諛섎났 ?덉뿉???대뵒?먯꽌 硫덉텧吏 ?뺤씤?쒕떎.

### goal_completed ?곹깭 UX

`goal_completed` ?곹깭?먯꽌?????댁긽 ?ㅽ뻾??task媛 ?놁쓬??紐낇솗???덈궡?댁빞 ?쒕떎.

?뺤콉:

- `auto-step`? ?꾨즺??goal?먯꽌 異붽? ?묒뾽???ㅽ뻾?섏? ?딅뒗??
- `auto-cycle`? ?꾨즺 ?곹깭瑜?諛섎났?섏? ?딄퀬 `completed: true`濡?醫낅즺?댁빞 ?쒕떎.
- 異쒕젰?먮뒗 ??紐⑺몴瑜??쒖옉?섎젮硫?`.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`????goal 湲곗
??쇰줈 珥덇린?뷀빐???쒕떎???덈궡瑜??ы븿?쒕떎.
- ?꾨즺 ?곹깭?먯꽌 build/test/review/commit???먮룞?쇰줈 ?ㅽ뻾?섏? ?딅뒗??

### ask_gpt_review ?곹깭 UX

`ask_gpt_review` ?곹깭???щ엺??ChatGPT ???붾㈃?먯꽌 由щ럭瑜??섑뻾?댁빞 ?섎뒗 吏?먯씠??

?뺤콉:

- `auto-step`怨?`auto-cycle`? GPT API瑜??몄텧?섏? ?딅뒗??
- `auto-cycle`? `ask_gpt_review`?먯꽌 硫덉텧 ???섎룞 由щ럭 釉뚮━吏 紐낅졊???④퍡 蹂댁뿬以섏빞 ?쒕떎.
- JSON 異쒕젰?먮룄 `ai-dev-copy-review-prompt.ps1`? `ai-dev-save-review.ps1 -FromClipboard` 紐낅졊???ы븿
?섏뼱???쒕떎.
- message?먮뒗 review-prompt 蹂듭궗, ChatGPT 遺숈뿬?ｊ린, JSON 由щ럭 蹂듭궗, save-review ?ㅽ뻾 ?먮쫫??吏㏐쾶 ?ㅻ챸?쒕떎.

### save-review ?ㅽ뙣? ?곹깭 ?ㅼ뿼 諛⑹?

由щ럭 JSON ?뚯떛 ?ㅽ뙣???ъ슜?먭? ?섎せ???대┰蹂대뱶 ?댁슜??蹂듭궗?덉쓣 ???먯＜ 諛쒖깮?????덈떎. ???ㅽ뙣媛 ?대? ?꾨즺??goal?대굹 ?뺤긽 
review ?곹깭瑜?遺덊븘?뷀븯寃??ㅼ뿼?쒗궎硫????쒕떎.

媛쒖꽑 諛⑺뼢:

- ?섎せ??JSON ?낅젰? preview瑜??ы븿???먯씤???ㅻ챸?쒕떎.
- 媛?ν븳 寃쎌슦 ?ㅽ뙣 ?낅젰??湲곗〈 `review.md`? `state.json`??利됱떆 ??뼱?곌린 ?꾩뿉 蹂댁〈 ?щ?瑜??좏깮?????덇쾶 ?쒕떎.
- `goalStatus`媛 `completed`???곹깭?먯꽌???ㅽ뙣???꾩떆 由щ럭 ?낅젰留뚯쑝濡??꾨즺 ?곹깭瑜?`blocked`泥섎읆 蹂댁씠寃?留뚮뱾吏 ?딅뒗?
?
- ?뺤긽 JSON ????먮쫫怨??ㅽ뙣 湲곕줉 ?먮쫫??援щ텇?쒕떎.
- ?곹깭 ?뚯씪??媛깆떊?섎뒗 寃쎌슦 ?대뼡 ?꾨뱶瑜?諛붽씀?붿? 異쒕젰 ?먮뒗 臾몄꽌濡??뺤씤?????덉뼱???쒕떎.

### 理쒖쥌 寃利?寃곌낵 湲곕줉 UX

T006 媛숈? 理쒖쥌 寃利?task??build/test/lint ?몄뿉??PowerShell 臾몃쾿 寃利? `auto-step`/`auto-cycle` DryRun,
 `save-review` ?깃났/?ㅽ뙣 ?먮쫫 ?뺤씤???꾩슂?섎떎.

?뺤콉:

- ?ㅽ뻾??寃利?紐낅졊怨?寃곌낵瑜?`test-result.md`???④릿??
- ?ㅽ뻾?섏? ?딆? 寃利앹? ?듦낵濡?湲곕줉?섏? ?딅뒗??
- 理쒖쥌 寃利앹뿉???뺤씤???섎룞 紐낅졊, exit code, 二쇱슂 異쒕젰 ?붿빟??湲곕줉?쒕떎.
- build/test/lint ?먮쫫? 湲곗〈 `ai-dev-check.ps1` ?숈옉怨?異⑸룎?섏? ?딆븘???쒕떎.
- 臾몃쾿 寃利앹씠??DryRun 寃곌낵瑜?湲곕줉???뚮뒗 `ai-dev-check.ps1 -ManualSummaryOnly -ManualSummary "..."`瑜??ъ
슜?????덈떎.
- ?섎룞 ?붿빟 湲곕줉 紐⑤뱶??npm build/test/lint瑜??ㅽ뻾?섏? ?딅뒗??
- ?섎룞 ?붿빟?먮뒗 PowerShell 臾몃쾿 寃利?寃곌낵, `auto-step` DryRun 寃곌낵, `auto-cycle` DryRun 寃곌낵, `save-revi
ew` ?ㅽ뙣/?깃났 ?먮쫫 ?뺤씤, git status ?뺤씤泥섎읆 ?щ엺???ㅼ젣濡??섑뻾????ぉ留??곷뒗??
- ?ㅽ뻾?섏? ?딆? 寃利???ぉ? ?섎룞 ?붿빟???듦낵濡??곸? ?딅뒗??
- ?섎룞 ?붿빟 紐⑤뱶??`state.json.lastCommandStatus`??湲곕줉 ?묒뾽 ?깃났 ?щ?瑜??삵븯硫? 寃利??먯껜???듦낵/?ㅽ뙣/誘몄닔???먮떒?
 `test-result.md` 蹂몃Ц???④릿??

## Codex CLI ?꾩쟾 ?먮룞???뺤콉

AI Dev Loop???ㅼ쓬 ?먮룞???④퀎??Codex CLI瑜?援ы쁽?먯? 由щ럭?대줈 ?ъ슜?쒕떎. GPT API Key, Cline, Copilot CLI, `gh
` ?놁씠 濡쒖뺄 ??μ냼 ?덉뿉??`codex exec` 湲곕컲 ?ㅽ뻾 ?먮쫫??援ъ꽦?쒕떎.

?꾩옱 ?섍꼍 湲곗?:

- Codex CLI: `codex-cli 0.133.0`
- ?ㅽ뻾 諛⑹떇: `codex exec`
- workdir: `D:\ai-apps\planpilot-local`
- approval: `never`
- sandbox: `workspace-write`
- Cline: ??젣?섏뼱 ?ъ슜?섏? ?딆쓬
- Copilot CLI, `gh`: ?꾩옱 ?ъ슜?섏? ?딆쓬

### ??븷 遺꾨━

- 援ы쁽????븷: `current-task-prompt.md`瑜?Codex CLI???꾨떖???꾩옱 task 踰붿쐞 ?덉쓽 肄붾뱶 ?먮뒗 臾몄꽌 ?섏젙???섑뻾?쒕떎.
- 由щ럭????븷: `review-prompt.md`瑜?Codex CLI???꾨떖??吏?뺣맂 JSON ?뺤떇??由щ럭 寃곌낵瑜??앹꽦?쒕떎.
- 由щ럭 ??? Codex 由щ럭 寃곌낵??`.ai-dev/review-response.json`????ν븳 ??`ai-dev-save-review.ps1` ?먮쫫?쇰
줈 `.ai-dev/review.md`? `.ai-dev/state.json`??諛섏쁺?쒕떎.
- 猷⑦봽 湲곕줉: 援ы쁽 寃곌낵, 由щ럭 寃곌낵, ?ㅽ뙣 ?붿빟? `.ai-dev/codex-result.md`, `.ai-dev/review-response.json`
, `.ai-dev/loop-log.md`, `.ai-dev/state.json`???④릿??

### 珥덇린 full auto-cycle ?쒗븳

珥덇린 `ai-dev-auto-cycle-full.ps1`???덉쟾???꾪빐 ?묒? 踰붿쐞?먯꽌留??숈옉?댁빞 ?쒕떎.

- 湲곕낯 寃利??⑥쐞??`MaxTasks 1`濡??쒗븳?쒕떎.
- Codex 援ы쁽 ?ㅽ뻾? 紐낆떆??`AllowCodex` ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- Codex 由щ럭 ?ㅽ뻾? 紐낆떆??`AllowReviewCodex` ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- git commit? 紐낆떆??`AllowCommit` ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- goal ?낅젰 湲곕컲 ?ㅽ뻾? `ai-dev-auto-goal.ps1`?먯꽌 ?쒖옉?섎릺, full cycle ?몄텧? 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 ?섑
뻾?쒕떎.
- git push, PR ?앹꽦, 諛고룷???먮룞??踰붿쐞?먯꽌 ?쒖쇅?쒕떎.

### ?덉슜 紐낅졊怨??덉슜 ?④퀎

紐낆떆??Allow ?듭뀡怨??덉쟾 議곌굔??留뚯”???뚮쭔 ?ㅼ쓬 ?④퀎瑜??먮룞???꾨낫濡??붾떎.

- `ai-dev-make-prompt.ps1`濡??꾩옱 task prompt ?앹꽦
- `ai-dev-run-codex.ps1`濡?Codex 援ы쁽 ?ㅽ뻾
- `ai-dev-check.ps1`濡?build/check ?ㅽ뻾
- `ai-dev-save-diff.ps1`濡?diff ???- `ai-dev-make-review-prompt.ps1`濡?由щ럭 prompt ?앹꽦
- `ai-dev-run-review-codex.ps1`濡?Codex 由щ럭 ?ㅽ뻾
- `ai-dev-save-review.ps1`濡?由щ럭 JSON ???- 由щ럭媛 `pass`?닿퀬 紐⑤뱺 寃뚯씠?몃? ?듦낵??寃쎌슦?먮쭔 `ai-dev-commit
.ps1`? `ai-dev-complete-task.ps1` ?곌껐

### 紐⑺몴 ?낅젰 湲곕컲 ?먮룞 ?ㅽ뻾 ?뺤콉

理쒖쥌 紐⑺몴???ъ슜?먭? `GoalTitle`怨?`GoalDescription`留??낅젰??task ?앹꽦遺??Codex 援ы쁽, 寃利? Codex 由щ럭, pass
 ??而ㅻ컠怨?task ?꾨즺 泥섎━源뚯? ?댁뼱媛????덇쾶 ?섎뒗 寃껋씠??

?덉긽 理쒖쥌 紐낅졊:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "?낅Т 寃??寃곌낵 
?섏씠?쇱씠??異붽?" -GoalDescription "寃?됱뼱? ?쇱튂?섎뒗 ?낅Т ?쒕ぉ/硫붾え/?꾨줈?앺듃紐낆쓣 ?붾㈃?먯꽌 媛뺤“ ?쒖떆?쒕떎." -AllowCo
dex -AllowReviewCodex -AllowCommit -MaxTasks 1
```

`ai-dev-auto-goal.ps1`??梨낆엫:

- `GoalTitle`怨?`GoalDescription` ?꾩닔 ?낅젰 寃利?- Codex CLI瑜??댁슜??goal/queue/state 珥덉븞 ?앹꽦
- ?앹꽦??JSON ?뚯떛怨??꾩닔 ?꾨뱶 寃利?- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json` 媛깆떊
 ?꾨낫 ?쒖떆
- `.ai-dev/current-task-prompt.md` ?앹꽦 ?곌껐
- 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 `ai-dev-auto-cycle-full.ps1` ?몄텧
- DryRun?먯꽌 ?앹꽦??goal/task 怨꾪쉷怨??ㅽ뻾 ?④퀎瑜??쒖떆
- Json 異쒕젰?먯꽌 ?щ엺???쎈뒗 ?띿뒪?몃? ?욎? ?딆쓬

?덉쟾 湲곗?:

- `GoalTitle` ?먮뒗 `GoalDescription`??鍮꾩뼱 ?덉쑝硫?醫낅즺?쒕떎.
- Codex媛 ?앹꽦??goal/queue/state JSON???뚯떛?????놁쑝硫?醫낅즺?쒕떎.
- `queue.json` ?꾩닔 ?꾨뱶? task ?꾩닔 ?꾨뱶媛 ?놁쑝硫?醫낅즺?쒕떎.
- `state.json` ?꾩닔 ?꾨뱶媛 ?놁쑝硫?醫낅즺?쒕떎.
- ?ㅼ젣 full cycle ?ㅽ뻾? `AllowRun` ?먮뒗 洹몄뿉 以?섎뒗 紐낆떆???ㅽ뻾 ?듭뀡???덉쓣 ?뚮쭔 ?섑뻾?쒕떎.
- `AllowCodex`, `AllowReviewCodex`, `AllowCommit`? 媛곴컖 援ы쁽, 由щ럭, 而ㅻ컠 ?④퀎瑜?蹂꾨룄濡??곕떎.
- package ?뚯씪 蹂寃? build/check ?ㅽ뙣, 由щ럭 decision??`pass`媛 ?꾨땶 寃쎌슦 ?먮룞 而ㅻ컠?섏? ?딅뒗??

### 湲덉? 紐낅졊怨?湲덉? ?④퀎

?ㅼ쓬 ?묒뾽? full auto-cycle?먯꽌 ?먮룞 ?ㅽ뻾?섏? ?딅뒗??

- GPT API 吏곸젒 ?몄텧
- Cline ?ㅽ뻾
- Copilot CLI ?ㅽ뻾
- `gh` ?먮뒗 GitHub PR ?먮룞 ?곕룞
- `git push`
- `git reset`
- `git clean`
- destructive `git checkout` ?먮뒗 ?ъ슜??蹂寃??섎룎由ш린
- `npm install`
- package ???援먯껜
- DB ??젣, 珥덇린?? 蹂듭썝, 留덉씠洹몃젅?댁뀡
- ?ъ슜???곗씠????뼱?곌린

### ?먮룞 而ㅻ컠 寃뚯씠??
?먮룞 而ㅻ컠? ?ㅼ쓬 議곌굔??紐⑤몢 留뚯”?댁빞留?媛?ν븯??

- `AllowCommit`??紐낆떆?곸쑝濡?吏?뺣릺???덈떎.
- build/check媛 ?깃났?덈떎.
- 由щ럭 decision??`pass`??
- `package.json`怨?`package-lock.json`??蹂寃쎈릺吏 ?딆븯??
- ?꾩옱 task 踰붿쐞 諛??뚯씪???ы븿?섏? ?딆븯??
- dirty worktree媛 ?덉긽 蹂寃쎈쭔 ?ы븿?쒕떎.
- `git reset`, `git clean`, `npm install` ?놁씠 ?꾨즺 媛?ν븯??

?ㅼ쓬 寃쎌슦?먮뒗 ?먮룞 而ㅻ컠?섏? ?딅뒗??

- build/check ?ㅽ뙣
- 由щ럭 decision??`revise` ?먮뒗 `blocked`
- 由щ럭 JSON ?뚯떛 ?ㅽ뙣
- package ?뚯씪 蹂寃?媛먯?
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃?媛먯?
- ?꾩옱 task 踰붿쐞 諛??섏젙 媛먯?

### ?덉쟾 以묐떒 議곌굔

Codex CLI ?먮룞?붾뒗 ?꾨옒 議곌굔?먯꽌 利됱떆 以묐떒?쒕떎.

- Codex 援ы쁽 ?ㅽ뻾 ??`git status`媛 dirty??寃쎌슦
- `current-task-prompt.md` ?먮뒗 `review-prompt.md`媛 ?녾굅???꾩옱 task? 留욎? ?딅뒗 寃쎌슦
- Codex ?ㅽ뻾 寃곌낵媛 ?ㅽ뙣?섍굅??異쒕젰??鍮꾩뼱 ?덈뒗 寃쎌슦
- Codex 由щ럭 寃곌낵?먯꽌 JSON 媛앹껜瑜?異붿텧?????녿뒗 寃쎌슦
- build/check媛 ?ㅽ뙣??寃쎌슦
- package ?뚯씪 蹂寃쎌씠 媛먯???寃쎌슦
- 由щ럭 decision??`pass`媛 ?꾨땶 寃쎌슦
- DB schema 蹂寃? ?곗씠????젣, 蹂듭썝, 留덉씠洹몃젅?댁뀡???꾩슂??寃쎌슦
- 媛숈? ?ㅻ쪟媛 諛섎났?섏뼱 ?덉쟾?섍쾶 吏꾪뻾?????녿뒗 寃쎌슦

?ㅽ뙣 ?쒖뿉???ㅽ뙣瑜?由щ럭 寃곌낵濡??ㅼ씤?섏? ?딅룄濡?二쇱쓽?쒕떎. ?뱁엳 ?대? `completed`??goal???꾩떆 ?낅젰 ?ㅻ쪟??Codex ?ㅽ뻾 ?ㅽ뙣
留뚯쑝濡?`blocked`泥섎읆 蹂댁씠寃?留뚮뱾吏 ?딅뒗?? ?꾩슂??寃쎌슦 `state.json`?먮뒗 ?ㅽ뙣 ?붿빟留?湲곕줉?섍퀬, 湲곗〈 ?꾨즺 ?곹깭瑜???뼱?몄?
 ?щ???蹂꾨룄 ?뺤콉怨??ъ슜???먮떒???곕Ⅸ??

## ?먮룞 而ㅻ컠 議곌굔

?ㅼ쓬 議곌굔??紐⑤몢 留뚯”?댁빞 ?먮룞 而ㅻ컠?????덈떎.

- ?꾩옱 task???꾨즺 湲곗???異⑹”?덈떎.
- ?덉슜???뚯씪留??섏젙?섏뿀??
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠 ?녿떎.
- ?꾩슂??build, test, lint媛 ?깃났?덈떎.
- ?ㅽ뻾?섏? 紐삵븳 ?꾩닔 寃利앹씠 ?녿떎.
- GPT 由щ럭?먯꽌 P1 臾몄젣媛 ?녿떎.
- 由щ럭 吏?곸궗??쓣 諛섏쁺?????ш?利앹씠 ?깃났?덈떎.
- `AGENTS.md`? ?ъ슜??吏?쒕? ?꾨컲?섏? ?딆븯??
- lock file, DB schema, 蹂댁븞 愿??蹂寃쎌씠 ?덉슜 踰붿쐞 諛뽰뿉??諛쒖깮?섏? ?딆븯??
- 而ㅻ컠?먮뒗 ?꾩옱 task? 吏곸젒 愿?⑤맂 蹂寃쎈쭔 ?ы븿?쒕떎.

??μ냼 ?뺤콉?대굹 ?ъ슜??吏?쒓? ?먮룞 而ㅻ컠???덉슜?섏? ?딆쑝硫?而ㅻ컠?섏? ?딄퀬 寃곌낵留?湲곕줉?쒕떎.

## `.ai-dev` ?ㅽ뻾 ?곗텧臾?而ㅻ컠/臾댁떆 ?뺤콉

AI Dev Loop???ㅼ젣 湲곕뒫 蹂寃쎄낵 猷⑦봽 ?댁쁺 ?곹깭瑜?遺꾨━?댁꽌 ?ㅻ，?? ?ㅽ뻾 以??앹꽦???뚯씪??議댁옱?쒕떎???댁쑀留뚯쑝濡?湲곕뒫 而ㅻ컠???④
퍡 ?ы븿?섏? ?딅뒗??

### 湲곕뒫 而ㅻ컠

湲곕뒫 而ㅻ컠?먮뒗 ?꾩옱 task???꾨즺 湲곗???異⑹”?섍린 ?꾪빐 ?ㅼ젣濡??섏젙??肄붾뱶? 臾몄꽌留??ы븿?쒕떎.

?ы븿 ?꾨낫:

- ?꾩옱 task??援ы쁽 肄붾뱶
- ?꾩옱 task??吏곸젒 ?꾩슂???뺤콉 臾몄꽌 ?먮뒗 ?섎룞 寃利?泥댄겕由ъ뒪??- ?꾩옱 task媛 紐낆떆?곸쑝濡??앹꽦?섎룄濡??붽뎄???쒗뵆由우씠???덉떆 ?
뚯씪

湲곕뒫 而ㅻ컠?먯꽌 湲곕낯?곸쑝濡??쒖쇅???꾨낫:

- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/review-response.json`

### 猷⑦봽 ?곹깭 而ㅻ컠

猷⑦봽 ?곹깭 而ㅻ컠? goal, queue, state, 寃利? 由щ럭, ?ㅽ뻾 ?대젰????μ냼???④만 ?꾩슂媛 ?덉쓣 ??湲곕뒫 而ㅻ컠怨?蹂꾨룄濡?留뚮뱺??

?ы븿 媛???꾨낫:

- `.ai-dev/goal.md`
- `.ai-dev/backlog.md`
- `.ai-dev/plan.md`
- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`

猷⑦봽 ?곹깭 而ㅻ컠???꾩옱 紐⑺몴? 吏곸젒 愿?⑤맂 ?뚯씪留??좏깮?쒕떎. 紐⑤뱺 ?ㅽ뻾 ?곗텧臾쇱쓣 留ㅻ쾲 而ㅻ컠?섎뒗 寃껋? 湲곕낯媛믪씠 ?꾨땲??

### ????먮뒗 誘쇨컧 ?곗텧臾?
- `.ai-dev/diff.md`? `.ai-dev/review-prompt.md`???꾩껜 diff??臾몄꽌 ?댁슜???ы븿??鍮좊Ⅴ寃?而ㅼ쭏 ???덉쑝誘濡???긽 
而ㅻ컠?섏? ?딅뒗??
- `.ai-dev/review-response.json`? ?몃? 由щ럭 ?묐떟, 誘쇨컧 ?뺣낫, ?λЦ diff瑜??ы븿?????덉쑝誘濡??댁슜???뺤씤?섍린 ?꾩뿉
??而ㅻ컠?섏? ?딅뒗??
- ?ш린媛 ???곗텧臾쇱? ?꾩슂 ???뺣━?섍굅??蹂꾨룄 蹂댁〈 ?뺤콉???곕씪 ?쒖쇅?쒕떎.
- API Key, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?? ?몄쬆 ?뺣낫媛 ?ы븿???곗텧臾쇱? 而ㅻ컠?섏? ?딅뒗??
- ?ㅼ젣 `.gitignore` 蹂寃쎌? 蹂꾨룄 task?먯꽌 ?꾩슂?깃낵 ?곹뼢 踰붿쐞瑜?寃?좏븳 ??吏꾪뻾?쒕떎.

### untracked ?뚯씪怨?由щ럭 ?낅젰

- untracked ?띿뒪???뚯씪???댁슜? ?좉퇋 ?뚯씪 由щ럭瑜??꾪빐 diff ?곗텧臾쇱뿉 ?ы븿?????덈떎.
- 由щ럭???ы븿?덈떎???ъ떎? ?대떦 ?뚯씪??而ㅻ컠?댁빞 ?쒕떎???섎?媛 ?꾨땲??
- untracked ?뚯씪? ?꾩옱 task 踰붿쐞, 誘쇨컧 ?뺣낫, ?뚯씪 ?ш린, ??μ냼 蹂댁〈 ?꾩슂?깆쓣 蹂꾨룄濡??뺤씤????而ㅻ컠 ??곸쓣 寃곗젙?쒕떎.
- 諛붿씠?덈━, ????뚯씪, ?쎄린 ?ㅽ뙣 ?뚯씪? 由щ럭 ?곗텧臾쇱뿉???댁슜???앸왂?????덈떎.

### 而ㅻ컠 ???뺤씤

- 而ㅻ컠 ?꾩뿉??`git status --short`濡?蹂寃??뚯씪???뺤씤?쒕떎.
- 媛?ν븯硫?而ㅻ컠 ?ㅽ겕由쏀듃??`-DryRun` ?먮뒗 ?좏깮 ?뚯씪 而ㅻ컠 諛⑹떇???곗꽑?쒕떎.
- 湲곕뒫 而ㅻ컠怨?猷⑦봽 ?곹깭 而ㅻ컠???욎뿬 ?덉쑝硫?而ㅻ컠??遺꾨━?쒕떎.
- ?덉긽?섏? 紐삵븳 ?ъ슜??蹂寃쎌씠???꾩옱 task 踰붿쐞 諛??뚯씪???덉쑝硫??먮룞 而ㅻ컠??以묐떒?쒕떎.
- `git add .` ?먮뒗 臾댁“嫄댁쟻???꾩껜 stage???ъ슜?섏? ?딅뒗??

## 以묐떒 議곌굔

?ㅼ쓬 以??섎굹?쇰룄 諛쒖깮?섎㈃ ?꾩옱 task ?먮뒗 ?먮룞 媛쒕컻 猷⑦봽瑜?以묐떒?쒕떎.

- ?꾩옱 釉뚮옖移??먮뒗 ?묒뾽 ?섍꼍???뺤콉怨??ㅻⅤ??
- ?묒뾽 ?몃━???덉긽?섏? 紐삵븳 蹂寃쎌씠 ?덈떎.
- 媛숈? 寃利??ㅽ뙣瑜??덉슜???ъ떆???잛닔 ?덉뿉 ?닿껐?섏? 紐삵븳??
- task 踰붿쐞 諛??뚯씪 ?섏젙???꾩슂?섎떎.
- DB schema 蹂寃쎌씠??migration???꾩슂?섎떎.
- 湲곗〈 ?곗씠???먯긽 媛?μ꽦???덉쟾?섍쾶 ?먮떒?????녿떎.
- ?洹쒕え 由ы뙥?곕쭅 ?먮뒗 愿묐쾾?꾪븳 UI 蹂寃쎌씠 ?꾩슂?섎떎.
- ?덈줈???⑦궎吏 ?ㅼ튂??????⑦궎吏 援먯껜媛 ?꾩슂?섎떎.
- ?몃? ?ㅽ듃?뚰겕, ?쒕쾭 API, ?몄쬆 ?뺣낫, API Key媛 ?꾩슂?섎떎.
- ?뚯뒪???먮뒗 由щ럭 寃곌낵??P1 臾몄젣媛 ?⑥븘 ?덈떎.
- ?ъ슜??吏?쒖? ??μ냼 ?뺤콉??異⑸룎?쒕떎.
- ?ъ슜???쒕룄, 沅뚰븳 ?쒗븳, ?ㅽ듃?뚰겕 ?쒗븳?쇰줈 ?덉쟾?섍쾶 怨꾩냽?????녿떎.

以묐떒 ??`.ai-dev/state.json`怨?`.ai-dev/loop-log.md`??以묐떒 ?ъ쑀? ?ㅼ쓬???꾩슂???ъ슜??寃곗젙??湲곕줉?쒕떎.

## 湲덉? ?ы빆

- ?꾩옱 task 踰붿쐞 諛??뚯씪???꾩쓽濡??섏젙?섏? ?딅뒗??
- ?ъ슜??蹂寃??ы빆???섎룎由ъ? ?딅뒗??
- 寃利??ㅽ뙣 ?곹깭?먯꽌 ?ㅼ쓬 task濡??섏뼱媛吏 ?딅뒗??
- 寃利앺븯吏 ?딆? 寃곌낵瑜??듦낵濡?湲곕줉?섏? ?딅뒗??
- 由щ럭?먯꽌 ?뺤씤?섏? ?딆? 蹂寃쎌쓣 ?먮룞 而ㅻ컠?섏? ?딅뒗??
- `git add .`, 媛뺤젣 push, destructive git 紐낅졊???ъ슜?섏? ?딅뒗??
- ?ъ슜???뱀씤 ?놁씠 諛고룷?섍굅???먭꺽 釉뚮옖移섏뿉 push?섏? ?딅뒗??
- ?ㅼ젣 ?ъ슜???곗씠?곕? ??젣?섍굅??珥덇린?뷀븯吏 ?딅뒗??
- DB schema瑜?怨꾪쉷 ?놁씠 蹂寃쏀븯吏 ?딅뒗??
- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? `localStorage`瑜??꾩쓽濡?異붽??섏? ?딅뒗??
- API Key, 媛쒖씤?뺣낫, 諛깆뾽 ?곗씠?곕? ?몃?濡??꾩넚?섏? ?딅뒗??
- ?먮룞???몄쓽瑜??꾪빐 蹂댁븞 ?뺤콉?대굹 ??μ냼 洹쒖튃???꾪솕?섏? ?딅뒗??

## 珥덇린 ?ㅽ뿕 踰붿쐞

Level 5 ?먮룞 媛쒕컻 猷⑦봽??珥덇린 ?ㅽ뿕? ?꾪뿕?꾧? ??퀬 ?섎룎由ш린 ?ъ슫 ?묒뾽?쇰줈 ?쒗븳?쒕떎.

?덉슜 ?꾨낫:

- 臾몄꽌 ?뺣━
- ?묒? ?쒖닔 ?좏떥 遺꾨━
- unused import ?먮뒗 helper ?뺣━
- 湲곗〈 湲곕뒫??諛붽씀吏 ?딅뒗 ?묒? 而댄룷?뚰듃 ?뺣━
- ?섎룞 ?뚯뒪??泥댄겕由ъ뒪??蹂닿컯

珥덇린 ?ㅽ뿕?먯꽌 湲덉??섎뒗 ?묒뾽:

- ?ㅼ젣 DB ??젣 ?먮뒗 珥덇린??- DB schema 蹂寃??먮뒗 migration
- ?洹쒕え 由ы뙥?곕쭅
- ?⑦궎吏 ???援먯껜
- ?꾩옱 task 踰붿쐞 諛??섏젙
- ?뚯씪 媛?몄삤湲? 蹂듭썝, ??뼱?곌린, 蹂묓빀泥섎읆 ?곗씠???먯긽 ?꾪뿕???덈뒗 湲곕뒫
- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린?? ?뚮┝, Capacitor 異붽?
- ?ъ슜???뱀씤 ?녿뒗 push ?먮뒗 諛고룷

## ?꾩엯 ???뺤씤 ?ы빆

?ㅼ젣 ?먮룞???ㅽ겕由쏀듃瑜?留뚮뱾湲??꾩뿉 ?ㅼ쓬 ??ぉ??蹂꾨룄 ?묒뾽?쇰줈 ?뺤젙?쒕떎.

- `.ai-dev` ?뚯씪??JSON schema? ?꾩닔 ?꾨뱶
- task蹂?理쒕? ?ъ떆???잛닔
- build, test, lint 紐낅졊 ?좏깮 湲곗?
- GPT 由щ럭??P1/P2/P3 ?먯젙 湲곗?
- ?먮룞 而ㅻ컠 ?덉슜 踰붿쐞? 釉뚮옖移??뺤콉
- ?ъ슜???쒕룄 ?먮뒗 沅뚰븳 ?쒗븳 諛쒖깮 ??蹂듦뎄 ?덉감
- 濡쒓렇 蹂댁〈 湲곌컙怨?誘쇨컧 ?뺣낫 湲곕줉 湲덉? 湲곗?
- ?щ엺??猷⑦봽瑜?以묒??섍굅???ш컻?섎뒗 諛⑸쾿

codex
기존 문서는 PowerShell 기본 출력에서 글자가 깨져 보이므로 UTF-8로 다시 읽어 필요한 구조만 참고하겠습니다. 문서 작성 자체는 UTF-8 Markdown으로 진
행하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath docs\\ai-dev-loop-policy.md -Encoding UTF8" in D:\ai-apps\planpilot-local
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath docs\\ai-dev-loop-operation.md -Encoding UTF8" in D:\ai-apps\planpilot-local
 succeeded in 2211ms:
# PlanPilot Local AI 자동 개발 루프 정책

이 문서는 사용자가 목표를 입력하면 AI가 작업을 분해하고, 구현하고, 검증하고, 리뷰하고, 작업 단위로 자동 커밋하는 Level 5 자동 개발 루프의 기준을 정리한다.

현재 문서는 정책 문서이며, 실제 자동화 스크립트, 실행기, 감시 프로세스, CI 연동은 구현하지 않는다.

## 목적

- 사용자는 구현 세부사항보다 달성할 목표와 우선순위를 입력한다.
- AI는 목표를 작은 작업으로 분해하고 한 번에 하나씩 안전하게 처리한다.
- 각 작업은 구현, 검증, 리뷰, 커밋 결과를 독립적으로 추적할 수 있어야 한다.
- 자동화가 장시간 실행되더라도 현재 작업 범위를 벗어나지 않아야 한다.
- 저장소의 `AGENTS.md`, 보안 정책, 금지 사항, 사용자 지시는 자동 개발 루프보다 항상 우선한다.

## Level 5 자동 개발 루프 정의

Level 5 자동 개발 루프는 사용자가 `.ai-dev/goal.md`에 목표를 작성한 뒤, AI가 다음 작업을 스스로 선택하고 완료 상태까지 진행하는 운영 방식이다.

AI가 담당하는 범위:

- 목표 분석
- 작업 분해
- 실행 순서 결정
- 현재 작업 구현
- build, test, lint 실행
- 실패 원인 분석과 허용 범위 내 재수정
- GPT 기반 변경 리뷰
- 리뷰 지적사항 반영
- 자동 커밋
- 다음 작업 선택
- 진행 상태와 로그 기록

AI는 목표가 불명확하거나 안전하게 판단할 수 없는 경우 임의로 범위를 확장하지 않고 중단한다.

## 기본 동작 흐름

1. `.ai-dev/goal.md`와 `.ai-dev/backlog.md`를 읽는다.
2. 저장소의 `AGENTS.md`와 현재 작업 트리 상태를 확인한다.
3. 목표를 작은 task로 분해하고 `.ai-dev/plan.md`와 `.ai-dev/queue.json`을 갱신한다.
4. queue에서 우선순위가 가장 높고 실행 가능한 task 하나를 선택한다.
5. 선택한 task의 수정 예정 파일, 위험도, 검증 방법을 기록한다.
6. 현재 task 범위 안에서만 구현한다.
7. task에 필요한 build, test, lint를 실행한다.
8. 실패하면 같은 task 범위 안에서 원인을 수정하고 다시 검증한다.
9. 검증이 성공하면 전체 변경 diff를 GPT가 리뷰한다.
10. 리뷰 지적사항이 있으면 같은 task 범위 안에서 수정하고 다시 검증한다.
11. 자동 커밋 조건을 모두 만족하면 task 단위 커밋을 만든다.
12. `.ai-dev/state.json`, `.ai-dev/test-result.md`, `.ai-dev/review.md`, `.ai-dev/loop-log.md`를 
갱신한다.
13. 다음 task를 선택하거나 중단 조건에 따라 루프를 종료한다.

## 사람이 입력하는 파일

### `.ai-dev/goal.md`

사용자가 달성하려는 목표를 작성하는 파일이다.

포함 권장 항목:

- 목표
- 완료 기준
- 허용 범위
- 금지 범위
- 우선순위
- 참고 문서
- 검증 방법
- 커밋 또는 배포 제한

목표는 가능한 한 결과 중심으로 작성한다. 구현 방식은 저장소 구조와 정책에 맞춰 AI가 판단할 수 있다.

### `.ai-dev/backlog.md`

사용자가 원하는 후속 작업, 아이디어, 낮은 우선순위 후보를 기록하는 파일이다.

정책:

- backlog 항목은 자동 실행이 확정된 task가 아니다.
- AI는 현재 goal과 직접 관련된 항목만 queue 후보로 올린다.
- 위험도가 높거나 범위가 큰 항목은 문서화 task로 전환할 수 있다.
- 현재 goal과 무관한 backlog 항목은 임의로 구현하지 않는다.

## AI가 생성하거나 수정하는 파일

### `.ai-dev/plan.md`

현재 goal을 어떤 단계로 처리할지 사람이 읽을 수 있는 형태로 정리한다.

포함 항목:

- 목표 요약
- 작업 분해 결과
- 작업 순서
- 예상 수정 파일
- 작업별 위험도
- 검증 계획
- 중단 조건

### `.ai-dev/queue.json`

자동 개발 루프가 처리할 task 목록과 상태를 구조화해 저장한다.

task 상태 후보:

- `pending`
- `in_progress`
- `blocked`
- `completed`
- `skipped`

각 task는 최소한 다음 정보를 포함해야 한다.

- 고유 id
- 제목
- 목적
- 우선순위
- 허용 수정 파일
- 검증 명령
- 커밋 메시지 후보
- 현재 상태

### `.ai-dev/state.json`

자동 개발 루프의 현재 실행 상태를 기록한다.

포함 항목:

- 현재 goal
- 현재 task id
- 마지막 완료 task id
- 마지막 성공 검증 시각
- 마지막 커밋 hash
- 재시도 횟수
- 중단 사유

### `.ai-dev/test-result.md`

작업별 build, test, lint 실행 결과를 기록한다.

정책:

- 실행하지 않은 검증은 통과로 기록하지 않는다.
- 실패한 검증은 원인과 재시도 결과를 남긴다.
- 검증 명령이 저장소에 없거나 실행이 허용되지 않으면 미수행 사유를 남긴다.

### `.ai-dev/review.md`

작업별 GPT 리뷰 결과를 기록한다.

검토 항목:

- 타입 오류 가능성
- 빌드 또는 테스트 실패 가능성
- 런타임 오류 가능성
- 기존 기능 회귀 가능성
- 현재 task 범위 밖 수정 여부
- `AGENTS.md` 위반 여부
- 보안, 데이터 손상, 개인정보 유출 위험

### `.ai-dev/loop-log.md`

자동 개발 루프의 실행 이력을 시간 순서로 기록한다.

포함 항목:

- task 선택
- 수정 파일
- 검증 결과
- 리뷰 결과
- 커밋 결과
- 중단 또는 재시도 사유

## 작업 단위 원칙

- 한 번에 하나의 task만 수행한다.
- 하나의 task는 하나의 명확한 목적만 가져야 한다.
- task 범위 밖 파일은 수정하지 않는다.
- 각 task는 독립적으로 검증할 수 있어야 한다.
- 각 task는 검증 성공 후 하나의 커밋으로 만든다.
- 관련성이 낮은 변경을 하나의 커밋에 묶지 않는다.
- 큰 기능은 구현, 정책 문서화, 검증 보강을 별도 task로 나눈다.
- 대규모 변경이 필요한 경우 작은 선행 task로 다시 분해한다.

## 자동화 단계

### 1. goal 분석

- 목표와 완료 기준을 확인한다.
- 허용 범위와 금지 범위를 분리한다.
- 저장소 정책과 충돌하는 요구가 있는지 확인한다.
- 불명확한 조건이 안전성에 영향을 주면 중단하고 사용자 확인을 요청한다.

### 2. queue 생성

- 목표를 작은 task로 분해한다.
- 위험도가 낮고 선행 조건이 충족된 task를 앞에 둔다.
- DB schema 변경, 대규모 리팩터링, 외부 네트워크 연동은 별도 검토 task로 분리한다.

### 3. current task 선택

- `pending` 상태 중 우선순위가 가장 높은 task 하나를 선택한다.
- 이전 task가 실패했거나 검증되지 않았으면 다음 task로 넘어가지 않는다.
- 현재 작업 트리가 예상하지 못한 변경을 포함하면 새 task를 시작하지 않는다.

### 4. 구현

- 수정 예정 파일과 위험도를 기록한다.
- 기존 코드 스타일, 타입, store, DB 구조를 우선 사용한다.
- task 범위 밖 리팩터링이나 기능 추가를 하지 않는다.

### 5. build/test/lint 실행

- task에 필요한 검증 명령만 실행한다.
- 실행 권한과 저장소 정책을 먼저 확인한다.
- 실행하지 않은 검증은 미수행으로 기록한다.

### 6. 실패 시 재수정

- 실패 원인을 현재 task 범위 안에서만 수정한다.
- 같은 문제가 반복되면 재시도 횟수를 기록한다.
- 허용 범위를 넘어야 해결할 수 있으면 중단한다.

### 7. GPT 리뷰

- 전체 diff를 기준으로 변경을 검토한다.
- P1 수준의 데이터 손상, 보안, 런타임 오류, 주요 회귀 위험이 있으면 커밋하지 않는다.
- P2/P3 지적사항은 현재 task 범위 안에서 안전하게 해결할 수 있을 때만 반영한다.

## 수동 GPT 리뷰 브리지 정책

현재 AI Dev Loop는 GPT API 키가 없는 환경에서도 ChatGPT 웹 화면을 사용해 리뷰를 진행할 수 있어야 한다. 이 흐름은 API 자동 호출이 아니라 사람이
 검토 내용을 옮기는 수동 브리지이며, 자동화 스크립트는 프롬프트 생성, 클립보드 복사, 리뷰 JSON 저장 안내까지만 돕는다.

### 기본 원칙

- GPT API를 직접 호출하지 않는다.
- ChatGPT 웹 화면에 자동으로 접속하거나 입력하지 않는다.
- `review-prompt.md`는 로컬에서 생성한다.
- 사용자는 prompt 내용을 확인한 뒤 ChatGPT 웹 화면에 직접 붙여넣는다.
- ChatGPT에는 리뷰 결과를 지정된 JSON 형식만 출력하도록 요청한다.
- 사용자는 ChatGPT가 반환한 JSON 리뷰를 복사한다.
- 리뷰 JSON은 `ai-dev-save-review.ps1 -FromClipboard` 또는 별도 수동 브리지 helper를 통해 저장한다.
- 리뷰 저장 뒤에는 기존 decision 규칙에 따라 `pass`, `revise`, `blocked` 흐름을 계속 진행한다.

### 수동 리뷰 흐름

1. `ai-dev-make-review-prompt.ps1`가 `.ai-dev/review-prompt.md`를 생성한다.
2. 사용자는 `review-prompt.md` 내용을 클립보드에 복사한다.
3. 사용자는 ChatGPT 웹 화면에 prompt를 붙여넣는다.
4. ChatGPT는 JSON 리뷰만 출력해야 한다.
5. 사용자는 JSON 리뷰 전체를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`가 클립보드의 JSON을 파싱해 `.ai-dev/review.md`와 `.ai-dev/state.
json`을 갱신한다.
7. decision이 `pass`이면 complete-task 또는 commit 단계로 진행한다.
8. decision이 `revise`이면 revise prompt를 생성해 Codex/Cline에 수동으로 전달한다.
9. decision이 `blocked`이면 사용자 판단을 기다린다.

### auto-step과 수동 브리지

`ai-dev-auto-step.ps1`는 `ask_gpt_review` 상태에서 GPT API를 호출하지 않는다. 대신 수동 리뷰 브리지에 필요한 다음 행동을 안내해야 한
다.

안내 후보:

- `review-prompt.md` 생성 여부 확인
- `review-prompt.md` 클립보드 복사 명령 안내
- ChatGPT 웹 화면에 붙여넣으라는 안내
- JSON 리뷰만 받아야 한다는 안내
- 리뷰 JSON을 복사한 뒤 `ai-dev-save-review.ps1 -FromClipboard`를 실행하라는 안내

### manual-cycle과 수동 브리지

`ai-dev-manual-cycle.ps1`는 현재 상태와 다음 action을 함께 보여주는 수동 운영 대시보드다. 사용자는 `manual-cycle` 결과에서 `ask_
gpt_review`를 확인한 뒤 수동 리뷰 브리지로 전환한다.

권장 흐름:

1. `ai-dev-manual-cycle.ps1`로 현재 task, git 상태, test-result, review 상태, next action을 확인한다.
2. next action이 `ask_gpt_review`이면 `ai-dev-copy-review-prompt.ps1`로 `review-prompt.md`를 클립보드에 복사
한다.
3. 사용자가 ChatGPT 웹 화면에 prompt를 붙여넣는다.
4. ChatGPT에는 JSON 리뷰만 출력하도록 요청한다.
5. 사용자가 JSON 리뷰를 클립보드에 복사한다.
6. `ai-dev-save-review.ps1 -FromClipboard`로 리뷰 결과를 저장한다.
7. 저장된 decision에 따라 다음 단계를 선택한다.

decision별 기준:

- `pass`: 현재 task 완료 처리 또는 커밋 조건 검토로 진행한다.
- `revise`: `ai-dev-make-revise-prompt.ps1`로 재수정 프롬프트를 만들고 Codex/Cline에 수동으로 전달한다.
- `blocked`: 사용자 판단이 필요하므로 루프를 중단하고 요구사항, 범위, 위험도를 다시 확인한다.

이 흐름은 GPT API 키가 없어도 동작한다. 단, `review-prompt.md`에는 diff와 테스트 결과가 포함될 수 있으므로 ChatGPT에 붙여넣기 전에 사용자
가 민감 정보와 대형 diff 포함 여부를 확인해야 한다.

### 민감 정보와 공유 범위

`review-prompt.md`에는 git diff, 테스트 결과, 현재 task 설명이 포함될 수 있다. diff 안에 민감 정보, 백업 데이터, 개인정보, API Ke
y, 대형 파일 내용이 포함될 수 있으므로 사용자는 ChatGPT에 붙여넣기 전에 prompt 내용을 확인해야 한다.

정책:

- API Key, 개인정보, 백업 데이터가 포함된 prompt는 외부 ChatGPT 화면에 붙여넣지 않는다.
- `diff.md`와 `review-prompt.md`가 너무 크면 범위를 줄이거나 산출물을 정리한 뒤 다시 생성한다.
- 민감 정보가 의심되면 리뷰 브리지 흐름을 중단하고 사용자 판단을 받는다.
- 수동 리뷰 브리지는 편의 기능일 뿐, 보안 판단을 자동화하지 않는다.

### 8. 리뷰 반영

- 리뷰 수정 후 필요한 검증을 다시 실행한다.
- 수정으로 task 범위가 커지면 중단하고 queue를 다시 분해한다.

### 9. 자동 커밋

- 자동 커밋 조건을 모두 만족한 경우에만 수정한 파일을 명시적으로 stage한다.
- `git add .`는 사용하지 않는다.
- 커밋 메시지는 짧고 명확한 영어 문장으로 작성한다.

### 10. 다음 task 선택

- 현재 task의 상태, 검증 결과, 리뷰 결과, 커밋 hash를 기록한다.
- 다음 task의 선행 조건을 확인한다.
- 중단 조건이 없을 때만 다음 task를 시작한다.

## auto-step 동작 정책

`ai-dev-auto-step.ps1`는 현재 queue, state, review, test, git 상태를 읽고 안전한 다음 한 단계만 처리하는 보조 스크립트다. 완전
 자동 개발 루프 실행기가 아니며, 사용자 판단이나 외부 AI 호출이 필요한 순간에는 중단하거나 다음 명령만 안내한다.

### 기본 원칙

- 한 번 실행할 때 하나의 action만 처리한다.
- `ai-dev-next.ps1`가 판단하는 다음 action을 기반으로 동작한다.
- 상태 파일과 프롬프트 파일을 갱신하는 안전한 로컬 스크립트만 자동 실행한다.
- Codex, Cline, GPT API, git commit, git push는 자동 실행하지 않는다.
- destructive git 명령, DB 삭제/복원/마이그레이션, package 설치는 자동 실행하지 않는다.
- 실패하면 state와 출력에 실패 이유를 남기고 다음 action으로 진행하지 않는다.

### 자동 실행 허용 후보

초기 auto-step에서 자동 실행할 수 있는 후보는 로컬 파일 생성 또는 검증 보조 작업으로 제한한다.

- `current-task-prompt.md`가 없을 때 `scripts/ai-dev-make-prompt.ps1` 실행
- 검증이 필요한 상태에서 명시적으로 안전한 옵션이 선택된 경우 `scripts/ai-dev-check.ps1` 실행
- diff 저장이 필요한 상태에서 `scripts/ai-dev-save-diff.ps1` 실행
- review prompt 생성이 필요한 상태에서 `scripts/ai-dev-make-review-prompt.ps1` 실행
- revise prompt 생성이 필요한 상태에서 사용자가 명시적으로 허용한 경우 `scripts/ai-dev-make-revise-prompt.ps1` 실행 후보 검토

`ai-dev-check.ps1`는 프로젝트 명령을 실행할 수 있으므로 기본 자동 실행 범위는 보수적으로 둔다. 초기 구현은 DryRun 또는 명시적 안전 옵션에서만 che
ck 실행을 허용한다.

### 자동 실행 금지 또는 중단 후보

다음 상태에서는 auto-step이 직접 작업하지 않고 사용자에게 다음 행동을 안내하거나 중단한다.

- Codex 또는 Cline이 현재 task 구현을 수행해야 하는 경우
- GPT 리뷰가 필요한 경우
- 리뷰 결과가 `blocked`인 경우
- 리뷰 결과가 `revise`이고 재수정 범위가 불명확한 경우
- git commit이 필요한 경우
- git push, PR 생성, 배포가 필요한 경우
- 사용자 데이터 삭제, 복원, 덮어쓰기, 마이그레이션 위험이 있는 경우
- package 설치 또는 package 파일 변경이 필요한 경우
- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우

특히 git commit은 이번 목표의 auto-step 자동 실행 범위에서 제외한다. auto-step은 커밋이 필요하다는 사실과 추천 명령을 안내할 수는 있지만 `ai-
dev-commit.ps1`를 직접 실행하지 않는다.

### auto-cycle 동작 기준

`ai-dev-auto-cycle.ps1`는 auto-step을 제한 횟수 안에서 반복하는 보조 스크립트다.

- `-MaxSteps` 같은 반복 제한을 둔다.
- 각 반복은 auto-step 한 번의 결과를 확인한 뒤 다음 반복 여부를 판단한다.
- 사용자 개입 필요 action, blocked, failed, commit 필요, Codex/GPT 필요 상태에서는 중단한다.
- 같은 action이 반복되거나 상태가 변하지 않으면 무한 루프 위험으로 중단한다.
- auto-cycle도 Codex/GPT API 호출, git commit, git push를 자동 실행하지 않는다.

### 관련 명령 역할 구분

- `ai-dev-next.ps1`: 현재 상태를 읽고 다음 추천 action과 명령만 안내한다. 파일 수정이나 하위 명령 실행을 하지 않는다. “다음에 무엇을 해야 하지?
”만 알고 싶을 때 사용한다.
- `ai-dev-manual-cycle.ps1`: 상태 요약과 다음 행동 안내를 한 번에 보여주는 수동 운영 대시보드다. 현재 task, 검증, 리뷰, diff 파일 상태
를 함께 보며 사람이 직접 다음 명령을 고를 때 사용한다.
- `ai-dev-auto-step.ps1`: `next` 판단 결과를 기반으로 안전하다고 정의된 다음 한 단계를 실행한다. 프롬프트 생성 같은 로컬 보조 작업은 실행할 수
 있지만 Codex/GPT/commit 단계에서는 멈춘다.
- `ai-dev-auto-cycle.ps1`: 제한 횟수 안에서 auto-step을 반복한다. 여러 안전 단계를 이어가고 싶을 때 사용하지만, 사용자 개입 필요 actio
n, 실패, blocked, commit 필요 상태에서는 멈춘다.

사용 추천:

- 상황 파악: `ai-dev-manual-cycle.ps1`
- 다음 행동만 확인: `ai-dev-next.ps1`
- 안전한 자동 1단계 실행: `ai-dev-auto-step.ps1`
- 안전 단계 반복 실행: `ai-dev-auto-cycle.ps1`

`ai-dev-auto-step.ps1`와 `ai-dev-auto-cycle.ps1`는 Codex/Cline 실행, GPT 리뷰 요청, git commit을 자동 실행하지 
않는다.

## 수동 자동화 UX 개선 기준

AI Dev Loop는 GPT API 없이도 사람이 다음 행동을 빠르게 판단할 수 있어야 한다. 자동화 스크립트는 실행 여부보다 현재 상태, 중단 이유, 추천 명령, 위험 
여부를 명확히 보여주는 것을 우선한다.

### 다음 행동 판단 순서

사용자가 현재 상태를 판단할 때는 아래 명령을 우선 확인한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-status.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-next.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-manual-cycle.ps1
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-step.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle.ps1 -DryRun -MaxSteps 3
```

- `status`: 현재 goal/task/test/review/git 상태를 확인한다.
- `next`: 다음 action과 추천 명령만 확인한다.
- `manual-cycle`: 상태와 다음 action을 한 화면에서 확인한다.
- `auto-step -DryRun`: 실제 실행 없이 auto-step이 무엇을 할지 확인한다.
- `auto-cycle -DryRun -MaxSteps 3`: 제한된 반복 안에서 어디에서 멈출지 확인한다.

### goal_completed 상태 UX

`goal_completed` 상태에서는 더 이상 실행할 task가 없음을 명확히 안내해야 한다.

정책:

- `auto-step`은 완료된 goal에서 추가 작업을 실행하지 않는다.
- `auto-cycle`은 완료 상태를 반복하지 않고 `completed: true`로 종료해야 한다.
- 출력에는 새 목표를 시작하려면 `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json`을 새 goal 기준으로 초기
화해야 한다는 안내를 포함한다.
- 완료 상태에서 build/test/review/commit을 자동으로 실행하지 않는다.

### ask_gpt_review 상태 UX

`ask_gpt_review` 상태는 사람이 ChatGPT 웹 화면에서 리뷰를 수행해야 하는 지점이다.

정책:

- `auto-step`과 `auto-cycle`은 GPT API를 호출하지 않는다.
- `auto-cycle`은 `ask_gpt_review`에서 멈출 때 수동 리뷰 브리지 명령을 함께 보여줘야 한다.
- JSON 출력에도 `ai-dev-copy-review-prompt.ps1`와 `ai-dev-save-review.ps1 -FromClipboard` 명령이 포함되어야 한
다.
- message에는 review-prompt 복사, ChatGPT 붙여넣기, JSON 리뷰 복사, save-review 실행 흐름을 짧게 설명한다.

### save-review 실패와 상태 오염 방지

리뷰 JSON 파싱 실패는 사용자가 잘못된 클립보드 내용을 복사했을 때 자주 발생할 수 있다. 이 실패가 이미 완료된 goal이나 정상 review 상태를 불필요하게 오염시
키면 안 된다.

개선 방향:

- 잘못된 JSON 입력은 preview를 포함해 원인을 설명한다.
- 가능한 경우 실패 입력을 기존 `review.md`와 `state.json`에 즉시 덮어쓰기 전에 보존 여부를 선택할 수 있게 한다.
- `goalStatus`가 `completed`인 상태에서는 실패한 임시 리뷰 입력만으로 완료 상태를 `blocked`처럼 보이게 만들지 않는다.
- 정상 JSON 저장 흐름과 실패 기록 흐름을 구분한다.
- 상태 파일을 갱신하는 경우 어떤 필드를 바꾸는지 출력 또는 문서로 확인할 수 있어야 한다.

### 최종 검증 결과 기록 UX

T006 같은 최종 검증 task는 build/test/lint 외에도 PowerShell 문법 검증, `auto-step`/`auto-cycle` DryRun, `save
-review` 성공/실패 흐름 확인이 필요하다.

정책:

- 실행한 검증 명령과 결과를 `test-result.md`에 남긴다.
- 실행하지 않은 검증은 통과로 기록하지 않는다.
- 최종 검증에서 확인한 수동 명령, exit code, 주요 출력 요약을 기록한다.
- build/test/lint 흐름은 기존 `ai-dev-check.ps1` 동작과 충돌하지 않아야 한다.
- 문법 검증이나 DryRun 결과를 기록할 때는 `ai-dev-check.ps1 -ManualSummaryOnly -ManualSummary "..."`를 사용할 수 있다
.
- 수동 요약 기록 모드는 npm build/test/lint를 실행하지 않는다.
- 수동 요약에는 PowerShell 문법 검증 결과, `auto-step` DryRun 결과, `auto-cycle` DryRun 결과, `save-review` 실패/성
공 흐름 확인, git status 확인처럼 사람이 실제로 수행한 항목만 적는다.
- 실행하지 않은 검증 항목은 수동 요약에 통과로 적지 않는다.
- 수동 요약 모드의 `state.json.lastCommandStatus`는 기록 작업 성공 여부를 뜻하며, 검증 자체의 통과/실패/미수행 판단은 `test-result.
md` 본문에 남긴다.

## Codex CLI 완전 자동화 정책

AI Dev Loop의 다음 자동화 단계는 Codex CLI를 구현자와 리뷰어로 사용한다. GPT API Key, Cline, Copilot CLI, `gh` 없이 로컬 저
장소 안에서 `codex exec` 기반 실행 흐름을 구성한다.

현재 환경 기준:

- Codex CLI: `codex-cli 0.133.0`
- 실행 방식: `codex exec`
- workdir: `D:\ai-apps\planpilot-local`
- approval: `never`
- sandbox: `workspace-write`
- Cline: 삭제되어 사용하지 않음
- Copilot CLI, `gh`: 현재 사용하지 않음

### 역할 분리

- 구현자 역할: `current-task-prompt.md`를 Codex CLI에 전달해 현재 task 범위 안의 코드 또는 문서 수정을 수행한다.
- 리뷰어 역할: `review-prompt.md`를 Codex CLI에 전달해 지정된 JSON 형식의 리뷰 결과를 생성한다.
- 리뷰 저장: Codex 리뷰 결과는 `.ai-dev/review-response.json`에 저장한 뒤 `ai-dev-save-review.ps1` 흐름으로 `.ai-d
ev/review.md`와 `.ai-dev/state.json`에 반영한다.
- 루프 기록: 구현 결과, 리뷰 결과, 실패 요약은 `.ai-dev/codex-result.md`, `.ai-dev/review-response.json`, `.ai-de
v/loop-log.md`, `.ai-dev/state.json`에 남긴다.

### 초기 full auto-cycle 제한

초기 `ai-dev-auto-cycle-full.ps1`는 안전을 위해 작은 범위에서만 동작해야 한다.

- 기본 검증 단위는 `MaxTasks 1`로 제한한다.
- Codex 구현 실행은 명시적 `AllowCodex` 옵션이 있을 때만 수행한다.
- Codex 리뷰 실행은 명시적 `AllowReviewCodex` 옵션이 있을 때만 수행한다.
- git commit은 명시적 `AllowCommit` 옵션이 있을 때만 수행한다.
- goal 입력 기반 실행은 `ai-dev-auto-goal.ps1`에서 시작하되, full cycle 호출은 명시적 실행 옵션이 있을 때만 수행한다.
- git push, PR 생성, 배포는 자동화 범위에서 제외한다.

### 허용 명령과 허용 단계

명시적 Allow 옵션과 안전 조건을 만족할 때만 다음 단계를 자동화 후보로 둔다.

- `ai-dev-make-prompt.ps1`로 현재 task prompt 생성
- `ai-dev-run-codex.ps1`로 Codex 구현 실행
- `ai-dev-check.ps1`로 build/check 실행
- `ai-dev-save-diff.ps1`로 diff 저장
- `ai-dev-make-review-prompt.ps1`로 리뷰 prompt 생성
- `ai-dev-run-review-codex.ps1`로 Codex 리뷰 실행
- `ai-dev-save-review.ps1`로 리뷰 JSON 저장
- 리뷰가 `pass`이고 모든 게이트를 통과한 경우에만 `ai-dev-commit.ps1`와 `ai-dev-complete-task.ps1` 연결

### 목표 입력 기반 자동 실행 정책

최종 목표는 사용자가 `GoalTitle`과 `GoalDescription`만 입력해 task 생성부터 Codex 구현, 검증, Codex 리뷰, pass 시 커밋과 tas
k 완료 처리까지 이어갈 수 있게 하는 것이다.

예상 최종 명령:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\ai-dev-auto-goal.ps1 -GoalTitle "업무 검색 결과 하이라
이트 추가" -GoalDescription "검색어와 일치하는 업무 제목/메모/프로젝트명을 화면에서 강조 표시한다." -AllowCodex -AllowReviewCodex 
-AllowCommit -MaxTasks 1
```

`ai-dev-auto-goal.ps1`의 책임:

- `GoalTitle`과 `GoalDescription` 필수 입력 검증
- Codex CLI를 이용한 goal/queue/state 초안 생성
- 생성된 JSON 파싱과 필수 필드 검증
- `.ai-dev/goal.md`, `.ai-dev/queue.json`, `.ai-dev/state.json` 갱신 후보 표시
- `.ai-dev/current-task-prompt.md` 생성 연결
- 명시적 실행 옵션이 있을 때만 `ai-dev-auto-cycle-full.ps1` 호출
- DryRun에서 생성될 goal/task 계획과 실행 단계를 표시
- Json 출력에서 사람이 읽는 텍스트를 섞지 않음

안전 기준:

- `GoalTitle` 또는 `GoalDescription`이 비어 있으면 종료한다.
- Codex가 생성한 goal/queue/state JSON을 파싱할 수 없으면 종료한다.
- `queue.json` 필수 필드와 task 필수 필드가 없으면 종료한다.
- `state.json` 필수 필드가 없으면 종료한다.
- 실제 full cycle 실행은 `AllowRun` 또는 그에 준하는 명시적 실행 옵션이 있을 때만 수행한다.
- `AllowCodex`, `AllowReviewCodex`, `AllowCommit`은 각각 구현, 리뷰, 커밋 단계를 별도로 연다.
- package 파일 변경, build/check 실패, 리뷰 decision이 `pass`가 아닌 경우 자동 커밋하지 않는다.

### 금지 명령과 금지 단계

다음 작업은 full auto-cycle에서 자동 실행하지 않는다.

- GPT API 직접 호출
- Cline 실행
- Copilot CLI 실행
- `gh` 또는 GitHub PR 자동 연동
- `git push`
- `git reset`
- `git clean`
- destructive `git checkout` 또는 사용자 변경 되돌리기
- `npm install`
- package 대량 교체
- DB 삭제, 초기화, 복원, 마이그레이션
- 사용자 데이터 덮어쓰기

### 자동 커밋 게이트

자동 커밋은 다음 조건을 모두 만족해야만 가능하다.

- `AllowCommit`이 명시적으로 지정되어 있다.
- build/check가 성공했다.
- 리뷰 decision이 `pass`다.
- `package.json`과 `package-lock.json`이 변경되지 않았다.
- 현재 task 범위 밖 파일이 포함되지 않았다.
- dirty worktree가 예상 변경만 포함한다.
- `git reset`, `git clean`, `npm install` 없이 완료 가능하다.

다음 경우에는 자동 커밋하지 않는다.

- build/check 실패
- 리뷰 decision이 `revise` 또는 `blocked`
- 리뷰 JSON 파싱 실패
- package 파일 변경 감지
- 예상하지 못한 사용자 변경 감지
- 현재 task 범위 밖 수정 감지

### 안전 중단 조건

Codex CLI 자동화는 아래 조건에서 즉시 중단한다.

- Codex 구현 실행 전 `git status`가 dirty인 경우
- `current-task-prompt.md` 또는 `review-prompt.md`가 없거나 현재 task와 맞지 않는 경우
- Codex 실행 결과가 실패하거나 출력이 비어 있는 경우
- Codex 리뷰 결과에서 JSON 객체를 추출할 수 없는 경우
- build/check가 실패한 경우
- package 파일 변경이 감지된 경우
- 리뷰 decision이 `pass`가 아닌 경우
- DB schema 변경, 데이터 삭제, 복원, 마이그레이션이 필요한 경우
- 같은 오류가 반복되어 안전하게 진행할 수 없는 경우

실패 시에는 실패를 리뷰 결과로 오인하지 않도록 주의한다. 특히 이미 `completed`인 goal을 임시 입력 오류나 Codex 실행 실패만으로 `blocked`처럼 보
이게 만들지 않는다. 필요한 경우 `state.json`에는 실패 요약만 기록하고, 기존 완료 상태를 덮어쓸지 여부는 별도 정책과 사용자 판단을 따른다.

## 자동 커밋 조건

다음 조건을 모두 만족해야 자동 커밋할 수 있다.

- 현재 task의 완료 기준을 충족했다.
- 허용된 파일만 수정되었다.
- 예상하지 못한 사용자 변경이 없다.
- 필요한 build, test, lint가 성공했다.
- 실행하지 못한 필수 검증이 없다.
- GPT 리뷰에서 P1 문제가 없다.
- 리뷰 지적사항을 반영한 뒤 재검증이 성공했다.
- `AGENTS.md`와 사용자 지시를 위반하지 않았다.
- lock file, DB schema, 보안 관련 변경이 허용 범위 밖에서 발생하지 않았다.
- 커밋에는 현재 task와 직접 관련된 변경만 포함된다.

저장소 정책이나 사용자 지시가 자동 커밋을 허용하지 않으면 커밋하지 않고 결과만 기록한다.

## `.ai-dev` 실행 산출물 커밋/무시 정책

AI Dev Loop는 실제 기능 변경과 루프 운영 상태를 분리해서 다룬다. 실행 중 생성된 파일이 존재한다는 이유만으로 기능 커밋에 함께 포함하지 않는다.

### 기능 커밋

기능 커밋에는 현재 task의 완료 기준을 충족하기 위해 실제로 수정한 코드와 문서만 포함한다.

포함 후보:

- 현재 task의 구현 코드
- 현재 task에 직접 필요한 정책 문서 또는 수동 검증 체크리스트
- 현재 task가 명시적으로 생성하도록 요구한 템플릿이나 예시 파일

기능 커밋에서 기본적으로 제외할 후보:

- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`
- `.ai-dev/diff.md`
- `.ai-dev/review-prompt.md`
- `.ai-dev/review-response.json`

### 루프 상태 커밋

루프 상태 커밋은 goal, queue, state, 검증, 리뷰, 실행 이력을 저장소에 남길 필요가 있을 때 기능 커밋과 별도로 만든다.

포함 가능 후보:

- `.ai-dev/goal.md`
- `.ai-dev/backlog.md`
- `.ai-dev/plan.md`
- `.ai-dev/queue.json`
- `.ai-dev/state.json`
- `.ai-dev/loop-log.md`
- `.ai-dev/test-result.md`
- `.ai-dev/review.md`

루프 상태 커밋도 현재 목표와 직접 관련된 파일만 선택한다. 모든 실행 산출물을 매번 커밋하는 것은 기본값이 아니다.

### 대형 또는 민감 산출물

- `.ai-dev/diff.md`와 `.ai-dev/review-prompt.md`는 전체 diff나 문서 내용을 포함해 빠르게 커질 수 있으므로 항상 커밋하지 않는다.
- `.ai-dev/review-response.json`은 외부 리뷰 응답, 민감 정보, 장문 diff를 포함할 수 있으므로 내용을 확인하기 전에는 커밋하지 않는다.
- 크기가 큰 산출물은 필요 시 정리하거나 별도 보존 정책에 따라 제외한다.
- API Key, 개인정보, 백업 데이터, 인증 정보가 포함된 산출물은 커밋하지 않는다.
- 실제 `.gitignore` 변경은 별도 task에서 필요성과 영향 범위를 검토한 뒤 진행한다.

### untracked 파일과 리뷰 입력

- untracked 텍스트 파일의 내용은 신규 파일 리뷰를 위해 diff 산출물에 포함할 수 있다.
- 리뷰에 포함했다는 사실은 해당 파일을 커밋해야 한다는 의미가 아니다.
- untracked 파일은 현재 task 범위, 민감 정보, 파일 크기, 저장소 보존 필요성을 별도로 확인한 뒤 커밋 대상을 결정한다.
- 바이너리, 대형 파일, 읽기 실패 파일은 리뷰 산출물에서 내용을 생략할 수 있다.

### 커밋 전 확인

- 커밋 전에는 `git status --short`로 변경 파일을 확인한다.
- 가능하면 커밋 스크립트의 `-DryRun` 또는 선택 파일 커밋 방식을 우선한다.
- 기능 커밋과 루프 상태 커밋이 섞여 있으면 커밋을 분리한다.
- 예상하지 못한 사용자 변경이나 현재 task 범위 밖 파일이 있으면 자동 커밋을 중단한다.
- `git add .` 또는 무조건적인 전체 stage는 사용하지 않는다.

## 중단 조건

다음 중 하나라도 발생하면 현재 task 또는 자동 개발 루프를 중단한다.

- 현재 브랜치 또는 작업 환경이 정책과 다르다.
- 작업 트리에 예상하지 못한 변경이 있다.
- 같은 검증 실패를 허용된 재시도 횟수 안에 해결하지 못한다.
- task 범위 밖 파일 수정이 필요하다.
- DB schema 변경이나 migration이 필요하다.
- 기존 데이터 손상 가능성을 안전하게 판단할 수 없다.
- 대규모 리팩터링 또는 광범위한 UI 변경이 필요하다.
- 새로운 패키지 설치나 대량 패키지 교체가 필요하다.
- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요하다.
- 테스트 또는 리뷰 결과에 P1 문제가 남아 있다.
- 사용자 지시와 저장소 정책이 충돌한다.
- 사용량 한도, 권한 제한, 네트워크 제한으로 안전하게 계속할 수 없다.

중단 시 `.ai-dev/state.json`과 `.ai-dev/loop-log.md`에 중단 사유와 다음에 필요한 사용자 결정을 기록한다.

## 금지 사항

- 현재 task 범위 밖 파일을 임의로 수정하지 않는다.
- 사용자 변경 사항을 되돌리지 않는다.
- 검증 실패 상태에서 다음 task로 넘어가지 않는다.
- 검증하지 않은 결과를 통과로 기록하지 않는다.
- 리뷰에서 확인되지 않은 변경을 자동 커밋하지 않는다.
- `git add .`, 강제 push, destructive git 명령을 사용하지 않는다.
- 사용자 승인 없이 배포하거나 원격 브랜치에 push하지 않는다.
- 실제 사용자 데이터를 삭제하거나 초기화하지 않는다.
- DB schema를 계획 없이 변경하지 않는다.
- 서버 API, 로그인, 클라우드 동기화, `localStorage`를 임의로 추가하지 않는다.
- API Key, 개인정보, 백업 데이터를 외부로 전송하지 않는다.
- 자동화 편의를 위해 보안 정책이나 저장소 규칙을 완화하지 않는다.

## 초기 실험 범위

Level 5 자동 개발 루프의 초기 실험은 위험도가 낮고 되돌리기 쉬운 작업으로 제한한다.

허용 후보:

- 문서 정리
- 작은 순수 유틸 분리
- unused import 또는 helper 정리
- 기존 기능을 바꾸지 않는 작은 컴포넌트 정리
- 수동 테스트 체크리스트 보강

초기 실험에서 금지하는 작업:

- 실제 DB 삭제 또는 초기화
- DB schema 변경 또는 migration
- 대규모 리팩터링
- 패키지 대량 교체
- 현재 task 범위 밖 수정
- 파일 가져오기, 복원, 덮어쓰기, 병합처럼 데이터 손상 위험이 있는 기능
- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor 추가
- 사용자 승인 없는 push 또는 배포

## 도입 전 확인 사항

실제 자동화 스크립트를 만들기 전에 다음 항목을 별도 작업으로 확정한다.

- `.ai-dev` 파일의 JSON schema와 필수 필드
- task별 최대 재시도 횟수
- build, test, lint 명령 선택 기준
- GPT 리뷰의 P1/P2/P3 판정 기준
- 자동 커밋 허용 범위와 브랜치 정책
- 사용량 한도 또는 권한 제한 발생 시 복구 절차
- 로그 보존 기간과 민감 정보 기록 금지 기준
- 사람이 루프를 중지하거나 재개하는 방법

 succeeded in 2291ms:
# AI Dev Loop 운영 순서

Goal을 입력하면 AI Dev Loop가 자동으로 계획을 세우고, Codex가 현재 task 범위 안에서 구현한다.
구현 후에는 필요한 build/lint 검증을 통과시키고, 리뷰 pass 상태를 확인한다.
리뷰 pass 후 구현 변경을 커밋하고, `complete-task`를 실행해 task 완료 메타데이터를 갱신한다.
마지막으로 `.ai-dev` 메타 변경을 별도 커밋한 뒤 최종 `git clean` 상태를 확인한다.

codex
이제 새 정책 초안 파일을 추가하겠습니다. 기존 대형 정책 문서의 내용을 반복하지 않고, 현재 로컬 운영에서 바로 판단할 수 있는 자동화 범위, 사용자 확인 지점, 중단 기
준 중심으로 작게 정리합니다.
apply patch
patch: completed
D:\ai-apps\planpilot-local\docs\codex-cli-automation-policy.md
diff --git a/docs/codex-cli-automation-policy.md b/docs/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..bc517a5593b43b1e00faf70fca1ae0f8521a3423
--- /dev/null
+++ b/docs/codex-cli-automation-policy.md
@@ -0,0 +1,91 @@
+# Codex CLI 자동화 정책 초안
+
+이 문서는 PlanPilot Local에서 Codex CLI를 AI Dev Loop의 구현자와 리뷰어로 사용할 때의 자동화 범위와 중단 기준을 정리한다. 목적은 로컬 우선
 개발 흐름을 유지하면서, 한 번에 하나의 task를 안전하게 처리하는 것이다.
+
+이 문서는 정책 초안이며 앱 기능, 런타임 동작, 데이터 스키마, 배포 자동화를 변경하지 않는다.
+
+## 기본 원칙
+
+- 자동화는 현재 task prompt에 명시된 범위 안에서만 수행한다.
+- 한 번에 하나의 task만 처리한다.
+- 저장소의 `AGENTS.md`, 사용자 지시, 보안 규칙은 자동화 편의보다 우선한다.
+- 로컬 파일과 로컬 명령만 사용하며 서버 API, 로그인, 클라우드 동기화, 외부 배포를 추가하지 않는다.
+- 사용자 데이터 삭제, 초기화, 복원, 덮어쓰기, 마이그레이션 위험이 있으면 자동 진행하지 않는다.
+- 실행하지 않은 build, test, lint, review는 통과로 기록하지 않는다.
+
+## 자동화가 수행할 수 있는 범위
+
+Codex CLI 자동화는 명시된 task 범위와 안전 조건을 만족할 때 다음 작업을 수행할 수 있다.
+
+- 현재 task prompt 읽기와 요구사항 정리
+- 허용된 파일 안의 문서 또는 코드 수정
+- 현재 task에 필요한 작은 범위의 오류 수정
+- 로컬 검증 명령 실행 후보 안내 또는 허용된 검증 실행
+- diff 저장, 리뷰 prompt 생성, 리뷰 결과 저장 같은 AI Dev Loop 보조 산출물 생성
+- Codex CLI 기반 구현 실행
+- Codex CLI 기반 리뷰 실행
+- 리뷰 결과가 `pass`이고 모든 게이트를 통과한 경우 task 완료 처리 후보 제안
+
+초기 운영에서는 문서 정리, 작은 유틸 정리, 수동 테스트 체크리스트 보강처럼 되돌리기 쉬운 작업을 우선한다. DB schema 변경, 대규모 리팩터링, 패키지 변경, 배
포 자동화는 별도 task로 분리하고 자동 진행하지 않는다.
+
+## 사용자 확인이 필요한 상황
+
+다음 상황에서는 자동화가 멈추고 사용자의 판단이나 명시적 허용을 받아야 한다.
+
+- task 목표, 완료 기준, 허용 파일이 불명확한 경우
+- 현재 task 범위 밖 파일 수정이 필요한 경우
+- `package.json`, `package-lock.json`, lock file 변경이 필요한 경우
+- 새 패키지 설치 또는 패키지 대량 교체가 필요한 경우
+- DB schema 변경, 데이터 마이그레이션, 데이터 삭제 또는 복원이 필요한 경우
+- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요한 경우
+- GitHub PR, push, 배포, 원격 브랜치 작업이 필요한 경우
+- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우
+- 리뷰 결과가 `revise` 또는 `blocked`이고 수정 범위가 명확하지 않은 경우
+- 민감 정보가 diff, prompt, review 산출물에 포함된 것으로 의심되는 경우
+
+사용자 확인이 필요한 상황에서는 다음 행동, 위험, 필요한 결정을 짧게 기록하고 임의로 범위를 넓히지 않는다.
+
+## 자동 커밋 게이트
+
+자동 커밋은 저장소 정책과 사용자 지시가 허용하고, 아래 조건을 모두 만족할 때만 가능하다.
+
+- 커밋 실행이 명시적으로 허용되어 있다.
+- 현재 task 완료 기준이 충족되어 있다.
+- 수정 파일이 현재 task 범위 안에 있다.
+- 예상하지 못한 사용자 변경이 없다.
+- 필요한 검증이 성공했고, 실행하지 못한 필수 검증이 없다.
+- Codex 리뷰 또는 지정된 리뷰가 `pass`이다.
+- `package.json`, `package-lock.json`, lock file이 변경되지 않았다.
+- DB schema, 사용자 데이터, 보안 관련 위험이 새로 생기지 않았다.
+
+이 조건 중 하나라도 만족하지 않으면 커밋하지 않고 결과와 사유만 보고한다. `git add .`, `git push`, `git reset`, `git clean`, d
estructive `git checkout`은 자동화 범위에 포함하지 않는다.
+
+## 중단 기준
+
+다음 조건이 발생하면 Codex CLI 자동화는 즉시 중단한다.
+
+- 저장소 규칙과 task 요구사항이 충돌한다.
+- 현재 task 범위를 벗어나야만 해결할 수 있다.
+- 같은 오류가 반복되어 안전하게 해결할 수 없다.
+- 검증 실패 원인이 현재 task 안에서 수정 가능하지 않다.
+- 리뷰 결과가 `pass`가 아니다.
+- Codex 실행 결과가 실패했거나 출력이 비어 있다.
+- 리뷰 JSON을 파싱할 수 없다.
+- package 파일 변경, DB schema 변경, 데이터 손상 가능성이 감지된다.
+- 권한 제한, sandbox 제한, 네트워크 제한으로 안전하게 계속할 수 없다.
+- 사용자의 기존 변경을 되돌려야만 진행할 수 있다.
+
+중단 시에는 실패를 리뷰 결과로 오인하지 않는다. 기존 완료 상태나 사용자 변경을 덮어쓰지 않고, 중단 사유와 다음에 필요한 결정을 보고한다.
+
+## 기록 기준
+
+자동화 결과는 사람이 후속 판단을 할 수 있을 정도로만 기록한다.
+
+- 수정한 파일 목록
+- 수행한 작업 요약
+- 실행한 검증과 결과
+- 실행하지 못한 검증과 사유
+- 리뷰 결과 또는 리뷰 미수행 사유
+- 중단 사유와 필요한 사용자 결정
+
+민감 정보, API Key, 개인정보, 백업 데이터, 대형 diff는 로그나 리뷰 산출물에 포함하지 않는다. 필요한 경우 산출물 생성 전에 범위를 줄이고 사용자 확인을 받
는다.

diff --git a/docs/codex-cli-automation-policy.md b/docs/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..bc517a5593b43b1e00faf70fca1ae0f8521a3423
--- /dev/null
+++ b/docs/codex-cli-automation-policy.md
@@ -0,0 +1,91 @@
+# Codex CLI 자동화 정책 초안
+
+이 문서는 PlanPilot Local에서 Codex CLI를 AI Dev Loop의 구현자와 리뷰어로 사용할 때의 자동화 범위와 중단 기준을 정리한다. 목적은 로컬 우선
 개발 흐름을 유지하면서, 한 번에 하나의 task를 안전하게 처리하는 것이다.
+
+이 문서는 정책 초안이며 앱 기능, 런타임 동작, 데이터 스키마, 배포 자동화를 변경하지 않는다.
+
+## 기본 원칙
+
+- 자동화는 현재 task prompt에 명시된 범위 안에서만 수행한다.
+- 한 번에 하나의 task만 처리한다.
+- 저장소의 `AGENTS.md`, 사용자 지시, 보안 규칙은 자동화 편의보다 우선한다.
+- 로컬 파일과 로컬 명령만 사용하며 서버 API, 로그인, 클라우드 동기화, 외부 배포를 추가하지 않는다.
+- 사용자 데이터 삭제, 초기화, 복원, 덮어쓰기, 마이그레이션 위험이 있으면 자동 진행하지 않는다.
+- 실행하지 않은 build, test, lint, review는 통과로 기록하지 않는다.
+
+## 자동화가 수행할 수 있는 범위
+
+Codex CLI 자동화는 명시된 task 범위와 안전 조건을 만족할 때 다음 작업을 수행할 수 있다.
+
+- 현재 task prompt 읽기와 요구사항 정리
+- 허용된 파일 안의 문서 또는 코드 수정
+- 현재 task에 필요한 작은 범위의 오류 수정
+- 로컬 검증 명령 실행 후보 안내 또는 허용된 검증 실행
+- diff 저장, 리뷰 prompt 생성, 리뷰 결과 저장 같은 AI Dev Loop 보조 산출물 생성
+- Codex CLI 기반 구현 실행
+- Codex CLI 기반 리뷰 실행
+- 리뷰 결과가 `pass`이고 모든 게이트를 통과한 경우 task 완료 처리 후보 제안
+
+초기 운영에서는 문서 정리, 작은 유틸 정리, 수동 테스트 체크리스트 보강처럼 되돌리기 쉬운 작업을 우선한다. DB schema 변경, 대규모 리팩터링, 패키지 변경, 배
포 자동화는 별도 task로 분리하고 자동 진행하지 않는다.
+
+## 사용자 확인이 필요한 상황
+
+다음 상황에서는 자동화가 멈추고 사용자의 판단이나 명시적 허용을 받아야 한다.
+
+- task 목표, 완료 기준, 허용 파일이 불명확한 경우
+- 현재 task 범위 밖 파일 수정이 필요한 경우
+- `package.json`, `package-lock.json`, lock file 변경이 필요한 경우
+- 새 패키지 설치 또는 패키지 대량 교체가 필요한 경우
+- DB schema 변경, 데이터 마이그레이션, 데이터 삭제 또는 복원이 필요한 경우
+- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요한 경우
+- GitHub PR, push, 배포, 원격 브랜치 작업이 필요한 경우
+- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우
+- 리뷰 결과가 `revise` 또는 `blocked`이고 수정 범위가 명확하지 않은 경우
+- 민감 정보가 diff, prompt, review 산출물에 포함된 것으로 의심되는 경우
+
+사용자 확인이 필요한 상황에서는 다음 행동, 위험, 필요한 결정을 짧게 기록하고 임의로 범위를 넓히지 않는다.
+
+## 자동 커밋 게이트
+
+자동 커밋은 저장소 정책과 사용자 지시가 허용하고, 아래 조건을 모두 만족할 때만 가능하다.
+
+- 커밋 실행이 명시적으로 허용되어 있다.
+- 현재 task 완료 기준이 충족되어 있다.
+- 수정 파일이 현재 task 범위 안에 있다.
+- 예상하지 못한 사용자 변경이 없다.
+- 필요한 검증이 성공했고, 실행하지 못한 필수 검증이 없다.
+- Codex 리뷰 또는 지정된 리뷰가 `pass`이다.
+- `package.json`, `package-lock.json`, lock file이 변경되지 않았다.
+- DB schema, 사용자 데이터, 보안 관련 위험이 새로 생기지 않았다.
+
+이 조건 중 하나라도 만족하지 않으면 커밋하지 않고 결과와 사유만 보고한다. `git add .`, `git push`, `git reset`, `git clean`, d
estructive `git checkout`은 자동화 범위에 포함하지 않는다.
+
+## 중단 기준
+
+다음 조건이 발생하면 Codex CLI 자동화는 즉시 중단한다.
+
+- 저장소 규칙과 task 요구사항이 충돌한다.
+- 현재 task 범위를 벗어나야만 해결할 수 있다.
+- 같은 오류가 반복되어 안전하게 해결할 수 없다.
+- 검증 실패 원인이 현재 task 안에서 수정 가능하지 않다.
+- 리뷰 결과가 `pass`가 아니다.
+- Codex 실행 결과가 실패했거나 출력이 비어 있다.
+- 리뷰 JSON을 파싱할 수 없다.
+- package 파일 변경, DB schema 변경, 데이터 손상 가능성이 감지된다.
+- 권한 제한, sandbox 제한, 네트워크 제한으로 안전하게 계속할 수 없다.
+- 사용자의 기존 변경을 되돌려야만 진행할 수 있다.
+
+중단 시에는 실패를 리뷰 결과로 오인하지 않는다. 기존 완료 상태나 사용자 변경을 덮어쓰지 않고, 중단 사유와 다음에 필요한 결정을 보고한다.
+
+## 기록 기준
+
+자동화 결과는 사람이 후속 판단을 할 수 있을 정도로만 기록한다.
+
+- 수정한 파일 목록
+- 수행한 작업 요약
+- 실행한 검증과 결과
+- 실행하지 못한 검증과 사유
+- 리뷰 결과 또는 리뷰 미수행 사유
+- 중단 사유와 필요한 사용자 결정
+
+민감 정보, API Key, 개인정보, 백업 데이터, 대형 diff는 로그나 리뷰 산출물에 포함하지 않는다. 필요한 경우 산출물 생성 전에 범위를 줄이고 사용자 확인을 받
는다.

codex
문서 파일을 추가했습니다. 이제 작성된 내용을 UTF-8로 다시 읽어 성공 기준인 자동화 범위, 사용자 확인 지점, 중단 기준이 빠짐없이 들어갔는지 수동 검토하겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralP
ath docs\\codex-cli-automation-policy.md -Encoding UTF8" in D:\ai-apps\planpilot-local
 succeeded in 1779ms:
# Codex CLI 자동화 정책 초안

이 문서는 PlanPilot Local에서 Codex CLI를 AI Dev Loop의 구현자와 리뷰어로 사용할 때의 자동화 범위와 중단 기준을 정리한다. 목적은 로컬 우선 
개발 흐름을 유지하면서, 한 번에 하나의 task를 안전하게 처리하는 것이다.

이 문서는 정책 초안이며 앱 기능, 런타임 동작, 데이터 스키마, 배포 자동화를 변경하지 않는다.

## 기본 원칙

- 자동화는 현재 task prompt에 명시된 범위 안에서만 수행한다.
- 한 번에 하나의 task만 처리한다.
- 저장소의 `AGENTS.md`, 사용자 지시, 보안 규칙은 자동화 편의보다 우선한다.
- 로컬 파일과 로컬 명령만 사용하며 서버 API, 로그인, 클라우드 동기화, 외부 배포를 추가하지 않는다.
- 사용자 데이터 삭제, 초기화, 복원, 덮어쓰기, 마이그레이션 위험이 있으면 자동 진행하지 않는다.
- 실행하지 않은 build, test, lint, review는 통과로 기록하지 않는다.

## 자동화가 수행할 수 있는 범위

Codex CLI 자동화는 명시된 task 범위와 안전 조건을 만족할 때 다음 작업을 수행할 수 있다.

- 현재 task prompt 읽기와 요구사항 정리
- 허용된 파일 안의 문서 또는 코드 수정
- 현재 task에 필요한 작은 범위의 오류 수정
- 로컬 검증 명령 실행 후보 안내 또는 허용된 검증 실행
- diff 저장, 리뷰 prompt 생성, 리뷰 결과 저장 같은 AI Dev Loop 보조 산출물 생성
- Codex CLI 기반 구현 실행
- Codex CLI 기반 리뷰 실행
- 리뷰 결과가 `pass`이고 모든 게이트를 통과한 경우 task 완료 처리 후보 제안

초기 운영에서는 문서 정리, 작은 유틸 정리, 수동 테스트 체크리스트 보강처럼 되돌리기 쉬운 작업을 우선한다. DB schema 변경, 대규모 리팩터링, 패키지 변경, 배포
 자동화는 별도 task로 분리하고 자동 진행하지 않는다.

## 사용자 확인이 필요한 상황

다음 상황에서는 자동화가 멈추고 사용자의 판단이나 명시적 허용을 받아야 한다.

- task 목표, 완료 기준, 허용 파일이 불명확한 경우
- 현재 task 범위 밖 파일 수정이 필요한 경우
- `package.json`, `package-lock.json`, lock file 변경이 필요한 경우
- 새 패키지 설치 또는 패키지 대량 교체가 필요한 경우
- DB schema 변경, 데이터 마이그레이션, 데이터 삭제 또는 복원이 필요한 경우
- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요한 경우
- GitHub PR, push, 배포, 원격 브랜치 작업이 필요한 경우
- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우
- 리뷰 결과가 `revise` 또는 `blocked`이고 수정 범위가 명확하지 않은 경우
- 민감 정보가 diff, prompt, review 산출물에 포함된 것으로 의심되는 경우

사용자 확인이 필요한 상황에서는 다음 행동, 위험, 필요한 결정을 짧게 기록하고 임의로 범위를 넓히지 않는다.

## 자동 커밋 게이트

자동 커밋은 저장소 정책과 사용자 지시가 허용하고, 아래 조건을 모두 만족할 때만 가능하다.

- 커밋 실행이 명시적으로 허용되어 있다.
- 현재 task 완료 기준이 충족되어 있다.
- 수정 파일이 현재 task 범위 안에 있다.
- 예상하지 못한 사용자 변경이 없다.
- 필요한 검증이 성공했고, 실행하지 못한 필수 검증이 없다.
- Codex 리뷰 또는 지정된 리뷰가 `pass`이다.
- `package.json`, `package-lock.json`, lock file이 변경되지 않았다.
- DB schema, 사용자 데이터, 보안 관련 위험이 새로 생기지 않았다.

이 조건 중 하나라도 만족하지 않으면 커밋하지 않고 결과와 사유만 보고한다. `git add .`, `git push`, `git reset`, `git clean`, de
structive `git checkout`은 자동화 범위에 포함하지 않는다.

## 중단 기준

다음 조건이 발생하면 Codex CLI 자동화는 즉시 중단한다.

- 저장소 규칙과 task 요구사항이 충돌한다.
- 현재 task 범위를 벗어나야만 해결할 수 있다.
- 같은 오류가 반복되어 안전하게 해결할 수 없다.
- 검증 실패 원인이 현재 task 안에서 수정 가능하지 않다.
- 리뷰 결과가 `pass`가 아니다.
- Codex 실행 결과가 실패했거나 출력이 비어 있다.
- 리뷰 JSON을 파싱할 수 없다.
- package 파일 변경, DB schema 변경, 데이터 손상 가능성이 감지된다.
- 권한 제한, sandbox 제한, 네트워크 제한으로 안전하게 계속할 수 없다.
- 사용자의 기존 변경을 되돌려야만 진행할 수 있다.

중단 시에는 실패를 리뷰 결과로 오인하지 않는다. 기존 완료 상태나 사용자 변경을 덮어쓰지 않고, 중단 사유와 다음에 필요한 결정을 보고한다.

## 기록 기준

자동화 결과는 사람이 후속 판단을 할 수 있을 정도로만 기록한다.

- 수정한 파일 목록
- 수행한 작업 요약
- 실행한 검증과 결과
- 실행하지 못한 검증과 사유
- 리뷰 결과 또는 리뷰 미수행 사유
- 중단 사유와 필요한 사용자 결정

민감 정보, API Key, 개인정보, 백업 데이터, 대형 diff는 로그나 리뷰 산출물에 포함하지 않는다. 필요한 경우 산출물 생성 전에 범위를 줄이고 사용자 확인을 받는
다.

diff --git a/docs/codex-cli-automation-policy.md b/docs/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..bc517a5593b43b1e00faf70fca1ae0f8521a3423
--- /dev/null
+++ b/docs/codex-cli-automation-policy.md
@@ -0,0 +1,91 @@
+# Codex CLI 자동화 정책 초안
+
+이 문서는 PlanPilot Local에서 Codex CLI를 AI Dev Loop의 구현자와 리뷰어로 사용할 때의 자동화 범위와 중단 기준을 정리한다. 목적은 로컬 우선
 개발 흐름을 유지하면서, 한 번에 하나의 task를 안전하게 처리하는 것이다.
+
+이 문서는 정책 초안이며 앱 기능, 런타임 동작, 데이터 스키마, 배포 자동화를 변경하지 않는다.
+
+## 기본 원칙
+
+- 자동화는 현재 task prompt에 명시된 범위 안에서만 수행한다.
+- 한 번에 하나의 task만 처리한다.
+- 저장소의 `AGENTS.md`, 사용자 지시, 보안 규칙은 자동화 편의보다 우선한다.
+- 로컬 파일과 로컬 명령만 사용하며 서버 API, 로그인, 클라우드 동기화, 외부 배포를 추가하지 않는다.
+- 사용자 데이터 삭제, 초기화, 복원, 덮어쓰기, 마이그레이션 위험이 있으면 자동 진행하지 않는다.
+- 실행하지 않은 build, test, lint, review는 통과로 기록하지 않는다.
+
+## 자동화가 수행할 수 있는 범위
+
+Codex CLI 자동화는 명시된 task 범위와 안전 조건을 만족할 때 다음 작업을 수행할 수 있다.
+
+- 현재 task prompt 읽기와 요구사항 정리
+- 허용된 파일 안의 문서 또는 코드 수정
+- 현재 task에 필요한 작은 범위의 오류 수정
+- 로컬 검증 명령 실행 후보 안내 또는 허용된 검증 실행
+- diff 저장, 리뷰 prompt 생성, 리뷰 결과 저장 같은 AI Dev Loop 보조 산출물 생성
+- Codex CLI 기반 구현 실행
+- Codex CLI 기반 리뷰 실행
+- 리뷰 결과가 `pass`이고 모든 게이트를 통과한 경우 task 완료 처리 후보 제안
+
+초기 운영에서는 문서 정리, 작은 유틸 정리, 수동 테스트 체크리스트 보강처럼 되돌리기 쉬운 작업을 우선한다. DB schema 변경, 대규모 리팩터링, 패키지 변경, 배
포 자동화는 별도 task로 분리하고 자동 진행하지 않는다.
+
+## 사용자 확인이 필요한 상황
+
+다음 상황에서는 자동화가 멈추고 사용자의 판단이나 명시적 허용을 받아야 한다.
+
+- task 목표, 완료 기준, 허용 파일이 불명확한 경우
+- 현재 task 범위 밖 파일 수정이 필요한 경우
+- `package.json`, `package-lock.json`, lock file 변경이 필요한 경우
+- 새 패키지 설치 또는 패키지 대량 교체가 필요한 경우
+- DB schema 변경, 데이터 마이그레이션, 데이터 삭제 또는 복원이 필요한 경우
+- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요한 경우
+- GitHub PR, push, 배포, 원격 브랜치 작업이 필요한 경우
+- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우
+- 리뷰 결과가 `revise` 또는 `blocked`이고 수정 범위가 명확하지 않은 경우
+- 민감 정보가 diff, prompt, review 산출물에 포함된 것으로 의심되는 경우
+
+사용자 확인이 필요한 상황에서는 다음 행동, 위험, 필요한 결정을 짧게 기록하고 임의로 범위를 넓히지 않는다.
+
+## 자동 커밋 게이트
+
+자동 커밋은 저장소 정책과 사용자 지시가 허용하고, 아래 조건을 모두 만족할 때만 가능하다.
+
+- 커밋 실행이 명시적으로 허용되어 있다.
+- 현재 task 완료 기준이 충족되어 있다.
+- 수정 파일이 현재 task 범위 안에 있다.
+- 예상하지 못한 사용자 변경이 없다.
+- 필요한 검증이 성공했고, 실행하지 못한 필수 검증이 없다.
+- Codex 리뷰 또는 지정된 리뷰가 `pass`이다.
+- `package.json`, `package-lock.json`, lock file이 변경되지 않았다.
+- DB schema, 사용자 데이터, 보안 관련 위험이 새로 생기지 않았다.
+
+이 조건 중 하나라도 만족하지 않으면 커밋하지 않고 결과와 사유만 보고한다. `git add .`, `git push`, `git reset`, `git clean`, d
estructive `git checkout`은 자동화 범위에 포함하지 않는다.
+
+## 중단 기준
+
+다음 조건이 발생하면 Codex CLI 자동화는 즉시 중단한다.
+
+- 저장소 규칙과 task 요구사항이 충돌한다.
+- 현재 task 범위를 벗어나야만 해결할 수 있다.
+- 같은 오류가 반복되어 안전하게 해결할 수 없다.
+- 검증 실패 원인이 현재 task 안에서 수정 가능하지 않다.
+- 리뷰 결과가 `pass`가 아니다.
+- Codex 실행 결과가 실패했거나 출력이 비어 있다.
+- 리뷰 JSON을 파싱할 수 없다.
+- package 파일 변경, DB schema 변경, 데이터 손상 가능성이 감지된다.
+- 권한 제한, sandbox 제한, 네트워크 제한으로 안전하게 계속할 수 없다.
+- 사용자의 기존 변경을 되돌려야만 진행할 수 있다.
+
+중단 시에는 실패를 리뷰 결과로 오인하지 않는다. 기존 완료 상태나 사용자 변경을 덮어쓰지 않고, 중단 사유와 다음에 필요한 결정을 보고한다.
+
+## 기록 기준
+
+자동화 결과는 사람이 후속 판단을 할 수 있을 정도로만 기록한다.
+
+- 수정한 파일 목록
+- 수행한 작업 요약
+- 실행한 검증과 결과
+- 실행하지 못한 검증과 사유
+- 리뷰 결과 또는 리뷰 미수행 사유
+- 중단 사유와 필요한 사용자 결정
+
+민감 정보, API Key, 개인정보, 백업 데이터, 대형 diff는 로그나 리뷰 산출물에 포함하지 않는다. 필요한 경우 산출물 생성 전에 범위를 줄이고 사용자 확인을 받
는다.

codex
완료했습니다. 새 문서 [docs/codex-cli-automation-policy.md](D:/ai-apps/planpilot-local/docs/codex-cli-aut
omation-policy.md)를 추가했습니다.

변경 내용:
- Codex CLI 자동화의 기본 원칙을 한국어로 정리했습니다.
- 자동화가 수행할 수 있는 범위, 사용자 확인이 필요한 상황, 자동 커밋 게이트, 중단 기준, 기록 기준을 분리해 문서화했습니다.
- 로컬 우선 원칙, `package.json`/lock file 변경 금지, DB/사용자 데이터 보호, 외부 API/배포 제외 조건을 반영했습니다.

검증:
- `Get-Content -Encoding UTF8`로 작성 문서를 다시 읽어 문서가 정상 출력되는지 확인했습니다.
- 자동화 범위, 사용자 확인 지점, 중단 기준이 포함되어 있는지 수동 검토했습니다.
- 문서 작업만 수행했으며 build/test/lint는 프롬프트에서 요구하지 않아 실행하지 않았습니다.

남은 위험:
- 기존 `docs/ai-dev-loop-policy.md`에도 관련 내용이 있어 향후 중복 정리는 별도 task로 다루는 것이 좋습니다.
- 이번 task에서는 문서 초안만 추가했고 자동화 스크립트 동작은 검증하지 않았습니다.

다음 task로 넘어가도 되는지:
- 현재 task 기준으로는 넘어가도 됩니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
```md
T001 Codex CLI 자동화 정책 문서 초안 작성 완료. docs/codex-cli-automation-policy.md를 추가해 자동화 허용 범위, 사용자 확인 필요
 상황, 자동 커밋 게이트, 중단 기준, 기록 기준을 한국어로 정리했다. 문서는 UTF-8로 다시 읽어 수동 검증했으며 build/test/lint는 실행하지 않았다.
```
diff --git a/docs/codex-cli-automation-policy.md b/docs/codex-cli-automation-policy.md
new file mode 100644
index 0000000000000000000000000000000000000000..bc517a5593b43b1e00faf70fca1ae0f8521a3423
--- /dev/null
+++ b/docs/codex-cli-automation-policy.md
@@ -0,0 +1,91 @@
+# Codex CLI 자동화 정책 초안
+
+이 문서는 PlanPilot Local에서 Codex CLI를 AI Dev Loop의 구현자와 리뷰어로 사용할 때의 자동화 범위와 중단 기준을 정리한다. 목적은 로컬 우선
 개발 흐름을 유지하면서, 한 번에 하나의 task를 안전하게 처리하는 것이다.
+
+이 문서는 정책 초안이며 앱 기능, 런타임 동작, 데이터 스키마, 배포 자동화를 변경하지 않는다.
+
+## 기본 원칙
+
+- 자동화는 현재 task prompt에 명시된 범위 안에서만 수행한다.
+- 한 번에 하나의 task만 처리한다.
+- 저장소의 `AGENTS.md`, 사용자 지시, 보안 규칙은 자동화 편의보다 우선한다.
+- 로컬 파일과 로컬 명령만 사용하며 서버 API, 로그인, 클라우드 동기화, 외부 배포를 추가하지 않는다.
+- 사용자 데이터 삭제, 초기화, 복원, 덮어쓰기, 마이그레이션 위험이 있으면 자동 진행하지 않는다.
+- 실행하지 않은 build, test, lint, review는 통과로 기록하지 않는다.
+
+## 자동화가 수행할 수 있는 범위
+
+Codex CLI 자동화는 명시된 task 범위와 안전 조건을 만족할 때 다음 작업을 수행할 수 있다.
+
+- 현재 task prompt 읽기와 요구사항 정리
+- 허용된 파일 안의 문서 또는 코드 수정
+- 현재 task에 필요한 작은 범위의 오류 수정
+- 로컬 검증 명령 실행 후보 안내 또는 허용된 검증 실행
+- diff 저장, 리뷰 prompt 생성, 리뷰 결과 저장 같은 AI Dev Loop 보조 산출물 생성
+- Codex CLI 기반 구현 실행
+- Codex CLI 기반 리뷰 실행
+- 리뷰 결과가 `pass`이고 모든 게이트를 통과한 경우 task 완료 처리 후보 제안
+
+초기 운영에서는 문서 정리, 작은 유틸 정리, 수동 테스트 체크리스트 보강처럼 되돌리기 쉬운 작업을 우선한다. DB schema 변경, 대규모 리팩터링, 패키지 변경, 배
포 자동화는 별도 task로 분리하고 자동 진행하지 않는다.
+
+## 사용자 확인이 필요한 상황
+
+다음 상황에서는 자동화가 멈추고 사용자의 판단이나 명시적 허용을 받아야 한다.
+
+- task 목표, 완료 기준, 허용 파일이 불명확한 경우
+- 현재 task 범위 밖 파일 수정이 필요한 경우
+- `package.json`, `package-lock.json`, lock file 변경이 필요한 경우
+- 새 패키지 설치 또는 패키지 대량 교체가 필요한 경우
+- DB schema 변경, 데이터 마이그레이션, 데이터 삭제 또는 복원이 필요한 경우
+- 외부 네트워크, 서버 API, 인증 정보, API Key가 필요한 경우
+- GitHub PR, push, 배포, 원격 브랜치 작업이 필요한 경우
+- 예상하지 못한 사용자 변경이 작업 트리에 있는 경우
+- 리뷰 결과가 `revise` 또는 `blocked`이고 수정 범위가 명확하지 않은 경우
+- 민감 정보가 diff, prompt, review 산출물에 포함된 것으로 의심되는 경우
+
+사용자 확인이 필요한 상황에서는 다음 행동, 위험, 필요한 결정을 짧게 기록하고 임의로 범위를 넓히지 않는다.
+
+## 자동 커밋 게이트
+
+자동 커밋은 저장소 정책과 사용자 지시가 허용하고, 아래 조건을 모두 만족할 때만 가능하다.
+
+- 커밋 실행이 명시적으로 허용되어 있다.
+- 현재 task 완료 기준이 충족되어 있다.
+- 수정 파일이 현재 task 범위 안에 있다.
+- 예상하지 못한 사용자 변경이 없다.
+- 필요한 검증이 성공했고, 실행하지 못한 필수 검증이 없다.
+- Codex 리뷰 또는 지정된 리뷰가 `pass`이다.
+- `package.json`, `package-lock.json`, lock file이 변경되지 않았다.
+- DB schema, 사용자 데이터, 보안 관련 위험이 새로 생기지 않았다.
+
+이 조건 중 하나라도 만족하지 않으면 커밋하지 않고 결과와 사유만 보고한다. `git add .`, `git push`, `git reset`, `git clean`, d
estructive `git checkout`은 자동화 범위에 포함하지 않는다.
+
+## 중단 기준
+
+다음 조건이 발생하면 Codex CLI 자동화는 즉시 중단한다.
+
+- 저장소 규칙과 task 요구사항이 충돌한다.
+- 현재 task 범위를 벗어나야만 해결할 수 있다.
+- 같은 오류가 반복되어 안전하게 해결할 수 없다.
+- 검증 실패 원인이 현재 task 안에서 수정 가능하지 않다.
+- 리뷰 결과가 `pass`가 아니다.
+- Codex 실행 결과가 실패했거나 출력이 비어 있다.
+- 리뷰 JSON을 파싱할 수 없다.
+- package 파일 변경, DB schema 변경, 데이터 손상 가능성이 감지된다.
+- 권한 제한, sandbox 제한, 네트워크 제한으로 안전하게 계속할 수 없다.
+- 사용자의 기존 변경을 되돌려야만 진행할 수 있다.
+
+중단 시에는 실패를 리뷰 결과로 오인하지 않는다. 기존 완료 상태나 사용자 변경을 덮어쓰지 않고, 중단 사유와 다음에 필요한 결정을 보고한다.
+
+## 기록 기준
+
+자동화 결과는 사람이 후속 판단을 할 수 있을 정도로만 기록한다.
+
+- 수정한 파일 목록
+- 수행한 작업 요약
+- 실행한 검증과 결과
+- 실행하지 못한 검증과 사유
+- 리뷰 결과 또는 리뷰 미수행 사유
+- 중단 사유와 필요한 사용자 결정
+
+민감 정보, API Key, 개인정보, 백업 데이터, 대형 diff는 로그나 리뷰 산출물에 포함하지 않는다. 필요한 경우 산출물 생성 전에 범위를 줄이고 사용자 확인을 받
는다.

tokens used
45,362
완료했습니다. 새 문서 [docs/codex-cli-automation-policy.md](D:/ai-apps/planpilot-local/docs/codex-cli-automation-policy.md)를 추가했습니다.

변경 내용:
- Codex CLI 자동화의 기본 원칙을 한국어로 정리했습니다.
- 자동화가 수행할 수 있는 범위, 사용자 확인이 필요한 상황, 자동 커밋 게이트, 중단 기준, 기록 기준을 분리해 문서화했습니다.
- 로컬 우선 원칙, `package.json`/lock file 변경 금지, DB/사용자 데이터 보호, 외부 API/배포 제외 조건을 반영했습니다.

검증:
- `Get-Content -Encoding UTF8`로 작성 문서를 다시 읽어 문서가 정상 출력되는지 확인했습니다.
- 자동화 범위, 사용자 확인 지점, 중단 기준이 포함되어 있는지 수동 검토했습니다.
- 문서 작업만 수행했으며 build/test/lint는 프롬프트에서 요구하지 않아 실행하지 않았습니다.

남은 위험:
- 기존 `docs/ai-dev-loop-policy.md`에도 관련 내용이 있어 향후 중복 정리는 별도 task로 다루는 것이 좋습니다.
- 이번 task에서는 문서 초안만 추가했고 자동화 스크립트 동작은 검증하지 않았습니다.

다음 task로 넘어가도 되는지:
- 현재 task 기준으로는 넘어가도 됩니다.

`.ai-dev/loop-log.md`에 기록할 작업 요약:
```md
T001 Codex CLI 자동화 정책 문서 초안 작성 완료. docs/codex-cli-automation-policy.md를 추가해 자동화 허용 범위, 사용자 확인 필요 상황, 자동 커밋 게이트, 중단 기준, 기록 기준을 한국어로 정리했다. 문서는 UTF-8로 다시 읽어 수동 검증했으며 build/test/lint는 실행하지 않았다.
```

```
# Codex Review Result

## Run

- Started at: 2026-07-18 18:31:57
- Ended at: 2026-07-18 18:32:51
- Exit code: 0
- Review prompt: .ai-dev/review-prompt.md
- Review response: .ai-dev/review-response.json
- Command: codex exec <short wrapper pointing to .ai-dev/review-prompt.md>

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
session id: 019f7491-74c2-7120-82d3-6c469bdff034
--------
user
Read and follow the full review prompt at this absolute file path: D:\ai-apps\planpilot-local\.ai-dev
\review-prompt.md
codex
지정된 리뷰 프롬프트를 먼저 읽고, 그 지시 범위 안에서만 필요한 파일을 확인하겠습니다. PowerShell 읽기 명령만 사용합니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\.ai-dev\\review-prompt.md'" in D:\ai-apps\planpilot-local
 succeeded in 1806ms:
# AI Dev Review Prompt

## Role

너는 이 저장소의 엄격한 코드 리뷰어다.

## Review Goal

- 현재 task의 변경사항이 목표와 일치하는지 검토한다.
- 빌드/테스트 결과와 git diff를 함께 검토한다.
- 리뷰 판단은 App Change Files와 diff 본문의 실제 앱 변경 파일을 중심으로 수행한다.
- .ai-dev 파일은 자동화 상태/로그/프롬프트 산출물로 별도 확인하되, 앱 변경 결함으로 과대평가하지 않는다.
- 다음 task 범위까지 미리 구현했는지 확인한다.

## Project Goal

# 목표
GitHub PR 연동 검토를 현재 PlanPilot Local 구조에 맞춰 가장 작은 실행 가능한 개발 목표로 정리한다.

## 배경
P2 백로그 항목인 GitHub PR 연동 검토는 즉시 기능 구현보다 현재 React + Vite + TypeScript, Zustand, Dexie 기반 로컬 앱 구조에서 어떤 범
위가 안전한지 먼저 확인하는 작업이다. 이번 목표는 실제 연동 구현이 아니라, 현재 저장소 상태에서 다음 작업으로 옮길 수 있는 최소 검토 결과를 남기는 것이다.

## 성공 기준
- 현재 코드 구조에서 PR 관련 정보를 표시하거나 관리할 수 있는 후보 위치를 확인한다.
- MVP에서 다룰 최소 사용자 흐름과 제외할 범위를 구분한다.
- 필요한 데이터 형태와 저장 위치 후보를 간단히 정리한다.
- 후속 구현 작업으로 바로 전환 가능한 작은 작업 단위를 제안한다.

## 제약사항
- privacy-first 방향을 유지한다.
- 로컬 앱 구조와 기존 상태 관리 방식을 우선한다.
- 기존 IndexedDB 데이터를 깨뜨리는 변경은 하지 않는다.
- App.tsx에 새 복잡도를 무리하게 추가하지 않는다.
- 이번 목표에서는 검토 문서 작성 범위로 제한한다.

## 범위 제외
- 실제 GitHub 연동 구현
- 인증 흐름 구현
- 원격 데이터 자동 수집
- 데이터베이스 schema 변경
- 대규모 화면 재구성

## 수동 검증
- 작성된 검토 내용이 현재 앱 구조와 충돌하지 않는지 확인한다.
- 후속 작업이 하나의 작은 구현 단위로 분리되어 있는지 확인한다.
- 사용자-facing 문구가 한국어 기준을 따르는지 확인한다.

## Current Task

- Task ID: T001
- Title: GitHub PR 연동 검토 문서 작성
- Description: 현재 저장소 구조를 기준으로 GitHub PR 정보를 어떤 방식으로 다룰 수 있는지 검토하고, MVP 범위와 후속 구현 단위를 한국어 문서로 정리한다.
- Type: documentation
- Status: in_progress
- Priority: P2
- Depends on:
- 없음
- Verification:
- 검토 문서에 현재 구조 요약, 최소 범위, 제외 범위, 후속 작업이 포함되어 있는지 확인한다.
- 데이터 저장 또는 화면 변경이 필요한 경우 별도 후속 작업으로 분리되어 있는지 확인한다.

## Test Result

# AI Dev Test Result

## 2026-07-18 18:31:43

- Overall result: passed
- Current task: T001
- Mode: BuildOnly (build + lint when available)
- Commands:
  - npm run build: passed
  - npm run test: skipped
  - npm run lint: passed

### npm run build

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 build
> tsc -b && vite build

[36mvite v8.0.10 [32mbuilding client environment for production...[36m[39m
[2K
transforming...✓ 48 modules transformed.
rendering chunks...
computing gzip size...
dist/index.html                   0.46 kB │ gzip:   0.29 kB
dist/assets/index-DvjxWt30.css    5.69 kB │ gzip:   1.93 kB
dist/assets/index-DtLVvPCG.js   317.50 kB │ gzip: 100.16 kB

[32m✓ built in 197ms[39m
```
### npm run test

- Status: skipped
- Exit code: 없음

```text
package.json에 test script가 없습니다.
```
### npm run lint

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 lint
> eslint .
```

## Diff To Review

# AI Dev Diff

## Generated At

2026-07-18 18:31:52

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/loop-log.md
 M .ai-dev/queue.json
 M .ai-dev/state.json
 M .ai-dev/test-result.md
?? .ai-dev/auto-goal-planning-prompt.md
?? .ai-dev/github-pr-integration-review.md
```

## App Change Files

- 없음

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/loop-log.md
- .ai-dev/queue.json
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md
- .ai-dev/github-pr-integration-review.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
변경 없음
```

## Unstaged Diff

```text
변경 없음
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```

## Review Criteria

- 현재 task 요구사항을 충족했는가
- 실제 앱 변경 파일과 .ai-dev 운영 산출물이 구분되어 있는가
- .ai-dev 운영 산출물만 변경된 경우 앱 변경 리뷰로 과대평가하지 않았는가
- 현재 task 범위를 벗어나지 않았는가
- 다음 task를 미리 구현하지 않았는가
- 기존 기능을 깨뜨릴 가능성이 있는가
- 데이터 삭제, 초기화, 복원 같은 위험 작업이 포함되었는가
- package.json 또는 package-lock.json을 불필요하게 수정했는가
- 검증 결과가 충분한가
- 문서나 수동검증 체크리스트 갱신이 필요한가
- 더 단순한 구현이 가능한가

### Strict Criteria

- 작은 불확실성도 revise로 판정한다.
- 테스트가 없거나 skipped이면 revise 후보로 본다.
- task 범위를 벗어난 파일 수정은 high 이상으로 판정한다.
- package 변경은 기본적으로 blocked 후보로 본다.

## Output Format

리뷰 결과는 아래 JSON 형식만 출력한다. JSON 앞뒤에 설명, Markdown 코드 펜스, 추가 문장을 출력하지 않는다.

{
  "decision": "pass | revise | blocked",
  "severity": "none | low | medium | high | critical",
  "summary": "짧은 요약",
  "required_changes": [
    {
      "file": "파일 경로 또는 unknown",
      "reason": "수정이 필요한 이유",
      "suggestion": "구체적 수정 방향"
    }
  ],
  "optional_suggestions": [
    {
      "file": "파일 경로 또는 unknown",
      "suggestion": "선택 개선 의견"
    }
  ],
  "scope_check": {
    "within_current_task": true,
    "scope_issues": []
  },
  "test_check": {
    "build_passed": true,
    "test_passed": true,
    "lint_passed": true,
    "issues": []
  },
  "next_step": "complete_task | revise_with_codex | stop_for_user"
}

## Decision Rules

- pass: 현재 task 요구사항 충족, 치명적 문제 없음, 다음 task로 넘어가도 됨
- revise: 수정이 필요하지만 자동 수정 가능
- blocked: 요구사항 충돌, 데이터 위험, 패키지 추가, 대규모 리팩터링 등 사용자 판단 필요

codex
리뷰 대상 앱 diff는 없고, 실제 산출물은 `.ai-dev/github-pr-integration-review.md`로 보입니다. 요구사항 충족 여부를 확인하기 위해 해당 문서만
 추가로 읽겠습니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "Get-Content -LiteralPath '
D:\\ai-apps\\planpilot-local\\.ai-dev\\github-pr-integration-review.md'" in D:\ai-apps\planpilot-loca
l
 succeeded in 1758ms:
# GitHub PR ?곕룞 寃??
## 紐⑹쟻

GitHub PR ?뺣낫瑜??ㅼ젣濡??곕룞?섍린 ?꾩뿉, PlanPilot Local???꾩옱 援ъ“?먯꽌 ?덉쟾?섍쾶 ?ㅻ０ ???덈뒗 理쒖냼 踰붿쐞瑜??뺣━?쒕떎. ?대쾲 寃?
좊뒗 臾몄꽌 ?묒꽦留??섑뻾?섎ŉ, ?몄쬆, ?ㅽ듃?뚰겕 ?곕룞, DB schema 蹂寃? UI 援ы쁽? ?ы븿?섏? ?딅뒗??

## ?꾩옱 援ъ“ ?붿빟

- ?깆? React + Vite + TypeScript 湲곕컲 濡쒖뺄 ?뱀빋?대떎.
- ?붾㈃ 吏꾩엯?먯씤 `src/App.tsx`???섎떒 ???곹깭? ?뚯깮 ?곗씠??怨꾩궛??留↔퀬, ?ㅼ젣 ?붾㈃? `src/views/TodayView.tsx`, `src/
views/TasksView.tsx`, `src/views/ProjectsView.tsx`, `src/views/SettingsView.tsx`濡?遺꾨━?섏뼱 ?덈떎.
- ?곹깭 愿由щ뒗 `src/store.ts`??Zustand store媛 ?대떦?섎ŉ, ?꾩옱 ?꾨찓?몄? `tasks`, `projects`, `appSettings`?대떎.
- 濡쒖뺄 ??μ? `src/db.ts`??Dexie v1 schema媛 ?대떦?섎ŉ, ?꾩옱 ?뚯씠釉붿? `tasks`, `projects`, `appSettings`肉먯씠??
- ??낆? `src/types.ts`??`Task`, `Project`, `AppSettings`, `StoredAppSettings`濡??뺤쓽?섏뼱 ?덈떎.
- 諛깆뾽/媛?몄삤湲?寃利??먮쫫? ?ㅼ젙 ?붾㈃怨?`src/utils/exportData.ts`, `src/utils/importValidation.ts` 怨꾩뿴??遺숈뼱 ?
덈떎.

## PR ?뺣낫 ?꾨낫 ?꾩튂

### 1. ?낅Т 硫붾え ?먮뒗 ?쒓렇 湲곕컲 ?섎룞 湲곕줉

媛???묒? 踰붿쐞??湲곗〈 `Task`??`memo` ?먮뒗 `tags`??PR URL, ??μ냼紐? PR 踰덊샇瑜??ъ슜?먭? 吏곸젒 ?곷뒗 諛⑹떇?대떎.

- ?μ젏: DB schema 蹂寃쎌씠 ?꾩슂 ?녾퀬, ?꾩옱 IndexedDB ?곗씠?곕? 嫄대뱶由ъ? ?딅뒗??
- ?μ젏: `TasksView`? `TaskCard`??湲곗〈 ?낅Т ?먮쫫 ?덉뿉??諛붾줈 ?댄빐?????덈떎.
- ?⑥젏: 援ъ“?붾맂 PR ?곹깭, 由щ럭?? merge ?곹깭, 泥댄겕 ?곹깭瑜??덉젙?곸쑝濡??꾪꽣留곹븯湲??대졄??
- ?먮떒: 1李?MVP 寃??寃곌낵濡쒕뒗 媛???덉쟾???쒖옉?먯씠??

### 2. ?꾨줈?앺듃 ?⑥쐞 ?ㅻ챸????μ냼/PR 留λ씫 湲곕줉

`Project.description`??GitHub ??μ냼 URL ?먮뒗 愿??PR 湲곗????곴퀬, 媛쒕퀎 PR? ?낅Т濡?愿由ы븯??諛⑹떇?대떎.

- ?μ젏: ??μ냼??? ?⑥쐞 留λ씫? ?꾨줈?앺듃? ?먯뿰?ㅻ읇寃?留욌뒗??
- ?μ젏: ???뚯씠釉??놁씠 ?꾨줈?앺듃 ?붾㈃??湲곗〈 ?곗씠??援ъ“瑜??ъ궗?⑺븷 ???덈떎.
- ?⑥젏: PR ?⑥쐞 ?곹깭 愿由щ뒗 寃곌뎅 ?낅Т ?먮뒗 蹂꾨룄 援ъ“媛 ?꾩슂?섎떎.
- ?먮떒: ??μ냼 留λ씫 ?쒖떆???꾨낫媛 ?????덉쑝?? PR 紐⑸줉 愿由ъ쓽 ?듭떖 ?꾩튂濡쒕뒗 遺議깊븯??

### 3. 蹂꾨룄 PR ?꾨찓??異붽?

`PullRequest` 媛숈? ????? Zustand ?곹깭, Dexie ?뚯씠釉붿쓣 異붽??섎뒗 諛⑹떇?대떎.

- ?μ젏: PR 踰덊샇, URL, ?곹깭, 由щ럭 ?곹깭, ?곌껐 ?낅Т瑜?援ъ“?뷀븷 ???덈떎.
- ?⑥젏: `src/types.ts`, `src/db.ts`, `src/store.ts`, ?붾㈃ 而댄룷?뚰듃, 諛깆뾽/媛?몄삤湲??뺤콉源뚯? ?④퍡 諛붾먮떎.
- ?⑥젏: Dexie schema version怨?migration 怨꾪쉷???꾩슂???대쾲 task 踰붿쐞瑜??섎뒗??
- ?먮떒: ?ㅼ젣 ?곕룞 ?먮뒗 援ъ“?붾맂 愿由ш? ?꾩슂?댁쭊 ??蹂꾨룄 task濡??ㅻ쨪???쒕떎.

## MVP 理쒖냼 ?ъ슜???먮쫫

?대쾲 湲곕뒫??泥?援ы쁽 ?꾨낫??"GitHub PR ?곕룞"???꾨땲??"?낅Т??PR 留곹겕瑜??섎룞?쇰줈 ?곌껐??異붿쟻?쒕떎"濡?醫곹엳??寃껋씠 ?덉쟾?섎떎.

1. ?ъ슜?먭? ?낅Т瑜?留뚮뱾嫄곕굹 ?섏젙????PR URL??硫붾え???곷뒗??
2. ?ъ슜?먭? ?낅Т ?쒕ぉ, 硫붾え, ?쒓렇 寃?됱쑝濡?PR 愿???낅Т瑜?李얜뒗??
3. ?ъ슜?먮뒗 PR ?곹깭瑜?GitHub?먯꽌 吏곸젒 ?뺤씤?섍퀬, PlanPilot?먮뒗 ?????곹깭留??섎룞?쇰줈 愿由ы븳??

???먮쫫? ?쒕쾭 API, GitHub ?몄쬆, ?먭꺽 ?곗씠???섏쭛, DB schema 蹂寃??놁씠 ?꾩옱 援ъ“? 異⑸룎?섏? ?딅뒗??

## MVP ?쒖쇅 踰붿쐞

- GitHub OAuth ?먮뒗 Personal Access Token ?낅젰
- GitHub API ?몄텧
- `gh` CLI ?먮뒗 Copilot CLI ?몄텧
- PR ?먮룞 ?섏쭛, ?먮룞 ?숆린?? polling
- PR ?곹깭, 由щ럭?? 泥댄겕 寃곌낵, merge 媛???щ? ?먮룞 諛섏쁺
- ?쒕쾭 API, 濡쒓렇?? ?대씪?곕뱶 ?숆린??- `localStorage` ???- Dexie schema 蹂寃쎄낵 migration
- 蹂꾨룄 PR ???먮뒗 ?洹쒕え ?붾㈃ ?ш뎄??- ?뚮┝ ?먮뒗 Android notification 沅뚰븳 ?붿껌

## ?꾩슂???곗씠???뺥깭 ?꾨낫

### 1李??꾨낫: 湲곗〈 Task ?ъ궗??
蹂꾨룄 schema 蹂寃??놁씠 ?ㅼ쓬 媛믪쓣 ?щ엺???낅젰?쒕떎.

- `Task.title`: PR怨??곌껐???낅Т ?쒕ぉ
- `Task.memo`: PR URL, ??μ냼紐? PR 踰덊샇, 泥섎━ 硫붾え
- `Task.tags`: `github`, `pr`, ??μ냼 蹂꾩묶 媛숈? ?섎룞 遺꾨쪟
- `Task.status`: PlanPilot ?덉뿉?쒖쓽 泥섎━ ?곹깭
- `Task.projectId`: 愿???꾨줈?앺듃

??諛⑹떇? ?꾩옱 諛깆뾽/export/import ??곸씤 `tasks` ?덉뿉 ?먯뿰?ㅻ읇寃??ы븿?쒕떎.

### ?꾩냽 ?꾨낫: 援ъ“?붾맂 PR 留곹겕 ?꾨뱶

?뺤떇 援ъ“?붽? ?꾩슂?댁쭏 ??寃?좏븷 ???덈뒗 ?뺥깭???ㅼ쓬怨?媛숇떎.

```ts
type PullRequestLink = {
  id: string;
  taskId?: string;
  projectId?: string;
  provider: "github";
  repository: string;
  number: number;
  url: string;
  title?: string;
  state?: "open" | "closed" | "merged" | "draft";
  lastCheckedAt?: string;
  createdAt: string;
  updatedAt: string;
};
```

?ㅻ쭔 ??援ъ“????table ?먮뒗 `Task` ?뺤옣???붽뎄?섎?濡? migration 怨꾪쉷怨?諛깆뾽/媛?몄삤湲??뺤콉 ?낅뜲?댄듃媛 ?좏뻾?섏뼱???쒕떎.

## ????꾩튂 ?꾨낫

- 1李? 湲곗〈 `tasks` ?뚯씠釉붿쓽 `memo`, `tags`, `projectId`瑜??ъ슜?쒕떎.
- 2李? ?꾨줈?앺듃蹂?GitHub ??μ냼 留λ씫???꾩슂?섎㈃ 湲곗〈 `projects.description`???ъ슜?쒕떎.
- 蹂대쪟: 蹂꾨룄 `pullRequests` ?뚯씠釉붿? Dexie schema 蹂寃쎌씠誘濡??대쾲 踰붿쐞?먯꽌 ?쒖쇅?쒕떎.
- 蹂대쪟: `appSettings`??GitHub ?ㅼ젙????ν븯??諛⑹떇? ?몄쬆/?좏겙 ???臾몄젣? ?곌껐?섎?濡??쒖쇅?쒕떎.

## ?꾩냽 援ы쁽 ?묒뾽 ?쒖븞

?ㅼ쓬 task濡?諛붾줈 ?꾪솚 媛?ν븳 媛???묒? 援ы쁽 ?⑥쐞???ㅼ쓬 ?섎굹??

**Task ?꾨낫: ?낅Т 硫붾え??PR URL ?쒖떆 湲곗? ?뺣━ 諛??섎룞 ?뚯뒪??*

- 踰붿쐞: 肄붾뱶 蹂寃??놁씠, ?ъ슜?먭? ?낅Т 硫붾え??GitHub PR URL???곴퀬 寃?됱쑝濡?李얜뒗 ?섎룞 ?먮쫫???뚯뒪??泥댄겕由ъ뒪?몄뿉 異붽??쒕떎.
- ?ы븿: PR URL ?덉떆, ?쒓렇 ?덉떆, 寃?됱뼱 ?덉떆, ?쒖쇅 湲곕뒫 紐낆떆
- ?쒖쇅: 留곹겕 ?먮룞 ?뚯떛, ?몃? API ?몄텧, DB schema 蹂寃?- 寃利? 湲곗〈 ?낅Т 異붽?/?섏젙/寃??諛깆뾽 ?먮쫫怨?異⑸룎?섏? ?딅뒗吏 ?섎룞 ?
뺤씤

洹??ㅼ쓬 援ы쁽???꾩슂?섎떎硫???踰덉㎏ ?묒? task??"TaskCard ?먮뒗 TaskForm?먯꽌 PR URL???щ엺???쎄린 ?쎄쾶 蹂댁뿬以????덈뒗 理쒖냼 UI 寃
??媛 ?곸젅?섎떎. ??寃쎌슦?먮룄 `App.tsx`??蹂듭옟?꾨? 異붽??섏? ?딄퀬 `TaskCard` ?먮뒗 ?묒? utility遺??寃?좏빐???쒕떎.

## 以묐떒 議곌굔

?ㅼ쓬 ?붽뎄媛 ?ㅼ뼱?ㅻ㈃ 蹂꾨룄 task濡?遺꾨━?섍퀬, 援ы쁽 ?꾩뿉 異붽? 寃?좉? ?꾩슂?섎떎.

- GitHub ?몄쬆 ?뺣낫 ???- GitHub API ?먮뒗 `gh` CLI ?몄텧
- PR ?곹깭 ?먮룞 ?숆린??- ??Dexie table 異붽?
- `Task` ??낆뿉 援ъ“?붾맂 PR ?꾨뱶 異붽?
- 諛깆뾽/媛?몄삤湲?schema ?뺤옣
- ?????먮뒗 ???붾㈃ ?ш뎄??
## ?섎룞 寃利?寃곌낵

- ?꾩옱 援ъ“?먯꽌 PR ?뺣낫瑜??쒖떆?섍굅??愿由ы븷 ?꾨낫 ?꾩튂瑜?`Task.memo`, `Task.tags`, `Project.description`, 蹂꾨룄 PR ?
꾨찓?몄쑝濡?援щ텇?덈떎.
- MVP 理쒖냼 ?먮쫫? 湲곗〈 ?낅Т??PR URL???섎룞 湲곕줉?섍퀬 寃?됲븯??諛⑹떇?쇰줈 ?쒗븳?덈떎.
- ?쒖쇅 踰붿쐞???몄쬆, API ?몄텧, ?먮룞 ?섏쭛, schema 蹂寃? ?洹쒕え UI 蹂寃쎌쑝濡?紐낇솗??遺꾨━?덈떎.
- ?꾩슂???곗씠???뺥깭??湲곗〈 Task ?ъ궗?⑹븞???곗꽑?섍퀬, 援ъ“?붾맂 `PullRequestLink`???꾩냽 ?꾨낫濡쒕쭔 ?④꼈??
- ?꾩냽 ?묒뾽? 肄붾뱶 蹂寃??녿뒗 ?섎룞 ?먮쫫 ?뚯뒪??泥댄겕由ъ뒪???묒꽦?쇰줈 遺꾨━?덈떎.

## src ???뚯씪 ?섏젙 ?댁쑀

?대쾲 task???곗텧臾쇱씠 寃??臾몄꽌?대ŉ, ?꾨＼?꾪듃??Likely Files媛 `.ai-dev/goal.md`? `.ai-dev/github-pr-integratio
n-review.md`瑜?吏?뺥뻽?? ?곕씪??`src` 諛뽰쓽 `.ai-dev/github-pr-integration-review.md`瑜??덈줈 ?묒꽦?섎뒗 寃껋씠 task ?
꾨즺???꾩슂?섎떎.

codex
PowerShell 5.1의 기본 인코딩 때문에 문서가 깨져 보일 수 있어, 파일 자체가 UTF-8로 정상인지 확인하겠습니다. 문서 품질 판단에 직접 영향을 주는 부분입니다.
exec
"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command "[System.IO.File]::ReadAllT
ext('D:\\ai-apps\\planpilot-local\\.ai-dev\\github-pr-integration-review.md', [System.Text.Encoding]:
:UTF8)" in D:\ai-apps\planpilot-local
 succeeded in 1754ms:
# GitHub PR 연동 검토

## 목적

GitHub PR 정보를 실제로 연동하기 전에, PlanPilot Local의 현재 구조에서 안전하게 다룰 수 있는 최소 범위를 정리한다. 이번 검토는 문서 작성만 수행하며, 인증,
 네트워크 연동, DB schema 변경, UI 구현은 포함하지 않는다.

## 현재 구조 요약

- 앱은 React + Vite + TypeScript 기반 로컬 웹앱이다.
- 화면 진입점인 `src/App.tsx`는 하단 탭 상태와 파생 데이터 계산을 맡고, 실제 화면은 `src/views/TodayView.tsx`, `src/views/TasksVi
ew.tsx`, `src/views/ProjectsView.tsx`, `src/views/SettingsView.tsx`로 분리되어 있다.
- 상태 관리는 `src/store.ts`의 Zustand store가 담당하며, 현재 도메인은 `tasks`, `projects`, `appSettings`이다.
- 로컬 저장은 `src/db.ts`의 Dexie v1 schema가 담당하며, 현재 테이블은 `tasks`, `projects`, `appSettings`뿐이다.
- 타입은 `src/types.ts`에 `Task`, `Project`, `AppSettings`, `StoredAppSettings`로 정의되어 있다.
- 백업/가져오기 검증 흐름은 설정 화면과 `src/utils/exportData.ts`, `src/utils/importValidation.ts` 계열에 붙어 있다.

## PR 정보 후보 위치

### 1. 업무 메모 또는 태그 기반 수동 기록

가장 작은 범위는 기존 `Task`의 `memo` 또는 `tags`에 PR URL, 저장소명, PR 번호를 사용자가 직접 적는 방식이다.

- 장점: DB schema 변경이 필요 없고, 현재 IndexedDB 데이터를 건드리지 않는다.
- 장점: `TasksView`와 `TaskCard`의 기존 업무 흐름 안에서 바로 이해할 수 있다.
- 단점: 구조화된 PR 상태, 리뷰어, merge 상태, 체크 상태를 안정적으로 필터링하기 어렵다.
- 판단: 1차 MVP 검토 결과로는 가장 안전한 시작점이다.

### 2. 프로젝트 단위 설명에 저장소/PR 맥락 기록

`Project.description`에 GitHub 저장소 URL 또는 관련 PR 기준을 적고, 개별 PR은 업무로 관리하는 방식이다.

- 장점: 저장소나 팀 단위 맥락은 프로젝트와 자연스럽게 맞는다.
- 장점: 새 테이블 없이 프로젝트 화면의 기존 데이터 구조를 재사용할 수 있다.
- 단점: PR 단위 상태 관리는 결국 업무 또는 별도 구조가 필요하다.
- 판단: 저장소 맥락 표시는 후보가 될 수 있으나, PR 목록 관리의 핵심 위치로는 부족하다.

### 3. 별도 PR 도메인 추가

`PullRequest` 같은 새 타입, Zustand 상태, Dexie 테이블을 추가하는 방식이다.

- 장점: PR 번호, URL, 상태, 리뷰 상태, 연결 업무를 구조화할 수 있다.
- 단점: `src/types.ts`, `src/db.ts`, `src/store.ts`, 화면 컴포넌트, 백업/가져오기 정책까지 함께 바뀐다.
- 단점: Dexie schema version과 migration 계획이 필요해 이번 task 범위를 넘는다.
- 판단: 실제 연동 또는 구조화된 관리가 필요해진 뒤 별도 task로 다뤄야 한다.

## MVP 최소 사용자 흐름

이번 기능의 첫 구현 후보는 "GitHub PR 연동"이 아니라 "업무에 PR 링크를 수동으로 연결해 추적한다"로 좁히는 것이 안전하다.

1. 사용자가 업무를 만들거나 수정할 때 PR URL을 메모에 적는다.
2. 사용자가 업무 제목, 메모, 태그 검색으로 PR 관련 업무를 찾는다.
3. 사용자는 PR 상태를 GitHub에서 직접 확인하고, PlanPilot에는 할 일 상태만 수동으로 관리한다.

이 흐름은 서버 API, GitHub 인증, 원격 데이터 수집, DB schema 변경 없이 현재 구조와 충돌하지 않는다.

## MVP 제외 범위

- GitHub OAuth 또는 Personal Access Token 입력
- GitHub API 호출
- `gh` CLI 또는 Copilot CLI 호출
- PR 자동 수집, 자동 동기화, polling
- PR 상태, 리뷰어, 체크 결과, merge 가능 여부 자동 반영
- 서버 API, 로그인, 클라우드 동기화
- `localStorage` 저장
- Dexie schema 변경과 migration
- 별도 PR 탭 또는 대규모 화면 재구성
- 알림 또는 Android notification 권한 요청

## 필요한 데이터 형태 후보

### 1차 후보: 기존 Task 재사용

별도 schema 변경 없이 다음 값을 사람이 입력한다.

- `Task.title`: PR과 연결된 업무 제목
- `Task.memo`: PR URL, 저장소명, PR 번호, 처리 메모
- `Task.tags`: `github`, `pr`, 저장소 별칭 같은 수동 분류
- `Task.status`: PlanPilot 안에서의 처리 상태
- `Task.projectId`: 관련 프로젝트

이 방식은 현재 백업/export/import 대상인 `tasks` 안에 자연스럽게 포함된다.

### 후속 후보: 구조화된 PR 링크 필드

정식 구조화가 필요해질 때 검토할 수 있는 형태는 다음과 같다.

```ts
type PullRequestLink = {
  id: string;
  taskId?: string;
  projectId?: string;
  provider: "github";
  repository: string;
  number: number;
  url: string;
  title?: string;
  state?: "open" | "closed" | "merged" | "draft";
  lastCheckedAt?: string;
  createdAt: string;
  updatedAt: string;
};
```

다만 이 구조는 새 table 또는 `Task` 확장을 요구하므로, migration 계획과 백업/가져오기 정책 업데이트가 선행되어야 한다.

## 저장 위치 후보

- 1차: 기존 `tasks` 테이블의 `memo`, `tags`, `projectId`를 사용한다.
- 2차: 프로젝트별 GitHub 저장소 맥락이 필요하면 기존 `projects.description`을 사용한다.
- 보류: 별도 `pullRequests` 테이블은 Dexie schema 변경이므로 이번 범위에서 제외한다.
- 보류: `appSettings`에 GitHub 설정을 저장하는 방식은 인증/토큰 저장 문제와 연결되므로 제외한다.

## 후속 구현 작업 제안

다음 task로 바로 전환 가능한 가장 작은 구현 단위는 다음 하나다.

**Task 후보: 업무 메모의 PR URL 표시 기준 정리 및 수동 테스트**

- 범위: 코드 변경 없이, 사용자가 업무 메모에 GitHub PR URL을 적고 검색으로 찾는 수동 흐름을 테스트 체크리스트에 추가한다.
- 포함: PR URL 예시, 태그 예시, 검색어 예시, 제외 기능 명시
- 제외: 링크 자동 파싱, 외부 API 호출, DB schema 변경
- 검증: 기존 업무 추가/수정/검색/백업 흐름과 충돌하지 않는지 수동 확인

그 다음 구현이 필요하다면 두 번째 작은 task는 "TaskCard 또는 TaskForm에서 PR URL을 사람이 읽기 쉽게 보여줄 수 있는 최소 UI 검토"가 적절하다. 이 경우
에도 `App.tsx`에 복잡도를 추가하지 않고 `TaskCard` 또는 작은 utility부터 검토해야 한다.

## 중단 조건

다음 요구가 들어오면 별도 task로 분리하고, 구현 전에 추가 검토가 필요하다.

- GitHub 인증 정보 저장
- GitHub API 또는 `gh` CLI 호출
- PR 상태 자동 동기화
- 새 Dexie table 추가
- `Task` 타입에 구조화된 PR 필드 추가
- 백업/가져오기 schema 확장
- 새 탭 또는 큰 화면 재구성

## 수동 검증 결과

- 현재 구조에서 PR 정보를 표시하거나 관리할 후보 위치를 `Task.memo`, `Task.tags`, `Project.description`, 별도 PR 도메인으로 구분했다.
- MVP 최소 흐름은 기존 업무에 PR URL을 수동 기록하고 검색하는 방식으로 제한했다.
- 제외 범위는 인증, API 호출, 자동 수집, schema 변경, 대규모 UI 변경으로 명확히 분리했다.
- 필요한 데이터 형태는 기존 Task 재사용안을 우선하고, 구조화된 `PullRequestLink`는 후속 후보로만 남겼다.
- 후속 작업은 코드 변경 없는 수동 흐름 테스트 체크리스트 작성으로 분리했다.

## src 외 파일 수정 이유

이번 task의 산출물이 검토 문서이며, 프롬프트의 Likely Files가 `.ai-dev/goal.md`와 `.ai-dev/github-pr-integration-review.m
d`를 지정했다. 따라서 `src` 밖의 `.ai-dev/github-pr-integration-review.md`를 새로 작성하는 것이 task 완료에 필요하다.


codex
{"decision":"pass","severity":"none","summary":"검토 문서는 현재 구조 요약, MVP 최소 흐름, 제외 범위, 데이터/저장 위치 후보, 후속 작
업 단위를 포함하며 task 범위를 벗어난 앱 변경은 없습니다.","required_changes":[],"optional_suggestions":[],"scope_check":{"
within_current_task":true,"scope_issues":[]},"test_check":{"build_passed":true,"test_passed":true,"li
nt_passed":true,"issues":["package.json에 test script가 없어 npm run test는 skipped였으나, 이번 task는 문서 작성 범위이
고 build/lint가 통과했습니다."]},"next_step":"complete_task"}
tokens used
36,504
{"decision":"pass","severity":"none","summary":"검토 문서는 현재 구조 요약, MVP 최소 흐름, 제외 범위, 데이터/저장 위치 후보, 후속 작업 단위를 포함하며 task 범위를 벗어난 앱 변경은 없습니다.","required_changes":[],"optional_suggestions":[],"scope_check":{"within_current_task":true,"scope_issues":[]},"test_check":{"build_passed":true,"test_passed":true,"lint_passed":true,"issues":["package.json에 test script가 없어 npm run test는 skipped였으나, 이번 task는 문서 작성 범위이고 build/lint가 통과했습니다."]},"next_step":"complete_task"}

```
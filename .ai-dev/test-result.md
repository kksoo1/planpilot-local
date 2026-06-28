# AI Dev Test Result

## 2026-06-28 19:56:36

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

[32m✓ built in 257ms[39m
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

### stale Review summary manual verification

- Status: passed
- Command: scripts/ai-dev-status.ps1
- Evidence:
  - Review summary shows `Status: stale`.
  - Review summary shows `Reason: previous review summary hidden because current task is initial state`.
  - After the stale status and reason, Review summary prints only `숨김`.
  - stale Review summary status에서는 stale `Decision`, `Severity`, `Next step`, `Summary`가 출력되지 않습니다.
  - Test result summary stale behavior remains unchanged.

```text
Review summary
- Status: stale
- Reason: previous review summary hidden because current task is initial state
- 숨김
```

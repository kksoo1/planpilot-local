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
AI Software Company 무인 개발 흐름에서 사람이 개입하게 만드는 commit scope 처리와 비구현 task revise 자동화를 보강한다.

## 배경
현재 자동 commit 스크립트는 디렉터리 경로가 -Files로 전달될 때 해당 디렉터리 아래의 실제 변경 파일 범위를 안정적으로 해석하지 못할 수 있다. 또한 documentation, analysis, verification task에서 strict review가 revise를 요구하는 경우 허용 범위 안의 명확한 수정임에도 자동 복구가 끊길 수 있다.

## 성공 기준
- -Files에 .ai-company/, .ai-company/reports/, ai-software-company/ 같은 디렉터리 경로가 전달되면 해당 디렉터리 아래 변경 파일로 안전하게 확장된다.
- 파일 경로와 디렉터리 경로 혼합 입력, untracked 파일, 수정 파일, 삭제 파일이 정상 처리된다.
- 선택 디렉터리 내부 변경은 선택 파일 외 staged 파일로 오판하지 않는다.
- 선택 범위 밖 staged 파일은 기존처럼 차단한다.
- repo root 밖 경로와 .. traversal 경로는 차단된다.
- 비구현 task에서 strict review가 revise를 요구하면 조건이 명확하고 파일 범위가 허용될 때 Codex 자동 재수정을 최대 1회 수행한다.
- 비구현 task의 두 번째 revise는 추가 자동 수정 없이 명확한 stopped reason으로 중단된다.
- documentation task의 BuildOnly 검증 정책에서 npm test skipped는 실패로 보지 않는다.
- implementation task의 기존 build/test/lint 정책은 유지된다.
- scripts/ai-dev-test.ps1에 실제 임시 Git 저장소 또는 worktree 기반 테스트가 추가되고 기존 안전장치는 약화되지 않는다.
- 최종 검증에서 build, 전체 npm test, lint, strict review가 통과한다.

## 제약사항
- PowerShell 5.1 호환성을 유지한다.
- UTF-8 호환성을 유지한다.
- 기존 테스트를 삭제하거나 약화하지 않는다.
- Git pathspec 의미를 무분별하게 확장하지 않는다.
- 한 번에 필요한 범위의 스크립트와 테스트만 수정한다.

## 범위 제외
- GUI 또는 Supervisor 신규 구현은 포함하지 않는다.
- 데이터 저장 구조 변경은 포함하지 않는다.
- 알림, 동기화, 인증 관련 기능은 포함하지 않는다.
- 대규모 구조 재작성은 포함하지 않는다.

## 수동 검증
- scripts/ai-dev-test.ps1 실행 결과를 확인한다.
- build, 전체 npm test, lint 결과를 확인한다.
- strict review 결과가 pass인지 확인한다.

## Current Task

- Task ID: T001
- Title: commit scope 디렉터리 확장 보강
- Description: -Files로 전달된 파일 및 디렉터리 입력을 repo 내부 실제 변경 파일 목록으로 안전하게 정규화하고, 선택 범위 밖 staged 파일 차단 로직을 유지한다.
- Type: implementation
- Status: in_progress
- Priority: P0
- Depends on:
- 없음
- Verification:
- .ai-company/ 디렉터리 대상 여러 파일 commit 성공 테스트
- .ai-company/reports/ 하위 문서 commit 성공 테스트
- 디렉터리 내부 untracked 파일 포함 테스트
- 디렉터리 내부 삭제 파일 포함 테스트
- 디렉터리 밖 staged 파일 차단 테스트
- 파일과 디렉터리 혼합 scope 처리 테스트
- repo 외부 및 traversal 경로 차단 테스트

## Test Result

# AI Dev Test Result

## 2026-08-10 16:26:57

- Overall result: passed
- Current task: T001
- Mode: standard
- Commands:
  - npm run build: passed
  - npm run test: passed
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

[32m✓ built in 255ms[39m
```
### npm run test

- Status: passed
- Exit code: 0

```text

> planpilot-local@0.0.0 test
> powershell -ExecutionPolicy Bypass -File scripts/ai-dev-test.ps1

AI Dev automation tests
Repository: D:\ai-apps\planpilot-local

[PASS] auto-goal MaxSteps default is at least 40
       Detected=40
[PASS] maxsteps-forwarding forwards MaxSteps 57 to child script
       Expected=57 Actual=57 ExitCode=1 Args=-MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1
[PASS] maxsteps-forwarding forwards MaxTasks and allow switches
       ExpectedMaxTasks=3 ActualMaxTasks=3 MissingSwitches=
[PASS] maxsteps-forwarding fake child exited successfully
       AutoGoalExitCode=1
[PASS] maxsteps-forwarding child script was invoked
       ExitCode=1 OutputPreview=Step 1: validate-input    Command: check GoalTitle/GoalDescription    Executed: False    Skipped: False    Exit code: 0    Message: Input validation completed: MaxSteps forwarding test  Step 2: dirty-worktree-gate    Command: git status --porcelain    Executed: True    Skipped: False    Exit code: 0    Message: AllowDirty is set. Baseline dirty count: 2  Step 3: plan-goal    Command: codex exec <auto-goal planning prompt>    Executed: True    Skipped: False    Exit code: 0    Message: Codex goal planning completed. Result: .ai-dev/codex-result.md  Step 4: validate-generated-json    Command: goal/queue/state JSON validation    Executed: False    Skipped: False    Exit code: 0    Message: goalMarkdown, queue, and state JSON validation completed. currentTaskId: T001  Step 5: write-state-files    Command: .ai-dev/goal.md, .ai-dev/queue.json, .ai-dev/state.json    Executed: True    Skipped: False    Exit code: 0    Message: New goal, queue, and state files were written.  Step 6: make-prompt    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-make-prompt.ps1    Executed: True    Skipped: False    Exit code: 0    Message: 생성된 프롬프트 파일: .ai-dev/current-task-prompt.md  Current task id: T001  Current task title: Forwarding test  Step 7: auto-cycle-full    Command: powershell -ExecutionPolicy Bypass -File scripts/ai-dev-auto-cycle-full.ps1 -MaxTasks 3 -MaxSteps 57 -AllowCodex -AllowReviewCodex -AllowCommit -AllowDirty -ProtectedBaselineDirtyPaths scripts/ai-dev-auto-cycle-full.ps1,scripts/ai-dev-auto-goal.ps1    Executed: True    Skipped: False    Exit code: 0    Message: completed  Step 8: verify-goal-status    Command: .ai-dev/state.json goalStatus 확인    Executed: False    Skipped: False    Exit code: 0    Message: auto-cycle-full 성공 후 goalStatus completed 확인.  Step 9: final-change-gate    Command: cleanup auto-goal temp artifacts, git status --short    Executed: True    Skipped: False    Exit code: 1    Message: Final clean verification failed: baseline dirty files remain, so auto-goal will not report completed.  Baseline dirty count: 2  Final dirty count: 7  Final .ai-dev meta commit created: skipped (baseline dirty remains).  Remaining baseline dirty paths:  scripts/ai-dev-auto-cycle-full.ps1  scripts/ai-dev-auto-goal.ps1   M .ai-dev/codex-result.md   M .ai-dev/current-task-prompt.md   M .ai-dev/goal.md   M .ai-dev/queue.json   M .ai-dev/state.json   M scripts/ai-dev-auto-cycle-full.ps1   M scripts/ai-dev-auto-goal.ps1  Plan preview:    Goal title: Forwarding test    Current task id: T001    Task T001: Forwarding test      Type: implementation      Status: in_progress      Priority: P0      Likely files: scripts/ai-dev-test.ps1      Verification: Verify MaxSteps forwarding.  Stopped reason: final_baseline_dirty_remains  Outcome category: actual_failure  Completed: False  Exit code: 1
[PASS] all-goal-candidates-excluded stopped reason
       Expected=all_goal_candidates_excluded ExitCode=1
[PASS] all-goal-candidates-excluded expected_non_work classification
[PASS] all-goal-candidates-excluded baseline marker preservation
[PASS] all-goal-candidates-excluded no new dirty paths
       NewDirtyPaths=
[PASS] all-goal-candidates-excluded no staged paths
       StagedPaths=
[PASS] dirty-worktree stopped reason
       Expected=dirty_worktree ExitCode=1
[PASS] dirty-worktree expected_non_work classification
[PASS] dirty-worktree baseline marker preservation
[PASS] dirty-worktree no new dirty paths
       NewDirtyPaths=
[PASS] dirty-worktree no staged paths
       StagedPaths=
[PASS] baseline-output-conflict stopped reason
       Expected=baseline_output_conflict ExitCode=1
[PASS] baseline-output-conflict expected_non_work classification
[PASS] baseline-output-conflict baseline marker preservation
[PASS] baseline-output-conflict no new dirty paths
       NewDirtyPaths=
[PASS] baseline-output-conflict no staged paths
       StagedPaths=
[PASS] commit-scope-ai-company-directory commit succeeds
       ExitCode=0 OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  커밋 메시지: test: commit scope commit-scope-ai-company-directory  커밋 해시: 501d557308a1db8ac02284abe9d0442282834904  앱 변경 파일 수: 4  AI Dev 운영 산출물 수: 0  전체 변경 파일 수: 4  현재 task: unknown
[PASS] commit-scope-ai-company-directory committed file scope
       Expected=.ai-company/customer-decisions.json, .ai-company/customer-requests.json, .ai-company/reports/adapter-plan.md, .ai-company/reports/new-scope-report.md Actual=.ai-company/customer-decisions.json, .ai-company/customer-requests.json, .ai-company/reports/adapter-plan.md, .ai-company/reports/new-scope-report.md Missing= Unexpected=
[PASS] commit-scope-reports-directory commit succeeds
       ExitCode=0 OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  커밋 메시지: test: commit scope commit-scope-reports-directory  커밋 해시: 44585c8ea2c81268e5c8ee06aa89d684035571f5  앱 변경 파일 수: 1  AI Dev 운영 산출물 수: 0  전체 변경 파일 수: 1  현재 task: unknown
[PASS] commit-scope-reports-directory committed file scope
       Expected=.ai-company/reports/adapter-plan.md Actual=.ai-company/reports/adapter-plan.md Missing= Unexpected=
[PASS] commit-scope-new-directory commit succeeds
       ExitCode=0 OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  커밋 메시지: test: commit scope commit-scope-new-directory  커밋 해시: 1fd757780e81aac367a851fbf1bda988a7abb64f  앱 변경 파일 수: 2  AI Dev 운영 산출물 수: 0  전체 변경 파일 수: 2  현재 task: unknown
[PASS] commit-scope-new-directory committed file scope
       Expected=ai-software-company/notes.md, ai-software-company/reports/summary.md Actual=ai-software-company/notes.md, ai-software-company/reports/summary.md Missing= Unexpected=
[PASS] commit-scope-file-and-directory commit succeeds
       ExitCode=0 OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  커밋 메시지: test: commit scope commit-scope-file-and-directory  커밋 해시: e7ce2014d6e5af67417ed91c1e3a13490679416d  앱 변경 파일 수: 2  AI Dev 운영 산출물 수: 0  전체 변경 파일 수: 2  현재 task: unknown
[PASS] commit-scope-file-and-directory committed file scope
       Expected=.ai-company/reports/adapter-plan.md, scripts/ai-dev-status.ps1 Actual=.ai-company/reports/adapter-plan.md, scripts/ai-dev-status.ps1 Missing= Unexpected=
[PASS] commit-scope-blocks-outside-staged-file commit blocked
       ExitCode=1 ExpectedFragment=선택 파일 외에 이미 staged 된 파일 OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  powershell.exe : Stop-WithError : 선택 파일 외에 이미 staged 된 파일이 있습니다: scripts/ai  -dev-status.ps1  At D:\ai-apps\planpilot-local\scripts\ai-dev-test.ps1:681 char:23  +             $output = & powershell `  +                       ~~~~~~~~~~~~~~      + CategoryInfo          : NotSpecified: (Stop-WithError ...-dev-status      .ps1:String) [], RemoteException      + FullyQualifiedErrorId : NativeCommandError     At C:\Users\SECUI\AppData\Local\Temp\planpilot-test-commit-scope-blocks-out  side-staged-file-20260810161817156\scripts\ai-dev-commit.ps1:353 char:9  +         Stop-WithError "선택 파일 외에 이미 staged 된 파일이 있습니다: $($unexpectedS ...  +         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorE      xception      + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorExce      ption,Stop-WithError
[PASS] commit-scope-blocks-repo-outside-path commit blocked
       ExitCode=1 ExpectedFragment=저장소 밖 파일 OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  powershell.exe : Stop-WithError : 저장소 밖 파일은 선택할 수 없습니다: C:\Users\SECUI\AppD  ata\Local\Temp  At D:\ai-apps\planpilot-local\scripts\ai-dev-test.ps1:681 char:23  +             $output = & powershell `  +                       ~~~~~~~~~~~~~~      + CategoryInfo          : NotSpecified: (Stop-WithError ...Data\Local\      Temp:String) [], RemoteException      + FullyQualifiedErrorId : NativeCommandError     At C:\Users\SECUI\AppData\Local\Temp\planpilot-test-commit-scope-blocks-rep  o-outside-path-20260810161836706\scripts\ai-dev-commit.ps1:173 char:9  +         Stop-WithError "저장소 밖 파일은 선택할 수 없습니다: $Pathspec"  +         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorE      xception      + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorExce      ption,Stop-WithError
[PASS] commit-scope-blocks-traversal-path commit blocked
       ExitCode=1 ExpectedFragment=traversal OutputPreview=WARNING: 현재 task를 찾지 못했습니다. 기본 커밋 메시지를 사용할 수 있습니다.  powershell.exe : Stop-WithError : 상위 디렉터리 traversal 경로는 선택할 수 없습니다: ../outs  ide.txt  At D:\ai-apps\planpilot-local\scripts\ai-dev-test.ps1:681 char:23  +             $output = & powershell `  +                       ~~~~~~~~~~~~~~      + CategoryInfo          : NotSpecified: (Stop-WithError ... ../outside      .txt:String) [], RemoteException      + FullyQualifiedErrorId : NativeCommandError     At C:\Users\SECUI\AppData\Local\Temp\planpilot-test-commit-scope-blocks-tra  versal-path-20260810161850920\scripts\ai-dev-commit.ps1:156 char:9  +         Stop-WithError "상위 디렉터리 traversal 경로는 선택할 수 없습니다: $Pathspec"  +         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorE      xception      + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorExce      ption,Stop-WithError
[PASS] review-required-files-partial-diff recovery prompt expectation
       ExpectedRecoveryPrompt=True ExitCode=1
[PASS] review-required-files-partial-diff missing files section includes only expected targets
       MissingSection=B.ps1
[PASS] review-required-files-partial-diff does not stop as stale required file missing
       ExitCode=1
[PASS] review-required-files-all-changed recovery prompt expectation
       ExpectedRecoveryPrompt=False ExitCode=1
[PASS] review-required-files-all-changed missing files section includes only expected targets
       MissingSection=
[PASS] review-required-files-all-changed does not stop as stale required file missing
       ExitCode=1
[PASS] review-required-files-recovery-limit recovery prompt expectation
       ExpectedRecoveryPrompt=False ExitCode=1
[PASS] review-required-files-recovery-limit missing files section includes only expected targets
       MissingSection=
[PASS] review-required-files-recovery-limit does not stop as stale required file missing
       ExitCode=1
[PASS] missing-implementation-no-diff-no-commit stopped reason expectation
       Expected=missing_implementation ExitCode=1
[PASS] missing-implementation-no-diff-no-commit run-codex expectation
       Expected=True Actual=True
[PASS] missing-implementation-no-diff-no-commit run-review-codex expectation
       Expected=True Actual=True
[PASS] missing-implementation-no-diff-no-commit complete-task expectation
       Expected=False Actual=False
[PASS] missing-implementation-no-diff-no-commit missing_implementation expectation
       Expected=True Actual=True
[PASS] saved-review-current-commit-resumes stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-current-commit-resumes run-codex expectation
       Expected=False Actual=False
[PASS] saved-review-current-commit-resumes run-review-codex expectation
       Expected=False Actual=False
[PASS] saved-review-current-commit-resumes complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-current-commit-resumes missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-pass-current-skips-review-codex run-codex expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex run-review-codex expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-pass-current-skips-review-codex missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-previous-task-head-reruns-codex stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-previous-task-head-reruns-codex run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-previous-task-head-reruns-codex run-review-codex expectation
       Expected=True Actual=True
[PASS] saved-review-previous-task-head-reruns-codex complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-previous-task-head-reruns-codex missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-different-task-reruns-review stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-different-task-reruns-review run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-different-task-reruns-review run-review-codex expectation
       Expected=True Actual=True
[PASS] saved-review-different-task-reruns-review complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-different-task-reruns-review missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-stale-fingerprint-reruns-review stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] saved-review-stale-fingerprint-reruns-review run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-stale-fingerprint-reruns-review run-review-codex expectation
       Expected=True Actual=True
[PASS] saved-review-stale-fingerprint-reruns-review complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-stale-fingerprint-reruns-review missing_implementation expectation
       Expected=False Actual=False
[PASS] saved-review-pass-test-failed-does-not-complete stopped reason expectation
       Expected=test_failed ExitCode=1
[PASS] saved-review-pass-test-failed-does-not-complete run-codex expectation
       Expected=True Actual=True
[PASS] saved-review-pass-test-failed-does-not-complete run-review-codex expectation
       Expected=False Actual=False
[PASS] saved-review-pass-test-failed-does-not-complete complete-task expectation
       Expected=False Actual=False
[PASS] saved-review-pass-test-failed-does-not-complete missing_implementation expectation
       Expected=False Actual=False
[PASS] previous-task-head-commit-not-implementation stopped reason expectation
       Expected=missing_implementation ExitCode=1
[PASS] previous-task-head-commit-not-implementation run-codex expectation
       Expected=True Actual=True
[PASS] previous-task-head-commit-not-implementation run-review-codex expectation
       Expected=True Actual=True
[PASS] previous-task-head-commit-not-implementation complete-task expectation
       Expected=False Actual=False
[PASS] previous-task-head-commit-not-implementation missing_implementation expectation
       Expected=True Actual=True
[PASS] previous-task-commit-not-implementation stopped reason expectation
       Expected=missing_implementation ExitCode=1
[PASS] previous-task-commit-not-implementation run-codex expectation
       Expected=True Actual=True
[PASS] previous-task-commit-not-implementation run-review-codex expectation
       Expected=True Actual=True
[PASS] previous-task-commit-not-implementation complete-task expectation
       Expected=False Actual=False
[PASS] previous-task-commit-not-implementation missing_implementation expectation
       Expected=True Actual=True
[PASS] test-failed-recovers-once-then-passes stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] test-failed-recovers-once-then-passes run-codex count
       Expected=2 Actual=2
[PASS] test-failed-recovers-once-then-passes check count
       Expected=2 Actual=2
[PASS] test-failed-recovers-once-then-passes review-codex count
       Expected=1 Actual=1
[PASS] test-failed-recovers-once-then-passes recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] test-failed-recovers-once-then-passes raw review preservation
       Expected=False RawFiles=0
[PASS] test-failed-recovers-once-then-passes revise prompt test-result content
       Expected=True Actual=True
[PASS] test-failed-recovers-once-then-passes seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] test-failed-twice-stops-without-extra-codex stopped reason expectation
       Expected=test_failed ExitCode=1
[PASS] test-failed-twice-stops-without-extra-codex run-codex count
       Expected=2 Actual=2
[PASS] test-failed-twice-stops-without-extra-codex check count
       Expected=2 Actual=2
[PASS] test-failed-twice-stops-without-extra-codex review-codex count
       Expected=0 Actual=0
[PASS] test-failed-twice-stops-without-extra-codex recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] test-failed-twice-stops-without-extra-codex raw review preservation
       Expected=False RawFiles=0
[PASS] test-failed-twice-stops-without-extra-codex revise prompt test-result content
       Expected=True Actual=True
[PASS] test-failed-twice-stops-without-extra-codex seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] review-json-extraction-recovers-once stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] review-json-extraction-recovers-once run-codex count
       Expected=1 Actual=1
[PASS] review-json-extraction-recovers-once check count
       Expected=1 Actual=1
[PASS] review-json-extraction-recovers-once review-codex count
       Expected=2 Actual=2
[PASS] review-json-extraction-recovers-once recovery count
       Type=review_json_extraction_failed Expected=1 Actual=1
[PASS] review-json-extraction-recovers-once raw review preservation
       Expected=True RawFiles=1
[PASS] review-json-extraction-recovers-once revise prompt test-result content
       Expected=False Actual=False
[PASS] review-json-extraction-recovers-once seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] review-json-extraction-twice-stops stopped reason expectation
       Expected=review_json_extraction_failed ExitCode=1
[PASS] review-json-extraction-twice-stops run-codex count
       Expected=1 Actual=1
[PASS] review-json-extraction-twice-stops check count
       Expected=1 Actual=1
[PASS] review-json-extraction-twice-stops review-codex count
       Expected=2 Actual=2
[PASS] review-json-extraction-twice-stops recovery count
       Type=review_json_extraction_failed Expected=1 Actual=1
[PASS] review-json-extraction-twice-stops raw review preservation
       Expected=True RawFiles=1
[PASS] review-json-extraction-twice-stops revise prompt test-result content
       Expected=False Actual=False
[PASS] review-json-extraction-twice-stops seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] stale-review-json-stop-reason-does-not-recover stopped reason expectation
       Expected=run-review-codex_failed ExitCode=1
[PASS] stale-review-json-stop-reason-does-not-recover run-codex count
       Expected=1 Actual=1
[PASS] stale-review-json-stop-reason-does-not-recover check count
       Expected=1 Actual=1
[PASS] stale-review-json-stop-reason-does-not-recover review-codex count
       Expected=1 Actual=1
[PASS] stale-review-json-stop-reason-does-not-recover recovery count
       Type=review_json_extraction_failed Expected=0 Actual=0
[PASS] stale-review-json-stop-reason-does-not-recover raw review preservation
       Expected=False RawFiles=0
[PASS] stale-review-json-stop-reason-does-not-recover revise prompt test-result content
       Expected=False Actual=False
[PASS] stale-review-json-stop-reason-does-not-recover seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] package-scripts-only-allowed stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] package-scripts-only-allowed run-codex count
       Expected=1 Actual=1
[PASS] package-scripts-only-allowed check count
       Expected=1 Actual=1
[PASS] package-scripts-only-allowed review-codex count
       Expected=1 Actual=1
[PASS] package-scripts-only-allowed raw review preservation
       Expected=False RawFiles=0
[PASS] package-scripts-only-allowed revise prompt test-result content
       Expected=False Actual=False
[PASS] package-scripts-only-allowed seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] package-dependencies-blocked stopped reason expectation
       Expected=package_files_changed ExitCode=1
[PASS] package-dependencies-blocked run-codex count
       Expected=1 Actual=1
[PASS] package-dependencies-blocked check count
       Expected=1 Actual=1
[PASS] package-dependencies-blocked review-codex count
       Expected=1 Actual=1
[PASS] package-dependencies-blocked raw review preservation
       Expected=False RawFiles=0
[PASS] package-dependencies-blocked revise prompt test-result content
       Expected=False Actual=False
[PASS] package-dependencies-blocked seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] package-lock-blocked stopped reason expectation
       Expected=package_files_changed ExitCode=1
[PASS] package-lock-blocked run-codex count
       Expected=1 Actual=1
[PASS] package-lock-blocked check count
       Expected=1 Actual=1
[PASS] package-lock-blocked review-codex count
       Expected=1 Actual=1
[PASS] package-lock-blocked raw review preservation
       Expected=False RawFiles=0
[PASS] package-lock-blocked revise prompt test-result content
       Expected=False Actual=False
[PASS] package-lock-blocked seeded recovery isolation
       SeedTask= CurrentTask=T001
[PASS] same-task-used-test-recovery-does-not-repeat stopped reason expectation
       Expected=test_failed ExitCode=1
[PASS] same-task-used-test-recovery-does-not-repeat run-codex count
       Expected=1 Actual=1
[PASS] same-task-used-test-recovery-does-not-repeat check count
       Expected=1 Actual=1
[PASS] same-task-used-test-recovery-does-not-repeat review-codex count
       Expected=0 Actual=0
[PASS] same-task-used-test-recovery-does-not-repeat recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] same-task-used-test-recovery-does-not-repeat raw review preservation
       Expected=False RawFiles=0
[PASS] same-task-used-test-recovery-does-not-repeat revise prompt test-result content
       Expected=False Actual=False
[PASS] same-task-used-test-recovery-does-not-repeat seeded recovery isolation
       SeedTask=T001 CurrentTask=T001
[PASS] new-task-test-recovery-count-is-independent stopped reason expectation
       Expected=allow_commit_required ExitCode=1
[PASS] new-task-test-recovery-count-is-independent run-codex count
       Expected=2 Actual=2
[PASS] new-task-test-recovery-count-is-independent check count
       Expected=2 Actual=2
[PASS] new-task-test-recovery-count-is-independent review-codex count
       Expected=1 Actual=1
[PASS] new-task-test-recovery-count-is-independent recovery count
       Type=test_failed Expected=1 Actual=1
[PASS] new-task-test-recovery-count-is-independent raw review preservation
       Expected=False RawFiles=0
[PASS] new-task-test-recovery-count-is-independent revise prompt test-result content
       Expected=True Actual=True
[PASS] new-task-test-recovery-count-is-independent seeded recovery isolation
       SeedTask=T001 CurrentTask=T002

Test summary: Passed=162, Failed=0
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

2026-08-10 16:27:12

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-commit.ps1
 M scripts/ai-dev-test.ps1
?? .ai-dev/auto-goal-planning-prompt.md
```

## App Change Files

- scripts/ai-dev-commit.ps1
- scripts/ai-dev-test.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md
- .ai-dev/auto-goal-planning-prompt.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-commit.ps1 |  63 ++++++++++--
 scripts/ai-dev-test.ps1   | 241 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+), 10 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-commit.ps1 b/scripts/ai-dev-commit.ps1
index 44338ef..4cb1051 100644
--- a/scripts/ai-dev-commit.ps1
+++ b/scripts/ai-dev-commit.ps1
@@ -150,6 +150,12 @@ function Convert-ToRepoPathspec {
 
     $trimmedPathspec = $Pathspec.Trim()
     $normalizedPathspec = $trimmedPathspec.Replace('\', '/')
+    $pathSegments = @($normalizedPathspec -split "/" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
+
+    if ($pathSegments -contains "..") {
+        Stop-WithError "상위 디렉터리 traversal 경로는 선택할 수 없습니다: $Pathspec"
+    }
+
     $projectRootFullPath = [System.IO.Path]::GetFullPath($projectRoot).TrimEnd('\', '/')
     $projectRootPrefix = $projectRootFullPath + [System.IO.Path]::DirectorySeparatorChar
 
@@ -172,7 +178,49 @@ function Convert-ToRepoPathspec {
         return $relativePath.Replace('\', '/')
     }
 
-    return $normalizedPathspec.TrimStart('/')
+    $relativePathFromFullPath = $fullPath.Substring($projectRootPrefix.Length)
+    return $relativePathFromFullPath.Replace('\', '/').TrimStart('/')
+}
+
+function Test-IsPathInScope {
+    param(
+        [string]$ChangedPath,
+        [string]$ScopePath
+    )
+
+    $normalizedChangedPath = $ChangedPath.Replace('\', '/').TrimStart('/')
+    $normalizedScopePath = $ScopePath.Replace('\', '/').TrimStart('/').TrimEnd('/')
+    $scopePrefix = $normalizedScopePath + "/"
+
+    return (
+        $normalizedChangedPath.Equals($normalizedScopePath, [System.StringComparison]::OrdinalIgnoreCase) -or
+        $normalizedChangedPath.StartsWith($scopePrefix, [System.StringComparison]::OrdinalIgnoreCase)
+    )
+}
+
+function Get-ChangedPathsForScope {
+    param(
+        [string]$ScopePath
+    )
+
+    try {
+        $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--untracked-files=all", "--", $ScopePath) -DisplayName "git status --porcelain --untracked-files=all -- $ScopePath"
+    } catch {
+        Stop-WithError $_.Exception.Message
+    }
+
+    if ([string]::IsNullOrWhiteSpace($fileStatus)) {
+        return @()
+    }
+
+    return @(
+        $fileStatus -split "`r?`n" |
+            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
+            ForEach-Object { Convert-ToChangedPath $_ } |
+            ForEach-Object { Convert-ToRepoPathspec $_ } |
+            Where-Object { Test-IsPathInScope $_ $ScopePath } |
+            Select-Object -Unique
+    )
 }
 
 function Convert-ToFileList {
@@ -279,19 +327,14 @@ if ($null -ne $Files -and $Files.Count -gt 0) {
             Stop-WithError "-Files에는 비어 있지 않은 파일 경로만 지정할 수 있습니다."
         }
 
-        $normalizedFile = Convert-ToRepoPathspec $file
-
-        try {
-            $fileStatus = Invoke-GitCapture -Arguments @("status", "--porcelain", "--", $normalizedFile) -DisplayName "git status --porcelain -- $normalizedFile"
-        } catch {
-            Stop-WithError $_.Exception.Message
-        }
+        $normalizedScope = Convert-ToRepoPathspec $file
+        $changedPathsInScope = @(Get-ChangedPathsForScope $normalizedScope)
 
-        if ([string]::IsNullOrWhiteSpace($fileStatus)) {
+        if ($changedPathsInScope.Count -eq 0) {
             Stop-WithError "선택한 파일에 커밋할 변경사항이 없습니다: $file"
         }
 
-        $selectedFiles += $normalizedFile
+        $selectedFiles += $changedPathsInScope
     }
 
     $selectedFiles = @($selectedFiles | Select-Object -Unique)
diff --git a/scripts/ai-dev-test.ps1 b/scripts/ai-dev-test.ps1
index 78447f6..2a53635 100644
--- a/scripts/ai-dev-test.ps1
+++ b/scripts/ai-dev-test.ps1
@@ -579,6 +579,176 @@ function Invoke-IsolatedScenario {
     }
 }
 
+function Invoke-CommitScopeScenario {
+    param(
+        [Parameter(Mandatory = $true)]
+        [string]$Name,
+
+        [Parameter(Mandatory = $true)]
+        [string[]]$ScopeArgs,
+
+        [string[]]$ExpectedCommittedFiles = @(),
+
+        [string[]]$ChangedFiles = @(),
+
+        [string[]]$DeletedFiles = @(),
+
+        [string[]]$StagedOutsideFiles = @(),
+
+        [bool]$ExpectSuccess = $true,
+
+        [string]$ExpectedOutputFragment = ""
+    )
+
+    $tmpRoot = Join-Path $env:TEMP (
+        "planpilot-test-" +
+        $Name +
+        "-" +
+        (Get-Date -Format "yyyyMMddHHmmssfff")
+    )
+
+    $scenarioRoot = New-IsolatedScenarioRoot -Name $Name -Root $tmpRoot
+
+    if ($scenarioRoot.Cleanup -eq "none") {
+        Write-TestResult `
+            -Name "$Name isolated repository creation" `
+            -Passed $false `
+            -Detail $scenarioRoot.Error
+
+        return
+    }
+
+    try {
+        Copy-Item `
+            -LiteralPath (
+                Join-Path $repoRoot "scripts\ai-dev-commit.ps1"
+            ) `
+            -Destination (
+                Join-Path $tmpRoot "scripts\ai-dev-commit.ps1"
+            ) `
+            -Force
+
+        & git -C $tmpRoot config user.email "ai-dev-test@example.invalid" | Out-Null
+        & git -C $tmpRoot config user.name "AI Dev Test" | Out-Null
+
+        $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
+
+        foreach ($changedFile in @($ChangedFiles)) {
+            $changedPath = Join-Path $tmpRoot $changedFile
+            $changedDirectory = Split-Path -Parent $changedPath
+
+            if (-not [string]::IsNullOrWhiteSpace($changedDirectory)) {
+                [System.IO.Directory]::CreateDirectory($changedDirectory) | Out-Null
+            }
+
+            [System.IO.File]::WriteAllText(
+                $changedPath,
+                "changed by commit scope test $Name",
+                $utf8WithBom
+            )
+        }
+
+        foreach ($deletedFile in @($DeletedFiles)) {
+            $deletedPath = Join-Path $tmpRoot $deletedFile
+
+            if ([System.IO.File]::Exists($deletedPath)) {
+                [System.IO.File]::Delete($deletedPath)
+            }
+        }
+
+        foreach ($stagedOutsideFile in @($StagedOutsideFiles)) {
+            $stagedPath = Join-Path $tmpRoot $stagedOutsideFile
+            $stagedDirectory = Split-Path -Parent $stagedPath
+
+            if (-not [string]::IsNullOrWhiteSpace($stagedDirectory)) {
+                [System.IO.Directory]::CreateDirectory($stagedDirectory) | Out-Null
+            }
+
+            [System.IO.File]::WriteAllText(
+                $stagedPath,
+                "staged outside commit scope test $Name",
+                $utf8WithBom
+            )
+
+            & git -C $tmpRoot add -- $stagedOutsideFile | Out-Null
+        }
+
+        Push-Location $tmpRoot
+
+        try {
+            $previousErrorActionPreference = $ErrorActionPreference
+            $ErrorActionPreference = "Continue"
+            $output = & powershell `
+                -NoProfile `
+                -ExecutionPolicy Bypass `
+                -File ".\scripts\ai-dev-commit.ps1" `
+                -Message "test: commit scope $Name" `
+                -Files ($ScopeArgs -join ",") `
+                -AllowWithoutPassedCheck `
+                -AllowWithoutPassedReview 2>&1
+            $scenarioExitCode = $LASTEXITCODE
+            $outputText = $output | Out-String
+        }
+        finally {
+            $ErrorActionPreference = $previousErrorActionPreference
+            Pop-Location
+        }
+
+        if ($ExpectSuccess) {
+            $committedFiles = @(
+                & git -C $tmpRoot diff-tree --no-commit-id --name-only -r HEAD |
+                    ForEach-Object { $_.Replace('\', '/') } |
+                    Sort-Object
+            )
+            $expectedFiles = @(
+                $ExpectedCommittedFiles |
+                    ForEach-Object { $_.Replace('\', '/') } |
+                    Sort-Object
+            )
+            $unexpectedCommittedFiles = @($committedFiles | Where-Object { $expectedFiles -notcontains $_ })
+            $missingCommittedFiles = @($expectedFiles | Where-Object { $committedFiles -notcontains $_ })
+
+            Write-TestResult `
+                -Name "$Name commit succeeds" `
+                -Passed ($scenarioExitCode -eq 0) `
+                -Detail "ExitCode=$scenarioExitCode OutputPreview=$((($outputText.Replace("`r", " ").Replace("`n", " ")).Trim()))"
+
+            Write-TestResult `
+                -Name "$Name committed file scope" `
+                -Passed ($unexpectedCommittedFiles.Count -eq 0 -and $missingCommittedFiles.Count -eq 0) `
+                -Detail (
+                    "Expected=" +
+                    ($expectedFiles -join ", ") +
+                    " Actual=" +
+                    ($committedFiles -join ", ") +
+                    " Missing=" +
+                    ($missingCommittedFiles -join ", ") +
+                    " Unexpected=" +
+                    ($unexpectedCommittedFiles -join ", ")
+                )
+        } else {
+            $fragmentMatched = (
+                [string]::IsNullOrWhiteSpace($ExpectedOutputFragment) -or
+                $outputText.Contains($ExpectedOutputFragment)
+            )
+
+            Write-TestResult `
+                -Name "$Name commit blocked" `
+                -Passed ($scenarioExitCode -ne 0 -and $fragmentMatched) `
+                -Detail "ExitCode=$scenarioExitCode ExpectedFragment=$ExpectedOutputFragment OutputPreview=$((($outputText.Replace("`r", " ").Replace("`n", " ")).Trim()))"
+        }
+    }
+    catch {
+        Write-TestResult `
+            -Name "$Name execution" `
+            -Passed $false `
+            -Detail ("Line={0} Message={1}" -f $_.InvocationInfo.ScriptLineNumber, $_.Exception.Message)
+    }
+    finally {
+        Remove-IsolatedScenarioRoot -ScenarioRoot $scenarioRoot
+    }
+}
+
 function Set-JsonFile {
     param(
         [Parameter(Mandatory = $true)]
@@ -1886,6 +2056,77 @@ Invoke-IsolatedScenario `
         "-MaxSteps", "40"
     )
 
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-ai-company-directory" `
+    -ScopeArgs @(".ai-company/") `
+    -ChangedFiles @(
+        ".ai-company/customer-requests.json",
+        ".ai-company/reports/adapter-plan.md",
+        ".ai-company/reports/new-scope-report.md"
+    ) `
+    -DeletedFiles @(".ai-company/customer-decisions.json") `
+    -ExpectedCommittedFiles @(
+        ".ai-company/customer-requests.json",
+        ".ai-company/reports/adapter-plan.md",
+        ".ai-company/reports/new-scope-report.md",
+        ".ai-company/customer-decisions.json"
+    )
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-reports-directory" `
+    -ScopeArgs @(".ai-company/reports/") `
+    -ChangedFiles @(".ai-company/reports/adapter-plan.md") `
+    -ExpectedCommittedFiles @(".ai-company/reports/adapter-plan.md")
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-new-directory" `
+    -ScopeArgs @("ai-software-company/") `
+    -ChangedFiles @(
+        "ai-software-company/notes.md",
+        "ai-software-company/reports/summary.md"
+    ) `
+    -ExpectedCommittedFiles @(
+        "ai-software-company/notes.md",
+        "ai-software-company/reports/summary.md"
+    )
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-file-and-directory" `
+    -ScopeArgs @(".ai-company/reports/", "scripts/ai-dev-status.ps1") `
+    -ChangedFiles @(
+        ".ai-company/reports/adapter-plan.md",
+        "scripts/ai-dev-status.ps1"
+    ) `
+    -ExpectedCommittedFiles @(
+        ".ai-company/reports/adapter-plan.md",
+        "scripts/ai-dev-status.ps1"
+    )
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-blocks-outside-staged-file" `
+    -ScopeArgs @(".ai-company/") `
+    -ChangedFiles @(".ai-company/customer-requests.json") `
+    -StagedOutsideFiles @("scripts/ai-dev-status.ps1") `
+    -ExpectedCommittedFiles @() `
+    -ExpectSuccess $false `
+    -ExpectedOutputFragment "선택 파일 외에 이미 staged 된 파일"
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-blocks-repo-outside-path" `
+    -ScopeArgs @($env:TEMP) `
+    -ChangedFiles @(".ai-company/customer-requests.json") `
+    -ExpectedCommittedFiles @() `
+    -ExpectSuccess $false `
+    -ExpectedOutputFragment "저장소 밖 파일"
+
+Invoke-CommitScopeScenario `
+    -Name "commit-scope-blocks-traversal-path" `
+    -ScopeArgs @("../outside.txt") `
+    -ChangedFiles @(".ai-company/customer-requests.json") `
+    -ExpectedCommittedFiles @() `
+    -ExpectSuccess $false `
+    -ExpectedOutputFragment "traversal"
+
 Invoke-ReviewRequiredFilesRecoveryScenario `
     -Name "review-required-files-partial-diff" `
     -RequiredFiles @("A.ps1", "B.ps1") `
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
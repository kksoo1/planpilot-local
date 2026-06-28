# AI Dev Diff

## Generated At

2026-06-28 20:01:11

## Git Status

```text
 M .ai-dev/codex-result.md
 M .ai-dev/codex-review-result.md
 M .ai-dev/current-task-prompt.md
 M .ai-dev/diff.md
 M .ai-dev/goal.md
 M .ai-dev/queue.json
 M .ai-dev/review-prompt.md
 M .ai-dev/review-response.json
 M .ai-dev/review.md
 M .ai-dev/revise-prompt.md
 M .ai-dev/state.json
 M .ai-dev/test-result.md
 M scripts/ai-dev-status.ps1
```

## App Change Files

- scripts/ai-dev-status.ps1

## AI Dev Operational Artifact Files

- .ai-dev/codex-result.md
- .ai-dev/codex-review-result.md
- .ai-dev/current-task-prompt.md
- .ai-dev/diff.md
- .ai-dev/goal.md
- .ai-dev/queue.json
- .ai-dev/review-prompt.md
- .ai-dev/review-response.json
- .ai-dev/review.md
- .ai-dev/revise-prompt.md
- .ai-dev/state.json
- .ai-dev/test-result.md

## Review Diff Scope

아래 diff 본문은 실제 앱 변경 파일 중심으로 검토하도록 .ai-dev 운영 산출물 diff를 제외합니다. .ai-dev 변경은 위 운영 산출물 목록에서 별도로 확인합니다.

## Unstaged Diff Stat

```text
 scripts/ai-dev-status.ps1 | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
```

## Unstaged Diff

```text
diff --git a/scripts/ai-dev-status.ps1 b/scripts/ai-dev-status.ps1
index ec23aa9..54a7440 100644
--- a/scripts/ai-dev-status.ps1
+++ b/scripts/ai-dev-status.ps1
@@ -158,15 +158,15 @@ function Get-ReviewSummary {
         }
 
         if ($IsInitialState) {
-            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." $review
+            return New-SummaryStatus "stale" "현재 task가 초기 상태라 이전 review 요약을 숨겼습니다." "숨김"
         }
 
         if ((Test-HasValue $LastReviewDecision) -and $LastReviewDecision -ne "not_started" -and (Test-HasValue $decision) -and $decision -ne $LastReviewDecision) {
-            return New-SummaryStatus "stale" "review decision($decision)이 state lastReviewDecision($LastReviewDecision)와 다릅니다." $review
+            return New-SummaryStatus "stale" "review decision($decision)이 state lastReviewDecision($LastReviewDecision)와 다릅니다." "숨김"
         }
 
         if (-not (Test-HasValue $LastReviewDecision) -or $LastReviewDecision -eq "not_started") {
-            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요약을 숨겼습니다." $review
+            return New-SummaryStatus "stale" "state lastReviewDecision이 초기 상태라 이전 review 요약을 숨겼습니다." "숨김"
         }
 
         return New-SummaryStatus "current" "현재 상태와 일치합니다." $review
@@ -333,10 +333,14 @@ Write-Host ""
 Write-Host "Review summary:"
 Write-Host "  Status: $($reviewSummary.status)"
 Write-Host "  Reason: $($reviewSummary.reason)"
-Write-Host "  Decision: $($reviewSummary.content.decision)"
-Write-Host "  Severity: $($reviewSummary.content.severity)"
-Write-Host "  Next step: $($reviewSummary.content.nextStep)"
-Write-Host "  Summary: $($reviewSummary.content.summary)"
+if ($reviewSummary.status -eq "stale") {
+    Write-Host $reviewSummary.content
+} else {
+    Write-Host "  Decision: $($reviewSummary.content.decision)"
+    Write-Host "  Severity: $($reviewSummary.content.severity)"
+    Write-Host "  Next step: $($reviewSummary.content.nextStep)"
+    Write-Host "  Summary: $($reviewSummary.content.summary)"
+}
 
 if ($reviewSummary.status -eq "current" -and (Test-HasValue $reviewSummary.content.fallback)) {
     Write-Host $reviewSummary.content.fallback
```

## Staged Diff Stat

```text
변경 없음
```

## Staged Diff

```text
변경 없음
```
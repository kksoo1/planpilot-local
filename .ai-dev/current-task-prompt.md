Fix the actual durable history bug found by targeted verification.

Observed error:
[System.Management.Automation.PSObject] does not have method op_Addition
Location:
scripts/ai-dev-autopilot.ps1
Add-AutopilotGoalHistoryTitle
Line pattern:
$events += [PSCustomObject][ordered]@{ ... }

Root cause:
When an existing history goal already has an events property, PowerShell can treat $events as a single PSObject instead of an array, so += fails.

Required fix:
1. Modify scripts/ai-dev-autopilot.ps1 only.
2. In Add-AutopilotGoalHistoryTitle, normalize existing events to a real object array before appending.
3. Preserve existing event history.
4. Preserve support for old history entries that are plain strings.
5. Preserve DryRun behavior.
6. Preserve selected/prepared/completed event recording.
7. Do not modify app src files.
8. Do not commit.

Suggested implementation direction:
Use an explicit object array, for example:
$events = @()
if (...) {
  $events = @($existingGoal.events)
}
$events = @($events) + @([PSCustomObject][ordered]@{ event = $Event; at = $now })

Also check any similar goal array append path if needed so repeated history updates do not fail.

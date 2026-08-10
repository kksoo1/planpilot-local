# Required Files Recovery Prompt

리뷰 required_changes와 실제 changedFiles 비교에서 누락 파일이 확인되었습니다. 아래 누락 파일만 대상으로 현재 task 범위 안에서 최소 수정하세요.

## Reason

`	ext
재리뷰도 revise + revise_with_codex를 반환해 자동 revise 재시도를 중단합니다. summary=초기 .ai-company 상태 파일은 존재하고 JSON/JSONL 파싱은 통과하지만, PowerShell 5.1 기본 읽기에서 한글이 깨져 보여 T002의 한글 UTF-8 유지 요구를 충족했다고 보기 어렵습니다., severity=medium, next_step=revise_with_codex, required_changes=[
    {
        "file":  ".ai-company/*.json, .ai-company/events.jsonl",
        "reason":  "PowerShell 5.1의 기본 Get-Content 출력에서 한글 문자열이 mojibake로 표시됩니다. T002는 Windows PowerShell 5.1 환경에서 한글 UTF-8을 유지하는 파일 형식을 요구합니다.",
        "suggestion":  "회사 상태 파일을 PowerShell 5.1에서도 한글이 정상 표시되도록 UTF-8 BOM 포함 형식으로 다시 저장하거나, 상태 파일의 한글 설명 문자열을 제거해 ASCII enum/키 중심으로 유지하고 한글 라벨은 별도 표시 계층에서 처리하십시오."
    },
    {
        "file":  ".ai-dev/diff.md",
        "reason":  "Review Diff Scope에는 App Change Files가 없음으로 표시되지만 실제 T002 산출물인 .ai-company 파일들이 존재합니다. 리뷰 산출물이 실제 변경 파일을 반영하지 못해 변경 범위 판단이 불확실합니다.",
        "suggestion":  ".ai-company 초기 파일들이 diff/review 대상에 포함되도록 변경 감지 산출물을 갱신한 뒤 다시 리뷰하십시오."
    }
]
`

## Missing Required Files

`	ext
.ai-company/*.json, .ai-company/events.jsonl
`

## Latest required_changes

`json
[
    {
        "file":  ".ai-company/*.json, .ai-company/events.jsonl",
        "reason":  "PowerShell 5.1의 기본 Get-Content 출력에서 한글 문자열이 mojibake로 표시됩니다. T002는 Windows PowerShell 5.1 환경에서 한글 UTF-8을 유지하는 파일 형식을 요구합니다.",
        "suggestion":  "회사 상태 파일을 PowerShell 5.1에서도 한글이 정상 표시되도록 UTF-8 BOM 포함 형식으로 다시 저장하거나, 상태 파일의 한글 설명 문자열을 제거해 ASCII enum/키 중심으로 유지하고 한글 라벨은 별도 표시 계층에서 처리하십시오."
    },
    {
        "file":  ".ai-dev/diff.md",
        "reason":  "Review Diff Scope에는 App Change Files가 없음으로 표시되지만 실제 T002 산출물인 .ai-company 파일들이 존재합니다. 리뷰 산출물이 실제 변경 파일을 반영하지 못해 변경 범위 판단이 불확실합니다.",
        "suggestion":  ".ai-company 초기 파일들이 diff/review 대상에 포함되도록 변경 감지 산출물을 갱신한 뒤 다시 리뷰하십시오."
    }
]
`

## Rules

- 위 누락 파일과 직접 관련된 변경만 수행합니다.
- 기존 사용자 변경과 baseline 변경을 되돌리지 않습니다.
- package.json, package-lock.json, node_modules, dist, .git은 수정하지 않습니다.
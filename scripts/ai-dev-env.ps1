try {
    chcp 65001 | Out-Null
    $OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::InputEncoding = [System.Text.Encoding]::UTF8
} catch {
    # UTF-8 콘솔 설정 실패는 AI Dev 스크립트 실행을 중단하지 않는다.
}

try {
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)

    chcp 65001 | Out-Null
    [Console]::OutputEncoding = $utf8NoBom
    [Console]::InputEncoding = $utf8NoBom
    $OutputEncoding = $utf8NoBom

    $env:PYTHONIOENCODING = "utf-8"
    $env:PYTHONUTF8 = "1"
    $env:npm_config_unicode = "true"
} catch {
    # UTF-8 콘솔 설정 실패는 AI Dev 스크립트 실행을 중단하지 않는다.
}

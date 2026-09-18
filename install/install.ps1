# Codex 슬래시 명령으로 설치 (Windows)
# 실행: powershell -ExecutionPolicy Bypass -File install.ps1
$dest = Join-Path $HOME ".codex\prompts"
New-Item -ItemType Directory -Force $dest | Out-Null
Copy-Item (Join-Path $PSScriptRoot "handdrawn-mv.md") $dest -Force
Write-Host "설치 완료: $dest\handdrawn-mv.md"
Write-Host "Codex에서 /handdrawn-mv 로 사용할 수 있습니다. (Codex 재시작 필요할 수 있음)"

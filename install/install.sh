#!/usr/bin/env bash
# Codex 슬래시 명령으로 설치 (macOS / Linux)
# 실행: bash install.sh
dest="$HOME/.codex/prompts"
mkdir -p "$dest"
cp "$(dirname "$0")/handdrawn-mv.md" "$dest/"
echo "설치 완료: $dest/handdrawn-mv.md"
echo "Codex에서 /handdrawn-mv 로 사용할 수 있습니다. (Codex 재시작 필요할 수 있음)"

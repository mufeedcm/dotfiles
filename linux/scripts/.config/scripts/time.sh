#!/usr/bin/env bash
set -euo pipefail

CATEGORIES=(
  "LEARNING-DEV"
  "LEARNING-ELECTRONICS"
  "PROGRAMMING"
  "CONFIGURING"
  "WASTED"
  "STOP"
)


selected=$(printf "%s\n" "${CATEGORIES[@]}" | rofi -dmenu -i -p "Track:")

[[ -z "$selected" ]] && exit 0

if [[ "$selected" == "STOP" ]]; then
  timew stop 2>/dev/null || true
  notify-send "timew" "Stopped tracking"
else
  timew start "$selected"
  notify-send "timew" "Started: $selected"
fi

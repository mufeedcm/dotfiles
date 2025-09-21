#!/usr/bin/env bash
set -euo pipefail

CATEGORIES=(
  "learning"
  "config"
  "wasted"
  "stop"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | rofi -dmenu -i -p "Track:")

[[ -z "$selected" ]] && exit 0

if [[ "$selected" == "stop" ]]; then
  timew stop 2>/dev/null || true
  notify-send "timew" "Stopped tracking"

  # unblock YouTube if it was blocked
  sudo hostess rm www.youtube.com ::1 || true
else
  timew start "$selected"
  notify-send "timew" "Started: $selected"

  if [[ "$selected" == "learning" ]]; then
    # block YouTube while learning
    sudo hostess add www.youtube.com ::1
  else
    # in other modes, unblock YouTube
    sudo hostess rm www.youtube.com ::1 || true
  fi
fi

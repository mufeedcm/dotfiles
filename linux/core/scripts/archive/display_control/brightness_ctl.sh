#!/bin/bash

# BRIGHTNESS_FILE="/tmp/.brightness_level"
BRIGHTNESS_FILE="$HOME/.cache/display_control/brightness_ctl"

output=$(xrandr | grep " connected" | cut -f1 -d " ")
level=$(cat "$BRIGHTNESS_FILE" 2>/dev/null || echo 100)

case "$1" in
    up)
        level=$((level + 5))
        ;;
    down)
        level=$((level - 5))
        ;;
esac

# Clamp 0–100
[ "$level" -gt 100 ] && level=100
[ "$level" -lt 1 ] && level=1

# Convert to float for xrandr (e.g., 80 => 0.80)
brightness=$(awk "BEGIN { print $level / 100 }")

xrandr --output "$output" --brightness "$brightness"
echo "$level" > "$BRIGHTNESS_FILE"

notify-send -u low -t 800 -h int:value:$level -h string:x-canonical-private-synchronous:brightness "🌞 Brightness: $level%"

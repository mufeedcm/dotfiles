#!/bin/bash

# LEVEL_FILE="/tmp/.warmness_kelvin"
LEVEL_FILE="$HOME/.cache/display_control/warmness_ctl"
kelvin=$(cat "$LEVEL_FILE" 2>/dev/null || echo 6500)

case "$1" in
    up)
        kelvin=$((kelvin + 500))
        ;;
    down)
        kelvin=$((kelvin - 500))
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Clamp 1000–6500
[ "$kelvin" -gt 6500 ] && kelvin=6500
[ "$kelvin" -lt 1000 ] && kelvin=1000

# Apply
redshift -x >/dev/null 2>&1
redshift -O "$kelvin" >/dev/null 2>&1 &
echo "$kelvin" > "$LEVEL_FILE"

# Normalize for dunst bar
percent=$(awk "BEGIN { printf \"%d\", (($kelvin - 1000) / 5500) * 100 }")

# Notify
notify-send -u low -t 800 \
  -h string:x-canonical-private-synchronous:warmness \
  -h int:value:$percent \
  "🌅 Warmness: $kelvin K"

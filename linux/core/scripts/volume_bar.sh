#!/usr/bin/env bash

action="$1"

case "$action" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if echo "$volume" | grep -q MUTED; then
    notify-send -t 1000 -h string:x-canonical-private-synchronous:volume \
        "🔇 Muted"
else
    vol=$(echo "$volume" | awk '{printf "%d", $2*100}')
    notify-send -t 1000 \
      -h string:x-canonical-private-synchronous:volume \
      -h int:value:"$vol" \
      "🔊 Volume $vol%"
fi

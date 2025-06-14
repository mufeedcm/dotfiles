#!/bin/bash

case $BUTTON in
  1) pactl set-sink-mute @DEFAULT_SINK@ toggle ;; # left click = toggle mute
  4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;; # scroll up
  5) pactl set-sink-volume @DEFAULT_SINK@ -5% ;; # scroll down
esac

muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
level=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1)

if [ "$muted" = "yes" ]; then
  echo "🔇"
else
  echo "🔊 $level"
fi


# pkill -RTMIN+1 dwmblocks

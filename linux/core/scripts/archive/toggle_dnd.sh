#!/usr/bin/env bash

STATE=$(dunstctl is-paused)

if [ "$STATE" = "true" ]; then
    dunstctl set-paused false
    notify-send -u low "Do Not Disturb" "Disabled"
else
    dunstctl set-paused true
    notify-send -u low "Do Not Disturb" "Enabled"
fi

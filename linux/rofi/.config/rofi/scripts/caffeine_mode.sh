#!/bin/bash

# Caffeine Mode Toggle

CAFFEINE_STATE_FILE="/tmp/caffeine_mode"

if [ -f "$CAFFEINE_STATE_FILE" ] && grep -q "on" "$CAFFEINE_STATE_FILE"; then
    pkill xautolock
    notify-send -u low "Caffeine Mode" "Disabled"
    echo "off" > "$CAFFEINE_STATE_FILE"
else
    xautolock -time 15 -locker "slock & systemctl suspend;" & disown
    notify-send -u low "Caffeine Mode" "Enabled"
    echo "on" > "$CAFFEINE_STATE_FILE"
fi

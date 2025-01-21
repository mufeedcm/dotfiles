#!/bin/bash

# File to store the state of caffeine mode
CAFFEINE_STATE_FILE="/tmp/caffeine_mode"

# Check the current state
if [ -f "$CAFFEINE_STATE_FILE" ] && grep -q "on" "$CAFFEINE_STATE_FILE"; then
    # Disable Caffeine Mode
    pkill xautolock
    notify-send -u low "Caffeine Mode" "Disabled"
    echo "off" > "$CAFFEINE_STATE_FILE"
else
    # Enable Caffeine Mode
    xautolock -time 15 -locker "slock & systemctl suspend;" & disown
    notify-send -u low "Caffeine Mode" "Enabled"
    echo "on" > "$CAFFEINE_STATE_FILE"
fi

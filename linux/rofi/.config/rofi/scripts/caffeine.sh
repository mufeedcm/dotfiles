#!/bin/bash

# File: ~/.config/i3/scripts/toggle_caffeine.sh

# State file to keep track of mode
CAFFEINE_STATE_FILE="/tmp/caffeine_mode"

# Check the current state
if [ -f "$CAFFEINE_STATE_FILE" ] && grep -q "on" "$CAFFEINE_STATE_FILE"; then
    # Disable Caffeine Mode
    xset s on +dpms
    notify-send -u low "Caffeine Mode" "Disabled"
    echo "off" > "$CAFFEINE_STATE_FILE"
else
    # Enable Caffeine Mode
    xset s off -dpms
    notify-send -u low "Caffeine Mode" "Enabled"
    echo "on" > "$CAFFEINE_STATE_FILE"
fi

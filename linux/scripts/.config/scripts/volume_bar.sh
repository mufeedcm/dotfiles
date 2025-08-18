#!/bin/bash

# Unified Volume Control Script with notify-send for 200% volume

action=$1  # Get the action: up, down, or toggle

# Configuration
sink=$(pactl list short sinks | grep RUNNING | awk '{print $1}')  # Get the default sink

# Ensure a valid sink is found
if [ -z "$sink" ]; then
    echo "No active audio sink found!"
    exit 1
fi

# Handle volume actions
case "$action" in
    up)
        pactl set-sink-volume "$sink" +5%
        ;;
    down)
        pactl set-sink-volume "$sink" -5%
        ;;
    toggle)
        pactl set-sink-mute "$sink" toggle
        ;;
    *)
        echo "Usage: $0 {up|down|toggle}"
        exit 1
        ;;
esac

# Get the current volume percentage
vol=$(pactl get-sink-volume "$sink" | grep -oP '\d+%' | head -1 | tr -d '%')

# Check if muted
muted=$(pactl get-sink-mute "$sink" | grep -oP '(yes|no)')
if [ "$muted" = "yes" ]; then
    notify-send -u low -t 800 -h string:x-canonical-private-synchronous:volume "🔇 Volume: Muted"
else
    # Normalize volume to a 0-100 range for dunst's progress bar
    normalized_vol=$((vol > 200 ? 100 : vol * 100 / 200))
    notify-send -u low -t 800 -h string:x-canonical-private-synchronous:volume -h int:value:$normalized_vol "🔊 Volume: $vol%"
fi

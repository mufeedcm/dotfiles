#!/bin/bash

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"

get_current_port() {
    pactl list sinks | awk "/$SINK/,/Active Port/" | grep "Active Port" | awk '{print $3}'
}

# Initial port
CURRENT_PORT=$(get_current_port)

# Build options: current output second for convenience
if [[ "$CURRENT_PORT" == *headphones* ]]; then
    OPTIONS="Speakers\nHeadphones"
else
    OPTIONS="Headphones\nSpeakers"
fi

# Let user select output via rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Select audio output:" -lines 2)

# Set port based on choice
case "$CHOICE" in
    Headphones)
        TARGET_PORT="analog-output-headphones"
        ;;
    Speakers)
        TARGET_PORT="analog-output-lineout"
        ;;
    *)
        exit 0
        ;;
esac

# Apply sink + port
pactl set-default-sink "$SINK"
pactl set-sink-port "$SINK" "$TARGET_PORT"

# Move all active audio streams to the new sink
for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "$SINK"
done

# 🛠 Fix: Reapply port if necessary
sleep 0.5
RECHECK_PORT=$(get_current_port)
if [[ "$RECHECK_PORT" != "$TARGET_PORT" ]]; then
    pactl set-sink-port "$SINK" "$TARGET_PORT"
    sleep 0.3
    for input in $(pactl list short sink-inputs | cut -f1); do
        pactl move-sink-input "$input" "$SINK"
    done
fi




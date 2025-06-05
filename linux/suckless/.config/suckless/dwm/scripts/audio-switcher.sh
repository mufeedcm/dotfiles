#!/bin/bash

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"

# Get current active port of that sink
CURRENT_PORT=$(pactl list sinks | awk "/$SINK/,/Active Port/" | grep "Active Port" | awk '{print $3}')

# Prepare dmenu options with current output NOT first
if [[ "$CURRENT_PORT" == *headphones* ]]; then
    OPTIONS="Speakers\nHeadphones"
elif [[ "$CURRENT_PORT" == *lineout* ]]; then
    OPTIONS="Headphones\nSpeakers"
else
    OPTIONS="Headphones\nSpeakers"
fi

# Let user pick output
CHOICE=$(echo -e "$OPTIONS" | dmenu -i -p "Select audio output:")

case "$CHOICE" in
  Headphones)
    pactl set-default-sink "$SINK"
    pactl set-sink-port "$SINK" analog-output-headphones
    ;;
  Speakers)
    pactl set-default-sink "$SINK"
    pactl set-sink-port "$SINK" analog-output-lineout
    ;;
  *)
    exit 0
    ;;
esac

# Move all existing audio to the new sink
for input in $(pactl list short sink-inputs | cut -f1); do
  pactl move-sink-input "$input" "$SINK"
done

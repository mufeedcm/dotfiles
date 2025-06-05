#!/bin/bash

CHOICE=$(echo -e "Headphones\nSpeakers" | dmenu -i -p "Select audio output:")

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"

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

for input in $(pactl list short sink-inputs | cut -f1); do
  pactl move-sink-input $input "$SINK"
done

#!/bin/bash

SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"

get_current_port() {
  pactl list sinks | awk "/$SINK/,/Active Port/" | grep "Active Port" | awk '{print $3}'
}

# Initial port
CURRENT_PORT=$(get_current_port)

# Build options
if [[ "$CURRENT_PORT" == *headphones* ]]; then
    OPTIONS="Speakers\nHeadphones"
else
    OPTIONS="Headphones\nSpeakers"
fi

# User selects output
CHOICE=$(echo -e "$OPTIONS" | dmenu -i -p "Select audio output:")

# Set port
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

# Move audio streams to that sink
for input in $(pactl list short sink-inputs | cut -f1); do
  pactl move-sink-input "$input" "$SINK"
done

# 🛠 Fix: Force reapply port if things are still messed up
sleep 0.5
RECHECK_PORT=$(get_current_port)

if [[ "$RECHECK_PORT" != "$TARGET_PORT" ]]; then
  # Reapply port
  pactl set-sink-port "$SINK" "$TARGET_PORT"
  sleep 0.3
  for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "$SINK"
  done
fi


# #!/bin/bash
#
# SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"
#
# # Get current active port of that sink
# CURRENT_PORT=$(pactl list sinks | awk "/$SINK/,/Active Port/" | grep "Active Port" | awk '{print $3}')
#
# # Prepare dmenu options with current output NOT first
# if [[ "$CURRENT_PORT" == *headphones* ]]; then
#     OPTIONS="Speakers\nHeadphones"
# elif [[ "$CURRENT_PORT" == *lineout* ]]; then
#     OPTIONS="Headphones\nSpeakers"
# else
#     OPTIONS="Headphones\nSpeakers"
# fi
#
# # Let user pick output
# CHOICE=$(echo -e "$OPTIONS" | dmenu -i -p "Select audio output:")
#
# case "$CHOICE" in
#   Headphones)
#     pactl set-default-sink "$SINK"
#     pactl set-sink-port "$SINK" analog-output-headphones
#     ;;
#   Speakers)
#     pactl set-default-sink "$SINK"
#     pactl set-sink-port "$SINK" analog-output-lineout
#     ;;
#   *)
#     exit 0
#     ;;
# esac
#
# # Move all existing audio to the new sink
# for input in $(pactl list short sink-inputs | cut -f1); do
#   pactl move-sink-input "$input" "$SINK"
# done

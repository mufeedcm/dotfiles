#!/bin/bash
# ~/.config/suckless/dwm/scripts/display_control.sh

# MODE_FILE="/tmp/.dwm_control_mode"
MODE_FILE="$HOME/.cache/display_control/display_control"

choice=$(printf "brightness\nwarmness\ngrayscale" | dmenu -i -p "Adjust:")

case "$choice" in
    "brightness")
        echo "brightness" > "$MODE_FILE"
        notify-send "🌞 Brightness mode active"
        ;;
    "warmness")
        echo "warmness" > "$MODE_FILE"
        notify-send "🌅 Warmness mode active"
        ;;
    "grayscale")
        ~/.config/suckless/dwm/scripts/display_control/grayscale_ctl.sh
        ;;
    # "grayscale")
    #     echo "grayscale" > "$MODE_FILE"
    #     notify-send "🖤 Grayscale mode active"
    #     ;;
    *)
        exit 1
        ;;
esac

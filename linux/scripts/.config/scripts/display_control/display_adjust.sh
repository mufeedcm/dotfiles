#!/bin/bash
# ~/.config/suckless/dwm/scripts/adjust.sh

# MODE_FILE="/tmp/.dwm_control_mode"
MODE_FILE="$HOME/.cache/display_control/display_control"
mode=$(cat "$MODE_FILE" 2>/dev/null)

case "$mode" in
    brightness)
        ~/.config/suckless/dwm/scripts/display_control/brightness_ctl.sh "$1"
        ;;
    warmness)
        ~/.config/suckless/dwm/scripts/display_control/warmness_ctl.sh "$1"
        ;;
    grayscale)
        ~/.config/suckless/dwm/scripts/display_control/grayscale_ctl.sh "$1"
        ;;
    *)
        notify-send "❗ No mode selected. Run display_control.sh. Press TERMOD+h"
        ;;
esac

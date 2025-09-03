#!/bin/bash

# === File paths ===
BRIGHTNESS_FILE="$HOME/.cache/display_control/brightness_ctl"
WARMNESS_FILE="$HOME/.cache/display_control/warmness_ctl"
GRAYSCALE_FILE="$HOME/.cache/display_control/grayscale_ctl"

# === Detect display output ===
output=$(xrandr | grep " connected" | cut -f1 -d " ")

# === Restore Brightness ===
if [ -f "$BRIGHTNESS_FILE" ]; then
    level=$(cat "$BRIGHTNESS_FILE")
    [ "$level" -gt 100 ] && level=100
    [ "$level" -lt 1 ] && level=1
    brightness=$(awk "BEGIN { print $level / 100 }")
    xrandr --output "$output" --brightness "$brightness"
fi

# === Restore Warmness ===
if [ -f "$WARMNESS_FILE" ]; then
    kelvin=$(cat "$WARMNESS_FILE")
    [ "$kelvin" -gt 6500 ] && kelvin=6500
    [ "$kelvin" -lt 1000 ] && kelvin=1000
    redshift -x >/dev/null 2>&1
    redshift -O "$kelvin" >/dev/null 2>&1 &
fi

# === Restore Grayscale (if enabled before reboot) ===
if [ -f "$GRAYSCALE_FILE" ]; then
    # Kill any existing compositor
    pkill -x picom
    sleep 1
    # Apply grayscale shader (picom with glx backend)
    ~/.config/scripts/display_control/grayscale_ctl.sh --apply
else
    # Start regular picom
    # picom --config ~/.config/picom/picom.conf -b
fi



# #!/bin/bash
#
# # === File paths ===
# BRIGHTNESS_FILE="$HOME/.cache/display_control/brightness_ctl"
# WARMNESS_FILE="$HOME/.cache/display_control/warmness_ctl"
# GRAYSCALE_FILE="$HOME/.cache/display_control/grayscale_ctl"
#
# # === Detect display output ===
# output=$(xrandr | grep " connected" | cut -f1 -d " ")
#
# # === Restore Brightness ===
# if [ -f "$BRIGHTNESS_FILE" ]; then
#     level=$(cat "$BRIGHTNESS_FILE")
#     [ "$level" -gt 100 ] && level=100
#     [ "$level" -lt 1 ] && level=1
#     brightness=$(awk "BEGIN { print $level / 100 }")
#     xrandr --output "$output" --brightness "$brightness"
# fi
#
# # === Restore Warmness ===
# if [ -f "$WARMNESS_FILE" ]; then
#     kelvin=$(cat "$WARMNESS_FILE")
#     [ "$kelvin" -gt 6500 ] && kelvin=6500
#     [ "$kelvin" -lt 1000 ] && kelvin=1000
#     redshift -x >/dev/null 2>&1
#     redshift -O "$kelvin" >/dev/null 2>&1 &
# fi
#
# # === Restore Grayscale (if enabled before reboot) ===
# if [ -f "$GRAYSCALE_FILE" ]; then
#     # Kill any existing compositor
#     pkill -x picom
#     sleep 1
#     # Apply grayscale shader (picom with glx backend)
#     ~/.config/scripts/display_control/grayscale_ctl.sh --apply
# else
#     # Start regular picom
#     # picom --config ~/.config/picom/picom.conf -b
# fi

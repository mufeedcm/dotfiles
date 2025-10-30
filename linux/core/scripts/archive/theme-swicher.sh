#!/bin/bash

# This script changes the symlink for the current theme and reloads Xresources

THEME=$1

# Path to the Xresources directory
XRESOURCES_DIR="$HOME/.Xresources.d"

# The current theme symlink
CURRENT_THEME="$XRESOURCES_DIR/current.xr"

# Set the target theme file
case "$THEME" in
    "TokyoNight")
        TARGET_THEME="$XRESOURCES_DIR/tokyonight.xr"
        ;;
    "Light")
        TARGET_THEME="$XRESOURCES_DIR/light.xr"
        ;;
    *)
        echo "Unknown theme: $THEME"
        exit 1
        ;;
esac

# Update the symlink
ln -sf "$TARGET_THEME" "$CURRENT_THEME"

# Reload Xresources to apply the theme
xrdb -merge "$HOME/.Xresources"

# Notify the user
notify-send "Theme Changed" "Switched to $THEME theme"

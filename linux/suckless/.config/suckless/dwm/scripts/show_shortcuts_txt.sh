#!/bin/bash

# Path to the shortcuts text file
SHORTCUTS_FILE="$HOME/.config/suckless/dwm/scripts/show_shortcuts.txt"

# Check if the file exists
if [ ! -f "$SHORTCUTS_FILE" ]; then
    echo "Shortcuts file not found!"
    exit 1
fi

# Colors for Tokyo Night theme
BG_COLOR="#1a1b26"
FG_COLOR="#c0caf5"
SEL_BG_COLOR="#7aa2f7"
SEL_FG_COLOR="#1a1b26"
# Display the contents of the shortcuts file in dmenu
cat "$SHORTCUTS_FILE" | dmenu -l 20 -nb "$BG_COLOR" -nf "$FG_COLOR" -sb "$SEL_BG_COLOR" -sf "$SEL_FG_COLOR"

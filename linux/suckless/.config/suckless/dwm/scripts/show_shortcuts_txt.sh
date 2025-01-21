#!/bin/bash

# Path to the shortcuts text file
SHORTCUTS_FILE="$HOME/.config/suckless/dwm/scripts/show_shortcuts.txt"

# Check if the file exists
if [ ! -f "$SHORTCUTS_FILE" ]; then
    echo "Shortcuts file not found!"
    exit 1
fi

# Display the contents of the shortcuts file in dmenu using default colors
cat "$SHORTCUTS_FILE" | dmenu -l 20

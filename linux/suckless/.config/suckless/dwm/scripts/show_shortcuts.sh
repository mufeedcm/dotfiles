#!/bin/bash

# Function to extract keybindings from a Suckless config.h file
extract_keybindings() {
    local file=$1
    local app=$2
    echo "Shortcuts for $app:"
    echo "----------------------------------------"
    # Extract lines with keybindings and format them
    grep -E '\{.*MODKEY.*\}.*' "$file" | sed -E \
        -e 's/\{(.*MODKEY[^,]*),\s*(XK_[^,]*),\s*.*SHCMD\("([^"]*)"\)\},/\1 + \2: \3/' \
        -e 's/MODKEY/Alt/g' \
        -e 's/\|/ +/g' \
        -e 's/XK_//g'
    echo ""
}

# Paths to config.h files (updated for your setup)
DWM_CONFIG="$HOME/.config/suckless/dwm/config.h"
ST_CONFIG="$HOME/.config/suckless/st/config.h"
DMENU_CONFIG="$HOME/.config/suckless/dmenu/config.h"

# Temporary file to hold keybindings
KEYBINDINGS=$(mktemp)

# Output shortcuts from each file
if [ -f "$DWM_CONFIG" ]; then
    extract_keybindings "$DWM_CONFIG" "dwm" >> "$KEYBINDINGS"
fi
if [ -f "$ST_CONFIG" ]; then
    extract_keybindings "$ST_CONFIG" "st" >> "$KEYBINDINGS"
fi
if [ -f "$DMENU_CONFIG" ]; then
    extract_keybindings "$DMENU_CONFIG" "dmenu" >> "$KEYBINDINGS"
fi

# Check if the keybindings file is empty
if [ ! -s "$KEYBINDINGS" ]; then
    echo "No keybindings found!"
    exit 1
fi

# Display the content in dmenu using default colors
cat "$KEYBINDINGS" | dmenu -l 20

# Clean up the temporary file
rm "$KEYBINDINGS"

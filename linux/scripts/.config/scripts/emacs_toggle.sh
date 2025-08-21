#!/bin/bash
TITLE="scratchpad-emacs"
WIN_ID=$(i3-msg -t get_tree | grep -oP '"id":\K\d+(?=,.*"title":"'"$TITLE"'")')

if [ -z "$WIN_ID" ]; then
    emacs --name "$TITLE" -g 120x45 &
    sleep 0.5  
    i3-msg "[title=\"$TITLE\"] floating enable, resize set 1200 800, move position center, move scratchpad"
else
    i3-msg "[title=\"$TITLE\"] scratchpad show"
fi

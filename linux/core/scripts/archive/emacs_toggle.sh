#!/bin/bash

TITLE="scratchpad-emacs"
LOCKFILE="/tmp/scratchpad-emacs.lock"

# Get the window ID of Emacs with the given title
WIN_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window_properties?.title=="'"$TITLE"'") | .id')

if [ -z "$WIN_ID" ]; then
    # Only lock creation to prevent multiple launches
    (
        flock -n 200 || exit 0  # exit if another creation is ongoing

        # Create the window
        emacs --name "$TITLE" -g 120x45 &

        # Wait until the window appears
        while : ; do
            WIN_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window_properties?.title=="'"$TITLE"'") | .id')
            [ -n "$WIN_ID" ] && break
            sleep 0.1
        done

        # Make it floating, resize, center, move to scratchpad, then show
        i3-msg "[title=\"$TITLE\"] floating enable, resize set 1100 900, move position center, move scratchpad, scratchpad show"

    ) 200>"$LOCKFILE"
else
    # Window exists, check if it's visible
    VISIBLE=$(i3-msg -t get_tree | jq '.. | objects | select(.id=='"$WIN_ID"') | .visible')

    if [ "$VISIBLE" = "true" ]; then
        # Window is visible: move it to scratchpad
        i3-msg "[title=\"$TITLE\"] move scratchpad"
    else
        # Window hidden: show it, then center
        i3-msg "[title=\"$TITLE\"] scratchpad show, move position center"
    fi
fi

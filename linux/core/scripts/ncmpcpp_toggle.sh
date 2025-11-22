#!/bin/bash

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    if pgrep -f "st -c ncmpcpp" > /dev/null; then
        pkill -f "st -c ncmpcpp"
    else
        st -c ncmpcpp -g 60x25+1418+40 -e ncmpcpp &
        ST_PID=$!
        (
            sleep 4
            if ps -p $ST_PID > /dev/null; then
                kill $ST_PID 2>/dev/null
            fi
        ) &
    fi

elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if pgrep -f "wezterm.*--class ncmpcpp" > /dev/null; then
        pkill -f "wezterm.*--class ncmpcpp"
    else
        wezterm start --class ncmpcpp -- ncmpcpp &
        WEZTERM_PID=$!
        (
            sleep 4
            if ps -p $WEZTERM_PID > /dev/null; then
                kill $WEZTERM_PID 2>/dev/null
            fi
        ) &
    fi
else
    notify-send "Unknown session type" "Couldn't determine if Wayland or X11"
fi

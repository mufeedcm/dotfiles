#!/usr/bin/env bash

STATE=$(dunstctl is-paused)

if [ "$STATE" = "true" ]; then
    # Muted bell, grey
    # echo "%{F#928374}%{F-}"
    # echo "%{F#928374}%{F-}"
    echo "%{F#928374}%{F-}"
else
    # Normal bell, blue
    echo "%{F#83a598}%{F-}"
    # echo "%{F#ffff00}%{F-}"
fi

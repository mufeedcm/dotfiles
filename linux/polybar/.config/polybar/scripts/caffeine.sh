#!/usr/bin/env bash


CAFFEINE_STATE_FILE="/tmp/caffeine_mode"

if [ -f "$CAFFEINE_STATE_FILE" ] && grep -q "on" "$CAFFEINE_STATE_FILE"; then
    # Bright yellow coffee when ON
    echo "%{F#fabd2f}%{F-}"
else
    # Grey bed icon when OFF
    echo "%{F#928374}%{F-}"
fi

#!/bin/bash

# choice=$(echo -e "Yes\nNo" | dmenu -i -p "$1?")
choice=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "$1?")

if [ "$choice" = "Yes" ]; then
    eval "$2"
fi

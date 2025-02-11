#!/bin/sh

# Check if ncmpcpp is running
if pgrep -f "st -c ncmpcpp" > /dev/null; then
    # If running, kill it
    pkill -f "st -c ncmpcpp"
else
    # If not running, launch it
    st -c ncmpcpp -g 60x25+1425+25 -e ncmpcpp &
fi

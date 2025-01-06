#!/bin/bash

# Set the wallpaper
feh --bg-scale ~/.config/backgrounds/mistbg.jpg &

# picom &
# pkill -f status-bar.sh
~/.config/suckless/dwm/scripts/status-bar.sh &
xautolock -time 10 -locker "slock & systemctl suspend" &
nm-applet &
dunst &
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
pgrep -x buckle > /dev/null || buckle -g 40 &

# Start terminal with tmux on tag 1
# st -n win1tmux -e tmux &
st -n win1tmux -e zsh -ic tmux &

# Start Firefox on tag 2
# brave-browser &

# Start Beeper on tag 9
/home/mufeedcm/Applications/beeper-nightly.AppImage &

# Run dwm and monitor its exit
exec dwm &
DWM_PID=$!

# Wait for dwm to exit
wait $DWM_PID

# Cleanup: Kill `start.sh` and any processes it started
pkill -f status-bar.sh
# pkill picom
pkill nm-applet
pkill dunst
pkill xautolock
pkill buckle
exit

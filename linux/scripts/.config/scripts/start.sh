#!/bin/bash

# Create a file to store PIDs
PID_FILE="$HOME/.config/start_pids.txt"
> "$PID_FILE"  # Clear previous file contents

# Start applications and save their PIDs
feh --bg-scale ~/.config/backgrounds/mistbg.jpg &
echo $! >> "$PID_FILE"

amixer set Headphone 30% unmute

xsetroot -solid "#000000"  # Set a black background for fake transparency
picom -b &  # Start picom in the background
echo $! >> "$PID_FILE"

~/.config/scripts/status-bar.sh &
echo $! >> "$PID_FILE"

xautolock -time 5 -locker "slock & systemctl suspend" &
echo $! >> "$PID_FILE"

nohup /home/mufeedcm/Applications/beeper.AppImage >/dev/null 2>&1 &

nm-applet &
echo $! >> "$PID_FILE"

dunst &
echo $! >> "$PID_FILE"

# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape'
# pgrep -x buckle > /dev/null || buckle -g 40 &
# echo $! >> "$PID_FILE"

st -n win1tmux -e zsh -ic tmux &
echo $! >> "$PID_FILE"

# Start dwm (do not run it in the background)
exec dwm

# Cleanup: Kill processes listed in PID file after dwm exits
while read pid; do
    kill "$pid" 2>/dev/null
done < "$PID_FILE"

# Remove the PID file after cleanup
rm -f "$PID_FILE"

exit 0
# #!/bin/bash
#
#
# # Create a file to store PIDs
# PID_FILE="$HOME/.config/start_pids.txt"
# > "$PID_FILE"  # Clear previous file contents
#
# # Start applications and save their PIDs
# feh --bg-scale ~/.config/backgrounds/mistbg.jpg &
# echo $! >> "$PID_FILE"
#
#
# amixer set Headphone 30% unmute
#
# xsetroot -solid "#000000"  # Set a black background for fake transparency
# picom -b &  # Start picom in the background
# echo $! >> "$PID_FILE"
#
# ~/.config/scripts/status-bar.sh &
# echo $! >> "$PID_FILE"
#
# xautolock -time 5 -locker "slock & systemctl suspend" &
# echo $! >> "$PID_FILE"
#
#
# /home/mufeedcm/Applications/beeper-nightly.AppImage &
#
#
#
# nm-applet &
# echo $! >> "$PID_FILE"
#
# dunst &
# echo $! >> "$PID_FILE"
#
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape'
# pgrep -x buckle > /dev/null || buckle -g 40 &
# echo $! >> "$PID_FILE"
#
# st -n win1tmux -e zsh -ic tmux &
# echo $! >> "$PID_FILE"
#
# # Start dwm
# exec dwm &
# DWM_PID=$!
#
# # Wait for dwm to exit
# wait $DWM_PID
#
# # Cleanup: Kill processes listed in PID file
# while read pid; do
#     kill "$pid"
# done < "$PID_FILE"
#
# # Remove the PID file after cleanup
# rm "$PID_FILE"
#
# exit
#

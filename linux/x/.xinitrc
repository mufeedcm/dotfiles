#!/bin/bash

# Set up the X environment
export XDG_SESSION_TYPE=x11

# Apply user-specific configurations
[ -f ~/.xprofile ] && source ~/.xprofile

# Function to clean up background processes
cleanup() {
    pkill -P $$  # Kill all child processes when exiting
}

trap cleanup EXIT

# Select the window manager
WM=$(echo -e "dwm\ni3wm\ncinnamon" | dmenu -i -p "Select Window Manager:" \
    -nb "#1a1b26" -nf "#c0caf5" \
    -sb "#7aa2f7" -sf "#1a1b26" \
    -fn "monospace-10")

case "$WM" in
    dwm)
        # Start background processes
        feh --bg-scale ~/.config/backgrounds/mistbg.jpg &
        amixer set Headphone 30% unmute &
        picom &
        ~/.config/suckless/dwm/scripts/status-bar.sh &
        xautolock -time 5 -locker "slock & systemctl suspend" &
        /home/mufeedcm/Applications/beeper-nightly.AppImage &
        nm-applet &
        dunst &
        setxkbmap -option ctrl:nocaps
        xcape -e 'Control_L=Escape'
        buckle -g 40 &
        st -n win1tmux -e zsh -ic tmux &

        # Start dwm
        exec dwm
        ;;
    i3wm)
        exec i3
        ;;
    cinnamon)
        # Start Cinnamon desktop environment
        exec cinnamon-session-cinnamon
        ;;
    *)
        echo "Invalid selection or canceled. Exiting."
        exit 1
        ;;
esac

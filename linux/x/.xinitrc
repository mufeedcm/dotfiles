#!/bin/bash
export XDG_SESSION_TYPE=x11
[ -f ~/.xprofile ] && source ~/.xprofile
[ -f ~/.Xresources ] && xrdb ~/.Xresources
cleanup() {
    pkill -P $$  
    tmux kill-server  
}
trap cleanup EXIT



feh --bg-scale ~/.config/backgrounds/cold_mist_nature.jpg &
~/.config/suckless/dwm/scripts/status-bar.sh &
# xautolock -time 15 -locker "slock & systemctl suspend" &
xautolock -time 15 -locker "slock && systemctl suspend" -detectsleep
beeper-nightly &  
nm-applet &
dunst &
numlockx &
# buckle -g 40 &
flameshot &
picom &
amixer set Headphone 30% unmute &
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape'
st -n win1tmux -e zsh -ic tmux &  




exec dwm


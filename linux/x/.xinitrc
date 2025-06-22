#!/bin/bash
export XDG_SESSION_TYPE=x11
[ -f ~/.xprofile ] && source ~/.xprofile
# [ -f ~/.Xresources ] && xrdb ~/.Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
cleanup() {
    pkill -P $$  
    tmux kill-server  
}
trap cleanup EXIT



feh --bg-scale ~/.config/backgrounds/cold_mist_nature.jpg &
# feh --bg-scale ~/.config/backgrounds/tree-cold-mountain-art.jpg &
~/.config/suckless/dwm/scripts/status-bar.sh &
# slstatus &
# dwmblocks &
xautolock -time 15 -locker "slock & systemctl suspend" &
nm-applet &
dunst &
numlockx &
flameshot &
# picom &
amixer set Headphone 30% unmute &
# st -n win1tmux -e zsh -ic tmux &  
st -c StWinTmux -e zsh -ic tmux &
# firefox &  
zen-browser &
# beeper &  
# emacs &
emacs --daemon &
# amixer -c 1 -q set Headphone 60% unmute
buckle -g 40 &
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape'


exec dwm  


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
xautolock -time 15 -locker "slock & systemctl suspend" &
nm-applet &
dunst &
numlockx &
flameshot &
picom &
amixer set Headphone 30% unmute &
st -n win1tmux -e zsh -ic tmux &  
firefox &  
beeper-nightly &  
# emacs &
emacs --daemon &
# buckle -g 40 &
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape'


exec dwm  


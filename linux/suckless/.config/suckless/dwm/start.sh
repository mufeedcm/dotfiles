#!/bin/bash

# pkill -f start.sh
# Set the wallpaper
feh --bg-scale ~/.config/backgrounds/mistbg.jpg &

# Any other startup applications
picom &

#!/bin/bash

pgrep -x buckle > /dev/null || buckle -g 40 &

# if ! pgrep -f "status-bar.sh" > /dev/null; then
#     /home/mufeedcm/.config/suckless/dwm/scripts/status-bar.sh &
# fi

pkill -f status-bar.sh
~/.config/suckless/dwm/scripts/status-bar.sh &

xautolock -time 10 -locker "slock & systemctl suspend" &
nm-applet &

dunst &

setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

# Run dwm
exec dwm

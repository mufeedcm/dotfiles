#!/bin/bash

choice=$(echo -e "lock\nsleep\nlogout\nreboot\nshutdown" | rofi -dmenu -p "System")

case "$choice" in
    lock)
        i3lock --nofork -tiling --image='/home/mufeedcm/.config/backgrounds/mistbg_blurred.png' ;;
    sleep)
        i3lock --nofork -tiling --image='/home/mufeedcm/.config/backgrounds/mistbg_blurred.png' & systemctl suspend ;;
    logout)
        i3-msg exit ;;
    reboot)
        systemctl reboot ;;
    shutdown)
        systemctl poweroff ;;
esac

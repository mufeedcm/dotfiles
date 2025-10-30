#!/bin/bash

options="Sleep\nLogout\nShutdown\nReboot"

# Display the menu using rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu:" -lines 4)

# Handle the chosen option
case "$chosen" in
    Sleep)
        slock & systemctl suspend ;;  # Lock and suspend
    Logout)
        pkill dwm ;;  # Ends the dwm session
    Shutdown)
        systemctl poweroff ;;  # Shutdown the system
    Reboot)
        systemctl reboot ;;  # Reboot the system
    *)
        exit 0 ;;  # Exit if nothing valid is chosen
esac

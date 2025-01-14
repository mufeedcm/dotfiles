#!/bin/bash

options="Sleep\nLogout\nShutdown\nReboot"

# Display the menu using dmenu
chosen=$(echo -e "$options" | dmenu -i -p "Power Menu:" \
    -nb "#1a1b26" -nf "#c0caf5" \
    -sb "#7aa2f7" -sf "#1a1b26")

# Handle the chosen option
case "$chosen" in
    Sleep)
        slock & systemctl suspend ;;  # Lock and suspend
    Logout)
        pkill dwm ;;  # Ends the dwm session, triggering .xinitrc cleanup
    Shutdown)
        systemctl poweroff ;;  # Shutdown the system
    Reboot)
        systemctl reboot ;;  # Reboot the system
    *)
        exit 0 ;;  # Exit if no valid option is chosen
esac

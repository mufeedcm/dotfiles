#!/bin/bash
options="Sleep\nLogout\nShutdown\nReboot"
# chosen=$(echo -e "$options" | dmenu -i -p "Power Menu:")
chosen=$(echo -e "$options" | dmenu -i -p "Power Menu:" \
    -nb "#1a1b26" -nf "#c0caf5" \
    -sb "#7aa2f7" -sf "#1a1b26")
case "$chosen" in
    Sleep)
        slock & systemctl suspend ;; 
    Logout)
        PID_FILE="$HOME/.config/suckless/dwm/start_pids.txt"
        if [ -f "$PID_FILE" ]; then
            while read pid; do
                kill "$pid"
            done < "$PID_FILE"
        fi
        pkill dwm ;; 
    # Logout)
    #     pkill dwm ;; # Ends the dwm session
    Shutdown)
        systemctl poweroff ;; 
    Reboot)
        systemctl reboot ;; 
    *)
        exit 0 ;; 
esac

#!/bin/bash

INHIBIT_NAME="caffeine-wayland"
PIDFILE="/tmp/$INHIBIT_NAME.pid"

# if [ "$XDG_SESSION_TYPE" = "x11" ]; then
#     notify-send "Caffeine" "X11 session detected"
#
# elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        kill "$(cat "$PIDFILE")"
        rm -f "$PIDFILE"
        notify-send "☕ Caffeine OFF" "System Will Sleep"
    else
        systemd-inhibit --what=idle:sleep:handle-lid-switch --who="Caffeine" --why="User request" --mode=block bash -c "echo \$\$ > $PIDFILE; sleep infinity" &
        notify-send "☕ Caffeine ON" "System Won't Sleep"
    fi

# else
#     notify-send "Caffeine" "Unknown session type"
# fi

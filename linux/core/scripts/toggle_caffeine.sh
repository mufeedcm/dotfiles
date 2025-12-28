#!/bin/bash

PIDFILE="/tmp/caffeine-mode.pid"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  kill "$(cat "$PIDFILE")"
  rm -f "$PIDFILE"
  notify-send "☕ Caffeine OFF" "System Will Sleep"
else
  systemd-inhibit --what=idle:sleep:handle-lid-switch --who="Caffeine" --why="User request" --mode=block bash -c "echo \$\$ > $PIDFILE; sleep infinity" &
  notify-send "☕ Caffeine ON" "System Won't Sleep"
fi

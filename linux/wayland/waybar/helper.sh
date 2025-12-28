#!/bin/bash

PID_CAFFEINE="/tmp/caffeine-mode.pid"

case "$1" in
  caffeine)
    if [ -f "$PID_CAFFEINE" ] && kill -0 "$(cat "$PID_CAFFEINE")" 2>/dev/null; then
      echo " "
    else
      echo "󰾫 "
    fi
    ;;
esac

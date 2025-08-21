#!/usr/bin/env bash

# Check Wi-Fi connection status
if [ "$(nmcli general status | awk '/STATE/ {getline; print $1}')" = "disconnected" ]; then
    echo " No Wi-Fi "
else
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    echo "  $ssid"
fi

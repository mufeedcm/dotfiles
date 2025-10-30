#!/bin/bash

if [ "$BUTTON" = "1" ]; then
  st -e nmtui &  
  exit
fi

ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

if [ -z "$ssid" ]; then
  echo "睊 No WiFi"
else
  echo " $ssid"
fi



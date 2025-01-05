#!/bin/bash

# Check if caffeine is already active (xautolock is running)
if pgrep -x "xautolock" > /dev/null
then
    # If xautolock is running, kill it (disable caffeine mode)
    pkill xautolock
    # Send notification that caffeine mode is off
    notify-send "Caffeine Mode" "Caffeine mode is OFF. The system will sleep as usual." -u low
else
    # Otherwise, start xautolock again to resume the lock timer
    xautolock -time 10 -locker "slock & systemctl suspend;" &
    # Send notification that caffeine mode is on
    notify-send "Caffeine Mode" "Caffeine mode is ON. The system will not sleep." -u low
fi

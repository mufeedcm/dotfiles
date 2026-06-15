#!/usr/bin/env bash

BAT="/org/freedesktop/UPower/devices/battery_macsmc_battery"

warned_20=0
warned_10=0
warned_5=0

while true; do
    capacity=$(
        upower -i "$BAT" |
        awk '/percentage:/ {
            gsub("%","",$2)
            print int($2)
        }'
    )

    status=$(
        upower -i "$BAT" |
        awk '/state:/ {print $2}'
    )

    if [[ "$status" == "discharging" ]]; then

        if (( capacity <= 20 )) && (( warned_20 == 0 )); then
            notify-send \
                "Battery Low" \
                "$capacity% remaining"

            warned_20=1
        fi

        if (( capacity <= 10 )) && (( warned_10 == 0 )); then
            notify-send \
                -u critical \
                "Battery Critical" \
                "$capacity% remaining"

            warned_10=1
        fi

        if (( capacity <= 5 )) && (( warned_5 == 0 )); then
            notify-send \
                -u critical \
                -t 0 \
                "Battery Critical" \
                "Plug in charger NOW ($capacity%)"

            warned_5=1
        fi
    fi

    # Reset after plugging in charger
    if [[ "$status" == "charging" ]]; then
        warned_20=0
        warned_10=0
        warned_5=0
    fi

    sleep 60
done

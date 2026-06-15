#!/bin/bash

device_connected() {
    bluetoothctl info "$1" 2>/dev/null | grep -q "Connected: yes"
}

bluetooth_powered() {
    bluetoothctl show 2>/dev/null | grep -q "Powered: yes"
}

# Bluetooth OFF
if ! bluetooth_powered; then
    choice=$(
        printf "Bluetooth On\n" |
        rofi -dmenu -i -p "Bluetooth"
    )

    [[ "$choice" == "Bluetooth On" ]] &&
        bluetoothctl power on >/dev/null

    exit 0
fi

notify-send "Bluetooth" "Scanning..."

bluetoothctl scan on >/dev/null 2>&1
sleep 8

devices=$(bluetoothctl devices)

bluetoothctl scan off >/dev/null 2>&1

menu=$(
    echo "$devices" |
    while read -r _ mac name; do
        [[ -z "$mac" ]] && continue

        if device_connected "$mac"; then
            printf "● %s|%s\n" "$name" "$mac"
        else
            printf "  %s|%s\n" "$name" "$mac"
        fi
    done

    printf "Bluetooth Off|\n"
)

choice=$(
    printf "%s\n" "$menu" |
    cut -d'|' -f1 |
    rofi -dmenu -i -p "Connect to Bluetooth"
)

[[ -z "$choice" ]] && exit 0

if [[ "$choice" == "Bluetooth Off" ]]; then
    bluetoothctl power off >/dev/null
    notify-send "Bluetooth" "Disabled"
    exit 0
fi

mac=$(
    printf "%s\n" "$menu" |
    grep -F "$choice|" |
    head -n1 |
    cut -d'|' -f2
)

[[ -z "$mac" ]] && exit 1

device_name=$(
    echo "$choice" |
    sed -E 's/^●[[:space:]]*//' |
    sed -E 's/^[[:space:]]*//'
)

if device_connected "$mac"; then
    bluetoothctl disconnect "$mac" >/dev/null

    notify-send "Bluetooth" \
        "Disconnected from $device_name"

    exit 0
fi

if bluetoothctl info "$mac" 2>/dev/null | grep -q "Paired: yes"; then
    if bluetoothctl connect "$mac" >/dev/null; then
        notify-send "Bluetooth" \
            "Connected to $device_name"
    else
        notify-send "Bluetooth" \
            "Failed to connect to $device_name"
    fi

    exit 0
fi

notify-send "Bluetooth" "Pairing $device_name..."

if bluetoothctl pair "$mac"; then
    bluetoothctl trust "$mac"
    bluetoothctl connect "$mac"

    notify-send "Bluetooth" \
        "Paired and connected to $device_name"
else
    notify-send "Bluetooth" \
        "Failed to pair $device_name"
fi

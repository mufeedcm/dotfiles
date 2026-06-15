#!/usr/bin/env bash

notify-send "Wi-Fi" "Scanning for networks..."

nmcli dev wifi rescan >/dev/null 2>&1
sleep 2

band_from_freq() {
    local freq="${1%% *}"

    if (( freq >= 2400 && freq <= 2500 )); then
        echo "2.4 GHz"
    elif (( freq >= 4900 && freq <= 5900 )); then
        echo "5 GHz"
    else
        echo "Unknown"
    fi
}

menu=$(
    nmcli -t -f ACTIVE,SSID,FREQ dev wifi |
    while IFS=: read -r active ssid freq; do
        [[ -z "$ssid" ]] && continue

        band=$(band_from_freq "$freq")

        if [[ "$active" == "yes" ]]; then
            printf "● %-28s %s\n" "$ssid" "$band"
        else
            printf "  %-28s %s\n" "$ssid" "$band"
        fi
    done

    printf "󰖪 Disconnect Wi-Fi\n"
)

choice=$(
    printf '%s\n' "$menu" |
    rofi -dmenu -i -p "Connect to Wi-Fi"
)

[[ -z "$choice" ]] && exit 0

if [[ "$choice" == "󰖪 Disconnect Wi-Fi" ]]; then
    iface=$(
        nmcli -t -f DEVICE,TYPE device |
        awk -F: '$2=="wifi"{print $1; exit}'
    )

    if nmcli device disconnect "$iface"; then
        notify-send "Wi-Fi" \
            "Disconnected from current network"
    else
        notify-send "Wi-Fi" \
            "Failed to disconnect"
    fi

    exit 0
fi

ssid=$(
    echo "$choice" |
    sed -E 's/^●[[:space:]]*//' |
    sed -E 's/^[[:space:]]*//' |
    sed -E 's/[[:space:]]+(2\.4 GHz|5 GHz|Unknown).*$//'
)

# Saved network
if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then
    notify-send "Wi-Fi" \
        "Connecting to $ssid..."

    if nmcli connection up "$ssid"; then
        notify-send "Wi-Fi" \
            "Connected to $ssid"
    else
        notify-send "Wi-Fi" \
            "Failed to connect to $ssid"
    fi

    exit 0
fi

password=$(
    rofi -dmenu \
         -password \
         -p "Password for $ssid"
)

[[ -z "$password" ]] && exit 0

notify-send "Wi-Fi" \
    "Connecting to $ssid..."

if nmcli dev wifi connect "$ssid" password "$password"; then
    nmcli connection modify "$ssid" connection.autoconnect yes

    notify-send "Wi-Fi" \
        "Connected to $ssid"
else
    notify-send "Wi-Fi" \
        "Failed to connect to $ssid"
fi

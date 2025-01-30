#!/bin/bash

# Wi-Fi Networks
wifi_options="Wi-Fi Connect\nWi-Fi Disconnect"

# Caffeine Mode Toggle
caffeine_options="Caffeine Mode Toggle"

# App List (drun from rofi)
apps=$(rofi -show drun -modi drun -dmenu -p "Run App:")

# Combine all options
options="$wifi_options\n$caffeine_options\nGoogle Search (g <query> or g <url>)\nYouTube Search (yt <query>)\n$apps"

# Debugging: print options to verify
echo -e "$options"

# Show the options in rofi
chosen_option=$(echo -e "$options" | rofi -dmenu -p "Choose an action:")

# Handle chosen option
case "$chosen_option" in
    "Wi-Fi Connect")
        # Wi-Fi Connection Flow
        networks=$(nmcli -t -f SSID dev wifi | awk '!seen[$0]++')
        chosen_network=$(echo -e "$networks" | rofi -dmenu -p "Select a network to connect:")
        if [ -n "$chosen_network" ]; then
            password=$(rofi -dmenu -p "Enter password for $chosen_network:")
            nmcli dev wifi connect "$chosen_network" password "$password"
            notify-send "Wi-Fi" "Connected to $chosen_network"
        else
            notify-send "Wi-Fi" "No network selected"
        fi
        ;;
    "Wi-Fi Disconnect")
        active_ssid=$(nmcli -t -f SSID dev wifi | grep -v '^--')
        if [ -n "$active_ssid" ]; then
            nmcli con down id "$active_ssid"
            notify-send "Wi-Fi" "Disconnected from $active_ssid"
        else
            notify-send "Wi-Fi" "No active connection"
        fi
        ;;
    "Caffeine Mode Toggle")
        # Toggle Caffeine Mode
        CAFFEINE_STATE_FILE="/tmp/caffeine_mode"

        if [ -f "$CAFFEINE_STATE_FILE" ] && grep -q "on" "$CAFFEINE_STATE_FILE"; then
            pkill xautolock
            echo "off" > "$CAFFEINE_STATE_FILE"
            notify-send "Caffeine Mode" "Disabled"
        else
            xautolock -time 15 -locker "slock & systemctl suspend;" & disown
            echo "on" > "$CAFFEINE_STATE_FILE"
            notify-send "Caffeine Mode" "Enabled"
        fi
        ;;
    "Google Search (g <query> or g <url>)")
        query=$(rofi -dmenu -p "Enter search query or URL:")
        if [[ "$query" == g\ * ]]; then
            # Google search query
            search_query="${query#g }"
            xdg-open "https://www.google.com/search?q=${search_query// /+}"
        elif [[ "$query" =~ ^https?:// ]]; then
            # Open URL directly
            xdg-open "$query"
        else
            notify-send "Google Search" "Invalid query or URL"
        fi
        ;;
    "YouTube Search (yt <query>)")
        query=$(rofi -dmenu -p "Enter YouTube search query:")
        if [[ "$query" == yt\ * ]]; then
            # YouTube search query
            search_query="${query#yt }"
            xdg-open "https://www.youtube.com/results?search_query=${search_query// /+}"
        else
            notify-send "YouTube Search" "Invalid query format. Use 'yt <search term>'"
        fi
        ;;
    *)
        # If it's not a custom option, launch the app selected from rofi
        if [ -n "$chosen_option" ]; then
            setsid "$chosen_option" &
        fi
        ;;
esac

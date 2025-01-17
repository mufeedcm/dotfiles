#!/bin/bash

# Set colors for Tokyonight theme
DMENU_NB="#1a1b26"
DMENU_NF="#c0caf5"
DMENU_SB="#7aa2f7"
DMENU_SF="#1a1b26"

# Get available Wi-Fi networks
networks=$(nmcli -t -f SSID dev wifi | awk '!seen[$0]++')

# Menu options
options="Connect to Wi-Fi\nDisconnect from Wi-Fi\nExit"
chosen_option=$(echo -e "$options" | dmenu -i -p "Choose an option:" \
    -nb "$DMENU_NB" -nf "$DMENU_NF" -sb "$DMENU_SB" -sf "$DMENU_SF")

# Exit if no option is selected
[ -z "$chosen_option" ] && exit 0

case "$chosen_option" in
    "Connect to Wi-Fi")
        available_networks=$(nmcli -t -f SSID dev wifi | grep -v '^--' | uniq)
        chosen_network=$(echo -e "$available_networks" | dmenu -i -p "Available Networks:" \
            -nb "$DMENU_NB" -nf "$DMENU_NF" -sb "$DMENU_SB" -sf "$DMENU_SF")

        if [ -n "$chosen_network" ]; then
            # Disable auto-connect for all saved networks
            saved_connections=$(nmcli -t -f NAME con show | grep -E "Auto|$chosen_network")
            for connection in $saved_connections; do
                nmcli connection modify "$connection" connection.autoconnect no
            done

            # Check if the chosen network is saved
            saved_connection_name=$(nmcli -t -f NAME con show | grep -E "Auto $chosen_network|$chosen_network")

            if [ -n "$saved_connection_name" ]; then
                # Connect to saved network
                nmcli con up id "$saved_connection_name"
                if [ $? -eq 0 ]; then
                    nmcli connection modify "$saved_connection_name" connection.autoconnect yes
                    notify-send "Wi-Fi" "Connected to $chosen_network"
                else
                    notify-send "Wi-Fi" "Failed to connect"
                fi
            else
                # Prompt for password for new network
                password=$(dmenu -p "Enter password for $chosen_network:" \
                    -nb "$DMENU_NB" -nf "$DMENU_NF" -sb "$DMENU_SB" -sf "$DMENU_SF")
                if [ -n "$password" ]; then
                    nmcli dev wifi connect "$chosen_network" password "$password"
                    if [ $? -eq 0 ]; then
                        nmcli connection modify "$chosen_network" connection.autoconnect yes
                        notify-send "Wi-Fi" "Connected to $chosen_network"
                    else
                        notify-send "Wi-Fi" "Failed to connect"
                    fi
                else
                    notify-send "Wi-Fi" "No password entered"
                fi
            fi
        else
            # notify-send "Wi-Fi" "No network selected"
        fi
        ;;
    "Disconnect from Wi-Fi")
        # Get active Wi-Fi SSID
        active_ssid=$(nmcli -t -f SSID dev wifi | grep -v '^--')

        if [ -n "$active_ssid" ]; then
            # Get connection name
            connection_name=$(nmcli -t -f NAME con show --active | grep -E "Auto $active_ssid|$active_ssid")

            if [ -n "$connection_name" ]; then
                # Disable auto-connect and disconnect
                nmcli connection modify "$connection_name" connection.autoconnect no
                nmcli con down id "$connection_name"
                if [ $? -eq 0 ]; then
                    notify-send "Wi-Fi" "Disconnected from $active_ssid"
                else
                    notify-send "Wi-Fi" "Failed to disconnect"
                fi
            else
                notify-send "Wi-Fi" "Connection not found"
            fi
        else
            notify-send "Wi-Fi" "No active connection"
        fi
        ;;
    *)
        exit 0
        ;;
esac

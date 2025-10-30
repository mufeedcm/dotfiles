#!/bin/bash

# Scan Wi-Fi networks
nmcli dev wifi rescan &>/dev/null
sleep 1  # Give it a moment to populate list

# List available SSIDs (unique, non-empty)
networks=$(nmcli -t -f SSID dev wifi | awk 'NF' | awk '!seen[$0]++')

# Show dmenu prompt
# chosen_ssid=$(echo -e "$networks" | dmenu -i -p "Connect Wi-Fi:")
chosen_ssid=$(echo -e "$networks" | rofi -dmenu -i -p "Connect Wi-Fi:" )

# Exit if nothing selected
[ -z "$chosen_ssid" ] && exit 0

# Check if the SSID is already saved
saved=$(nmcli -t -f NAME connection show | grep -Fx "$chosen_ssid")

if [ -n "$saved" ]; then
    # Try to connect to the saved network
    if nmcli con up id "$chosen_ssid"; then
        nmcli connection modify "$chosen_ssid" connection.autoconnect yes
        notify-send "Wi-Fi" "Connected to $chosen_ssid"
    else
        notify-send "Wi-Fi" "Failed to connect to saved network"
    fi
else
    # Prompt for password and try to connect
    # password=$(dmenu -P -p "Password for $chosen_ssid")
password=$(rofi -dmenu -password -p "Password for $chosen_ssid")
    [ -z "$password" ] && notify-send "Wi-Fi" "No password entered" && exit 1

    if nmcli dev wifi connect "$chosen_ssid" password "$password"; then
        nmcli connection modify "$chosen_ssid" connection.autoconnect yes
        notify-send "Wi-Fi" "Connected to $chosen_ssid"
    else
        notify-send "Wi-Fi" "Failed to connect"
    fi
fi


# #!/bin/bash
#
# # Get available Wi-Fi networks
# networks=$(nmcli -t -f SSID dev wifi | awk '!seen[$0]++')
#
# # Menu options
# options="Connect to Wi-Fi\nDisconnect from Wi-Fi\nExit"
# # chosen_option=$(echo -e "$options" | dmenu -i -p "Choose an option:")
# chosen_option=$(echo -e "$options" | dmenu -i )
#
# # Exit if no option is selected
# [ -z "$chosen_option" ] && exit 0
#
# case "$chosen_option" in
#     "Connect to Wi-Fi")
#         available_networks=$(nmcli -t -f SSID dev wifi | grep -v '^--' | uniq)
#         chosen_network=$(echo -e "$available_networks" | dmenu -i -p "Available Networks:")
#
#         if [ -n "$chosen_network" ]; then
#             # Disable auto-connect for all saved networks
#             saved_connections=$(nmcli -t -f NAME con show | grep -E "Auto|$chosen_network")
#             for connection in $saved_connections; do
#                 nmcli connection modify "$connection" connection.autoconnect no
#             done
#
#             # Check if the chosen network is saved
#             saved_connection_name=$(nmcli -t -f NAME con show | grep -E "Auto $chosen_network|$chosen_network")
#
#             if [ -n "$saved_connection_name" ]; then
#                 # Connect to saved network
#                 nmcli con up id "$saved_connection_name"
#                 if [ $? -eq 0 ]; then
#                     nmcli connection modify "$saved_connection_name" connection.autoconnect yes
#                     notify-send "Wi-Fi" "Connected to $chosen_network"
#                 else
#                     notify-send "Wi-Fi" "Failed to connect"
#                 fi
#             else
#                 # Prompt for password for new network
#                 password=$(dmenu -p "Enter password for $chosen_network:")
#                 if [ -n "$password" ]; then
#                     nmcli dev wifi connect "$chosen_network" password "$password"
#                     if [ $? -eq 0 ]; then
#                         nmcli connection modify "$chosen_network" connection.autoconnect yes
#                         notify-send "Wi-Fi" "Connected to $chosen_network"
#                     else
#                         notify-send "Wi-Fi" "Failed to connect"
#                     fi
#                 else
#                     notify-send "Wi-Fi" "No password entered"
#                 fi
#             fi
#         else
#             notify-send "Wi-Fi" "No network selected"
#         fi
#         ;;
#     "Disconnect from Wi-Fi")
#         # Get active Wi-Fi SSID
#         active_ssid=$(nmcli -t -f SSID dev wifi | grep -v '^--')
#
#         if [ -n "$active_ssid" ]; then
#             # Get connection name
#             connection_name=$(nmcli -t -f NAME con show --active | grep -E "Auto $active_ssid|$active_ssid")
#
#             if [ -n "$connection_name" ]; then
#                 # Disable auto-connect and disconnect
#                 nmcli connection modify "$connection_name" connection.autoconnect no
#                 nmcli con down id "$connection_name"
#                 if [ $? -eq 0 ]; then
#                     notify-send "Wi-Fi" "Disconnected from $active_ssid"
#                 else
#                     notify-send "Wi-Fi" "Failed to disconnect"
#                 fi
#             else
#                 notify-send "Wi-Fi" "Connection not found"
#             fi
#         else
#             notify-send "Wi-Fi" "No active connection"
#         fi
#         ;;
#     *)
#         exit 0
#         ;;
# esac

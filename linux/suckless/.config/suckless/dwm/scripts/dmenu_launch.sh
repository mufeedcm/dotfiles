#!/bin/bash

# File to store the state of caffeine mode
CAFFEINE_STATE_FILE="/tmp/caffeine_mode"

# Function to check if a string is a URL
is_url() {
    [[ "$1" =~ ^(https?|ftp):// ]]
}

# Function to handle web searches (Google, YouTube)
search_web() {
    local engine="$1"
    local query="$2"

    if is_url "$query"; then
        xdg-open "$query"  # Open URL directly
    else
        case "$engine" in
            "g") xdg-open "https://www.google.com/search?q=${query// /+}" ;;
            "yt") xdg-open "https://www.youtube.com/results?search_query=${query// /+}" ;;
        esac
    fi
}

# Function to toggle Caffeine Mode
toggle_caffeine() {
    if [ -f "$CAFFEINE_STATE_FILE" ] && grep -q "on" "$CAFFEINE_STATE_FILE"; then
        pkill xautolock
        notify-send -u low "Caffeine Mode" "Disabled"
        echo "off" > "$CAFFEINE_STATE_FILE"
    else
        xautolock -time 15 -locker "slock & systemctl suspend;" & disown
        notify-send -u low "Caffeine Mode" "Enabled"
        echo "on" > "$CAFFEINE_STATE_FILE"
    fi
}

# List of commands
declare -A commands=(
    ["sleep"]="slock & systemctl suspend"
    ["logout"]="pkill dwm"
    ["restart"]="systemctl reboot"
    ["shutdown"]="systemctl poweroff"
    ["wifi"]="~/.config/suckless/dwm/scripts/wifi_menu.sh"
    ["caffeine mode"]="toggle_caffeine"
)

# Generate a combined list of commands and apps, then sort them alphabetically
menu_items=$((
    for cmd in "${!commands[@]}"; do echo "$cmd"; done
    echo
    dmenu_path
) | sort)

# Get user selection
# choice=$(echo -e "$menu_items" | dmenu -i -p "Choose an action:")
choice=$(echo -e "$menu_items" | dmenu -i )

# Handle special cases (searches)
if [[ "$choice" =~ ^(g|yt)\ (.+) ]]; then
    search_web "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    exit 0
fi

# Run selected command if it exists
if [[ -n "${commands[$choice]}" ]]; then
    eval "${commands[$choice]}"
else
    [ -n "$choice" ] && setsid "$choice" &  # Launch app if not a custom command
fi

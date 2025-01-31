#!/bin/bash

# Files to store state
CAFFEINE_STATE_FILE="/tmp/caffeine_mode"
SEARCH_HISTORY_FILE="$HOME/.search_history"
BROWSER='vieb'

# Function to check if a string is a URL
is_url() {
    [[ "$1" =~ ^(https?|ftp):// ]]
}

# Function to check if a query is a domain (e.g., mufeedcm.com)
is_domain() {
    [[ "$1" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}

# Function to handle web searches (Google, YouTube)
# Function to handle web searches (Google, YouTube)
search_web() {
    local engine="$1"
    local query="$2"

    # Save to history (avoid duplicates)
    grep -qxF "$engine $query" "$SEARCH_HISTORY_FILE" || echo "$engine $query" >> "$SEARCH_HISTORY_FILE"

    if is_url "$query"; then
        # If it's a full URL (http:// or https://), open it directly
        eval "$BROWSER \"$query\""
    elif is_domain "$query"; then
        # If it looks like a domain (without http://), open it directly
        eval "$BROWSER \"https://$query\""
    else
        # Otherwise, search it on Google/YouTube
        case "$engine" in
            "g") eval "$BROWSER \"https://www.google.com/search?q=${query// /+}\"" ;;
            "yt") eval "$BROWSER \"https://www.youtube.com/results?search_query=${query// /+}\"" ;;
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

# Function to get search suggestions from history
get_search_suggestions() {
    if [[ -f "$SEARCH_HISTORY_FILE" ]]; then
        cat "$SEARCH_HISTORY_FILE" | sort -u
    fi
}

# List of system commands
declare -A commands=(
    ["sleep"]="slock & systemctl suspend"
    ["logout"]="pkill dwm"
    ["restart"]="systemctl reboot"
    ["shutdown"]="systemctl poweroff"
    ["wifi"]="~/.config/suckless/dwm/scripts/wifi_menu.sh"
    ["caffeine mode"]="toggle_caffeine"
)

# Generate menu options: system commands + search history + installed apps
menu_items=$(
    {
        for cmd in "${!commands[@]}"; do echo "$cmd"; done
        get_search_suggestions
        dmenu_path  # Adds installed applications
    } | sort -u
)

# Get user input from dmenu
# input=$(echo -e "$menu_items" | dmenu -i -p "Search or command:")
input=$(echo -e "$menu_items" | dmenu -i)

# Handle searches
if [[ "$input" =~ ^(g|yt)\ (.+) ]]; then
    search_web "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
elif [[ -n "${commands[$input]}" ]]; then
    eval "${commands[$input]}"
elif [[ -n "$input" ]]; then
    setsid "$input" &  # Launch application if it's not a known command
fi

#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    # Menu entries
    echo -en "Books\0icon\x1ffolder\n"
    echo -en "Wi-Fi \0icon\x1fnetwork-wireless\n"
    echo -en "Power Menu\n"
    echo -en "Audio Switcher\n"
    echo -en "Caffeine Mode\n"
else
    # Run the selected script in background
    case "$1" in
        "Books") ~/.config/scripts/books_list.sh > /dev/null 2>&1 & ;;
        "Wi-Fi") ~/.config/scripts/wifi_menu.sh > /dev/null 2>&1 & ;;
        "Power Menu") ~/.config/scripts/power_menu.sh > /dev/null 2>&1 & ;;
        "Audio Switcher") ~/.config/scripts/audio-switcher.sh > /dev/null 2>&1 & ;;
        "Caffeine Mode") ~/.config/scripts/toggle_caffeine.sh > /dev/null 2>&1 & ;;
        *) exit 0 ;;
    esac
fi

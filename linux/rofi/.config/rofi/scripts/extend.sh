#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo -en "books\0icon\x1fx-office-document\n"
    echo -en "wifi\0icon\x1fnetwork-wireless\n"
    echo -en "power menu\0icon\x1fsystem-shutdown\n"
    echo -en "audio switcher\0icon\x1faudio-headphones\n"
    echo -en "caffeine mode\0icon\x1fpreferences-desktop-screensaver\n"
else
    # Run the selected script in background
    case "$1" in
        "books") ~/.config/scripts/books_list.sh > /dev/null 2>&1 & ;;
        "wifi") ~/.config/scripts/wifi_menu.sh > /dev/null 2>&1 & ;;
        "power menu") ~/.config/scripts/power_menu.sh > /dev/null 2>&1 & ;;
        "audio switcher") ~/.config/scripts/audio-switcher.sh > /dev/null 2>&1 & ;;
        "caffeine mode") ~/.config/scripts/toggle_caffeine.sh > /dev/null 2>&1 & ;;
        *) exit 0 ;;
    esac
fi

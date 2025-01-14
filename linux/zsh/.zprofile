if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    echo "login"
    read -r choice
    case "$choice" in
        "" | [yY]*)
            exec startx
            ;;
        [nN]*)
            # echo "Skipping window manager login. Use this terminal session."
            ;;
        *)
            # echo "Invalid input. Exiting."
            exit 1
            ;;
    esac
fi

# Created by `pipx` on 2024-12-31 03:55:36
export PATH="$PATH:/home/mufeedcm/.local/bin"

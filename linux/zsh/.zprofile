# if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#   echo "Loging into WM to continue press Enter, to Stop press n " 
#     read -r choice
#     case "$choice" in
#         "" | [yY]*)
#             exec startx
#             ;;
#         [nN]*)
#             ;;
#         *)
#             ;;
#     esac
# fi
alias x='startx'
# Created by `pipx` on 2024-12-31 03:55:36
export PATH="$PATH:/home/mufeedcm/.local/bin"

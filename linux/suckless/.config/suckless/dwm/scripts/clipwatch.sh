#!/bin/bash

# Run this in background to monitor clipboard changes
while clipnotify; do
  ~/.config/suckless/dwm/scripts/clipmenu.sh add
done

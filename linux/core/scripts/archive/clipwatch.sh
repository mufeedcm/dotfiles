#!/bin/bash

# Run this in background to monitor clipboard changes
while clipnotify; do
  ~/.config/scripts/clipmenu.sh add
done

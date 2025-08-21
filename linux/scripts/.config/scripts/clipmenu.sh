#!/bin/bash

HISTFILE="$HOME/.cache/clipmenu_history"
PLACEHOLDER="<NEWLINE>"

mkdir -p "$(dirname "$HISTFILE")"
touch "$HISTFILE"

# Add current clipboard text to history
add_clipboard() {
  CLIP=$(xclip -o -selection clipboard)
  [ -z "$CLIP" ] && exit 0

  MULTILINE=$(echo "$CLIP" | sed ':a;N;$!ba;s/\n/'"$PLACEHOLDER"'/g')

  # Avoid duplicate entries
  grep -Fxq "$MULTILINE" "$HISTFILE" || echo "$MULTILINE" >> "$HISTFILE"
  # notify-send "📋 Text copied to history"
}

# Select from history and restore
select_from_history() {
  # CHOICE=$(tac "$HISTFILE" | dmenu -b -l 10 -i -p "Clipboard history:")
# CHOICE=$(tac "$HISTFILE" | sed "s/$PLACEHOLDER/ /g" | cut -c1-80 | dmenu -b -l 10 -i -p "Clipboard history:")
CHOICE=$(tac "$HISTFILE" | sed "s/$PLACEHOLDER/ /g" | cut -c1-80 | rofi -dmenu -p "Clipboard history:" -lines 10 -bw 2 -scroll-method 0)
  [ -z "$CHOICE" ] && exit 0


  echo "$CHOICE" | sed "s/$PLACEHOLDER/\n/g" | xclip -i -selection clipboard
  # notify-send "📋 Text copied to clipboard"
}

case "$1" in
  add) add_clipboard ;;
  sel) select_from_history ;;
  *) echo "Usage: $0 {add|sel}" ;;
esac

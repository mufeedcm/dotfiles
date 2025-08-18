#!/bin/bash

BOOK_DIR="$HOME/books"

# Ensure the directory exists
[ -d "$BOOK_DIR" ] || { notify-send "openbook" "No such directory: $BOOK_DIR"; exit 1; }

# Get list of supported ebook files (filenames only)
mapfile -t BOOK_LIST < <(find "$BOOK_DIR" -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) -printf "%f\n")

# If no books found
[ ${#BOOK_LIST[@]} -eq 0 ] && { notify-send "openbook" "No books found in $BOOK_DIR"; exit 1; }

# Let user select a book via dmenu
SELECTED=$(printf '%s\n' "${BOOK_LIST[@]}" | dmenu -i -l 20 -p "Choose a book")

# If nothing selected, exit
[ -z "$SELECTED" ] && exit 0

# Construct full path
FULL_PATH="$BOOK_DIR/$SELECTED"

# Check if the file actually exists
if [ ! -f "$FULL_PATH" ]; then
    notify-send "openbook" "Selected file not found: $FULL_PATH"
    exit 1
fi

# Open with zathura (with notify)
zathura "$FULL_PATH" & disown
# notify-send "openbook" "Opening: $SELECTED"

#!/bin/bash

BOOK_DIR="$HOME/books"

# Ensure the directory exists
[ -d "$BOOK_DIR" ] || { notify-send "openbook" "No such directory: $BOOK_DIR"; exit 1; }

# Get list of supported ebook files
mapfile -t BOOK_LIST < <(find "$BOOK_DIR" -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) -printf "%f\n")

# Exit if no books found
[ ${#BOOK_LIST[@]} -eq 0 ] && { notify-send "openbook" "No books found in $BOOK_DIR"; exit 1; }

# Function to extract cover for PDFs/EPUBs (requires pdftoppm, unzip)
get_cover() {
    local file="$1"
    local cover="/tmp/rofi_book_cover.png"
    
    case "${file##*.}" in
        pdf)
            pdftoppm -f 1 -singlefile -png "$file" "${cover%.png}" >/dev/null 2>&1
            ;;
        epub)
            unzip -p "$file" "$(unzip -l "$file" | grep -i 'cover.*\.jpg\|cover.*\.png' | awk '{print $4}' | head -n1)" > "$cover" 2>/dev/null
            ;;
        djvu)
            ddjvu -format=png -page=1 "$file" "$cover" >/dev/null 2>&1
            ;;
        *)
            return 1
            ;;
    esac

    echo "$cover"
}

# Start ueberzug in a background shell
mkfifo /tmp/ueberzug_fifo
ueberzug layer --parser fifo < /tmp/ueberzug_fifo &
UEBERZUG_PID=$!

# Function to show cover in ueberzug
show_cover() {
    local file="$1"
    local cover_file
    cover_file=$(get_cover "$file")
    if [ -f "$cover_file" ]; then
        echo "add 1 cover cover $cover_file 0 0 200 300" > /tmp/ueberzug_fifo
    else
        echo "remove 1" > /tmp/ueberzug_fifo
    fi
}

# Let user select a book via rofi with live preview
SELECTED=$(printf '%s\n' "${BOOK_LIST[@]}" | rofi -dmenu -i -p "Choose a book" -lines 20 \
    -format 's' -on-select 'show_cover "$@"')

# Cleanup ueberzug
echo "quit" > /tmp/ueberzug_fifo
kill $UEBERZUG_PID 2>/dev/null
rm /tmp/ueberzug_fifo

# Exit if nothing selected
[ -z "$SELECTED" ] && exit 0

# Construct full path
FULL_PATH="$BOOK_DIR/$SELECTED"

# Check file exists
[ ! -f "$FULL_PATH" ] && { notify-send "openbook" "Selected file not found: $FULL_PATH"; exit 1; }

# Open with zathura
zathura "$FULL_PATH" & disown

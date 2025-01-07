# Config For windows
~ made by mufeedcm
~ initial config taken from kickstarter.nvim

## some screenshots

// screenshots

# Neovim Shortcuts and Cheatsheet

## Custom Keybindings

### Leader Key
- **Leader Key**: `Space`

### File and Text Navigation
- **`Space + o`**: Open `oil.nvim` for file management.
- **`Space + /`**: Search text within the current file.

### Search Functions
- **`Space + s`**: Displays additional shortcuts using `which-key`. (e.g., search within the current working directory, string search, etc.).

### Pane Navigation
- **`Ctrl + h`**: Move to the left pane.
- **`Ctrl + j`**: Move to the bottom pane.
- **`Ctrl + k`**: Move to the top pane.
- **`Ctrl + l`**: Move to the right pane.

---

## Basic Neovim Commands (Cheatsheet)

### Movement
- **`h`**: Move left.
- **`j`**: Move down.
- **`k`**: Move up.
- **`l`**: Move right.
- **`w`**: Jump to the start of the next word.
- **`b`**: Jump to the start of the previous word.
- **`e`**: Jump to the end of the current/next word.
- **`0`**: Jump to the start of the line.
- **`^`**: Jump to the first non-whitespace character of the line.
- **`$`**: Jump to the end of the line.

### Editing
- **`x`**: Delete the character under the cursor.
- **`dd`**: Delete the current line.
- **`dw`**: Delete from the cursor to the end of the current word.
- **`d$`**: Delete from the cursor to the end of the line.
- **`d^`**: Delete from the cursor to the start of the line.
- **`u`**: Undo the last change.
- **`Ctrl + r`**: Redo the last undone change.

### Copy, Cut, and Paste
- **`yy`**: Copy the current line.
- **`yw`**: Copy from the cursor to the end of the current word.
- **`y$`**: Copy from the cursor to the end of the line.
- **`p`**: Paste after the cursor.
- **`P`**: Paste before the cursor.

### File Saving and Exiting

- **`:w`**: Save the current file.
- **`:q`**: Quit Neovim.
- **`:wq`** or **`ZZ`**: Save and quit Neovim.
- **`:q!`**: Quit without saving changes.

### Search and Replace
- **`/`**: Search forward for a string.
- **`?`**: Search backward for a string.
- **`n`**: Jump to the next search result.
- **`N`**: Jump to the previous search result.
- **`:s/old/new`**: Replace the first occurrence of `old` with `new` in the current line.
- **`:s/old/new/g`**: Replace all occurrences of `old` with `new` in the current line.
- **`:%s/old/new/g`**: Replace all occurrences of `old` with `new` in the entire file.
- **`:%s/old/new/gc`**: Replace all occurrences of `old` with `new` in the entire file with confirmation.

### Visual Mode
- **`v`**: Start visual mode.
- **`V`**: Start visual line mode.
- **`Ctrl + v`**: Start visual block mode.
- **`y`**: Copy selected text in visual mode.
- **`d`**: Delete selected text in visual mode.

---

### Learn More
Run `:Tutor` in Neovim for an interactive tutorial on basic commands.

If you spot any mistakes or have suggestions, feel free to let me know!


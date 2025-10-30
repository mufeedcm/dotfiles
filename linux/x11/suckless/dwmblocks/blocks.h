// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", "~/.config/suckless/dwmblocks/scripts/volume.sh", 1, 1}, // Signal 1
    {"", "~/.config/suckless/dwmblocks/scripts/wifi.sh", 1, 2},   // Signal 3
    {"", "date +\"%A    %d/%m/%Y\"", 60, 0},
    {"", "date +\"%I:%M:%S %p\"", 1, 0},

};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;

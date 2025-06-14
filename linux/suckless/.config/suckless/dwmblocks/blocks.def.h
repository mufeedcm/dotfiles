// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    // {"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",
    // 30,		0},
    //
    // {"", "date '+%b %d (%a) %I:%M%p'", 5,		0},

    // Icon     Command                                  Update Interval Signal
    // {"",
    //  "pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes && echo 🔇 || pactl "
    //  "get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1",
    //  1, 0},
    // {"", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2", 5,
    // 0},

    {"", "~/.config/suckless/dwmblocks/scripts/volume.sh", 1, 1}, // Signal 1
    {"", "~/.config/suckless/dwmblocks/scripts/wifi.sh", 5, 3},   // Signal 3

    {"", "date +\"%A    %d/%m/%Y\"", 60, 0},
    {"", "date +\"%I:%M:%S %p\"", 1, 0},

};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;

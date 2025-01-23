/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 4; /* border pixel of windows */
static const unsigned int gappx = 6;    /* gaps between windows */
static const unsigned int snap = 32;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */

static const int splitstatus = 1;    /* 1 for split status items */
static const char *splitdelim = ";"; /* Character used for separating status */

static const char *fonts[] = {"Meslo LGM Nerd Font:size=10"};
/*static const char *fonts[] = {"monospace:size=10"};*/
static const char dmenufont[] = "Meslo LGM Nerd Font:size=10";
/*static const char dmenufont[] = "monospace:size=10";*/

static const char col_gray1[] = "#1a1b26"; // Background
static const char col_gray2[] = "#414868"; // Inactive border
static const char col_gray3[] = "#a9b1d6"; // Foreground (text)
static const char col_gray4[] = "#c0caf5"; // Selected text
static const char col_cyan[] = "#5a73ad";  // Accent (selected bar)

/*static const char col_gray1[] = "#222222";*/
/*static const char col_gray2[] = "#444444";*/
/*static const char col_gray3[] = "#bbbbbb";*/
/*static const char col_gray4[] = "#eeeeee";*/
/*static const char col_cyan[] = "#005577";*/
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, col_gray1, col_gray2},
    [SchemeSel] = {col_gray4, col_cyan, col_cyan},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};
/*static const char *tags[] = {"1", "2", "3", "4", "5"};*/

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    /*{"Gimp", NULL, NULL, 0, 1, -1},*/
    /*{"Firefox", NULL, NULL, 1 << 8, 0, -1},*/
    {"St", "win1tmux", NULL, 1 << 0, 0, -1}, // Tag 1
    /*{"firefox", NULL, NULL, 1 << 1, 0, -1},       // Tag 2*/
    /*{"brave-browser", NULL, NULL, 1 << 1, 0, -1}, // Tag 2*/
    {"Beeper", NULL, NULL, 1 << 8, 0, -1}, // Tag 9
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod1Mask
#define TERMMOD (Mod1Mask | ShiftMask)
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

static char dmenumon[2] = "0";
static const char *dmenucmd[] = {"dmenu_run", NULL};
/*static const char *dmenucmd[] = {*/
/*    "dmenu_run", "-m",      dmenumon, "-fn",    dmenufont, "-nb", col_gray1,*/
/*    "-nf",       col_gray3, "-sb",    col_cyan, "-sf",     col_gray4, NULL};*/

/*static const char *termcmd[] = {"kitty", NULL};*/
static const char *termcmd[] = {"st", NULL};

/* clang-format off */
static const Key keys[] = {
    /* modifier                     key             function        argument */
    
    // Applications
    {MODKEY,                       XK_p,          spawn,          {.v = dmenucmd}},
    {TERMMOD,                      XK_Return,     spawn,          {.v = termcmd}},
    {TERMMOD,                      XK_grave,      spawn,          {.v = (const char *[]){"st", "-e", "htop", NULL}}},
    {MODKEY,                       XK_space,      spawn,          SHCMD("rofi -show drun")},
    {0,                            XK_Print,      spawn,          SHCMD("flameshot gui")},

    // Dunst Notifications
    {MODKEY,                       XK_F6,         spawn,          SHCMD("dunstctl close")},
    {TERMMOD,                      XK_F6,         spawn,          SHCMD("dunstctl close-all")},
    {MODKEY,                       XK_F7,         spawn,          SHCMD("dunstctl history-pop")},
    {MODKEY,                       XK_F8,         spawn,          SHCMD("dunstctl context")},

    {TERMMOD,                      XK_s,          spawn,          SHCMD("slock & systemctl suspend")},
    {TERMMOD,                      XK_l,          spawn,          SHCMD("pkill dwm")},
    {TERMMOD,                      XK_u,          spawn,          SHCMD("systemctl poweroff")},
    {TERMMOD,                      XK_r,          spawn,          SHCMD("systemctl reboot")},

    // Custom Scripts
    {TERMMOD,                       XK_t,          spawn,          SHCMD("/bin/sh -c ~/.config/suckless/dwm/scripts/open_todo.sh")},
    {TERMMOD,                      XK_w,          spawn,          SHCMD("~/.config/suckless/dwm/scripts/wifi_menu.sh")},
    {MODKEY,                       XK_w,          spawn,          SHCMD("~/.config/suckless/dwm/scripts/caffeine-mode.sh")},
    /*{MODKEY,                       XK_Print,      spawn,          SHCMD("flameshot gui -d 5000")},*/
    /*{TERMMOD,                      XK_slash,      spawn,          SHCMD("~/.config/suckless/dwm/scripts/show_shortcuts.sh")},*/
    /*{MODKEY,                       XK_slash,      spawn,          SHCMD("~/.config/suckless/dwm/scripts/show_shortcuts_txt.sh")},*/
    /*{TERMMOD,                      XK_p,          spawn,          SHCMD("~/.config/suckless/dwm/scripts/power_menu.sh")},*/
    /*{TERMMOD,                      XK_slash,      spawn,          SHCMD("~/.config/suckless/dwm/scripts/show_shortcuts.sh")},*/
    /*{MODKEY,                       XK_slash,      spawn,          SHCMD("~/.config/suckless/dwm/scripts/show_shortcuts_txt.sh")},*/

    // Volume Controls
    {TERMMOD,                      XK_k,          spawn,          SHCMD("~/.config/suckless/dwm/scripts/volume_bar.sh up")},
    {TERMMOD,                      XK_j,          spawn,          SHCMD("~/.config/suckless/dwm/scripts/volume_bar.sh down")},
    {TERMMOD,                      XK_m,          spawn,          SHCMD("~/.config/suckless/dwm/scripts/volume_bar.sh toggle")},

    // Miscellaneous
    {MODKEY,                       XK_b,          togglebar,      {0}},
    {MODKEY,                       XK_j,          focusstack,     {.i = +1}},
    {MODKEY,                       XK_k,          focusstack,     {.i = -1}},
    {MODKEY,                       XK_h,          setmfact,       {.f = -0.05}},
    {MODKEY,                       XK_l,          setmfact,       {.f = +0.05}},
    {MODKEY,                       XK_Return,     zoom,           {0}},
    {MODKEY,                       XK_Tab,        view,           {0}},
    /*{TERMMOD,                      XK_q,          quit,           {0}},*/

    
    {MODKEY,                       XK_i,         incnmaster,      {.i = +1}},
    {MODKEY,                       XK_d,         incnmaster,      {.i = -1}},
    {TERMMOD,                      XK_c,         killclient,      {0}},
    {MODKEY,                       XK_t,         setlayout,       {.v = &layouts[0]}},
    {MODKEY,                       XK_f,         setlayout,       {.v = &layouts[1]}},
    {MODKEY,                       XK_m,         setlayout,       {.v = &layouts[2]}},
    {MODKEY,                       XK_space,     setlayout,       {0}},
    {TERMMOD,                      XK_space,     togglefloating,  {0}},
    {MODKEY,                       XK_0,         view,            {.ui = ~0}},
    {TERMMOD,                      XK_0,         tag,             {.ui = ~0}},
    {MODKEY,                       XK_comma,     focusmon,        {.i = -1}},
    {MODKEY,                       XK_period,    focusmon,        {.i = +1}},
    {TERMMOD,                      XK_comma,     tagmon,          {.i = -1}},
    {TERMMOD,                      XK_period,    tagmon,          {.i = +1}},






    TAGKEYS(XK_1, 0)
    TAGKEYS(XK_2, 1)
    TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3)
    TAGKEYS(XK_5, 4)
    TAGKEYS(XK_6, 5)
    TAGKEYS(XK_7, 6)
    TAGKEYS(XK_8, 7)
    TAGKEYS(XK_9, 8)
};

/* clang-format on */

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};

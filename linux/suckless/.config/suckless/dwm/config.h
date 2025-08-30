/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 3; /* border pixel of windows */
static const unsigned int gappx = 6;    /* gaps between windows */
static const unsigned int snap = 32;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const char *fonts[] = {"Meslo LGM Nerd Font:size=10"};
/*static const char *fonts[] = {"monospace:size=10"};*/
static const char dmenufont[] = "Meslo LGM Nerd Font:size=10";
/*static const char dmenufont[] = "monospace:size=10";*/

static char normbgcolor[] = "#222222";
static char normbordercolor[] = "#444444";
static char normfgcolor[] = "#bbbbbb";
static char selfgcolor[] = "#eeeeee";
static char selbordercolor[] = "#005577";
static char selbgcolor[] = "#005577";
static char *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = {"emacs", "--name", scratchpadname,
                                      "-g",    "120x45", NULL};
/*static const char *scratchpadcmd[] = {*/
/*    "emacs", "--name", scratchpadname, "-g", "1200x600+400+45", NULL};*/

/*static const char *scratchpadcmd[] = {"emacs", "--name", scratchpadname,
 * NULL};*/

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    /*{"St", "win1tmux", NULL, 1 << 0, 0, -1}, // Tag 1*/
    {"StWinTmux", NULL, NULL, 1 << 0, 0, -1}, // Tag 1
    /*{"firefox", NULL, NULL, 1 << 1, 0, -1},*/
    {"zen", NULL, NULL, 1 << 1, 0, -1},
    {"Emacs", NULL, scratchpadname, 0, 1, -1},
    {"ncmpcpp", NULL, NULL, 0, 1, -1},
    // {"nmtui", NULL, NULL, 0, 1, -1},
    // {"Beeper", NULL, NULL, 1 << 8, 0, -1}, // Tag 9
    /*{"firefox", NULL, "Picture-in-Picture", 1, 1, -1},*/
    {"zen", NULL, "Toolkit", 1, 1, -1},
    {"ttyclock", NULL, NULL, 0, 1, -1},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
/* 1 means respect size hints in tiled resizals */
/*static const int resizehints = 1;*/
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

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[] = {"dmenu_run", NULL};
// static const char *dmenucmd[] = {"rofi", "-show", "drun", NULL};
static const char *dmenucmd[] = {"rofi", "-show", "combi", "-combi-modi", NULL};
/*static const char *dmenucmd[] = {*/
/*    "dmenu_run", "-m",      dmenumon, "-fn",    dmenufont, "-nb", col_gray1,*/
/*    "-nf",       col_gray3, "-sb",    col_cyan, "-sf",     col_gray4, NULL};*/

/*static const char *termcmd[] = {"kitty", NULL};*/
static const char *termcmd[] = {"st", NULL};

static const char *ttyclockcmd[] = {
    "st", "-c", "ttyclock", "-g", "60x25+1425+25", "-e", "tty-clock", "-s",
    "-c", "-C", "2",        NULL};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
    {"normbgcolor", STRING, &normbgcolor},
    {"normbordercolor", STRING, &normbordercolor},
    {"normfgcolor", STRING, &normfgcolor},
    {"selbgcolor", STRING, &selbgcolor},
    {"selbordercolor", STRING, &selbordercolor},
    {"selfgcolor", STRING, &selfgcolor},
};

/* clang-format off */
static const Key keys[] = {
    /* modifier                     key             function        argument */
    
    // Applications
    {MODKEY,                       XK_p,      spawn,          {.v = dmenucmd}},
    // {MODKEY,                       XK_p,          spawn,          SHCMD("~/.config/scripts/rofi_launch.sh")},
    {TERMMOD,                      XK_Return,     spawn,          {.v = termcmd}},
    {TERMMOD,                      XK_grave,      spawn,          {.v = (const char *[]){"st", "-e", "htop", NULL}}},
    /*{MODKEY,                      XK_p,          spawn,          SHCMD("rofi -show drun")},*/

    {0,                            XK_Print,      spawn,          SHCMD("flameshot gui")},


    // Dunst Notifications
    {MODKEY,                       XK_F6,         spawn,          SHCMD("dunstctl close")},
    {TERMMOD,                      XK_F6,         spawn,          SHCMD("dunstctl close-all")},
    {MODKEY,                       XK_F7,         spawn,          SHCMD("dunstctl history-pop")},
    {MODKEY,                       XK_F8,         spawn,          SHCMD("dunstctl context")},

    {TERMMOD,                      XK_s,          spawn,          SHCMD("~/.config/scripts/confirm.sh 'Sleep' 'mpc pause && slock & systemctl suspend'")},
    {TERMMOD,                      XK_l,          spawn,          SHCMD("~/.config/scripts/confirm.sh 'Exit Dwm' 'pkill dwm'")},
    {TERMMOD,                      XK_u,          spawn,          SHCMD("~/.config/scripts/confirm.sh 'Shutdown' 'systemctl poweroff'")},
    {TERMMOD,                      XK_r,          spawn,          SHCMD("~/.config/scripts/confirm.sh 'Reboot' 'systemctl reboot'")},

    // Custom Scripts
    { MODKEY,                     XK_n,          togglescratch,   {.v = scratchpadcmd } },
    { MODKEY,                     XK_o,          spawn,           SHCMD("~/.config/scripts/ncmpcpp_toggle.sh") },
    { MODKEY,                     XK_w,          spawn,           SHCMD("~/.config/scripts/wifi_menu.sh") },
    { TERMMOD,                    XK_b,          spawn,           SHCMD("~/.config/scripts/books_list.sh") },
    { TERMMOD,                    XK_v,          spawn,           SHCMD("~/.config/scripts/clipmenu.sh sel") },
    // { MODKEY,                     XK_w,          spawn,           SHCMD("~/.config/scripts/nmtui_toggle.sh") },
    { MODKEY,                     XK_F12,        spawn,           {.v = ttyclockcmd } },
    /*{TERMMOD,                      XK_t,          spawn,          SHCMD("/bin/sh -c ~/.config/scripts/open_todo.sh")},*/
    /*{TERMMOD,                      XK_w,          spawn,          SHCMD("~/.config/scripts/wifi_menu.sh")},*/
    /*{MODKEY,                       XK_Print,      spawn,          SHCMD("flameshot gui -d 5000")},*/
    /*{TERMMOD,                      XK_slash,      spawn,          SHCMD("~/.config/scripts/show_shortcuts.sh")},*/
    /*{MODKEY,                       XK_slash,      spawn,          SHCMD("~/.config/scripts/show_shortcuts_txt.sh")},*/
    /*{TERMMOD,                      XK_p,          spawn,          SHCMD("~/.config/scripts/power_menu.sh")},*/
    /*{TERMMOD,                      XK_slash,      spawn,          SHCMD("~/.config/scripts/show_shortcuts.sh")},*/
    /*{MODKEY,                       XK_slash,      spawn,          SHCMD("~/.config/scripts/show_shortcuts_txt.sh")},*/

    // Volume Controls
    {TERMMOD,                      XK_k,          spawn,          SHCMD("~/.config/scripts/volume_bar.sh up")},
    {TERMMOD,                      XK_j,          spawn,          SHCMD("~/.config/scripts/volume_bar.sh down")},
    {TERMMOD,                      XK_m,          spawn,          SHCMD("~/.config/scripts/volume_bar.sh toggle")},
    {MODKEY,                       XK_s,          spawn,          SHCMD("~/.config/scripts/audio-switcher.sh toggle")},  

    //display controls
    { TERMMOD,                     XK_h,         spawn,          SHCMD("~/.config/scripts/display_control/display_control.sh") },
    { MODKEY,                      XK_comma,      spawn,          SHCMD("~/.config/scripts/display_control/display_adjust.sh down") },
    { MODKEY,                      XK_period,     spawn,          SHCMD("~/.config/scripts/display_control/display_adjust.sh up") },


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
    /*{MODKEY,                       XK_space,     setlayout,       {0}},*/
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
    // {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    // {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    // {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkClientWin, Mod4Mask, Button1, movemouse, {0}},
    {ClkClientWin, Mod4Mask, Button2, togglefloating, {0}},
    {ClkClientWin, Mod4Mask, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};

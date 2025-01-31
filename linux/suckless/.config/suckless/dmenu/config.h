/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;    /* -c option; centers dmenu on screen */
static int min_width = 500; /* minimum width when centered */
/* This is the ratio used in the original calculation */
/*static const float menu_height_ratio = 4.0f;   */
static const float menu_height_ratio =
    2.0f; /* This is the ratio used in the original calculation */
/* -fn option overrides fonts[0]; default X11 font or font set */
/*static const char *fonts[] = {"monospace:size=10"};*/
static const char *fonts[] = {"Meslo LGM Nerd Font:size=11"};
static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */

    /*[SchemeNorm] = {"#ffffff", "#1a1b26"},*/
    /*[SchemeSel] = {"#ffffff", "#3b4261"},*/
    /*[SchemeOut] = {"#ffffff", "#565f89"},*/
    [SchemeNorm] = {"#C0CAF5", "#1A1B26"},
    [SchemeSel] = {"#E0DEF4", "#505880"},
    [SchemeOut] = {"#A9B1D6", "#565F89"}
    /*[SchemeNorm] = {"#bbbbbb", "#222222"},*/
    /*[SchemeSel] = {"#eeeeee", "#005577"},*/
    /*[SchemeOut] = {"#000000", "#00ffff"},*/
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines = 8;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 30;
static unsigned int min_lineheight = 20;
static unsigned int columns = 1;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 3;

/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
/*static const char *fonts[] = {"monospace:size=10"};*/
static const char *fonts[] = {"Meslo LGM Nerd Font:size=10"};
static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    /*[SchemeNorm] = { "#c0caf5", "#1a1b26" },*/
    /*[SchemeSel]  = { "#c0caf5", "#7aa2f7" },*/
    /*[SchemeOut]  = { "#1a1b26", "#7dcfff" },*/
    /**/
    /*[SchemeNorm] = { "#1a1b26", "#1a1b26" },*/
    /*[SchemeSel]  = { "#1a1b26", "#3b4261" },*/
    /*[SchemeOut]  = { "#1a1b26", "#565f89" },*/
    /**/
    /*[SchemeNorm] = {"#565f89", "#1a1b26"},*/
    /*[SchemeSel] = {"#c0caf5", "#3b4261"},*/
    /*[SchemeOut] = {"#7aa2f7", "#565f89"},*/
    [SchemeNorm] = {"#ffffff", "#1a1b26"},
    [SchemeSel] = {"#ffffff", "#3b4261"},
    [SchemeOut] = {"#ffffff", "#565f89"},
    /*[SchemeNorm] = { "#bbbbbb", "#222222" },*/
    /*[SchemeSel] = { "#eeeeee", "#005577" },*/
    /*[SchemeOut] = { "#000000", "#00ffff" },*/
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines = 10;
static unsigned int columns = 1;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 1;

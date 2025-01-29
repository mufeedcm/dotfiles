/* user and group to drop privileges to */
static const char *user = "nobody";
static const char *group = "nobody";
/*static const char *group = "nogroup";*/

static const char *colorname[NUMCOLS] = {
    [INIT] = "#000000",   /* after initialization - dark background */
    [INPUT] = "#1f2335",  /* during input - soft blue */
    [FAILED] = "#c53b53", /* wrong password - soft light purple */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

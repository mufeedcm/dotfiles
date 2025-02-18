/* user and group to drop privileges to */
static const char *user = "nobody";
static const char *group = "nobody";
/*static const char *group = "nogroup";*/

/*static const char *colorname[NUMCOLS] = {*/
/*    [INIT] = "#000000",*/
/*    [INPUT] = "#1f2335",*/
/*    [FAILED] = "#c53b53",*/
/*};*/

static const char *colorname[NUMCOLS] = {
    [INIT] = "#000000",
    [INPUT] = "#303030",
    [FAILED] = "#505050",
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

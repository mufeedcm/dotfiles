------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.6,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "wezterm"
local fileManager = "nemo"
local menu = "rofi -show combi -combi-modi"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("hyprpaper & hypridle &")
    hl.exec_cmd("hyprsunset --temperature 1500 &")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("wezterm start --class FirstTerminal &")
    -- hl.exec_cmd("wezterm start --class TerminalWithTmux &")
    -- hl.exec_cmd("wezterm start --class TerminalWithTmux -- zsh -ic tmux &")
    hl.exec_cmd("firefox &")
    hl.exec_cmd("opentabletdriver-daemon &")
    hl.exec_cmd("emacs --daemon &")
    hl.exec_cmd("pkill dunst")
    hl.exec_cmd("swaync &")
    hl.exec_cmd("kmonad ~/.config/kmonad/config.kbd &")
    hl.exec_cmd("~/.config/scripts/battery_status.sh &")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 3,

        border_size = 2,

        col = {
            active_border   = "rgba(d79921ee)",
            inactive_border = "rgba(3c3836aa)",
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, damping = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

hl.config({
    dwindle = {
        preserve_split = true, 
    },
})

hl.config({
    master = {
        new_status = "slave",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        font_family             = "JetBrains Mono Nerd Font",
        force_default_wallpaper = 1, 
        disable_hyprland_logo   = true, 
    },
})


----------------
---- LAYERS ----
----------------

hl.config({
    layers = {
        allow_new_top_layers_over_existing_fullscreen = true, 
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 1.0, -- -1.0 - 1.0.

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_and_drag = false,
            tap_to_click = false,
            clickfinger_behavior = true,
        },
        numlock_by_default = true,
    },
    cursor = { no_hardware_cursors = true },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name        = "ugtablet-6-inch-pentablet",
    left_handed = false,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT" 
local shiftMod = "ALT + SHIFT"

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(menu))
hl.bind(shiftMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(shiftMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region -z --clipboard-only"))

hl.bind(shiftMod .. " + S", hl.dsp.exec_cmd("bash -c 'pgrep -x hyprlock >/dev/null && systemctl suspend || ~/.config/scripts/confirm.sh \"Sleep\" \"mpc pause && hyprlock & sleep 0.5 && systemctl suspend\"'"), { locked = true })

-- hl.bind(shiftMod .. " + L", hl.dsp.exec_cmd("bash -c 'pgrep -x hyprlock >/dev/null && hyprctl dispatch exit || ~/.config/scripts/confirm.sh \"Exit Hyprland\" \"hyprctl dispatch exit\"'"), { locked = true })

hl.bind(shiftMod .. " + L", hl.dsp.exec_cmd(
    "~/.config/scripts/confirm.sh 'Exit Hyprland' \"hyprctl dispatch 'hl.dsp.exit()'\""
), { locked = true })

hl.bind(shiftMod .. " + U", hl.dsp.exec_cmd("bash -c 'pgrep -x hyprlock >/dev/null && systemctl poweroff || ~/.config/scripts/confirm.sh \"Shutdown\" \"systemctl poweroff\"'"), { locked = true })

hl.bind(shiftMod .. " + R", hl.dsp.exec_cmd("bash -c 'pgrep -x hyprlock >/dev/null && systemctl reboot || ~/.config/scripts/confirm.sh \"Reboot\" \"systemctl reboot\"'"), { locked = true })
hl.bind(shiftMod .. " + X", hl.dsp.window.close())

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(shiftMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.config/scripts/ncmpcpp_toggle.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/scripts/wifi_menu.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/scripts/bluetooth_menu.sh"))
hl.bind(shiftMod .. " + B", hl.dsp.exec_cmd("~/.config/scripts/books_list.sh"))

hl.bind(shiftMod .. " + K", hl.dsp.exec_cmd("~/.config/scripts/volume_bar.sh up"), { repeating = true })
hl.bind(shiftMod .. " + J", hl.dsp.exec_cmd("~/.config/scripts/volume_bar.sh down"), { repeating = true })
hl.bind(shiftMod .. " + M", hl.dsp.exec_cmd("~/.config/scripts/volume_bar.sh mute"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + RETURN", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + J", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + K", hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + H", hl.dsp.layout("mfact -0.1"))
hl.bind(mainMod .. " + L", hl.dsp.layout("mfact +0.1"))

for i = 1, 10 do
    local key = i % 10 
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(shiftMod .. " + " .. key,       hl.dsp.window.move({ workspace = i }))
end

hl.workspace_rule({
    workspace = "special:emacs",
    persistent = false,
})

hl.on("workspace.created", function(ws)
    if ws.name == "special:emacs" and ws.is_empty then
      hl.exec_cmd("[float; center] emacs")
    end
end)
hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special("emacs"))

hl.window_rule({
    name  = "zathura-current-workspace",
    match = { class = "^(Zathura)$" },
    workspace = "current",
})
hl.window_rule({
    name  = "zathura-org-current-workspace",
    match = { class = "^(org.pwmt.zathura)$" },
    workspace = "current",
})

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "first-terminal-workspace",
    match = { class = "^(FirstTerminal)$" },
    workspace = "1",
})

hl.window_rule({
  name  = "firefox-workspace",
  match = { class = "^([Ff]irefox)$" },
  workspace = "2",
})

hl.window_rule({
    name  = "ncmpcpp-floating",
    match = { class = "^(ncmpcpp)$" },
    float = true,
    size  = "500 500",
    move  = "1090 33",
})


local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

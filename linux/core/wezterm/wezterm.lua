local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder and wezterm.config_builder() or {}

config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'MesloLGM Nerd Font',
  'Noto Color Emoji',
  'Iosevka Nerd Font',
})
config.font_size = 11
config.default_cursor_style = 'BlinkingBlock'
config.enable_scroll_bar = true
config.window_background_opacity = 1.0
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }

config.initial_cols = 120
config.initial_rows = 28
config.scrollback_lines = 3500
config.exit_behavior = 'Hold'
config.audible_bell = 'Disabled'

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.enable_wayland = false

config.color_scheme = nil

config.colors = {
  foreground = "#E4DCD2",
  background = "#161413",

  cursor_bg = "#C2A86C",
  cursor_fg = "#161413",
  cursor_border = "#C2A86C",

  selection_bg = "#2A2624",
  selection_fg = "#E4DCD2",

  ansi = {
    "#161413", -- black
    "#B06A6A", -- red
    "#8F9D6A", -- green
    "#C2A86C", -- yellow
    "#6F8F9D", -- blue
    "#9A7A92", -- magenta
    "#7FA09B", -- cyan
    "#E4DCD2", -- white
  },

  brights = {
    "#3A3532",
    "#C37A7A",
    "#A5B47A",
    "#D4B97A",
    "#88A6B3",
    "#B08CA7",
    "#98B8B3",
    "#F0E8DE",
  },
}
-- config.disable_default_key_bindings = true
--
-- config.keys = {
--   {
--     key = 'C',
--     mods = 'ALT',
--     action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
--   },
--   {
--     key = 'V',
--     mods = 'ALT',
--     action = act.PasteFrom 'Clipboard' },
--   }
return config

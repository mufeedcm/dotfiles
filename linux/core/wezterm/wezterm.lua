local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder and wezterm.config_builder() or {}

config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'MesloLGM Nerd Font',
  'Noto Color Emoji',
})
config.font_size = 10
config.color_scheme = 'Batman'
config.default_cursor_style = 'BlinkingBlock'
config.enable_scroll_bar = true
config.window_background_opacity = 1.0 -- set to 0.9 for slight transparency
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }

config.initial_cols = 120
config.initial_rows = 28
config.scrollback_lines = 3500
config.exit_behavior = 'Hold'
config.audible_bell = 'Disabled'

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.enable_wayland = false


return config

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
--
--


config.font = wezterm.font {
    family = 'Liga Space Mono for Powerline',
}
config.font_size = 18.0
config.cell_width = 0.89


-- Color Scheme
config.color_scheme = 'OneHalfDark'
config.colors = {
    background = "#0a0d12"
}

-- Hide the tab bar
config.hide_tab_bar_if_only_one_tab = true

-- window padding
config.window_padding = {
    left = 20,
    right = 20,
    top = 50,
    bottom = 20,
}

config.window_background_opacity = 0.8
config.macos_window_background_blur = 40
config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW|INTEGRATED_BUTTONS"
config.initial_cols = 110

-- and finally, return the configuration to wezterm
return config

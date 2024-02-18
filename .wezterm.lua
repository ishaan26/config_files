-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
----------------------------
-- Font
----------------------------
config.font = wezterm.font({
	family = "MeraIosevka Nerd Font",
	weight = "Regular",
	harfbuzz_features = { "zero" },
})

config.font_size = 14.0
-- config.cell_width = 0.9
-- config.line_height = 0.9
-- config.freetype_load_target = "Light"
-- config.freetype_render_target = "HorizontalLcd"

----------------------------
-- Theme
----------------------------
config.color_scheme = "OneHalfDark"
-- Background
config.colors = {
	background = "#0c0e15",
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80
config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW"

----------------------------
-- Window Scheme
----------------------------
-- Hide the tab bar
config.hide_tab_bar_if_only_one_tab = true

-- window padding
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

-- Startup
config.initial_cols = 110

-- and finally, return the configuration to wezterm
return config

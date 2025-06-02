local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", {
	position = "left",
	width = settings.group_paddings,
})

local mission_control = sbar.add("item", {
	icon = {
		string = "􀇵 ", -- SF Symbol for Mission Control (grid.3x3)
		color = colors.white,
		padding_left = 8,
		padding_right = 24,
		font = {
			family = settings.font.text,
			style = "Bold",
			size = 16.0,
		},
	},
	label = {
		string = "Desktops",
		color = colors.white,
		padding_right = 8,
		padding_left = 18,
		width = 55,
		align = "right",
		font = {
			family = settings.font.text,
			style = "Bold",
			size = 16.0,
		},
	},
	position = "left",
	padding_left = 1,
	padding_right = 1,
	background = colors.default_background,
	click_script = "open -a 'Mission Control'",
})

-- Double border for mission control using a single item bracket
sbar.add("bracket", { mission_control.name }, {
	background = colors.default_background,
})

-- Padding item required because of bracket
sbar.add("item", {
	position = "right",
	width = settings.group_paddings,
})

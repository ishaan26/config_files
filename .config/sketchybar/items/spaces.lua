local colors = require("colors")

local dices = { "󰇊 ", "󰇋 ", "󰇌 ", "󰇍 ", "󰇎 ", "󰇏 " }

for i, dice in ipairs(dices) do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = "sketchybar-app-font:Regular:20.0",
			string = dice,
			padding_left = 4,
			padding_right = 8,
			color = colors.white,
			highlight_color = colors.white,
		},
		label = {
			padding_right = 8,
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:20.0",
		},
		padding_right = 0,
		padding_left = 0,
		background = colors.transparent,
		popup = { background = { border_width = 2, border_color = colors.black } },
	})

	-- Single item bracket for space items to achieve double border on highlight
	local space_bracket = sbar.add("bracket", { space.name }, {
		background = colors.transparent,
	})

	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		script = "",
		width = 0,
	})

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		space:set({
			icon = { highlight = selected, highlight_color = colors.blue },
			label = { highlight = selected },
			background = { border_color = colors.transparent },
		})
		space_bracket:set({
			background = { border_color = colors.transparent },
		})
	end)

	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		else
			local op = (env.BUTTON == "right") and "--destroy" or "--focus"
			sbar.exec("yabai -m space " .. op .. " " .. env.SID)
		end
	end)

	space:subscribe("mouse.exited", function(_)
		space:set({ popup = { drawing = false } })
	end)
end

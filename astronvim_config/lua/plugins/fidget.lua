return {
	"j-hui/fidget.nvim",
	opts = {
		progress = {
			display = {
				render_limit = 3,
				done_icon = "✔",
			},
		},
		notification = {
			window = {
				normal_hl = "Comment", -- Base highlight group in the notification window
				winblend = 0, -- Background color opacity in the notification window
				border = "rounded", -- Border around the notification window
				zindex = 45, -- Stacking priority of the notification window
				max_width = 40, -- Maximum width of the notification window
				max_height = 2, -- Maximum height of the notification window
				x_padding = 1, -- Padding from right edge of window boundary
				y_padding = 0, -- Padding from bottom edge of window boundary
				align = "bottom", -- How to align the notification window
				relative = "editor", -- What the notification window position is relative to
			},
		},
	},
}

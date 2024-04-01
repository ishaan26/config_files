return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "onedark",
				section_separators = { left = "", right = "" },
			},
		},
	},
	{
		"rebelot/heirline.nvim",
		optional = true,
		opts = function(_, opts)
			opts.statusline = nil
		end,
	},
}

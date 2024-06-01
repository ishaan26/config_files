return {
	"loctvl842/monokai-pro.nvim",
	opts = {
		filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
		transparent_background = true,
		styles = {
			comment = { italic = true },
			keyword = { italic = true }, -- any other keyword
			type = { italic = false }, -- (preferred) int, long, char, etc
			storageclass = { italic = false }, -- static, register, volatile, etc
			structure = { italic = true }, -- struct, union, enum, etc
			parameter = { italic = false }, -- parameter pass in function
			annotation = { italic = true },
			tag_attribute = { italic = true }, -- attribute of tag in reactjs
		},
		background_clear = {
			"float_win",
			"toggleterm",
			"telescope",
			"which-key",
			"renamer",
			"notify",
			"nvim-tree",
			"neo-tree",
			"bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
		},
	},
}

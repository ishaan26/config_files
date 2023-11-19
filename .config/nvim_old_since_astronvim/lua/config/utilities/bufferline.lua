require("bufferline").setup({
	options = {
		offsets = { { filetype = "NvimTree", text = "File Explorer" } },
		separator_style = "thin",
		show_close_icon = false,
		diagnostics = "nvim_lsp",
	},
})

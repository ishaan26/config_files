return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.motion.mini-surround" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
	{ import = "astrocommunity.utility.nvim-toggler" },
	{ import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = 120,
			disabled_filetypes = { "help" },
		},
	},
}

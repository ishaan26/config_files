return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.motion.mini-surround" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
	{ import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = 120,
			disabled_filetypes = { "help" },
		},
	},
}

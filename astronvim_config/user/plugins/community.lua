return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.motion.mini-surround" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
	{ import = "astrocommunity.utility.nvim-toggler" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	{ import = "astrocommunity.syntax.hlargs-nvim" },
	{ import = "astrocommunity.indent.indent-blankline-nvim" },
	{ import = "astrocommunity.indent.mini-indentscope" },
	{ import = "astrocommunity.test.neotest" },
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = 120,
			disabled_filetypes = { "help" },
		},
	},
}

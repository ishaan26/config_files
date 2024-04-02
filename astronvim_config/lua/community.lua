-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.pack.lua" },

	-- Language Packs
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.typescript" },
	-- nvim ui
	{ import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

	-- Play nicely with vscode
	{ import = "astrocommunity.recipes.vscode" },

	-- support
	{ import = "astrocommunity.motion.mini-surround" },
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
	{ import = "astrocommunity.test.neotest" },

	-- Tabs
	{ import = "astrocommunity.bars-and-lines.bufferline-nvim" },

	-- syntax
	{ import = "astrocommunity.syntax.hlargs-nvim" },

	-- neovide
	{ import = "astrocommunity.recipes.neovide" },
}

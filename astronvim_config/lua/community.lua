-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",

	-----------------
	-- Language Packs
	-----------------

	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.nix" },
	{ import = "astrocommunity.pack.zig" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.typst" },
	{ import = "astrocommunity.markdown-and-latex.vimtex" },

	-----------------
	-- Tools
	-----------------
	-- ai
	{ import = "astrocommunity.ai.copilotchat-nvim" },

	-- Generate comment shortcut
	{ import = "astrocommunity.editing-support.neogen" },

	-----------------
	-- UI
	-----------------

	-- Top Bar
	{ import = "astrocommunity.bars-and-lines.dropbar-nvim" },

	-- Rainbows
	{ import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },

	-- panels
	{ import = "astrocommunity.utility.noice-nvim" },

	-- Colors
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.colorscheme.everforest" },
	{ import = "astrocommunity.colorscheme.eldritch-nvim" },
	{ import = "astrocommunity.colorscheme.sonokai" },
	{ import = "astrocommunity.recipes.cache-colorscheme" },
	{ import = "astrocommunity.color.transparent-nvim" },
}

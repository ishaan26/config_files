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
	{ import = "astrocommunity.pack.svelte" },
	{ import = "astrocommunity.pack.typescript-all-in-one" },
	{ import = "astrocommunity.pack.tailwindcss" },

	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.zig" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.python-ruff" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.typst" },
	{ import = "astrocommunity.markdown-and-latex.vimtex" },

	-----------------
	-- Tools
	-----------------

	-- Generate comment shortcut
	{ import = "astrocommunity.editing-support.neogen" },

	-- AI
	{ import = "astrocommunity.completion.avante-nvim" },

	-----------------
	-- UI
	-----------------

	-- Top Bar
	{ import = "astrocommunity.bars-and-lines.dropbar-nvim" },

	-- Better completion ui.
	{ import = "astrocommunity.completion.blink-cmp" },

	-- Smooth scrolling
	{ import = "astrocommunity.scrolling.neoscroll-nvim" },

	-- Rainbows
	{ import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },

	-- Colorschemes
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.colorscheme.everforest" },
	{ import = "astrocommunity.colorscheme.eldritch-nvim" },
	{ import = "astrocommunity.colorscheme.sonokai" },
	{ import = "astrocommunity.recipes.cache-colorscheme" },
	{ import = "astrocommunity.color.transparent-nvim" },
}

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
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.svelte" },
	{ import = "astrocommunity.pack.python-ruff" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.vue" },
	{ import = "astrocommunity.pack.tailwindcss" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.bash" },

	-----------------
	-- Tools
	-----------------

	-- Generate comment shortcut
	{ import = "astrocommunity.editing-support.neogen" },

	-- lsp
	{ import = "astrocommunity.lsp.ts-error-translator-nvim" },

	-----------------
	-- UI
	-----------------

	-- Better completion ui.
	{ import = "astrocommunity.completion.blink-cmp" },

	-- Smooth scrolling
	{ import = "astrocommunity.scrolling.neoscroll-nvim" },

	-- Rainbows
	{ import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },

	-- Bars and lines
	{ import = "astrocommunity.bars-and-lines.dropbar-nvim" },
	{ import = "astrocommunity.bars-and-lines.bufferline-nvim" },

	-- Colorschemes
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.colorscheme.everforest" },
	{ import = "astrocommunity.colorscheme.eldritch-nvim" },
	{ import = "astrocommunity.colorscheme.sonokai" },
	{ import = "astrocommunity.recipes.cache-colorscheme" },
	{ import = "astrocommunity.color.transparent-nvim" },
}

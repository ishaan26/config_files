-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",

	-- Language Packs
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.svelte" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.vue" },
	{ import = "astrocommunity.pack.tailwindcss" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.bash" },

	-- UI
	{ import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
	{ import = "astrocommunity.bars-and-lines.dropbar-nvim" },
	{ import = "astrocommunity.bars-and-lines.bufferline-nvim" },
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.colorscheme.tokyonight-nvim" },
	{ import = "astrocommunity.recipes.cache-colorscheme" },
	{ import = "astrocommunity.color.transparent-nvim" },
}

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.pack.lua" },

	-- Language Packs
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.zig" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.svelte" },
	{ import = "astrocommunity.pack.vue" },
	{ import = "astrocommunity.pack.tailwindcss" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.programming-language-support.csv-vim" },

	-- nvim ui
	{ import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

	-- Play nicely with vscode
	{ import = "astrocommunity.recipes.vscode" },

	-- support
	{ import = "astrocommunity.motion.mini-surround" },
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
	{ import = "astrocommunity.test.neotest" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },

	-- Tabs
	{ import = "astrocommunity.bars-and-lines.bufferline-nvim" },

	-- syntax
	{ import = "astrocommunity.syntax.hlargs-nvim" },

	-- neovide
	{ import = "astrocommunity.recipes.neovide" },
}

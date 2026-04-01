return {
	"dariuscorvus/tree-sitter-surrealdb.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		-- setup step
		require("tree-sitter-surrealdb").setup()
	end,
}

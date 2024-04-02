return {
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},

	{
		"AstroNvim/astrolsp",
		---@type AstroLSPOpts
		opts = {
			mappings = {
				n = {
					-- Code Actions
					["<leader>ra"] = {
						function()
							vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
							-- or vim.lsp.buf.codeAction() if you don't want grouping.
						end,
					},
					["<leader>la"] = {
						function()
							vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
							-- or vim.lsp.buf.codeAction() if you don't want grouping.
						end,
					},

					-- Get all runnables
					["<leader>rr"] = {
						function()
							vim.cmd.RustLsp("runnables") -- supports rust-analyzer's grouping
						end,
					},

					-- Get all testables
					["<leader>rt"] = {
						function()
							vim.cmd.RustLsp("testables") -- supports rust-analyzer's grouping
						end,
					},

					-- Get all debuggables
					["<leader>rd"] = {
						function()
							vim.cmd.RustLsp("debuggables") -- supports rust-analyzer's grouping
						end,
					},

					-- Explain Error
					ge = {
						function()
							vim.cmd.RustLsp("explainError")
						end,
					},

					-- Open Cargo.toml
					["<leader>rc"] = {
						function()
							vim.cmd.RustLsp("openCargo")
						end,
					},

					["<leader>ro"] = {
						function()
							-- Open Cargo.toml
							vim.cmd.RustLsp("openDocs")
						end,
					},
				},
			},
		},
	},

	-- Disable default rust_analyzer
	{
		"neovim/nvim-lspconfig",
		opts = {
			setup = {
				rust_analyzer = function()
					return true
				end,
			},
		},
	},
}

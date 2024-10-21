return {
	{
		"mrcjkb/rustaceanvim",
		opts = {
			tools = {
				replace_builtin_hover = false,
				float_win_config = {
					border = "rounded",
				},
			},
		},
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
						desc = "Code Actions",
					},

					-- Get all runnables
					["<leader>rr"] = {
						function()
							vim.cmd.RustLsp("runnables") -- supports rust-analyzer's grouping
						end,
						desc = "List out all the runnables",
					},

					-- Get all testables
					["<leader>rt"] = {
						function()
							vim.cmd.RustLsp("testables") -- supports rust-analyzer's grouping
						end,
						desc = "List out all the testables",
					},

					-- Get all debuggables
					["<leader>rd"] = {
						function()
							vim.cmd.RustLsp("debuggables") -- supports rust-analyzer's grouping
						end,
						desc = "List out the debuggables",
					},

					-- Explain Error
					ge = {
						function()
							vim.cmd.RustLsp("explainError")
						end,
						desc = "Explain the error",
					},

					-- Open Cargo.toml
					["<leader>rc"] = {
						function()
							vim.cmd.RustLsp("openCargo")
						end,
						desc = "Open Cargo.toml",
					},

					["<leader>ro"] = {
						function()
							-- Open Cargo.toml
							vim.cmd.RustLsp("openDocs")
						end,
						desc = "Open docs.rs",
					},
				},
			},
		},
	},
}

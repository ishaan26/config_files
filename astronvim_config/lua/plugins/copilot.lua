---@type LazySpec
return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "InsertEnter",
		config = function()
			require("minuet").setup({
				-- gemma4 does NOT support FIM/insert mode in Ollama, so we use
				-- the chat-completions endpoint via openai_compatible instead.
				provider = "openai_compatible",

				-- 1 completion recommended for local models
				n_completions = 1,

				-- Start modest; increase if your machine handles it
				context_window = 512,

				-- Local model can take a bit longer
				request_timeout = 15,

				throttle = 1000,
				debounce = 400,

				notify = "warn",

				provider_options = {
					openai_compatible = {
						-- Ollama needs a non-null env var; TERM is always set on macOS/Linux
						api_key = "TERM",
						name = "Ollama",
						end_point = "http://localhost:11434/v1/chat/completions",
						model = "gemma4:e4b",
						stream = true,
						optional = {
							max_tokens = 128,
							top_p = 0.9,
						},
					},
				},

				-- Virtual-text frontend (same inline ghost-text feel as copilot)
				virtualtext = {
					-- Auto-trigger for all filetypes
					auto_trigger_ft = { "*" },
					auto_trigger_ignore_ft = { "help", "TelescopePrompt", "neo-tree", "lazy" },

					keymap = {
						accept      = "<C-L>", -- same key as your old copilot config
						accept_line = "<C-J>", -- accept one line at a time
						next        = "<M-]>",
						prev        = "<M-[>",
						dismiss     = "<C-]>",
					},
				},
			})
		end,
	},
}

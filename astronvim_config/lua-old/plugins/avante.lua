-- Avante.nvim - AI-powered coding assistant using local Ollama models
-- Docs: https://github.com/yetone/avante.nvim

---@type LazySpec
return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Always use the latest source
		build = "make",
		opts = {
			-- Use Ollama as the AI provider
			provider = "ollama",

			-- Ollama provider configuration
			providers = {
				ollama = {
					-- Change this to whichever model you have pulled in Ollama
					-- e.g. "llama3.2", "deepseek-coder-v2", "qwen2.5-coder:7b", etc.
					model = "qwen3.5:cloud",
					-- Required: tells avante that Ollama is available
					is_env_set = function()
						return require("avante.providers.ollama").check_endpoint_alive()
					end,
					-- Optional extra parameters sent to the Ollama API
					extra_request_body = {
						temperature = 0.3,
						max_tokens = 32768, -- cloud model: no VRAM constraint, raise freely
					},
				},
			},

			-- Interaction mode: "agentic" (default, AI can use tools) or "legacy"
			mode = "agentic",

			-- Auto-suggestions (Tab completion flow). Can be heavy on local hardware;
			-- set to false if you notice slowdowns.
			auto_suggestions_provider = "ollama",
			-- hint: set to nil to disable inline suggestions entirely
			-- auto_suggestions_provider = nil,

			-- Behaviour tweaks
			behaviour = {
				auto_suggestions = false, -- disable automatic inline suggestions (toggle with keymap)
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
			},

			-- Window appearance
			windows = {
				position = "right",
				wrap = true,
				width = 30, -- percentage of the total editor width
				sidebar_header = {
					enabled = true,
					align = "center",
					rounded = true,
				},
				input = {
					prefix = "> ",
					height = 8,
				},
				edit = {
					border = "rounded",
					start_insert = true,
				},
				ask = {
					floating = false,
					start_insert = true,
					border = "rounded",
					focused = true,
				},
			},

			-- Highlight for diffs in the buffer
			highlights = {
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},

			-- Diff view mode: "smart" | "unified" | "horizontal" | "vertical"
			diff = {
				autojump = true,
				list_opener = "copen",
				override_timeoutlen = 500,
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",

			-- Optional: markdown rendering in the sidebar
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},

			-- Optional: clipboard image support
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- Required for Windows users
						use_absolute_path = true,
					},
				},
			},

			-- blink.cmp integration: surfaces avante completions in the cmp menu
			{
				"saghen/blink.cmp",
				optional = true,
				dependencies = { "saghen/blink.compat" }, -- required: bridges nvim-cmp sources into blink
				opts = {
					sources = {
						-- Append "avante" to whatever providers are already configured
						default = { "avante" },
						providers = {
							avante = {
								module = "blink.compat.source",
								name = "avante",
								opts = {},
							},
						},
					},
				},
			},
		},
	},
}

---@type LazySpec
return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- always pull latest
		build = "make",
		---@module 'avante'
		---@type avante.Config
		opts = {
			provider = "copilot",
			mode = "agentic",
			auto_suggestions_provider = "copilot",
			providers = {
				copilot = {
					model = "claude-sonnet-4-5",
				},
			},
			behaviour = {
				auto_suggestions = false, -- avoid conflicts with copilot.lua inline completions
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				minimize_diff = true,
				enable_token_counting = true,
			},
			windows = {
				position = "right",
				width = 30,
				wrap = true,
				sidebar_header = {
					enabled = true,
					align = "center",
					rounded = true,
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"zbirenbaum/copilot.lua",
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = { insert_mode = true },
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}

return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				endpoint = "http://127.0.0.1:11434",
				model = "qwen2.5-coder:14b",
				stream = true,
			},
		},
	},
}

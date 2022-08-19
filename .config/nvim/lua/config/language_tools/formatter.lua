-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {

		-- Avaiable formatters at https://github.com/mhartington/formatter.nvim

		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,
		},

		sh = {
			require("formatter.filetypes.sh").shfmt,
		},

		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},

		python = {
			require("formatter.filetypes.python").yapf,
		},

		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},

		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		}
	},
})

-- Initialize modules
require("user.options")
require("user.keymap")
require("user.plugins")
require("user.cmp")
require("user.lsp")
require("user.treesitter")
require("user.telescope")
require("user.nvim-tree")
require("user.trouble")
require("user.fidget")

require("colorizer").setup()
require("spellsitter").setup()
require("gitsigns").setup()

-- mini plugins
require("mini.starter").setup()
require("mini.comment").setup()
require("mini.tabline").setup()

-- Set colorscheme
require("onedark").setup({
	style = "deep",
	transparent = true,
	term_colors = true,
	code_style = {
		functions = "bold",
	},
	highlights = {
		TSComment = { fg = "#6B859E" },
	},
})

require("onedark").load()

-- Enable Lua Line
require("lualine").setup({
	options = {
		theme = "onedark",
	},
})

-- Save cursor position
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]])

-- Rainbow Brakets fix
vim.cmd([[
hi rainbowcol1 guifg=#E06C75
]])

-- Format files
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

vim.ui.input = require("popui.input-overrider")
vim.cmd([[ nnoremap ,d :lua require'popui.diagnostics-navigator'()<CR> ]])

-- Rust options
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0
vim.g.rust_clip_command = "xclip -selection clipboard"

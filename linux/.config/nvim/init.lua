-- Initialize modules
require("user.options")
require("user.keymap")
require("user.plugins")
require("user.cmp")
require("user.lsp")
require("nvim-tree").setup {
}

-- Set colorscheme
require('onedark').setup {
    style = 'deep',
	transparent = true,
	term_colors = true,
	code_style = {
        functions = 'italic',
    },
}
require('onedark').load()

-- Enable Lua Line
require('lualine').setup{
	options = {
		theme = 'onedark'
	}
}

-- Save cursor position
vim.cmd [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]]

-- Rust options
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0
vim.g.rust_clip_command = 'xclip -selection clipboard'

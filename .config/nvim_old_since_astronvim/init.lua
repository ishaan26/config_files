vim.opt.termguicolors = true

-------------------------------------
-- Import Modules
-------------------------------------

require("config.plugins")
require("config.keymap")
require("config.utilities")
require("config.options")
require("config.theme")
require("config.language_tools")

-------------------------------------
-- Other Settings
-------------------------------------

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

-- Command for formatting files through the lsp
vim.cmd([[ command! LspFormat execute 'lua vim.lsp.buf.format { async = true }' ]])

-- Rust autoformat on save
vim.g.rustfmt_autosave = 1

-- Use Snipmate version 1
vim.cmd([[ let g:snipMate = { 'snippet_version' : 1 } ]])

-------------------------------------
-- Neovide settings
-------------------------------------
vim.g.neovide_cursor_animation_length = 0.13

-- Initialize modules
require "user.options"
require "user.keymap"
require "user.plugins"
require "nvim-tree".setup {
}


-- Set colorscheme
vim.cmd "colorscheme onedark"
vim.cmd "hi Normal guibg=NONE ctermbg=NONE"


-- Save cursor position
vim.cmd [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]]

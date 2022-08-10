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
require("user.mini")
require("user.gitsigns")
require("user.neoclip")
require("user.dressing")
require("user.knap")
require("user.which-key")
require("user.bufferline")

require("colorizer").setup()
require("spellsitter").setup()

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

-- Rust options
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0
vim.g.rust_clip_command = "xclip -selection clipboard"

local gknapsettings = {
	texoutputext = "pdf",
	textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
	textopdfviewerlaunch = "zathura %outputfile%",
	textopdfviewerrefresh = "kill -HUP %pid%",
}
vim.g.knap_settings = gknapsettings

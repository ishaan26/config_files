---@diagnostic disable: unused-local
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-----------------------------------
-- Normal --
-----------------------------------

-- Better window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Lex explorer
keymap("n", "<leader>n", ":NvimTreeToggle<cr>", opts)

-- Write and quit with <leader>
keymap("n", "<A-w>", ":wa<cr>", opts)
keymap("n", "<A-q>", ":q<cr>", opts)

-- Toggle between current and last buffer
keymap("n", "<leader><leader>", "<c-^>", opts)

-- Telescope
keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
keymap("n", "<C-f>", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>b", ":Telescope neoclip<cr>", opts)

-- Add blank lines
keymap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', opts)
keymap("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', opts)

-- Remove search highlighting
keymap("n", "<F12>", ":noh<cr>", opts)

-- Toggle relative Line Numbers
keymap("n", "<F4>", ":set invrelativenumber<cr>", opts)

-- Move by line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Center search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)

-- Format document
keymap("n", "<F9>", ":FormatWrite<cr>", opts)
keymap("n", "<F10>", ":LspFormat<cr>", opts)

-- lsp stuff
vim.keymap.set("n", "<A-c>", "<cmd>Lspsaga code_action<cr>", opts)
vim.keymap.set("n", "<A-r>", "<cmd>Lspsaga rename<cr>", opts)
vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga preview_definition<cr>", opts)
vim.keymap.set("n", "<A-t>", "<cmd>Lspsaga lsp_finder<cr>", opts)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)

vim.keymap.set("n", "<A-e>", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>j", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)

-- Toruble
keymap("n", "<leader>x", ":TroubleToggle<cr>", opts)

-- Rust
keymap("n", "<F2>", ":RustTest<cr>", opts)

-----------------------------------
-- Insert --
-----------------------------------

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-----------------------------------
-- Visual --
-----------------------------------

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- hold on to the text yanked when pasted over something else.

-----------------------------------
-- Visual Block --
-----------------------------------

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-----------------------------------
-- Latex and Markdown previewer
-----------------------------------
-- F5 processes the document once, and refreshes the view
vim.keymap.set("i", "<F5>", function()
	require("knap").process_once()
end)
vim.keymap.set("v", "<F5>", function()
	require("knap").process_once()
end)
vim.keymap.set("n", "<F5>", function()
	require("knap").process_once()
end)

-- F6 closes the viewer application, and allows settings to be reset
vim.keymap.set("i", "<F6>", function()
	require("knap").close_viewer()
end)
vim.keymap.set("v", "<F6>", function()
	require("knap").close_viewer()
end)
vim.keymap.set("n", "<F6>", function()
	require("knap").close_viewer()
end)

-- F7 toggles the auto-processing on and off
vim.keymap.set("i", "<F7>", function()
	require("knap").toggle_autopreviewing()
end)
vim.keymap.set("v", "<F7>", function()
	require("knap").toggle_autopreviewing()
end)
vim.keymap.set("n", "<F7>", function()
	require("knap").toggle_autopreviewing()
end)

-- F8 invokes a SyncTeX forward search, or similar, where appropriate
vim.keymap.set("i", "<F8>", function()
	require("knap").forward_jump()
end)
vim.keymap.set("v", "<F8>", function()
	require("knap").forward_jump()
end)
vim.keymap.set("n", "<F8>", function()
	require("knap").forward_jump()
end)

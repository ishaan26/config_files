local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)

	--------------------------------------------------------
	------------------- My plugins here --------------------
	--------------------------------------------------------

	-- General useins --
	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "nvim-lua/popup.nvim" -- to open a popup window in neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

	-- File Tree --
	use {
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	}

	-- Assistants --
	use "jiangmiao/auto-pairs" -- Auto close brackets
	use "tpope/vim-surround" -- Creating surrounding characters
	use "tpope/vim-repeat" -- The . command on steriod
	use "machakann/vim-highlightedyank" -- Highlight the line yanked
	use "junegunn/fzf.vim" -- Fuzzy finder

	-- Language Tools --

	-- completion
	use "hrsh7th/nvim-cmp" -- main plugin for completion
	use "hrsh7th/cmp-buffer" -- buffer completion
	use "hrsh7th/cmp-path" -- path completion
	use "hrsh7th/cmp-cmdline" -- command completion
	use "hrsh7th/cmp-nvim-lua" -- nvim lua command completion

	-- snippets
	use "L3MON4D3/LuaSnip" -- install lua snip
	use "saadparwaiz1/cmp_luasnip" -- snippet completions
	use "rafamadriz/friendly-snippets" -- a bunch of snippets for different files.

	-- LSP
    use "neovim/nvim-lspconfig" -- enables lsp
	use "williamboman/nvim-lsp-installer" -- lsp installer inside neovim
	use "hrsh7th/cmp-nvim-lsp" -- lsp completions

	-- Syntax
	use {
        'nvim-treesitter/nvim-treesitter', -- treesitter
        run = ':TSUpdate'
    }
	use "p00f/nvim-ts-rainbow" -- Colorful brackets
	use "jose-elias-alvarez/null-ls.nvim" -- Formatting

	-- rust
	use {
    	'saecki/crates.nvim',
		event = { "BufRead Cargo.toml" },
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			require('crates').setup()
		end,
	}
	use "rust-lang/rust.vim"

	-- Git --
	use "lewis6991/gitsigns.nvim" -- Git showcase

	-- Visual --
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}
	use "navarasu/onedark.nvim" -- Onedark colorsheme

	-------------------------------------------------------------------------


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

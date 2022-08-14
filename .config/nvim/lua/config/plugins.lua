local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	--------------------------------------------------------
	------------------- My plugins here --------------------
	--------------------------------------------------------

	--------------------
	-- Packer --
	--------------------
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- to open a popup window in neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins

	--------------------
	-- Assistants --
	--------------------

	-- General
	use("jiangmiao/auto-pairs") -- Auto close brackets
	use("tpope/vim-repeat") -- The . command on steriod
	use("machakann/vim-highlightedyank") -- Highlight the line yanked
	use("junegunn/fzf.vim") -- Fuzzy finder
	use({ "echasnovski/mini.nvim", branch = "stable" }) -- Collection of minimal, independent, and fast Lua modules
	use("gennaro-tedesco/nvim-peekup") -- use vim registers easily
	use("RishabhRD/popfix") -- popup fixes
	use("MunifTanjim/nui.nvim") -- Nvim UI component library.
	use("stevearc/dressing.nvim") -- Nvim UI component library.
	use("folke/which-key.nvim") -- displays a popup with possible key bindings of the command you started typing.
	use({
		"AckslD/nvim-neoclip.lua", -- clipboard manager for neovim
		requires = {
			{ "tami5/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim", -- Fuzzy finder on steroids
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-ui-select.nvim")

	-- File tree
	use({
		"kyazdani42/nvim-tree.lua", -- File tree
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

	-- Tabs
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	--------------------
	-- Language Tools --
	--------------------

	-- Completion
	use("hrsh7th/nvim-cmp") -- main plugin for completion
	use("hrsh7th/cmp-buffer") -- buffer completion
	use("hrsh7th/cmp-path") -- path completion
	use("hrsh7th/cmp-cmdline") -- command completion
	use("hrsh7th/cmp-nvim-lua") -- nvim lua command completion

	-- Snippets
	use("L3MON4D3/LuaSnip") -- install lua snip
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("rafamadriz/friendly-snippets") -- a bunch of snippets for different files.

	-- LSP
	use("williamboman/mason.nvim") -- Nextgen lsp handler for neovim
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig") -- enables lsp
	use("mfussenegger/nvim-lint") -- Linter
	use("mhartington/formatter.nvim") -- Formatter
	use("williamboman/nvim-lsp-installer") -- lsp installer inside neovim
	use("hrsh7th/cmp-nvim-lsp") -- lsp completions
	use("RishabhRD/nvim-lsputils") -- better defaults for nvim lsp
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("j-hui/fidget.nvim") -- lsp progress handler

	-- Code Actions
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})

	-- Syntax
	use({
		"nvim-treesitter/nvim-treesitter", -- treesitter
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow") -- Colorful brackets
	use("jose-elias-alvarez/null-ls.nvim") -- Formatting
	use("norcalli/nvim-colorizer.lua") -- Color Highlighter
	use("lewis6991/spellsitter.nvim") -- Spell checker using treesitter

	-- Rust
	use({
		"saecki/crates.nvim", -- Crate versions in Cargo.toml files
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup()
		end,
	})
	use("rust-lang/rust.vim") -- Rust support for neovim

	-- Latex and markdown
	use("frabjous/knap") -- previewer

	--------------------
	-- Git --
	--------------------
	use("lewis6991/gitsigns.nvim") -- Show git diff lines

	--------------------
	-- Visual --
	--------------------
	use({
		"nvim-lualine/lualine.nvim", -- the bar at the bottom
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("kyazdani42/nvim-web-devicons") -- Icons
	use("navarasu/onedark.nvim") -- Onedark colorsheme

	-------------------------------------------------------------------------

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

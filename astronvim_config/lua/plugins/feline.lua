-- get a string of active_clients
local function active_clients()
	local clients = vim.lsp.get_active_clients()
	local client_string = ""
	for i, v in ipairs(clients) do
		client_string = client_string .. v.name
		if i < #clients then
			client_string = client_string .. ", "
		end
	end
	return client_string
end

-- configure feline
local function config(_, opts)
	local colorscheme = vim.g.colors_name
	local palette = require("nightfox.palette").load(colorscheme)
	local feline = require("feline")
	local vi_mode = require("feline.providers.vi_mode")
	local file = require("feline.providers.file")
	local separators = require("feline.defaults").statusline.separators.default_value
	local lsp = require("feline.providers.lsp")

	local theme = {
		black = "#000000",
		fg = "#a7aab0",
		purple = "#bb70d2",
		green = "#8fb573",
		orange = "#c49060",
		blue = "#54b0fd",
		yellow = "#dbb671",
		cyan = "#51a8b3",
		red = "#de5d68",
		grey = "#5a5b5e",
	}

	local c = {

		-- local function git_diff(type)
		-- 	---@diagnostic disable-next-line: undefined-field
		-- 	local gsd = vim.b.gitsigns_status_dict
		-- 	if gsd and gsd[type] and gsd[type] > 0 then return tostring(gsd[type]) end
		-- 	return nil
		-- end

		-- left
		vim_status = {
			provider = function()
				local s
				if require("lazy.status").has_updates() then
					s = require("lazy.status").updates()
				else
					s = ""
				end
				s = string.format("   %s  ", s)
				return s
			end,

			hl = { fg = theme.purple, bg = theme.black },
		},

		file_name = {
			provider = {
				name = "file_info",
				opts = { colored_icon = false },
			},
			hl = { fg = theme.black, bg = theme.blue },
			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = { fg = theme.blue, bg = theme.blue },
			},
		},

		git_branch = {
			provider = function()
				local git = require("feline.providers.git")
				local branch, icon = git.git_branch()
				local s
				if #branch > 0 then
					s = string.format(" %s%s ", icon, branch)
				else
					s = string.format(" %s ", "Untracked")
				end
				return s
			end,
			hl = { fg = theme.black, bg = theme.orange },

			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = { fg = theme.blue, bg = theme.black },
			},
		},

		lsp = {
			provider = function()
				if not lsp.is_lsp_attached() then
					return " 󱏎 LSP "
				end

				return string.format(" 󱁛 LSP(s): %s ", active_clients())
			end,

			hl = function()
				if not lsp.is_lsp_attached() then
					return { fg = theme.black, bg = theme.black }
				end
				return { fg = theme.black, bg = theme.purple }
			end,
		},

		git_diff = {
			git_diff_added = {
				provider = {
					name = "git_diff_added",
					opts = { colored_icon = false },
				},
				hl = {
					fg = theme.green,
					bg = theme.black,
				},
			},

			git_diff_removed = {
				provider = "git_diff_removed",
				hl = {
					fg = theme.red,
					bg = theme.black,
				},
			},

			git_diff_changed = {
				provider = "git_diff_changed",
				hl = {
					fg = theme.yellow,
					bg = theme.black,
				},
			},
		},

		vi_mode = {
			provider = function()
				return string.format("%s ", vi_mode.get_vim_mode())
			end,
			hl = function()
				return { fg = theme.black, bg = vi_mode.get_mode_color() }
			end,
			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = function()
					return { fg = vi_mode.get_mode_color(), bg = "none" }
				end,
			},
		},

		-- right
		macro = {
			provider = function()
				local s
				local recording_register = vim.fn.reg_recording()
				if #recording_register == 0 then
					s = ""
				else
					s = string.format(" Recording @%s ", recording_register)
				end
				return s
			end,
			hl = { fg = theme.black, bg = theme.black },
		},

		search_count = {
			provider = function()
				if vim.v.hlsearch == 0 then
					return ""
				end

				local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
				if not ok then
					return ""
				end
				if next(result) == nil then
					return ""
				end

				local denominator = math.min(result.total, result.maxcount)
				return string.format(" at %d of %d ", result.current, denominator)
			end,
			hl = { fg = theme.black, bg = palette.white.base },
		},

		cursor_position = {
			provider = {
				name = "position",
				opts = { padding = true },
			},
			hl = { fg = theme.black, bg = theme.blue },
			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = function()
					return { fg = theme.blue, bg = theme.black }
				end,
			},
			right_sep = {
				always_visible = true,
				str = " ",
				hl = { fg = theme.black, bg = theme.blue },
			},
		},

		scroll_bar = {
			provider = {
				name = "scroll_bar",
				opts = { reverse = true },
			},
			hl = { fg = palette.blue.dim, bg = theme.blue },
		},

		-- inactive statusline
		in_file_info = {
			provider = function()
				if vim.api.nvim_buf_get_name(0) ~= "" then
					return file.file_info({}, { colored_icon = false })
				else
					return file.file_type({}, { colored_icon = false, case = "lowercase" })
				end
			end,
			hl = { fg = theme.black, bg = theme.blue },
			left_sep = {
				always_visible = true,
				str = string.format("%s%s", separators.slant_left, separators.block),
				hl = { fg = theme.blue, bg = "none" },
			},
			right_sep = {
				always_visible = true,
				str = " ",
				hl = { fg = theme.black, bg = theme.blue },
			},
		},
	}

	local active = {
		{ -- left
			c.vim_status,
			c.vi_mode,
			c.file_name,
			c.git_branch,
			c.git_diff.git_diff_added,
			c.git_diff.git_diff_removed,
			c.git_diff.git_diff_changed,
		},
		{ -- right
			c.macro,
			c.search_count,
			c.lsp,
			c.cursor_position,
			c.scroll_bar,
		},
	}

	local inactive = {
		{ -- left
		},
		{ -- right
			c.in_file_info,
		},
	}

	opts.components = { active = active, inactive = inactive }

	feline.setup(opts)
	feline.use_theme(theme)
end

return {
	{
		"freddiehaddad/feline.nvim",
		config = config,
		dependencies = { "EdenEast/nightfox.nvim", "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
		init = function()
			-- use a global statusline
			-- vim.opt.laststatus = 3

			-- update statusbar when there's a plugin update
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyCheck",
				callback = function()
					vim.opt.statusline = vim.opt.statusline
				end,
			})

			-- hide the mode
			vim.opt.showmode = false

			-- hide search count on command line
			vim.opt.shortmess:append({ S = true })
		end,
		opts = {
			force_inactive = { filetypes = { "^dapui_*", "^help$", "^neotest*", "^NvimTree$", "^qf$" } },
			disable = { filetypes = { "^alpha$" } },
		},
	},
	{
		"rebelot/heirline.nvim",
		optional = true,
		opts = function(_, opts)
			opts.statusline = nil
		end,
	},
}

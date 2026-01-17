-- Feline statusline with dynamic theme colors
-- Uses vim highlight groups to get colors from current colorscheme

-- Helper function to get color from vim highlight group
local function get_hl_color(group, attr)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if ok and hl and hl[attr] then
		return string.format("#%06x", hl[attr])
	end
	return nil
end

-- Build theme colors from current vim colorscheme
local function get_theme_colors()
	-- For bg/black, try StatusLine or NormalFloat since Normal may be transparent
	local bar_bg = get_hl_color("StatusLine", "bg")
		or get_hl_color("NormalFloat", "bg")
		or get_hl_color("CursorLine", "bg")
		or "#000000"

	return {
		black = bar_bg,
		white = get_hl_color("Normal", "fg") or "#ffffff",
		fg = get_hl_color("Normal", "fg") or "#a0a8b7",
		bg = bar_bg,
		purple = get_hl_color("Statement", "fg") or get_hl_color("Keyword", "fg") or "#bf68d9",
		green = get_hl_color("String", "fg") or "#8ebd6b",
		orange = get_hl_color("Constant", "fg") or "#cc9057",
		blue = get_hl_color("Function", "fg") or "#4fa6ed",
		yellow = get_hl_color("Type", "fg") or "#e2b86b",
		cyan = get_hl_color("Special", "fg") or "#48b0bd",
		red = get_hl_color("DiagnosticError", "fg") or "#e55561",
		grey = get_hl_color("Comment", "fg") or "#535965",
	}
end

-- get a string of active_clients
local function active_clients()
	local clients = vim.lsp.get_clients()
	local client_string = ""
	for i, v in ipairs(clients) do
		if client_string ~= "typos_lsp" or client_string ~= "null-ls" then
			client_string = client_string .. v.name
			if i > 2 then
				client_string = client_string .. "..."
				break
			end

			if i < #clients then
				client_string = client_string .. ","
			end
		end
	end
	return client_string
end

-- configure feline
local function config(_, opts)
	local feline = require("feline")
	local vi_mode = require("feline.providers.vi_mode")
	local file = require("feline.providers.file")
	local separators = require("feline.defaults").statusline.separators.default_value
	local lsp = require("feline.providers.lsp")

	-- Get theme colors from current colorscheme
	local theme = get_theme_colors()

	local c = {

		-- left
		vim_status = {
			provider = function()
				local s
				if require("lazy.status").has_updates() then
					s = require("lazy.status").updates()
				else
					s = " "
				end
				s = string.format("  %s  ", s)
				return s
			end,

			hl = function()
				local t = get_theme_colors()
				return { fg = t.purple, bg = t.bg }
			end,
		},

		file_name = {
			provider = {
				name = "file_info",
				opts = { colored_icon = false },
			},
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = t.blue }
			end,
			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = function()
					local t = get_theme_colors()
					return { fg = t.blue, bg = t.blue }
				end,
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
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = t.orange }
			end,

			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = function()
					local t = get_theme_colors()
					return { fg = t.blue, bg = t.black }
				end,
			},
		},

		lsp = {
			provider = function()
				if not lsp.is_lsp_attached() then
					return " 󱏎 LSP "
				end

				return string.format(" %s [%s] ", require("lsp-progress").progress(), active_clients())
			end,

			hl = function()
				local t = get_theme_colors()
				if not lsp.is_lsp_attached() then
					return { fg = t.black, bg = t.black }
				end
				return { fg = t.black, bg = t.purple }
			end,

			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = function()
					local t = get_theme_colors()
					return { fg = t.black, bg = t.black }
				end,
			},
		},

		git_diff = {
			added = {
				provider = {
					name = "git_diff_added",
				},
				hl = function()
					local t = get_theme_colors()
					return { fg = t.green, bg = t.black }
				end,
			},

			removed = {
				provider = "git_diff_removed",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.red, bg = t.black }
				end,
			},

			changed = {
				provider = "git_diff_changed",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.yellow, bg = t.black }
				end,
			},
		},

		vi_mode = {
			provider = function()
				return string.format("%s ", vi_mode.get_vim_mode())
			end,
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = vi_mode.get_mode_color() }
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
		diagnostics = {
			errors = {
				provider = "diagnostic_errors",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.red, bg = t.black }
				end,
			},
			warnings = {
				provider = "diagnostic_warnings",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.yellow, bg = t.black }
				end,
			},
			hints = {
				provider = "diagnostic_hints",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.purple, bg = t.black }
				end,
			},
		},

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
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = t.black }
			end,
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
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = t.white }
			end,
		},

		cursor_position = {
			provider = {
				name = "position",
				opts = { padding = true },
			},
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = t.blue }
			end,
			left_sep = {
				always_visible = true,
				str = separators.block,
				hl = function()
					local t = get_theme_colors()
					return { fg = t.blue, bg = t.black }
				end,
			},
			right_sep = {
				always_visible = true,
				str = " ",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.black, bg = t.blue }
				end,
			},
		},

		scroll_bar = {
			provider = {
				name = "scroll_bar",
				opts = { reverse = true },
			},
			hl = function()
				local t = get_theme_colors()
				return { fg = t.yellow, bg = t.blue }
			end,
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
			hl = function()
				local t = get_theme_colors()
				return { fg = t.black, bg = t.blue }
			end,
			left_sep = {
				always_visible = true,
				str = string.format("%s%s", separators.slant_left, separators.block),
				hl = function()
					local t = get_theme_colors()
					return { fg = t.blue, bg = "none" }
				end,
			},
			right_sep = {
				always_visible = true,
				str = " ",
				hl = function()
					local t = get_theme_colors()
					return { fg = t.black, bg = t.blue }
				end,
			},
		},
	}

	local active = {
		{ -- left
			c.vim_status,
			c.vi_mode,
			c.file_name,

			c.git_branch,
			c.git_diff.added,
			c.git_diff.removed,
			c.git_diff.changed,
		},
		{ -- right
			c.diagnostics.errors,
			c.diagnostics.warnings,
			c.diagnostics.hints,
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
		"famiu/feline.nvim",
		config = config,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"linrongbin16/lsp-progress.nvim",
				opts = {
					spinner = {
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
					},
					spin_update_time = 500,
					max_size = 30,
					client_format = function(_, spinner, series_messages)
						return #series_messages > 0 and (spinner .. "  " .. table.concat(series_messages, "  ")) or "  "
					end,
					format = function(client_messages)
						local sign = " "
						if #client_messages > 0 then
							return table.concat(client_messages)
						end
						if #vim.lsp.get_clients() > 0 then
							return sign
						end
						return "󱏎 LSP"
					end,
				},
			},
		},
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

			-- update statusbar with LSP progress
			vim.api.nvim_create_augroup("feline_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "feline_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = function()
					vim.opt.statusline = vim.opt.statusline
				end,
			})

			-- Refresh feline when colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = "feline_augroup",
				callback = function()
					-- Small delay to ensure highlight groups are set
					vim.defer_fn(function()
						local ok, feline = pcall(require, "feline")
						if ok then
							feline.use_theme(get_theme_colors())
							vim.opt.statusline = vim.opt.statusline
						end
					end, 10)
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

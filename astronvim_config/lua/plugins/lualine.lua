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

local function get_config()
	local colors = get_theme_colors()

	local theme = {
		normal = {
			a = { fg = colors.black, bg = colors.blue, gui = "bold" },
			b = { fg = colors.white, bg = colors.grey },
			c = { fg = colors.fg, bg = colors.bg },
		},
		insert = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
		visual = { a = { fg = colors.black, bg = colors.purple, gui = "bold" } },
		replace = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },
		command = { a = { fg = colors.black, bg = colors.yellow, gui = "bold" } },
		inactive = {
			a = { fg = colors.white, bg = colors.black },
			b = { fg = colors.white, bg = colors.black },
			c = { fg = colors.white, bg = colors.black },
		},
	}

	return {
		options = {
			theme = theme,
			component_separators = "",
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{
					function()
						if package.loaded["lazy.status"] and require("lazy.status").has_updates() then
							return require("lazy.status").updates()
						end
						return "  "
					end,
					color = { fg = colors.purple, bg = colors.bg }, -- Match feline vim_status colors
					separator = { right = "" },
				},
				{ "mode", separator = { left = "" } },
			},
			lualine_b = {
				{
					"filename",
					file_status = true,
					symbols = { modified = "●", readonly = " ", unnamed = "[No Name]", new = " [New]" },
				},
			},
			lualine_c = {
				"branch",
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
					colored = true,
					diff_color = {
						added = { fg = colors.green },
						modified = { fg = colors.yellow },
						removed = { fg = colors.red },
					},
				},
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " " },
					diagnostics_color = {
						error = { fg = colors.red },
						warn = { fg = colors.yellow },
						info = { fg = colors.purple },
					},
				},
				{
					function()
						local recording_register = vim.fn.reg_recording()
						if recording_register == "" then
							return ""
						else
							return "Recording @" .. recording_register
						end
					end,
					color = { fg = colors.red, gui = "bold" },
				},
				{
					function()
						if vim.v.hlsearch == 0 then
							return ""
						end
						local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
						if not ok or next(result) == nil or result.total == 0 then
							return ""
						end
						return string.format("[%d/%d]", result.current, math.min(result.total, result.maxcount))
					end,
				},
				"encoding",
				"fileformat",
				"filesize",
				{
					function()
						local icon =
								require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, { default = true })
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if #clients > 0 then
							local client_names = {}
							for _, client in ipairs(clients) do
								table.insert(client_names, client.name)
							end
							return icon .. " " .. table.concat(client_names, ", ")
						end
						return ""
					end,
					color = { fg = colors.black, bg = colors.cyan },
					separator = { left = " ", right = " " },
					padding = { left = 1, right = 1 },
				},
			},
			lualine_y = { "location" },
			lualine_z = { "progress" },
		},
		extensions = { "lazy" },
	}
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- Refresh lualine when colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					-- Defer to ensure highlight groups are set
					vim.defer_fn(function()
						require("lualine").setup(get_config())
					end, 10)
				end,
			})

			require("lualine").setup(get_config())
		end,
		event = "VeryLazy",
	},
	-- Disable the default heirline
	{
		"rebelot/heirline.nvim",
		optional = true,
		opts = function(_, opts)
			opts.statusline = nil
		end,
	},
}

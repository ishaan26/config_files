-- Customize Mason

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			-- Remove emmet_ls if it exists in ensure_installed
			if opts.ensure_installed then
				opts.ensure_installed = vim.tbl_filter(function(tool)
					return tool ~= "emmet_ls" and tool ~= "emmet-ls"
				end, opts.ensure_installed)
			end
		end,
	},
}

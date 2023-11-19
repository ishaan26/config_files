local linter = require("lint")

linter.linters_by_ft = {
	markdown = { "vale" },
	bash = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

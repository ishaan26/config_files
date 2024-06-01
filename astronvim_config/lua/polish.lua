-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Themery block
-- This block will be replaced by Themery.
vim.cmd("colorscheme dracula")
vim.g.theme_id = 3
-- end themery block

-- Set up custom filetypes
vim.filetype.add({
	extension = {
		foo = "fooscript",
	},
	filename = {
		["Foofile"] = "fooscript",
	},
	pattern = {
		["~/%.config/foo/.*"] = "fooscript",
	},
})

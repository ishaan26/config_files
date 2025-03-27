return {
	"AstroNvim/astrolsp",
	---@type AstroLSPOpts
	opts = {
		mappings = {
			n = {
				-- Code Actions
				["<localleader>tp"] = { ":TypstPreviewToggle" },
			},
		},
	},
}

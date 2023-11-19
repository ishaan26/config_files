-- Set colorscheme
require("onedark").setup({
    style = "deep",
    transparent = true,
    term_colors = true,
    code_style = {
        functions = "bold",
    },
    highlights = {
        TSComment = { fg = "#6B859E" },
    },
})

require("onedark").load()

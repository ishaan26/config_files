return {
    "olimorris/onedarkpro.nvim",
    opts = {
        options = {
            highlight_inactive_windows = true,
            transparency = true,

        },
        plugins = {
            neo_tree = false,
            nvim_tree = false
        },
        highlights = {
            Comment = { italic = true },
            Directory = { bold = true },
            ErrorMsg = { italic = true, bold = true },
            Identifier = { fg = "#ABB2BF", bold = true },
            Keyword = { fg = "#49e2f5", italic = true },
            ["@variable.rust"] = { fg = "#FFFFFF", bold = true },
            ["@variable"] = { fg = "#FFFFFF", bold = true },
        },
        styles = {
            types = "bold",
            methods = "NONE",
            numbers = "NONE",
            strings = "NONE",
            comments = "italic",
            keywords = "italic",
            constants = "NONE",
            functions = "bold",
            operators = "NONE",
            variables = "NONE",
            parameters = "NONE",
            conditionals = "italic",
            virtual_text = "NONE",
        },
        options = {
            cursorline = true,
            transparency = true
        }
    },
}

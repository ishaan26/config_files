return {
    'navarasu/onedark.nvim',
    opts = {
        style = 'darker',
        transparent = true,
        colors = {
            bright_orange = "#ff8800", -- define a new color
        },
        code_style = {
            comments = 'italic',
            keywords = 'italic',
            functions = 'bold',
            strings = 'none',
            variables = 'bold',
            types = 'bold'
        },                      -- Lualine options --
        lualine = {
            transparent = true, -- lualine center bar transparency
        },
        highlights = {
            NormalFloat = { fg = "#ffffff", bg = "#000000" },
            FloatBorder = { fg = "#000000", bg = "#000000" },
        }
    },
}
-- return {
--     "olimorris/onedarkpro.nvim",
--     priority = 1000,
--     opts = {
--         options = {
--             highlight_inactive_windows = true,
--             cursorline = false,
--             transparency = true
--         },
--         plugins = {
--             neo_tree = false,
--             nvim_tree = false,
--             treesitter = false,
--         },
--         highlights = {
--             Comment = { italic = true },
--             Directory = { bold = true },
--             ErrorMsg = { italic = true, bold = true },
--         },
--         styles = {
--             types = "bold",
--             methods = "NONE",
--             numbers = "NONE",
--             strings = "NONE",
--             comments = "italic",
--             keywords = "italic",
--             constants = "NONE",
--             functions = "bold",
--             operators = "NONE",
--             variables = "NONE",
--             parameters = "bold",
--             conditionals = "italic",
--             virtual_text = "NONE",
--         },
--     },
-- }

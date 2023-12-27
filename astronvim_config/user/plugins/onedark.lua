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
            variables = 'bold'
        },                  -- Lualine options --
        lualine = {
            transparent = true, -- lualine center bar transparency
        },
    },
}
-- return {
--     "olimorris/onedarkpro.nvim",
--     opts = {
--         options = {
--             highlight_inactive_windows = true,
--             transparency = true,
--
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
--             -- Identifier = { fg = "#ABB2BF", bold = true },
--             -- Keyword = { fg = "#F844D6", italic = true },
--             ["@variable.rust"] = { fg = "#FFFFFF", bold = true },
--             ["@variable"] = { fg = "#FFFFFF", bold = true },
--         },
--         styles = {
--             types = "NONE",
--             methods = "NONE",
--             numbers = "NONE",
--             strings = "NONE",
--             comments = "italic",
--             keywords = "italic",
--             constants = "NONE",
--             functions = "bold",
--             operators = "NONE",
--             variables = "NONE",
--             parameters = "NONE",
--             conditionals = "italic",
--             virtual_text = "NONE",
--         },
--         options = {
--             cursorline = true,
--             transparency = true
--         }
--     },
-- }

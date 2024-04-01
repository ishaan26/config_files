return {
  "navarasu/onedark.nvim",
  lazy = false,
  name = "onedark",
  config = function()
    require("onedark").setup {
      style = "darker",
      transparent = true,
      colors = {
        bright_orange = "#ff8800", -- define a new color
        light_grey = "##c4c4c4",
      },
      code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "bold",
        strings = "none",
        variables = "bold",
        types = "bold",
      }, -- Lualine options --
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      -- highlights = {
      NormalFloat = { fg = "#ffffff", bg = "#000000" },
      --   FloatBorder = { fg = "#000000", bg = "#000000" },
      -- },
    }
  end,
}

return {
  "rebelot/kanagawa.nvim",
  opts = {
    compile = true, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls

    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },

    transparent = true,  -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}

    theme = "dragon",    --"wave" , "dragon", "lotus"

    overrides = function() -- add/modify highlights
      return {

        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
      }
    end,

    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
  },
}

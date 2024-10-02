return {
  "rebelot/kanagawa.nvim",
  opts = {
    undercurl = true, -- enable undercurls

    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },

    transparent = true, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}

    theme = "dragon", --"wave" , "dragon", "lotus"

    overrides = function(colors) -- add/modify highlights
      local theme = colors.theme
      return {
        NormalFloat = { bg = theme.ui.bg_m3 },
        FloatBorder = { bg = theme.ui.bg_m3 },
        FloatTitle = { bg = theme.ui.bg_m3 },

        -- Save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
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

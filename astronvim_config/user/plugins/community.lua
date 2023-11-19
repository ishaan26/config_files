return {
  "AstroNvim/astrocommunity",
  {
    import = "astrocommunity.pack.rust",
  },
  {
    import = "astrocommunity.colorscheme.nightfox-nvim",
    enabled = false,
  },
  {
    import = "astrocommunity.colorscheme.kanagawa-nvim",
    enabled = true,
  },
  {
    import = "astrocommunity.colorscheme.rose-pine",
  },
  {
    import = "astrocommunity.colorscheme.catppuccin",
  },
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      integrations = {
        sandwich = false,
        noice = true,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },
  {
    import = "astrocommunity.completion.copilot-lua",
  },
  { -- further customize the options set by the community
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C/>",
        },
      },
    },
  },
  {
    import = "astrocommunity.bars-and-lines.smartcolumn-nvim",
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = 120,
      disabled_filetypes = { "help" },
    },
  },
}

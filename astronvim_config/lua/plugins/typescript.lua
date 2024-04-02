return {
  { "jose-elias-alvarez/typescript.nvim", lazy = true }, -- add lsp plugin
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      setup_handlers = {
        -- add custom handler
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
        end,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "tsserver" }, -- automatically install lsp
    },
  },
}

return {
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.everforest_enable_italic = true
    vim.g.everforest_transparent_background = 2
    vim.g.everforest_float_style = "dim"
  end,
}


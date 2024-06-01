return {
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      transparent = true, -- Disable setting background
      styles = {         -- Style to be applied to different syntax groups
        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "italic",
        constants = "NONE",
        functions = "NONE",
        keywords = "italic",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
      },
    },
  },
}

return {
  "marko-cerovac/material.nvim",
  opts = {
    disable = {
      -- ... other settings
      background = true,
    },
    styles = { -- Give comments style such as bold, italic, underline etc.
      comments = { [[ italic = true ]] },
      strings = { [[ bold = false ]] },
      keywords = { [[ italic = true ]] },
      functions = { [[ undercurl = true ]] },
      variables = {},
      operators = {},
      types = {},
    },
  },
}

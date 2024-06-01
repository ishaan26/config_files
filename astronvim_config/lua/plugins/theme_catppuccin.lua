return {
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      flavour = "mocha",          -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
      styles = {                  -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },  -- Change the style of comments
        conditionals = {},
        loops = {},
        functions = {},
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
    },
  },
}

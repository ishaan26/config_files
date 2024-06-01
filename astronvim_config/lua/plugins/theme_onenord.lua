return {
  "rmehri01/onenord.nvim",
  opts = {
    styles = {
      comments = "italic",
      strings = "NONE",
      keywords = "italic",
      functions = "NONE",
      variables = "NONE",
      diagnostics = "underline",
    },
    disable = {
      background = true,     -- Disable setting the background color
      float_background = false, -- Disable setting the background color for floating windows
      cursorline = false,    -- Disable the cursorline
      eob_lines = true,      -- Hide the end-of-buffer lines
    },
  },
}

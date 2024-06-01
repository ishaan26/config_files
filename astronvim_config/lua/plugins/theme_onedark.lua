local vivid_colors = {
  bg = "#282c34",
  fg = "#abb2bf",
  red = "#ef596f",
  orange = "#d19a66",
  yellow = "#e5c07b",
  green = "#89ca78",
  cyan = "#2bbac5",
  blue = "#61afef",
  purple = "#d55fde",
  white = "#abb2bf",
  black = "#000000",
  gray = "#5c6370",
  highlight = "#e2be7d",
  comment = "#7f848e",
  none = "NONE",
}

return {
  "olimorris/onedarkpro.nvim",
  opts = {
    options = {
      highlight_inactive_windows = true,
      transparency = true,
    },
    highlights = {
      Comment = { italic = true, fg = vivid_colors.gray },
      Directory = { bold = true },
      ErrorMsg = { italic = true, bold = true },
      ["@variable"] = { fg = vivid_colors.white },
      NormalFloat = { bg = vivid_colors.black },
      FloatBorder = {
        bg = vivid_colors.black,
        fg = vivid_colors.gray,
      },
      NeoTreeRootFolder = { fg = vivid_colors.blue },
      NeoTreeDirectoryIcon = { fg = vivid_colors.blue },
      CursorLineNr = { fg = vivid_colors.blue },
    },
    styles = {
      keywords = "italic",
    },
  },
}

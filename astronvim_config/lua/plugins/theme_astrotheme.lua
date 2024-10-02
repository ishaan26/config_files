return {
  { -- further customize the options set by the community
    "astrotheme",
    opts = {
      palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`
      style = {
        transparent = true, -- Bool value, toggles transparency.
        inactive = false, -- Bool value, toggles inactive window color.
        float = true, -- Bool value, toggles floating windows background colors.
        neotree = false, -- Bool value, toggles neo-trees background color.
        border = true, -- Bool value, toggles borders.
        title_invert = false, -- Bool value, swaps text and background colors.
        italic_comments = true, -- Bool value, toggles italic comments.
        simple_syntax_colors = false, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
      },
      termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.
      terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.
    },
  },
}

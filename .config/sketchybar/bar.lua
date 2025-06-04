local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = true,
  height = 45,
  position = "bottom",
  color = colors.with_alpha(colors.dark_grey, 0.4),
  shadow = true,
  margin = 20,
  border_color = colors.with_alpha(colors.white, 0.2),
  border_width = 1,
  corner_radius = 8,
  padding_right = 0,
  padding_left = 15,
  blur_radius = 50,
  y_offset = 3,
})

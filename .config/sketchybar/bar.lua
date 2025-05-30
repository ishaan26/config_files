local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  height = 100,
  position = "bottom",
  color = colors.with_alpha(colors.black, 0.4),
  border_color = colors.transparent,
  border_width = 50,
  corner_radius = 9,
  padding_right = 35,
  padding_left = 35,
  blur_radius = 50,
  y_offset = -14,
})

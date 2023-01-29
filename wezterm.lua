local wezterm = require 'wezterm'
return {
  default_prog = {"wsl.exe", "--cd", "~"},
  color_scheme = "Edge Dark (base16)",
  font = wezterm.font("UDEV Gothic 35NFLG"),
  font_size = 12.0, -- フォントサイズは偶数でないと変になる
  initial_cols = 130,
  initial_rows = 37,
}

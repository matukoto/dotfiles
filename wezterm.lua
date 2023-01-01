local wezterm = require 'wezterm'
return {
  default_prog = {"wsl.exe"},
  color_scheme = "Edpresso",
  font = wezterm.font("UDEV Gothic 35NF"),
  font_size = 12.0, -- フォントサイズは偶数でないと変になる
}

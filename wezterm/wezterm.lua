local wezterm = require 'wezterm'
return {
  window_background_opacity = 0.85, -- 透過率
  default_prog = {"wsl.exe", "--cd", "~"},
  color_scheme = "Edge Dark (base16)",
  font = wezterm.font("UDEV Gothic 35NFLG"),
  font_size = 12.0, -- フォントサイズは偶数でないと変になる
  initial_cols = 130,
  initial_rows = 37,
  -- keybind ファイル読み込み
  keys = require("keybinds").keys,
  key_tables = require("keybinds").key_tables,
}

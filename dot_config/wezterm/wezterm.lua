local wezterm = require('wezterm')
local config = {
  window_background_opacity = 0.85, -- 透過率
  default_prog = { 'bash' },
  --default_prog = {"wsl.exe", "--cd", "~"},
  color_scheme = 'Edge Dark (base16)',
  font = wezterm.font('PlemolJP35 Console NF'),
  font_size = 14.0, -- フォントサイズは偶数でないと変になる
  initial_cols = 120,
  initial_rows = 37,
  -- keybind ファイル読み込み
  keys = require('keybinds').keys,
  key_tables = require('keybinds').key_tables,
  use_ime = false,
}
return config
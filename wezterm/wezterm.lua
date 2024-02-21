local wezterm = require 'wezterm'

local config = {}

config.window_background_opacity = 0.85 -- 透過率
config.color_scheme = 'Edge Dark (base16)'
config.font = wezterm.font("PlemolJP Console NF")
config.font_size = 12.0 -- フォントサイズは偶数でないと変にな
config.initial_cols = 120
config.initial_rows = 37
--config.-- keybind ファイル読み込み
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.use_ime = false

return config

local wezterm = require('wezterm')
local config = {
  window_background_opacity = 0.85, -- 透過率
  -- default_prog = { 'bash' },
  default_prog = { 'wsl.exe', '--cd', '~' },
  color_scheme = 'Edge Dark (base16)',
  font = wezterm.font('PlemolJP35 Console NF'),
  font_size = 14.0, -- フォントサイズは偶数でないと変になる
  initial_cols = 110,
  initial_rows = 37,
  -- keybind ファイル読み込み
  keys = require('keybinds').keys,
  key_tables = require('keybinds').key_tables,
  use_ime = false,
  -- タイトルバーの非表示
  window_decorations = 'RESIZE',
  -- タブバーの表示
  show_tabs_in_tab_bar = true,
  -- タブバーが1つしかない場合非表示
  hide_tab_bar_if_only_one_tab = true,
  -- タブの追加ボタンを非表示
  show_new_tab_button_in_tab_bar = false,
  -- タブのクローズボタンを非表示
  -- show_close_tab_button_in_tabs = false,
  -- タブ同士の境界線を非表示
  colors = {
    tab_bar = {
      inactive_tab_edge = 'none',
    },
  },
  -- タブバーを透過
  window_frame = {
    inactive_titlebar_bg = 'none',
    active_titlebar_bg = 'none',
  },
  -- タブの背景色と同じ色
  window_background_gradient = {
    colors = { '#000000' },
  },
  leader = { key = 'j', mods = 'ALT', timeout_milliseconds = 2000 },
}

local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({ args = { 'pwsh.exe', '-NoLogo' } })
  window:spawn_tab({ args = { 'wsl.exe', '--cd', '~' } })
end)

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_lower_left_triangle

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local background = '#5c6d74'
  local foreground = '#FFFFFF'
  local edge_background = 'none'
  if tab.is_active then
    background = '#78CDD1'
    foreground = '#000000'
    edge_background = '#78CDD1'
  end
  local edge_foreground = background
  local title = '   ' .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. '   '
  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

return config

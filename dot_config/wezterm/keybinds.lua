local wezterm = require('wezterm')
local act = wezterm.action

return {
  keys = {
    -- tab 移動
    { key = '2', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '1', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    -- tab 追加
    { key = 't', mods = 'ALT', action = act.SpawnTab('CurrentPaneDomain') },
    -- tab 閉じる
    { key = 'w', mods = 'ALT', action = act.CloseCurrentTab({ confirm = true }) },
    -- pane 移動
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection('Left') },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection('Right') },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection('Up') },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection('Down') },
    -- pane select
    {
      key = 'P',
      mods = 'SHIFT|CTRL',
      action = act.PaneSelect({ alphabet = '', mode = 'Activate' }),
    },
    -- pane close
    { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentPane({ confirm = true }) },
    -- full screen
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    -- vsplit
    {
      key = 'v',
      mods = 'ALT',
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    -- hsplit
    {
      key = 'h',
      mods = 'ALT',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    -- デフォルト設定
    { key = ')', mods = 'CTRL', action = act.ResetFontSize },
    { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = 'C', mods = 'CTRL', action = act.CopyTo('Clipboard') },
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo('Clipboard') },
    {
      key = 'F',
      mods = 'CTRL',
      action = act.Search('CurrentSelectionOrEmptyString'),
    },
    {
      key = 'F',
      mods = 'SHIFT|CTRL',
      action = act.Search('CurrentSelectionOrEmptyString'),
    },
    { key = 'K', mods = 'CTRL', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'L', mods = 'CTRL', action = act.ShowDebugOverlay },
    { key = 'L', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'M', mods = 'CTRL', action = act.Hide },
    { key = 'M', mods = 'SHIFT|CTRL', action = act.Hide },
    { key = 'N', mods = 'CTRL', action = act.SpawnWindow },
    { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'R', mods = 'CTRL', action = act.ReloadConfiguration },
    { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    {
      key = 'U',
      mods = 'CTRL',
      action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    {
      key = 'U',
      mods = 'SHIFT|CTRL',
      action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    { key = 'V', mods = 'CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'X', mods = 'CTRL', action = act.ActivateCopyMode },
    { key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'Z', mods = 'CTRL', action = act.TogglePaneZoomState },
    { key = 'Z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = '_', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo('Clipboard') },
    { key = 'c', mods = 'SUPER', action = act.CopyTo('Clipboard') },
    {
      key = 'f',
      mods = 'SHIFT|CTRL',
      action = act.Search('CurrentSelectionOrEmptyString'),
    },
    {
      key = 'f',
      mods = 'SUPER',
      action = act.Search('CurrentSelectionOrEmptyString'),
    },
    { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'k', mods = 'SUPER', action = act.ClearScrollback('ScrollbackOnly') },
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'm', mods = 'SHIFT|CTRL', action = act.Hide },
    { key = 'm', mods = 'SUPER', action = act.Hide },
    { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
    {
      key = 'u',
      mods = 'SHIFT|CTRL',
      action = act.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
    },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom('Clipboard') },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom('Clipboard') },
    { key = 'x', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom('PrimarySelection') },
    { key = 'Insert', mods = 'CTRL', action = act.CopyTo('PrimarySelection') },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo('Clipboard') },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom('Clipboard') },
  },

  key_tables = {
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode('MoveForwardWord') },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode('MoveBackwardWord') },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode('MoveToStartOfNextLine') },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
      { key = 'Space', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Cell' }) },
      { key = '$', mods = 'NONE', action = act.CopyMode('MoveToEndOfLineContent') },
      { key = '$', mods = 'SHIFT', action = act.CopyMode('MoveToEndOfLineContent') },
      { key = ',', mods = 'NONE', action = act.CopyMode('JumpReverse') },
      { key = '0', mods = 'NONE', action = act.CopyMode('MoveToStartOfLine') },
      { key = ';', mods = 'NONE', action = act.CopyMode('JumpAgain') },
      {
        key = 'F',
        mods = 'NONE',
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      {
        key = 'F',
        mods = 'SHIFT',
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      { key = 'G', mods = 'NONE', action = act.CopyMode('MoveToScrollbackBottom') },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode('MoveToScrollbackBottom') },
      { key = 'H', mods = 'NONE', action = act.CopyMode('MoveToViewportTop') },
      { key = 'H', mods = 'SHIFT', action = act.CopyMode('MoveToViewportTop') },
      { key = 'L', mods = 'NONE', action = act.CopyMode('MoveToViewportBottom') },
      { key = 'L', mods = 'SHIFT', action = act.CopyMode('MoveToViewportBottom') },
      { key = 'M', mods = 'NONE', action = act.CopyMode('MoveToViewportMiddle') },
      { key = 'M', mods = 'SHIFT', action = act.CopyMode('MoveToViewportMiddle') },
      { key = 'O', mods = 'NONE', action = act.CopyMode('MoveToSelectionOtherEndHoriz') },
      { key = 'O', mods = 'SHIFT', action = act.CopyMode('MoveToSelectionOtherEndHoriz') },
      {
        key = 'T',
        mods = 'NONE',
        action = act.CopyMode({ JumpBackward = { prev_char = true } }),
      },
      {
        key = 'T',
        mods = 'SHIFT',
        action = act.CopyMode({ JumpBackward = { prev_char = true } }),
      },
      { key = 'V', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Line' }) },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode({ SetSelectionMode = 'Line' }) },
      { key = '^', mods = 'NONE', action = act.CopyMode('MoveToStartOfLineContent') },
      { key = '^', mods = 'SHIFT', action = act.CopyMode('MoveToStartOfLineContent') },
      { key = 'b', mods = 'NONE', action = act.CopyMode('MoveBackwardWord') },
      { key = 'b', mods = 'ALT', action = act.CopyMode('MoveBackwardWord') },
      { key = 'b', mods = 'CTRL', action = act.CopyMode('PageUp') },
      { key = 'c', mods = 'CTRL', action = act.CopyMode('Close') },
      {
        key = 'f',
        mods = 'NONE',
        action = act.CopyMode({ JumpForward = { prev_char = false } }),
      },
      { key = 'f', mods = 'ALT', action = act.CopyMode('MoveForwardWord') },
      { key = 'f', mods = 'CTRL', action = act.CopyMode('PageDown') },
      { key = 'g', mods = 'NONE', action = act.CopyMode('MoveToScrollbackTop') },
      { key = 'g', mods = 'CTRL', action = act.CopyMode('Close') },
      { key = 'h', mods = 'NONE', action = act.CopyMode('MoveLeft') },
      { key = 'j', mods = 'NONE', action = act.CopyMode('MoveDown') },
      { key = 'k', mods = 'NONE', action = act.CopyMode('MoveUp') },
      { key = 'l', mods = 'NONE', action = act.CopyMode('MoveRight') },
      { key = 'm', mods = 'ALT', action = act.CopyMode('MoveToStartOfLineContent') },
      { key = 'o', mods = 'NONE', action = act.CopyMode('MoveToSelectionOtherEnd') },
      { key = 'q', mods = 'NONE', action = act.CopyMode('Close') },
      {
        key = 't',
        mods = 'NONE',
        action = act.CopyMode({ JumpForward = { prev_char = true } }),
      },
      { key = 'v', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Cell' }) },
      { key = 'v', mods = 'CTRL', action = act.CopyMode({ SetSelectionMode = 'Block' }) },
      { key = 'w', mods = 'NONE', action = act.CopyMode('MoveForwardWord') },
      {
        key = 'y',
        mods = 'NONE',
        action = act.Multiple({
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        }),
      },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode('PageUp') },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode('PageDown') },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode('MoveLeft') },
      { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode('MoveBackwardWord') },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode('MoveRight') },
      { key = 'RightArrow', mods = 'ALT', action = act.CopyMode('MoveForwardWord') },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode('MoveUp') },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode('MoveDown') },
    },

    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode('PriorMatch') },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
      { key = 'n', mods = 'CTRL', action = act.CopyMode('NextMatch') },
      { key = 'p', mods = 'CTRL', action = act.CopyMode('PriorMatch') },
      { key = 'r', mods = 'CTRL', action = act.CopyMode('CycleMatchType') },
      { key = 'u', mods = 'CTRL', action = act.CopyMode('ClearPattern') },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode('PriorMatchPage') },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode('NextMatchPage') },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode('PriorMatch') },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode('NextMatch') },
    },
  },
}
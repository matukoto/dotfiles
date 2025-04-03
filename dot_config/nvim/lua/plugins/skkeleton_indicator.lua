-- dot_config/nvim/lua/plugins/skkeleton_indicator.lua
-- Indicator for skkeleton input method status
return {
  'delphinus/skkeleton_indicator.nvim',
  -- Dependencies: Requires skkeleton
  dependencies = { 'vim-skk/skkeleton' },
  -- Load when skkeleton is potentially active or UI is ready
  event = "VeryLazy",
  -- opts table passes configuration directly to setup()
  opts = {
    -- Highlight group names for different modes
    eijiHlName = 'SkkeletonIndicatorEiji',
    hiraHlName = 'SkkeletonIndicatorHira',
    kataHlName = 'SkkeletonIndicatorKata',
    hankataHlName = 'SkkeletonIndicatorHankata',
    zenkakuHlName = 'SkkeletonIndicatorZenkaku',
    abbrevHlName = 'SkkeletonIndicatorAbbrev',
    -- Text displayed for each mode
    eijiText = 'A',
    hiraText = 'あ',
    kataText = 'ア',
    hankataText = 'ｶﾅ',
    zenkakuText = 'ＡＺ',
    abbrevText = 'abbr',
    -- Indicator window settings
    -- border = 'rounded', -- Optional border
    row = 1, -- Position row (relative to bottom)
    col = 0, -- Position column (relative to left)
    zindex = nil, -- Stacking order (nil for default)
    alwaysShown = false, -- Show only when skkeleton is active
    fadeOutMs = 0, -- No fade out effect
    ignoreFt = {}, -- Filetypes to ignore
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    -- Define highlight groups before setup if they don't exist
    -- Example: vim.api.nvim_set_hl(0, 'SkkeletonIndicatorHira', { fg = 'green' })
    require('skkeleton_indicator').setup(opts)
  end,
}

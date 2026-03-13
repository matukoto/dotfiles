-- dot_config/nvim/lua/plugins/skkeleton_indicator.lua
-- Indicator for skkeleton input method status
local skipped_filetypes = {
  sidekick_terminal = true,
}

local function build_buf_filter()
  local disabled_buffers = {}
  local group = vim.api.nvim_create_augroup('skkeletonIndicatorBufFilter', { clear = true })

  local function refresh(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
      disabled_buffers[buf] = nil
      return
    end

    if skipped_filetypes[vim.bo[buf].filetype] then
      disabled_buffers[buf] = true
    else
      disabled_buffers[buf] = nil
    end
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    refresh(buf)
  end

  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType', 'TermOpen' }, {
    group = group,
    callback = function(args)
      refresh(args.buf)
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
    group = group,
    callback = function(args)
      disabled_buffers[args.buf] = nil
    end,
  })

  return function(buf)
    return not disabled_buffers[buf]
  end
end

return {
  'delphinus/skkeleton_indicator.nvim',
  -- Dependencies: Requires skkeleton
  dependencies = { 'vim-skk/skkeleton' },
  -- Load when skkeleton is potentially active or UI is ready
  event = 'VeryLazy',
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
    zindex = 210, -- Sidekick composer のような浮動ウィンドウより前面に出す
    alwaysShown = false, -- Show only when skkeleton is active
    fadeOutMs = 0, -- No fade out effect
    ignoreFt = {}, -- Filetypes to ignore
    bufFilter = build_buf_filter(),
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    -- Define highlight groups before setup if they don't exist
    -- Example: vim.api.nvim_set_hl(0, 'SkkeletonIndicatorHira', { fg = 'green' })
    require('skkeleton_indicator').setup(opts)
  end,
}

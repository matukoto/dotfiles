-- dot_config/nvim/lua/plugins/nvim-lastplace.lua
-- Remembers the last cursor position of closed buffers
return {
  'ethanholz/nvim-lastplace',
  -- Load very early to capture buffer close events correctly
  event = "BufReadPre",
  -- opts table passes configuration directly to setup()
  opts = {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" }, -- Corrected 'quicfix'
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }, -- Added other VCS types
    lastplace_open_folds = true, -- Reopen folds when jumping to last position
    -- lastplace_cursor_position = "auto", -- "auto", "start", "end"
    -- lastplace_create_marks = true, -- Create marks for last places
    -- lastplace_mark_name = '"', -- Mark name to use
    -- lastplace_search_pattern = nil, -- Pattern to search for instead of line number
    -- lastplace_search_direction = "forward", -- "forward", "backward"
  },
  -- No explicit config or keys needed if opts handles everything
  -- config = function(_, opts)
  --   require('nvim-lastplace').setup(opts)
  -- end,
}

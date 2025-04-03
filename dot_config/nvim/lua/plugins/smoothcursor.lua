-- dot_config/nvim/lua/plugins/smoothcursor.lua
-- Smooth cursor movement animations
return {
  'gen740/SmoothCursor.nvim',
  -- Load very early or on demand
  event = "VeryLazy",
  -- opts table passes configuration directly to setup()
  opts = {
    -- type = "default", -- "default" | "exp" (experimental)
    -- fancy = { enable = true, head = { cursor = "▷", texthl = "SmoothCursor" } },
    -- speed = 20,
    -- update_interval = 30,
    -- priority = 10,
    -- disabled_filetypes = { "NvimTree", "neo-tree" },
    -- disable_float_win = false,
    -- disable_terminal = false,
    -- threshold = 3,
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    require('smoothcursor').setup(opts)
  end,
}

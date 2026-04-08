-- dot_config/nvim/lua/plugins/full_visual_line.lua
-- Makes visual line selection ('V') select the entire line content
return {
  '0xAdk/full_visual_line.nvim',
  -- Load when entering visual mode or specific events
  event = 'VeryLazy',
  -- No specific opts needed for default setup
  opts = {},
  -- config function ensures setup is called after loading
  config = function(_, opts)
    require('full_visual_line').setup(opts)
  end,
}

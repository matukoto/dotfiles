-- dot_config/nvim/lua/plugins/dmacro.lua
-- Configuration for dmacro.nvim - Enhanced macro recording/playback
return {
  'tani/dmacro.nvim',
  -- Load lazily, triggered by keymaps or commands
  cmd = { 'DmacroStart', 'DmacroStop', 'DmacroToggle', 'DmacroPlay' },
  event = 'VeryLazy',
  -- No opts needed
  -- Define keymaps using the 'keys' table
  keys = {
    -- Play macro mapping from original config
    { '<C-y>', '<Plug>(dmacro-play-macro)', mode = { 'i', 'n' }, desc = 'Play Macro (dmacro)' },
    -- Add other dmacro keymaps if desired
    -- { "q", "<cmd>DmacroToggle<cr>", mode = "n", desc = "Toggle Macro Recording" },
    -- { "@", "<cmd>DmacroPlay<cr>", mode = "n", desc = "Play Macro" }, -- Example, might conflict
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('dmacro').setup(opts) -- dmacro doesn't have a setup function
  --   -- Keymaps could also be defined here
  -- end,
}

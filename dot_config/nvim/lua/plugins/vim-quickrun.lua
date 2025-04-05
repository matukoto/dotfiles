-- dot_config/nvim/lua/plugins/vim-quickrun.lua
-- Configuration for thinca/vim-quickrun
return {
  'thinca/vim-quickrun',
  -- Load lazily, triggered by command or keymap
  cmd = { 'QuickRun' },
  event = 'VeryLazy',
  -- No opts needed
  -- config function to define command abbreviation
  config = function()
    -- Define command abbreviation 'qr' for 'QuickRun'
    vim.cmd('cabbrev qr QuickRun')
    -- Add keymaps if desired
    -- vim.keymap.set('n', '<leader>qr', '<cmd>QuickRun<cr>', { desc = "Quick Run" })
  end,
}

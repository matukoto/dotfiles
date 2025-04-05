-- dot_config/nvim/lua/plugins/vim-cheatsheet.lua
-- Configuration for reireias/vim-cheatsheet
return {
  'reireias/vim-cheatsheet',
  -- Load lazily, triggered by command or keymap
  cmd = { 'Cheatsheet' },
  event = 'VeryLazy',
  -- init function to set global variables before loading
  init = function()
    -- Set the path to the cheat sheet file
    -- Note: $HOME might not expand correctly here, use vim.fn.expand
    vim.g['cheatsheet#cheat_file'] = vim.fn.expand('$HOME/dotfiles/vim/cheatSheet/default.md')
    -- Enable floating window
    vim.g['cheatsheet#float_window'] = 1
    -- Set floating window width ratio
    vim.g['cheatsheet#float_window_width_ratio'] = 0.6
    -- Set floating window height ratio
    vim.g['cheatsheet#float_window_height_ratio'] = 0.5
  end,
  -- No opts or config needed
  -- Define keymaps if needed
  -- keys = {
  --   { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Open Cheatsheet" },
  -- },
}

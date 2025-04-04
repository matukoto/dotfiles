-- dot_config/nvim/lua/plugins/yazi.lua
-- Integration with the yazi terminal file manager
return {
  'mikavilpas/yazi.nvim',
  -- Dependencies: plenary is often needed
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- Load lazily, triggered by command or keymap
  cmd = { 'Yazi' },
  event = 'VeryLazy',
  -- opts table passes configuration directly to setup()
  opts = {
    -- Keymaps within the yazi buffer
    keymaps = {
      show_help = '<f1>',
      open_file_in_vertical_split = '<c-v>',
      open_file_in_horizontal_split = '<c-l>', -- Note: <C-h> might conflict
      open_file_in_tab = '<c-t>',
      grep_in_directory = '<c-s>',
      replace_in_directory = '<c-g>',
      cycle_open_buffers = '<tab>',
      copy_relative_path_to_selected_files = '<c-y>',
      send_to_quickfix_list = '<c-q>',
      change_working_directory = '<c-\\>',
      -- Add other yazi keymaps if needed
    },
    -- Other yazi.nvim options
    -- open_for_directories = true, -- Open yazi when opening a directory
    -- use_ya_for_sync = false, -- Use 'ya' command for syncing (requires yazi >= 0.2.2)
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    {
      '<leader>y',
      function()
        -- Ensure yazi is loaded before calling
        local ok, yazi = pcall(require, 'yazi')
        if ok then
          yazi.yazi()
        end
      end,
      desc = 'Open Yazi File Manager',
    },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('yazi').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

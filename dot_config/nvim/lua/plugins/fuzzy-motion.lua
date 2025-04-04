-- dot_config/nvim/lua/plugins/fuzzy-motion.lua
-- Configuration for fuzzy-motion.vim
return {
  'yuki-yano/fuzzy-motion.vim',
  -- Dependencies: Requires a matcher like fzf or kensaku
  dependencies = {
    -- 'junegunn/fzf', -- If using fzf matcher
    'lambdalisue/vim-kensaku', -- If using kensaku matcher
  },
  -- Load lazily, triggered by keymap or command
  cmd = { "FuzzyMotion" },
  event = "VeryLazy",
  -- init function to set global variables before loading
  init = function()
    -- Set the preferred matchers
    vim.g.fuzzy_motion_matchers = { 'fzf', 'kensaku' }
    -- Add other global settings if needed
  end,
  -- Define global keymaps using the 'keys' table
  keys = {
    { "<C-f>", "<cmd>FuzzyMotion<CR>", mode = "n", desc = "Fuzzy Motion Jump" },
    -- Add other keymaps if desired
  },
  -- No specific opts or config needed as configuration is done via globals and keymaps
  opts = {},
}

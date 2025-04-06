-- dot_config/nvim/lua/plugins/todo-comments.lua
-- Highlight and search for TODO comments
return {
  'folke/todo-comments.nvim',
  -- Load lazily, triggered by commands or events
  cmd = { 'TodoTrouble' },
  event = { 'BufReadPost', 'BufNewFile' },
  -- opts table passes configuration directly to setup()
  opts = {
    -- signs = true, -- Show signs in the signcolumn
    -- sign_priority = 8, -- Sign priority
    -- keywords = { ... }, -- Customize TODO keywords
    -- merge_keywords = true, -- Merge custom keywords with defaults
    -- highlight = { ... }, -- Customize highlighting
    -- colors = { ... }, -- Customize colors
    search = {
      command = 'rg', -- Use ripgrep for searching
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      -- Regex pattern for searching TODO comments
      -- pattern = [[\b(KEYWORDS):]], -- Example pattern
    },
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = 'Todo',
    },
    -- {
    --   '<leader>sT',
    --   function()
    --     Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
    --   end,
    --   desc = 'Todo/Fix/Fixme',
    -- },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('todo-comments').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

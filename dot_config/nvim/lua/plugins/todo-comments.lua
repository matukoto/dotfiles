-- dot_config/nvim/lua/plugins/todo-comments.lua
-- Highlight and search for TODO comments
return {
  'folke/todo-comments.nvim',
  -- Dependencies: Telescope for searching
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  -- Load lazily, triggered by commands or events
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  -- opts table passes configuration directly to setup()
  opts = {
    -- signs = true, -- Show signs in the signcolumn
    -- sign_priority = 8, -- Sign priority
    -- keywords = { ... }, -- Customize TODO keywords
    -- merge_keywords = true, -- Merge custom keywords with defaults
    -- highlight = { ... }, -- Customize highlighting
    -- colors = { ... }, -- Customize colors
    search = {
      command = "rg", -- Use ripgrep for searching
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- Regex pattern for searching TODO comments
      -- pattern = [[\b(KEYWORDS):]], -- Example pattern
    },
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      "]t", -- Jump to next TODO comment
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next TODO Comment",
    },
    {
      "[t", -- Jump to previous TODO comment
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous TODO Comment",
    },
    {
      "<leader>st", -- Search TODO comments with Telescope
      "<cmd>TodoTelescope<cr>",
      desc = "Search TODOs (Telescope)",
    },
    -- Optional: Integrate with trouble.nvim
    -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs in Trouble" },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('todo-comments').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

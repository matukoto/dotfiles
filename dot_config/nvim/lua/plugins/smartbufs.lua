-- dot_config/nvim/lua/plugins/smartbufs.lua
-- Smart buffer management (cycling, closing)
return {
  'johann2357/nvim-smartbufs',
  -- Dependencies: Needs bufdelete.nvim for the <C-w> mapping
  dependencies = { 'famiu/bufdelete.nvim' },
  -- Load lazily, triggered by keymaps
  event = "VeryLazy",
  -- No specific opts needed for default setup
  opts = {},
  -- Define keymaps using the 'keys' table
  keys = {
    {
      "<C-l>", -- Go to next buffer
      function()
        -- Use pcall for safety in keymaps
        local ok, smartbufs = pcall(require, "nvim-smartbufs")
        if ok then smartbufs.goto_next_buffer() end
      end,
      desc = "Next Buffer (Smartbufs)",
    },
    {
      "<C-h>", -- Go to previous buffer
      function()
        local ok, smartbufs = pcall(require, "nvim-smartbufs")
        if ok then smartbufs.goto_prev_buffer() end
      end,
      desc = "Previous Buffer (Smartbufs)",
    },
    {
      "<C-w>", -- Close current buffer using Bdelete
      "<cmd>Bdelete<CR>",
      mode = "n", -- Only in normal mode
      nowait = true, -- Don't wait for confirmation
      desc = "Close Buffer (Bdelete)",
    },
  },
  -- No explicit config function needed
  -- config = function(_, opts)
  --   -- nvim-smartbufs doesn't have a setup function
  --   -- Keymaps could also be defined here
  -- end,
}

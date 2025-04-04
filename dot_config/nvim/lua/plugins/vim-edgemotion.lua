-- dot_config/nvim/lua/plugins/vim-edgemotion.lua
-- Configuration for haya14busa/vim-edgemotion
return {
  'haya14busa/vim-edgemotion',
  -- Load lazily, triggered by keymaps
  event = "VeryLazy",
  -- Define keymaps using the 'keys' table
  keys = {
    { "<C-j>", "<Plug>(edgemotion-j)", mode = "n", desc = "Move Down (EdgeMotion)" },
    { "<C-k>", "<Plug>(edgemotion-k)", mode = "n", desc = "Move Up (EdgeMotion)" },
    -- Add other modes (visual, operator-pending) if needed
    -- { "<C-j>", "<Plug>(edgemotion-j)", mode = "v", desc = "Move Down (EdgeMotion Visual)" },
    -- { "<C-k>", "<Plug>(edgemotion-k)", mode = "v", desc = "Move Up (EdgeMotion Visual)" },
  },
  -- No specific opts or config needed for default behavior
  opts = {},
}

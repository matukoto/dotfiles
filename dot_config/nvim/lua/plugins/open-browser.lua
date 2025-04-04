-- dot_config/nvim/lua/plugins/open-browser.lua
-- Configuration for tyru/open-browser.vim
return {
  'tyru/open-browser.vim',
  -- Load lazily, triggered by keymaps
  event = "VeryLazy",
  -- init function to set global variables before loading
  init = function()
    -- Disable netrw's default gx mapping
    vim.g.netrw_nogx = 1
  end,
  -- Define keymaps using the 'keys' table
  keys = {
    { "gx", "<Plug>(openbrowser-smart-search)", mode = "n", desc = "Open URL/Search (Normal)" },
    { "gx", "<Plug>(openbrowser-smart-search)", mode = "v", desc = "Open URL/Search (Visual)" },
  },
  -- No specific opts or config needed
  opts = {},
}

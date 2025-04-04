-- dot_config/nvim/lua/plugins/vim-dadbod-ui.lua
-- Configuration for vim-dadbod-ui
return {
  'kristijanhusak/vim-dadbod-ui',
  -- Dependencies: Requires vim-dadbod
  dependencies = { 'tpope/vim-dadbod' },
  -- Load lazily, triggered by commands or keymaps
  cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUIDeleteBuffer", "DBUISaveQuery", "DBUILastQueryInfo" },
  event = "VeryLazy",
  -- init function to set global variables before loading
  init = function()
    -- Set the location for saved queries
    -- Note: Use vim.fn.expand to handle ~ correctly
    vim.g.db_ui_save_location = vim.fn.expand('~/.config/vim/dadbod-ui') -- Adjust path if needed
    -- Add other global settings if needed
    -- vim.g.db_ui_use_nerd_fonts = 1
    -- vim.g.db_ui_winwidth = 30
  end,
  -- Define global keymaps using the 'keys' table
  keys = {
    { "<Leader>w", "<Plug>(DBUI_SaveQuery)", mode = "n", desc = "DBUI Save Query" },
    -- Add other keymaps if desired
    -- { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
  },
  -- No opts needed
}

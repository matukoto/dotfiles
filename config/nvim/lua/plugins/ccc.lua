-- dot_config/nvim/lua/plugins/ccc.lua
return {
  'uga-rosa/ccc.nvim',
  -- Load lazily, perhaps on specific filetypes or commands
  event = 'VeryLazy',
  cmd = { 'CccPick', 'CccConvert', 'CccHighlighterToggle' },
  -- init function runs before the plugin is loaded
  init = function()
    -- Enable TrueColor support, essential for ccc.nvim
    vim.opt.termguicolors = true
  end,
  -- opts table passes configuration directly to setup()
  opts = {
    -- Color highlighter settings
    highlighter = {
      auto_enable = true, -- Automatically enable highlighter on buffer open
      lsp = true, -- Use LSP color information for highlighting
      -- Other highlighter options can be added here if needed
      -- e.g., style = "foreground" | "background" | "sign"
    },
    -- Other ccc options can be configured here
    -- e.g., picker = { ... }, converter = { ... }
  },
  -- Define keymaps using the 'keys' table
  keys = {
    { '<leader>ccp', '<cmd>CccPick<cr>', desc = 'Color Picker' },
    { '<leader>ccc', '<cmd>CccConvert<cr>', desc = 'Convert Color Format' },
    { '<leader>cct', '<cmd>CccHighlighterToggle<cr>', desc = 'Toggle Color Highlight' },
  },
  -- No explicit config function needed if init, opts, and keys are sufficient
  -- config = function(_, opts)
  --   require('ccc').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

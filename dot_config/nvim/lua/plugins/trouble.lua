-- dot_config/nvim/lua/plugins/trouble.lua
return {
  "folke/trouble.nvim",
  -- Dependencies like nvim-web-devicons are usually handled if listed elsewhere
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- opts can be used to pass configuration options to setup()
  opts = {
    -- Your custom configuration goes here
    -- Example: use_diagnostic_signs = true,
    -- Since the original config was just setup(), we leave opts empty or use defaults.
    -- Refer to trouble.nvim documentation for available options.
    auto_open = false, -- Don't automatically open trouble
    auto_close = false, -- Don't automatically close trouble
    auto_preview = true,
    auto_fold = false,
    signs = {
        -- icons / text used for diagnostics
        error = "",
        warning = "",
        hint = "󱩎",
        information = "",
        other = "",
    },
    -- use_diagnostic_signs = true, -- Use symbols defined in vim.diagnostic.config instead
  },
  -- Define keymaps using the 'keys' table
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
    { "<leader>xt", "<cmd>TroubleToggle todo<cr>", desc = "Todo Comments" }, -- If todo-comments.nvim is used
    { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References" }, -- Note: gR might conflict with other mappings
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require("trouble").setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

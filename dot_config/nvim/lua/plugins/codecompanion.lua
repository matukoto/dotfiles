-- dot_config/nvim/lua/plugins/codecompanion.lua
return {
  'olimorris/codecompanion.nvim',
  -- Dependencies: Needs the adapter plugin (copilot.lua in this case)
  dependencies = {
    'zbirenbaum/copilot.lua',
    'nvim-lua/plenary.nvim', -- Often a dependency
    'nvim-telescope/telescope.nvim', -- For default picker
  },
  -- Load lazily, triggered by commands or keymaps
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionInline" },
  event = "VeryLazy",
  -- opts table passes configuration directly to setup()
  -- Note: The original config had setup({ opts = { ... } }),
  -- so we use the inner table directly as lazy.nvim's opts.
  opts = {
    log_level = 'DEBUG', -- Or 'INFO', 'WARN', 'ERROR'
    strategies = {
      chat = {
        adapter = 'copilot', -- Use the copilot adapter for chat
        -- strategy = 'replace', -- Default strategy
      },
      inline = {
        adapter = 'copilot', -- Use the copilot adapter for inline actions
        -- strategy = 'replace', -- Default strategy
      },
    },
    adapters = {
      -- Configure the copilot adapter
      copilot = function()
        -- Extend the default copilot adapter settings
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              -- Specify the default model to use (if supported by the adapter)
              default = 'claude-3.7-sonnet', -- Or other models like 'gpt-4', etc.
            },
            -- Add other schema overrides if needed
          },
          -- Add other adapter overrides if needed
          -- e.g., request_opts = { timeout = 30000 }
        })
      end,
      -- Configure other adapters like 'openai', 'ollama' if needed
      -- openai = function() ... end,
    },
    -- Configure pickers, actions, etc. if needed
    -- picker = { ... },
    -- actions = { ... },
    -- quick_actions = { ... },
  },
  -- Define keymaps using the 'keys' table for discoverability
  keys = {
     { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
     { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
     { "<leader>ci", "<cmd>CodeCompanionInline<cr>", desc = "CodeCompanion Inline" },
     -- Add visual mode mappings if desired
     { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = "v", desc = "CodeCompanion Actions (Visual)" },
     { "<leader>cc", "<cmd>CodeCompanionChat<cr>", mode = "v", desc = "CodeCompanion Chat (Visual)" },
     { "<leader>ci", "<cmd>CodeCompanionInline<cr>", mode = "v", desc = "CodeCompanion Inline (Visual)" },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('codecompanion').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

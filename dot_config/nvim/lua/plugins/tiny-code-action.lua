-- dot_config/nvim/lua/plugins/tiny-code-action.lua
-- Minimalist code action UI
return {
  'rachartier/tiny-code-action.nvim',
  -- Dependencies: Telescope for the picker UI
  dependencies = { 'nvim-telescope/telescope.nvim' },
  -- Load when LSP attaches or the command/keymap is used
  event = "LspAttach",
  cmd = { "TinyCodeAction" },
  -- opts table passes configuration directly to setup()
  opts = {
    backend = 'delta', -- Use 'delta' for diff view (ensure delta is installed)
    backend_opts = {
      delta = {
        header_lines_to_remove = 4,
        args = { '--line-numbers' }, -- Arguments for delta
        -- args = { "--config", vim.fn.expand("~/.config/delta/config.yml") }, -- Example custom config
      },
      -- difftastic = { ... }, -- Configure if using difftastic backend
    },
    -- Telescope picker options
    telescope_opts = {
      layout_strategy = 'vertical',
      layout_config = {
        width = 0.7,
        height = 0.9,
        preview_cutoff = 1,
        preview_height = function(_, _, max_lines)
          local h = math.floor(max_lines * 0.5)
          return math.max(h, 10) -- Ensure minimum height
        end,
      },
      -- Add other telescope options if needed
      -- border = true,
      -- borderchars = { ... },
    },
    -- Icons for different code action kinds
    signs = {
      quickfix = { '󰁨', { link = 'DiagnosticInfo' } },
      others = { '?', { link = 'DiagnosticWarning' } },
      refactor = { '', { link = 'DiagnosticWarning' } },
      ['refactor.move'] = { '󰪹', { link = 'DiagnosticInfo' } },
      ['refactor.extract'] = { '', { link = 'DiagnosticError' } },
      ['source.organizeImports'] = { '', { link = 'TelescopeResultVariable' } },
      ['source.fixAll'] = { '', { link = 'TelescopeResultVariable' } },
      ['source'] = { '', { link = 'DiagnosticError' } },
      ['rename'] = { '󰑕', { link = 'DiagnosticWarning' } },
      ['codeAction'] = { '', { link = 'DiagnosticError' } },
      -- Add more kinds if needed
    },
    -- Other tiny-code-action options
    -- filter = function(action) return true end,
    -- sort = function(a, b) return a.kind < b.kind end,
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      "<leader>ca", -- Original keymap
      function()
        -- Ensure the plugin is loaded before calling
        local ok, tca = pcall(require, "tiny-code-action")
        if ok then tca.code_action() end
      end,
      mode = {"n", "v"}, -- Normal and Visual mode
      desc = "Code Action (Tiny)",
    },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('tiny-code-action').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}

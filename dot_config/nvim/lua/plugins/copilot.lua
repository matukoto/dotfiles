-- dot_config/nvim/lua/plugins/copilot.lua
return {
  'zbirenbaum/copilot.lua',
  -- Load when entering insert mode or specific commands are used
  event = "InsertEnter",
  cmd = { "Copilot", "CopilotAuth", "CopilotPanel", "CopilotSuggestion" },
  -- opts table passes configuration directly to setup()
  opts = {
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = '[[',
        jump_next = ']]',
        accept = '<CR>',
        refresh = 'gr',
        open = '<M-CR>', -- M stands for Alt
      },
      layout = {
        position = 'bottom', -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 75,
      keymap = {
        accept = '<Tab>', -- Use Tab to accept suggestion
        accept_word = false,
        accept_line = false,
        next = '<M-]>', -- Alt + ]
        prev = '<M-[>', -- Alt + [
        dismiss = '<C-]>', -- Ctrl + ]
      },
    },
    filetypes = {
      yaml = false,
      markdown = true,
      help = false,
      gitcommit = true,
      gitrebase = false,
      hgcommit = false,
      svn = false, -- Added svn just in case
      cvs = false,
      -- Disable for specific languages where it might interfere or isn't needed
      java = false,
      svelte = false,
      typescript = false,
      -- Default for unspecified filetypes
      ['*'] = false, -- Default to disabled unless explicitly enabled above
      -- Example: Enable for Lua
      lua = true,
      python = true, -- Example: Enable for Python
    },
    copilot_node_command = 'node', -- Ensure Node.js v18+ is in PATH
    server_opts_overrides = {
      -- Example override:
      -- trace = "verbose",
    },
  },
  -- config function to define commands after setup
  config = function(_, opts)
    require('copilot').setup(opts)
    -- Define command abbreviations after setup
    vim.cmd('cabbrev ce <Cmd>Copilot enable<CR>')
    vim.cmd('cabbrev cd <Cmd>Copilot disable<CR>')
  end,
}

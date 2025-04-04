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
        accept = '<Tab>',      -- サジェストを確定（Tab）
        accept_word = false,   -- 単語単位での確定を無効化
        accept_line = false,   -- 行単位での確定を無効化
        next = '<M-]>',       -- 次のサジェストに移動（Alt+]）
        prev = '<M-[>',       -- 前のサジェストに移動（Alt+[）
        dismiss = '<C-]>',     -- サジェストを閉じる（Ctrl+]）
        -- expand = '<C-Space>', -- Vim script設定から追加 (copilot#expand() は直接呼べないため、代替手段が必要か確認)
      },
    },
    -- filetypes from copilot.vim (empty in this case, but merging logic shown)
    -- Merge with existing filetypes, Vim script settings take precedence if defined
    filetypes = vim.tbl_deep_extend("force", {
      yaml = false,
      markdown = true,
      help = false,
      gitcommit = true,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      java = false,
      svelte = false,
      typescript = false,
      ['*'] = false,
      lua = true,
      python = true,
    }, vim.g.copilot_filetypes or {}), -- Merge with vim.g.copilot_filetypes if it exists
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

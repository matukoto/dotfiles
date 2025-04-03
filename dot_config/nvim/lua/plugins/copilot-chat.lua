-- dot_config/nvim/lua/plugins/copilot-chat.lua
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main', -- Or specify a release tag if preferred
  -- Dependencies: copilot.lua should be loaded, telescope is needed for the custom prompt action
  dependencies = {
    'zbirenbaum/copilot.lua', -- Ensure copilot core is loaded
    'nvim-lua/plenary.nvim', -- Often a dependency for telescope integrations
    'nvim-telescope/telescope.nvim', -- Needed for the custom prompt picker
  },
  -- Load lazily, triggered by commands or keymaps
  cmd = { "CopilotChat", "CopilotChatBuffer", "CopilotChatExplain", "CopilotChatReview", "CopilotChatFix", "CopilotChatOptimize", "CopilotChatDocs", "CopilotChatTests", "CopilotChatFixDiagnostic" },
  event = "VeryLazy",
  opts = {
    debug = false, -- Disable debug logging

    -- Default selection behavior (visual or line)
    -- selection = function(source)
    --   local select = require("CopilotChat.select")
    --   return select.visual(source) or select.line(source)
    -- end,

    -- Prompt presets
    prompts = {
      Explain = {
        prompt = '/COPILOT_EXPLAIN 選択されたコードの説明を段落をつけて書いてください。',
      },
      Review = {
        prompt = '/COPILOT_REVIEW 選択されたコードをレビューしてください。',
        -- callback = function(response, source) ... end,
      },
      Fix = {
        prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。',
      },
      Optimize = {
        prompt = '/COPILOT_REFACTOR 選択されたコードを最適化してパフォーマンスと可読性を向上させてください。',
      },
      Docs = {
        prompt = '/COPILOT_DOCS 選択されたコードに対してドキュメンテーションコメントを追加してください。',
      },
      Tests = {
        prompt = '/COPILOT_TESTS 選択されたコードの詳細な単体テスト関数を書いてください。',
      },
      FixDiagnostic = {
        prompt = 'ファイル内の次のような診断上の問題を解決してください:',
        -- selection function needs to be required within the config or globally accessible
        -- selection = require('CopilotChat.select').diagnostics, -- This might error if called before setup
      },
    },

    -- Chat window settings
    window = {
      layout = 'float',
      relative = 'editor',
      -- width = 0.5,
      -- height = 0.7,
      -- border = 'single',
      -- title = 'Copilot Chat',
    },

    -- Key mappings within the chat window
    mappings = {
      complete = {
        detail = 'Use @<Tab> or /<Tab> for options.',
        insert = '<Tab>',
      },
      close = {
        normal = 'q',
        insert = '<C-c>',
      },
      reset = {
        normal = '<C-l>',
        insert = '<C-l>',
      },
      submit_prompt = {
        normal = '<CR>',
        insert = '<C-m>',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
      yank_diff = {
        normal = 'gy',
      },
      show_diff = {
        normal = 'gd',
      },
      -- view_diff = { normal = '<C-d>' }, -- Example: Add mapping if needed
    },
  },
  config = function(_, opts)
    -- Need to require select functions here or make them available globally
    local select = require('CopilotChat.select')
    -- Update the FixDiagnostic prompt selection here after require
    if opts.prompts and opts.prompts.FixDiagnostic then
        opts.prompts.FixDiagnostic.selection = select.diagnostics
    end

    -- Call the setup function
    require('CopilotChat').setup(opts)

    -- Define custom functions globally or within this scope
    -- Make them global if called directly from keymaps outside this config
    _G.ShowCopilotChatActionPrompt = function()
      -- Ensure telescope is loaded before picking
      local ok, telescope = pcall(require, 'CopilotChat.integrations.telescope')
      if ok then
        local actions = require('CopilotChat.actions')
        telescope.pick(actions.prompt_actions())
      else
        vim.notify("Telescope integration for CopilotChat not found.", vim.log.levels.WARN)
      end
    end

    _G.CopilotChatBuffer = function()
      local input = vim.fn.input('Quick Chat (Buffer): ')
      if input ~= nil and input ~= '' then -- Check for nil in case user cancels
        require('CopilotChat').ask(input, { selection = select.buffer })
      end
    end

    -- Define keymaps after setup and function definitions
    vim.keymap.set('n', '<leader>cp', '<cmd>lua _G.ShowCopilotChatActionPrompt()<cr>', { noremap = true, silent = true, desc = "CopilotChat Actions" })
    vim.keymap.set('n', '<leader>cq', '<cmd>lua _G.CopilotChatBuffer()<cr>', { noremap = true, silent = true, desc = "CopilotChat Quick (Buffer)" })
    -- Add visual mode mapping if needed
    -- vim.keymap.set('v', '<leader>cp', '<cmd>lua _G.ShowCopilotChatActionPrompt()<cr>', { noremap = true, silent = true, desc = "CopilotChat Actions (Visual)" })

  end,
}

local select = require('CopilotChat.select')

require('CopilotChat').setup({
  debug = false, -- Enable debug logging

  -- default selection (visual or line)
  -- selection = function(source)
  --   return select.visual(source) or select.line(source)
  -- end,

  -- default prompts
  prompts = {
    Explain = {
      prompt = '/COPILOT_EXPLAIN 選択されたコードの説明を段落をつけて書いてください。',
    },
    Review = {
      prompt = '/COPILOT_REVIEW 選択されたコードをレビューしてください。',
      callback = function(response, source) end,
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
      selection = select.diagnostics,
    },
  },

  window = {
    layout = 'float',
    relative = 'editor',
  },

  -- default mappings
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
  },
})

function ShowCopilotChatActionPrompt()
  local actions = require('CopilotChat.actions')
  require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
end

-- バッファの内容全体を使って Copilot とチャットする
function CopilotChatBuffer()
  local input = vim.fn.input('Quick Chat: ')
  if input ~= '' then
    require('CopilotChat').ask(input, { selection = select.buffer })
  end
end

vim.api.nvim_set_keymap(
  'n',
  '<leader>cp',
  '<cmd>lua ShowCopilotChatActionPrompt()<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>cq',
  '<cmd>lua CopilotChatBuffer()<cr>',
  { noremap = true, silent = true }
)

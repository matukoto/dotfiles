-- GitHub Copilot Chatの設定
local select = require('CopilotChat.select')

require('CopilotChat').setup({
  debug = false, -- デバッグログを無効化

  -- デフォルトの選択方法（visual選択またはライン選択）
  -- selection = function(source)
  --   return select.visual(source) or select.line(source)
  -- end,

  -- プリセットプロンプトの設定
  prompts = {
    -- コードの説明を要求
    Explain = {
      prompt = '/COPILOT_EXPLAIN 選択されたコードの説明を段落をつけて書いてください。',
    },
    -- コードレビューを要求
    Review = {
      prompt = '/COPILOT_REVIEW 選択されたコードをレビューしてください。',
      callback = function(response, source) end,
    },
    -- バグ修正を要求
    Fix = {
      prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。',
    },
    -- コードの最適化を要求
    Optimize = {
      prompt = '/COPILOT_REFACTOR 選択されたコードを最適化してパフォーマンスと可読性を向上させてください。',
    },
    -- ドキュメントの生成を要求
    Docs = {
      prompt = '/COPILOT_DOCS 選択されたコードに対してドキュメンテーションコメントを追加してください。',
    },
    -- テストコードの生成を要求
    Tests = {
      prompt = '/COPILOT_TESTS 選択されたコードの詳細な単体テスト関数を書いてください。',
    },
    -- 診断問題の修正を要求
    FixDiagnostic = {
      prompt = 'ファイル内の次のような診断上の問題を解決してください:',
      selection = select.diagnostics,
    },
  },

  -- チャットウィンドウの表示設定
  window = {
    layout = 'float',     -- フローティングウィンドウとして表示
    relative = 'editor',  -- エディタを基準に位置を決定
  },

  -- キーマッピングの設定
  mappings = {
    -- 補完の操作
    complete = {
      detail = 'Use @<Tab> or /<Tab> for options.', -- 補完オプションのヘルプテキスト
      insert = '<Tab>',                             -- Tabキーで補完を実行
    },
    -- ウィンドウを閉じる
    close = {
      normal = 'q',    -- ノーマルモードでqキー
      insert = '<C-c>', -- インサートモードでCtrl+c
    },
    -- チャットをリセット
    reset = {
      normal = '<C-l>', -- ノーマルモードでCtrl+l
      insert = '<C-l>', -- インサートモードでCtrl+l
    },
    -- プロンプトを送信
    submit_prompt = {
      normal = '<CR>',  -- ノーマルモードでEnter
      insert = '<C-m>', -- インサートモードでCtrl+m
    },
    -- 差分を適用
    accept_diff = {
      normal = '<C-y>', -- ノーマルモードでCtrl+y
      insert = '<C-y>', -- インサートモードでCtrl+y
    },
    -- 差分をヤンク（コピー）
    yank_diff = {
      normal = 'gy',    -- ノーマルモードでgy
    },
    -- 差分を表示
    show_diff = {
      normal = 'gd',    -- ノーマルモードでgd
    },
  },
})

-- Copilotチャットのアクションプロンプトを表示する関数
-- Telescopeを使用してアクション一覧を表示
function ShowCopilotChatActionPrompt()
  local actions = require('CopilotChat.actions')
  require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
end

-- バッファの内容全体を使ってCopilotとチャットする関数
-- クイックチャット用のプロンプトを表示
function CopilotChatBuffer()
  local input = vim.fn.input('Quick Chat: ')
  if input ~= '' then
    require('CopilotChat').ask(input, { selection = select.buffer })
  end
end

-- キーマッピングの設定
-- <leader>cp: アクションプロンプトを表示
vim.api.nvim_set_keymap(
  'n',
  '<leader>cp',
  '<cmd>lua ShowCopilotChatActionPrompt()<cr>',
  { noremap = true, silent = true }
)
-- <leader>cq: バッファ全体を使ったクイックチャット
vim.api.nvim_set_keymap(
  'n',
  '<leader>cq',
  '<cmd>lua CopilotChatBuffer()<cr>',
  { noremap = true, silent = true }
)

-- GitHub Copilotの設定

require('copilot').setup({
  -- 補完候補一覧パネルの設定
  panel = {
    enabled = true,           -- パネル機能を有効化
    auto_refresh = false,     -- 自動更新を無効化
    -- パネル操作のキーマップ
    keymap = {
      jump_prev = '[[',      -- 前の候補にジャンプ
      jump_next = ']]',      -- 次の候補にジャンプ
      accept = '<CR>',       -- 候補を確定（Enter）
      refresh = 'gr',        -- 候補を再取得
      open = '<M-CR>',       -- パネルを開く（Alt+Enter）
    },
    -- パネルのレイアウト設定
    layout = {
      position = 'bottom',   -- パネルの位置（bottom/top/left/right/horizontal/vertical）
      ratio = 0.4,          -- パネルのサイズ比率
    },
  },

  -- インラインサジェスト（その場での補完）の設定
  suggestion = {
    enabled = true,          -- サジェスト機能を有効化
    auto_trigger = true,     -- 自動でサジェストを表示
    hide_during_completion = true,  -- 補完メニュー表示中はサジェストを隠す
    debounce = 75,          -- サジェスト更新の遅延時間（ミリ秒）
    -- サジェスト操作のキーマップ
    keymap = {
      accept = '<Tab>',      -- サジェストを確定（Tab）
      accept_word = false,   -- 単語単位での確定を無効化
      accept_line = false,   -- 行単位での確定を無効化
      next = '<M-[>',       -- 次のサジェストに移動（Alt+[）
      prev = '<M-]>',       -- 前のサジェストに移動（Alt+]）
      dismiss = '<C-]>',     -- サジェストを閉じる（Ctrl+]）
    },
  },

  -- ファイルタイプごとの有効/無効設定
  filetypes = {
    yaml = false,            -- YAMLファイルでは無効
    markdown = true,         -- Markdownファイルでは有効
    help = false,           -- ヘルプファイルでは無効
    gitcommit = true,       -- Gitコミットメッセージでは有効
    gitrebase = false,      -- Gitリベース操作では無効
    hgcommit = false,       -- Mercurialコミットでは無効
    cvs = false,            -- CVSでは無効
    java = false,           -- Javaファイルでは無効
    svelte = false,         -- Svelteファイルでは無効
    typescript = false,      -- TypeScriptファイルでは無効
    ['.'] = false,          -- デフォルトで無効
  },

  -- Copilotが使用するNodeコマンドの指定（Node.js 18.x以上が必要）
  copilot_node_command = 'node',

  -- サーバーオプションのオーバーライド設定
  server_opts_overrides = {},
})

-- コマンドラインエイリアスの設定
vim.cmd('cabbrev ce <Cmd>Copilot enable<CR>')   -- 'ce'でCopilotを有効化
vim.cmd('cabbrev cd <Cmd>Copilot disable<CR>')  -- 'cd'でCopilotを無効化

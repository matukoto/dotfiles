require('neotest').setup({
  adapters = {
    require('neotest-vitest'),
    -- require('neotest-java')({
    --   junit_jar = nil, -- default: stdpath("data") .. /nvim/neotest-java/junit-platform-console-standalone-[version].jar
    --   incremental_build = true,
    --   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'mvnw' }, { upward = true })[1]),
    -- }),
  },
  -- vim-guiseとの競合を避けるための設定
  discovery = {
    enabled = false, -- 自動ディスカバリーを無効化
  },
  -- 出力設定
  output = {
    open_on_run = false, -- テスト実行時の自動ウィンドウオープンを無効化
  },
  -- 診断設定
  diagnostic = {
    enabled = true, -- テスト失敗時の診断を有効化
    severity = vim.diagnostic.severity.ERROR, -- 失敗を ERROR として表示
  },
  -- ステータス設定
  status = {
    enabled = true,
    signs = true, -- サインを表示
    virtual_text = true, -- 仮想テキストを表示
  },
  -- サマリー設定
  summary = {
    enabled = true,
    expand_errors = true, -- エラーの詳細を自動展開
    mappings = {
      expand = { 'o', '<2-LeftMouse>' }, -- 展開/折りたたみのマッピング
      expand_all = 'O',
      output = 'o', -- テスト出力の表示
      jumpto = '<CR>', -- テストにジャンプ
      run = 'r', -- テストを実行
      stop = 's', -- テストを停止
      mark = 'm', -- テストをマーク
    },
  },
  -- アイコン設定
  icons = {
    running = '⟳',
    passed = '✓',
    failed = '✗',
    skipped = '↷',
    unknown = '?',
  },
  floating = {
    border = 'rounded', -- フローティングウィンドウのボーダー
    max_height = 0.6, -- 最大高さ（画面の60%）
    max_width = 0.6, -- 最大幅（画面の60%）
  },
})

-- 基本的なキーマップ
vim.keymap.set('n', '<leader>tt', function()
  require('neotest').run.run()
end, { desc = 'Run nearest test' })

vim.keymap.set('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run current file' })

vim.keymap.set('n', '<leader>ta', function()
  require('neotest').run.run(vim.loop.cwd())
end, { desc = 'Run All Tests in Directory' })

-- 拡張キーマップ
vim.keymap.set('n', '<leader>ts', function()
  require('neotest').summary.open({
    enter = true,
    position = 'right',
    win_options = { winbar = false },
  })
  -- require('neotest').summary.focus_file(vim.fn.expand('%:p'))
end, { desc = 'Open test summary for current file' })

vim.keymap.set('n', '<leader>to', function()
  require('neotest').output.open({ enter = true, auto_close = true })
end, { desc = 'Show test output' })

vim.keymap.set('n', '<leader>tO', function()
  require('neotest').output.open({ enter = true, auto_close = false, last_run = true })
end, { desc = 'Show test output (keep open)' })

vim.keymap.set('n', '[t', function()
  require('neotest').jump.prev({ status = 'failed' })
end, { desc = 'Jump to previous failed test' })

vim.keymap.set('n', ']t', function()
  require('neotest').jump.next({ status = 'failed' })
end, { desc = 'Jump to next failed test' })

vim.keymap.set('n', '<leader>tS', function()
  require('neotest').run.stop()
end, { desc = 'Stop test run' })

vim.keymap.set('n', '<leader>tw', function()
  require('neotest').watch.toggle(vim.fn.expand('%'))
end, { desc = 'Toggle test watch mode' })

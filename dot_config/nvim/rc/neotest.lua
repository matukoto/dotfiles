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
  output = {
    open_on_run = false, -- テスト実行時の自動ウィンドウオープンを無効化
  },
  enter = false,
})

vim.keymap.set('n', '<leader>tt', function()
  require('neotest').run.run()
end, { desc = 'Run nearest test' })

vim.keymap.set('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run current file' })

vim.keymap.set('n', '<leader>ta', function()
  require('neotest').run.run(vim.loop.cwd())
end, { desc = 'Run All Tests in Directory' })

vim.keymap.set('n', '<leader>ts', function()
  require('neotest').summary.open({
    enter = true,
    position = 'right',
    win_options = { winbar = false },
  })
end, { desc = 'Open test summary for current file' })

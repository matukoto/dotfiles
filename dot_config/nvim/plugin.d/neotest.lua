require('neotest').setup({
  adapters = {
    require('neotest-vitest'),
    require('neotest-java')({
      junit_jar = nil, -- default: stdpath("data") .. /nvim/neotest-java/junit-platform-console-standalone-[version].jar
      incremental_build = true,
    }),
  },
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
  require('neotest').summary.toggle()
end, { desc = 'Toggle test summary' })

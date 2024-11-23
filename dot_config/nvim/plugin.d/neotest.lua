require('neotest').setup({
  adapters = {
    require('neotest-vitest'),
  },
})

--   ['neotest-java'] = {
--     junit_jar = nil, -- default: stdpath("data") .. /nvim/neotest-java/junit-platform-console-standalone-[version].jar
--     incremental_build = false,
--   },
vim.keymap.set('n', '<leader>tr', function()
  require('neotest').run.run()
end, { desc = 'Run nearest test' })

vim.keymap.set('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run current file' })

vim.keymap.set('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { desc = 'Toggle test summary' })

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-plenary',
    {
      'rcasia/neotest-java',
      dependencies = {
        'mfussenegger/nvim-jdtls',
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
      },
    },
  },
  event = { 'VeryLazy' },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-plenary'),
        require('neotest-java'),
        require('neotest-vitest')({
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
          args = { '--coverage' },
        }),
      },
      status = { enabled = true, virtual_text = true, signs = false },
    })

    -- Key Bindings
    vim.keymap.set('n', '<leader>tn', '<cmd>lua require("neotest").run.run()<CR>', { desc = '[T]est [N]earest' })
    vim.keymap.set('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%s"))<CR>', { desc = '[T]est [F]ile' })
    vim.keymap.set('n', '<leader>ta', '<cmd>lua require("neotest").run.run({ suite = true })<CR>', { desc = '[T]est [A]ll' })
    vim.keymap.set('n', '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<CR>', { desc = '[T]est [S]ummary' })
    vim.keymap.set('n', '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<CR>', { desc = '[T]est [O]utput' })
  end,
}

return {
  {
    'rcasia/neotest-java',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-jdtls',
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
  },
  {
    'marilari88/neotest-vitest',
    ft = 'typescript',
  },
  {
    'nvim-neotest/neotest-plenary',
    ft = 'lua',
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'VeryLazy',
    opts = {
      adapters = {
        ['neotest-java'] = {
          -- config here
        },
        ['neotest-vitest'] = {
          --config here
        },
        ['neotest-plenary'] = {
          --config here
        },
      },
      keys = {
        {
          '<leader>tt',
          function()
            require('neotest').run.run()
          end,
          desc = 'Run Nearest Test',
        },
        {
          '<leader>tf',
          function()
            require('neotest').run.run(vim.fn.expand('%'))
          end,
          desc = 'Run Current File',
        },
        {
          '<leader>ta',
          function()
            require('neotest').run.run(vim.loop.cwd())
          end,
          desc = 'Run All Tests (Directory)',
        },
        {
          '<leader>tS',
          function()
            require('neotest').run.stop()
          end,
          desc = 'Stop Test Run',
        },
        {
          '<leader>ts',
          function()
            require('neotest').summary.toggle()
          end,
          desc = 'Toggle Test Summary',
        }, -- Use toggle instead of open
        {
          '<leader>to',
          function()
            require('neotest').output.open({ enter = true, auto_close = true })
          end,
          desc = 'Show Test Output',
        },
        {
          '<leader>tO',
          function()
            require('neotest').output.open({ enter = true, auto_close = false, last_run = true })
          end,
          desc = 'Show Last Test Output (Keep Open)',
        },
        {
          '<leader>tw',
          function()
            require('neotest').watch.toggle(vim.fn.expand('%'))
          end,
          desc = 'Toggle Watch Mode (File)',
        },
        {
          '[t',
          function()
            require('neotest').jump.prev({ status = 'failed' })
          end,
          desc = 'Prev Failed Test',
        },
        {
          ']t',
          function()
            require('neotest').jump.next({ status = 'failed' })
          end,
          desc = 'Next Failed Test',
        },
      },
    },
  },
}

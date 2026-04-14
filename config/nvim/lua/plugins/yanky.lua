return {
  'gbprod/yanky.nvim',
  event = 'VeryLazy',
  config = function()
    require('yanky').setup({
      ring = {
        history_length = 10,
        storage = 'shada', -- 'shada' or 'sqlite' or 'memory' memory はセッションごとに消える
        sync_with_numbered_registers = true,
        cancel_event = 'update',
        ignore_registers = { '_' },
        update_register_on_cycle = false,
        -- windows wsl 用の設定 '^M' を削除する
        permanent_wrapper = require('yanky.wrappers').remove_carriage_return,
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 50,
      },
    })
  end,
  dependencies = { 'folke/snacks.nvim' },
  keys = {
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },
    -- { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
    -- { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },
    {
      '<leader>P',
      function()
        Snacks.picker.yanky()
      end,
      mode = { 'n', 'x' },
      desc = 'Open Yank History',
    },
  },
}

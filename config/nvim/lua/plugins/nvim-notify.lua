return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  config = function()
    require('notify').setup({
      top_down = false,
    })
    vim.notify = require('notify')
  end,
}

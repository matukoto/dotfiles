require('snacks').setup({
  picker = {
    layout = {
      preset = 'dropdown',
      layout = {
        width = 0.8,
        min_width = 100,
        height = 0.9,
      },
    },
    win = {
      input = {
        keys = {
          -- select allを無効化
          ['<c-a>'] = false,
          ['<c-b>'] = false,
          ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
          ['<c-f>'] = false,
          ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
          ['<c-s>'] = false,
          ['<c-x>'] = { 'edit_split', mode = { 'i', 'n' } },
        },
      },
    },
  },
})

vim.keymap.set('n', '<leader>b', function()
  Snacks.picker.buffers()
end)

vim.keymap.set('n', '<leader>k', function()
  require('snacks.picker.config.sources').kensaku = require('plugins/snacks/sources/kensaku')
  Snacks.picker.kensaku()
end)

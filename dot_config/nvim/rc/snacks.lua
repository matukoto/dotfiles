require('snacks').setup({
  picker = {
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

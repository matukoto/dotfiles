require('buffer_manager').setup({})

vim.keymap.set('n', '<leader>b', '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<CR>')

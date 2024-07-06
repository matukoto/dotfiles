vim.keymap.set('n', '<C-l>', '<cmd>lua require("nvim-smartbufs").goto_next_buffer()<CR>')
vim.keymap.set('n', '<C-h>', '<cmd>lua require("nvim-smartbufs").goto_prev_buffer()<CR>')
vim.keymap.set('n', '<C-w>', '<cmd>Bdelete<CR>', { nowait = true })

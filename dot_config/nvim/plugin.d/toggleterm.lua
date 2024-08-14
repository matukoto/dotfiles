require('toggleterm').setup()
vim.api.nvim_set_keymap(
  'n',
  '<leader>t',
  '<cmd>lua require("toggleterm").toggle()<CR>',
  { noremap = true, silent = true }
)

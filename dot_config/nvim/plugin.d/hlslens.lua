require('hlslens').setup()

vim.api.nvim_set_keymap(
  'n',
  '*',
  [[*<Cmd>lua require('hlslens').start()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '#',
  [[#<Cmd>lua require('hlslens').start()<CR>]],
  { noremap = true, silent = true }
)

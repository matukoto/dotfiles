require('hlslens').setup()
local kopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
  'n',
  'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
-- packer
--use 'haya14busa/vim-asterisk'

vim.api.nvim_set_keymap(
  'n',
  '*',
  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  '#',
  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  'g*',
  [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  'g#',
  [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)

vim.api.nvim_set_keymap(
  'x',
  '*',
  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'x',
  '#',
  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'x',
  'g*',
  [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'x',
  'g#',
  [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
  kopts
)

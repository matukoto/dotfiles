-- hlslens.nvim: 検索結果のハイライトを拡張し、マッチ数と現在位置を表示するプラグイン
require('hlslens').setup()

-- キーマップのオプション設定
local kopts = { noremap = true, silent = true }
-- 順方向検索（n）と逆方向検索（N）のキーマッピング
-- 検索後にhlslensを起動して検索結果の視覚的フィードバックを表示
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
-- vim-asterisk統合のための設定
-- カーソル位置の単語を検索するための拡張機能
-- ノーマルモードのキーマッピング
vim.api.nvim_set_keymap(
  'n',
  '*',
  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  -- カーソル位置の単語を順方向に完全一致検索
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  '#',
  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  -- カーソル位置の単語を逆方向に完全一致検索
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  'g*',
  [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], -- カーソル位置の単語を順方向に部分一致検索
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  'g#',
  [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], -- カーソル位置の単語を逆方向に部分一致検索
  kopts
)

-- ビジュアルモードでの選択テキストを検索するためのキーマッピング
vim.api.nvim_set_keymap(
  'x',
  '*',
  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  -- 選択テキストを順方向に完全一致検索
  kopts
)
vim.api.nvim_set_keymap(
  'x',
  '#',
  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  -- 選択テキストを逆方向に完全一致検索
  kopts
)
vim.api.nvim_set_keymap(
  'x',
  'g*',
  [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], -- 選択テキストを順方向に部分一致検索
  kopts
)
vim.api.nvim_set_keymap(
  'x',
  'g#',
  [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], -- 選択テキストを逆方向に部分一致検索
  kopts
)

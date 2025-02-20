-- require など簡単な設定をまとめたファイル

-- キーストロークを表示する
-- local keycastr = require('keycastr')
-- keycastr.enable()
-- keycastr.show()
-- keycastr.config.set({
--   win_config = {
--     width = 100,
--     height = 10,
--   },
-- })

-- visual mode で行全体をマ-キングする
require('full_visual_line').setup()

-- markdown をレンダリングする
require('render-markdown').setup()

-- カーソル移動を可視化する
require('smoothcursor').setup()
require('todo-comments').setup()

-- dmacro
vim.keymap.set({ 'i', 'n' }, '<C-y>', '<Plug>(dmacro-play-macro)')

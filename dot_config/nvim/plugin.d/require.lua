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

-- LSP の諸々を表示する
require('fidget').setup()

-- visual mode で行全体をマ-キングする
require('full_visual_line').setup()

-- scroll bar を表示する
require('scrollbar').setup()

-- markdown をレンダリングする
require('render-markdown').setup()

-- カーソル移動を可視化する
require('smoothcursor').setup()

-- dmacro
require('dmacro').setup({
  dmacro_key = '<C-t>',
})

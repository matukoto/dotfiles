-- dial.nvim の設定
-- カーソル位置の数値や定義済みのテキストを増減させるためのプラグイン

-- 必要なモジュールの読み込み
local set = require('dial.map')
local map = vim.keymap

-- キーマッピングの設定
-- Ctrl+a: カーソル位置の値をインクリメント（増加）
map.set('n', '<C-a>', function()
  set.manipulate('increment', 'normal')
end)

-- Ctrl+x: カーソル位置の値をデクリメント（減少）
map.set('n', '<C-x>', function()
  set.manipulate('decrement', 'normal')
end)

-- 注: このプラグインは以下のような操作が可能
-- - 数値の増減（1 → 2 → 3 など）
-- - 真偽値の切り替え（true ⇄ false）
-- - 曜日の切り替え（Monday → Tuesday など）
-- - アルファベットの増減（a → b → c など）
-- - カスタム定義した値の切り替え

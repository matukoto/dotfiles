-- dot_config/nvim/lua/plugins/camelcasemotion.lua
-- Configuration for bkad/CamelCaseMotion
return {
  'bkad/CamelCaseMotion',
  -- Load lazily, likely triggered by keymaps or specific events
  event = 'VeryLazy',
  -- init function runs before the plugin is loaded, suitable for setting globals
  init = function()
    -- Set the trigger key for CamelCaseMotion
    vim.g.camelcasemotion_key = '['
    vim.cmd([[
      " 以下はデフォルトのキーマッピングの例（現在はコメントアウト）
      " ノーマルモードでの移動
      " map <silent> w <Plug>CamelCaseMotion_w     " 次のキャメルケース部分へ移動
      " map <silent> b <Plug>CamelCaseMotion_b     " 前のキャメルケース部分へ移動
      " map <silent> e <Plug>CamelCaseMotion_e     " 現在のキャメルケース部分の末尾へ移動
      " map <silent> ge <Plug>CamelCaseMotion_ge   " 前のキャメルケース部分の末尾へ移動
      " sunmap w
      " sunmap b
      " sunmap e
      " sunmap ge

      " オペレータ待機モードとビジュアルモードでのテキストオブジェクト
      " omap <silent> iw <Plug>CamelCaseMotion_iw  " キャメルケース部分の内側を選択
      " xmap <silent> iw <Plug>CamelCaseMotion_iw  " キャメルケース部分の内側を選択（ビジュアル）
      " omap <silent> ib <Plug>CamelCaseMotion_ib  " 前のキャメルケース境界まで選択
      " xmap <silent> ib <Plug>CamelCaseMotion_ib  " 前のキャメルケース境界まで選択（ビジュアル）
      " omap <silent> ie <Plug>CamelCaseMotion_ie  " 次のキャメルケース境界まで選択
      " xmap <silent> ie <Plug>CamelCaseMotion_ie  " 次のキャメルケース境界まで選択（ビジュアル）

      " インサートモードでの移動
      " imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b   " Shift+左で前のキャメルケース部分へ
      " imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w  " Shift+右で次のキャメルケース部分へ
      ]])
  end,
}

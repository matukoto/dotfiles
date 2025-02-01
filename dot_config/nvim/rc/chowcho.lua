-- ウィンドウ選択プラグイン（chowcho.nvim）の設定
require('chowcho').setup({
  -- ウィンドウ選択のラベル文字（各文字は1文字である必要があります）
  -- 配列の長さが移動可能な最大ウィンドウ数となります
  labels = { 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L' },

  -- デフォルトの除外ルールを使用するかどうか
  use_exclude_default = true,

  -- ラベルの大文字小文字を区別しない
  ignore_case = true,

  -- 特定のバッファやウィンドウを除外するための関数
  exclude = function(buf, win)
    -- noice.nvimのコマンドラインポップアップを除外
    local bt = vim.api.nvim_get_option_value('buftype', { buf = buf })
    local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if bt == 'nofile' and (ft == 'noice' or ft == 'vim') then
      return true
    end
    return false
  end,

  -- セレクターの表示設定
  selector = {
    float = {
      -- フローティングウィンドウのボーダースタイル
      border_style = 'rounded',
      
      -- アイコンを表示するかどうか
      icon_enabled = true,

      -- 各要素の色設定
      color = {
        -- ラベルの色
        label = {
          active = '#c8cfff',    -- アクティブなウィンドウのラベル色
          inactive = '#ababab',   -- 非アクティブなウィンドウのラベル色
        },
        -- テキストの色
        text = {
          active = '#fefefe',    -- アクティブなウィンドウのテキスト色
          inactive = '#d0d0d0',  -- 非アクティブなウィンドウのテキスト色
        },
        -- ボーダーの色
        border = {
          active = '#b400c8',    -- アクティブなウィンドウのボーダー色
          inactive = '#fefefe',  -- 非アクティブなウィンドウのボーダー色
        },
      },
      -- フローティングウィンドウのz-index
      zindex = 1,
    },
  },
})

-- キーマッピング：<Leader><Leader>でウィンドウ選択モードを開始
vim.keymap.set('n', '<Leader><Leader>', "<cmd>lua require('chowcho').run()<CR>")

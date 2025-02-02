-- hlchunk.nvim: コードブロックの視覚的な表示を強化するプラグイン
require('hlchunk').setup({
  -- コードチャンク（ブロック）の表示設定
  chunk = {
    enable = true,        -- チャンクの表示を有効化
    notify = false,       -- 通知を無効化
    use_treesitter = true, -- Tree-sitterを使用してより正確なパース
    -- サポートされるファイルタイプと除外ファイルタイプの詳細は以下を参照:
    -- https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
    -- support_filetypes = ft.support_filetypes,
    -- exclude_filetypes = ft.exclude_filetypes,

    -- インジケーターに使用する文字のカスタマイズ
    chars = {
      horizontal_line = '─', -- 水平線
      vertical_line = '│',   -- 垂直線
      left_top = '╭',        -- 左上のコーナー
      left_bottom = '╰',     -- 左下のコーナー
      right_arrow = '>',     -- 右矢印
    },
    -- インジケーターの色設定
    style = {
      { fg = '#806d9c' },           -- 通常のチャンクの色
      { fg = '#c21f30' },           -- エラーのあるチャンクの色
    },
    textobject = '',                -- テキストオブジェクトの定義
    max_file_size = 1024 * 1024,    -- 処理する最大ファイルサイズ（1MB）
    error_sign = true,              -- エラー表示を有効化
  },
  -- インデントガイドの設定
  indent = {
    enable = false,                  -- インデントガイドを無効化
  },
  -- 行番号の強調表示設定
  line_num = {
    enable = false,                  -- 行番号の強調表示を無効化
  },
  -- 空白行の表示設定
  blank = {
    enable = false,                  -- 空白行のインジケーターを無効化
  },
})

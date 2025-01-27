-- fm-nvim の設定
-- 様々なファイルマネージャーやターミナルベースのツールをNeovimと統合するプラグイン

require('fm-nvim').setup({
  -- ファイルを開く際に使用するVimコマンド
  edit_cmd = 'edit',

  -- ファイルマネージャーを閉じる/開く際のコールバック
  -- 詳細は`:h fm-nvim`のQ&Aセクションを参照
  on_close = {},
  on_open = {},

  -- UIオプション
  ui = {
    -- デフォルトのUI表示モード（"split"または"float"）
    default = 'float',

    -- フローティングウィンドウの設定
    float = {
      -- ウィンドウの境界線スタイル（:h nvim_open_winを参照）
      border = 'none',

      -- ウィンドウとボーダーのハイライトグループ（:h winhlを参照）
      float_hl = 'Normal',    -- ウィンドウ本体のハイライト
      border_hl = 'FloatBorder', -- ボーダーのハイライト

      -- ウィンドウの透過度（:h winblendを参照）
      blend = 0,

      -- ウィンドウのサイズ（0-1の割合で指定）
      height = 1,
      width = 1,

      -- ウィンドウの位置（画面に対する相対位置）
      x = 0.7,
      y = 0.7,
    },

    -- 分割ウィンドウの設定
    split = {
      -- 分割方向（topleft: 上部または左側に分割）
      direction = 'topleft',

      -- 分割サイズ（文字数）
      size = 24,
    },
  },

  -- 統合するターミナルコマンドの設定
  -- 注: 設定したコマンドは$PATHに含まれている必要があります
  cmds = {
    -- lf_cmd = 'lf',        -- ファイルマネージャー（lf）
    -- fm_cmd = 'fm',        -- ファイルマネージャー（fm）
    -- nnn_cmd = 'nnn',      -- ファイルマネージャー（nnn）
    -- fff_cmd = 'fff',      -- ファイルマネージャー（fff）
    -- twf_cmd = 'twf',      -- ファイルマネージャー（twf）
    -- fzf_cmd = 'fzf',      -- ファジーファインダー（fzf）
    -- fzy_cmd = 'find . | fzy', -- ファジーファインダー（fzy）
    -- xplr_cmd = 'xplr',    -- ファイルマネージャー（xplr）
    -- vifm_cmd = 'vifm',    -- ファイルマネージャー（vifm）
    -- skim_cmd = 'sk',      -- ファジーファインダー（skim）
    -- broot_cmd = 'broot',  -- ファイルマネージャー（broot）
    gitui_cmd = 'gitui',     -- Gitのターミナルインターフェース
    -- ranger_cmd = 'ranger', -- ファイルマネージャー（ranger）
    -- joshuto_cmd = 'joshuto', -- ファイルマネージャー（joshuto）
    lazygit_cmd = 'lazygit', -- Gitのターミナルインターフェース
    -- neomutt_cmd = 'neomutt', -- メールクライアント
    -- taskwarrior_cmd = 'taskwarrior-tui', -- タスク管理
  },

  -- プラグインで使用するキーマッピング
  mappings = {
    vert_split = '<C-v>',  -- 垂直分割でファイルを開く
    horz_split = '<C-h>',  -- 水平分割でファイルを開く
    tabedit = '<C-t>',     -- 新しいタブでファイルを開く
    edit = '<C-e>',        -- 現在のウィンドウでファイルを開く
    ESC = '<ESC>',         -- ファイルマネージャーを閉じる
  },

  -- brootの設定ファイルパス
  -- broot_conf = vim.fn.stdpath('data') .. '/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson',
})

-- コマンドラインエイリアスの設定
-- 'G'コマンドでGituiを起動
vim.cmd('cabbrev G Gitui')

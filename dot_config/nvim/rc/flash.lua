-- Flash.nvimの設定（高速な画面内移動を提供するプラグイン）

require('flash').setup({
  -- 検索時に利用するラベル文字列
  -- ここで指定した文字の中からジャンプ候補にアサインされる
  labels = 'asdfghjklqwertyuiopzxcvbnm',

  search = {
    -- 他のウィンドウもまたいで検索を行うか
    multi_window = true,
    -- 検索方向（true なら前方検索、false なら後方検索）
    forward = true,
    -- 検索の折り返し。true で行末から行頭に折り返して検索
    wrap = true,
    -- 検索モード(fuzzy|exact|search)。ここでは完全一致を意味する 'exact'
    mode = 'exact',
    -- 増分検索を利用するかどうか
    incremental = false,
  },

  jump = {
    -- ジャンプリストに登録するかどうか
    jumplist = true,
    -- ジャンプ先の位置を "start", "end", "range" のどこにするか
    pos = 'start',
    -- ジャンプ後にハイライトをクリアするかどうか
    nohearch = true,
    -- マッチが一つだけだった場合に自動的にジャンプするかどうか
    autojump = true,
    -- ジャンプ位置の範囲を含めるかどうか
    inclusive = nil,
    -- ジャンプ位置へのオフセット
    offset = nil,
  },

  label = {
    -- 大文字のラベルを許可するか
    uppercase = true,
    -- カーソル下の現在位置もラベル表示をするかどうか
    current = true,
    -- マッチの後ろ側にラベルを表示するか（数字や boolean でも細かい指定が可能）
    after = false,
    -- マッチの前側にラベルを表示するか
    before = true,
    -- ラベルの表示位置 ("eol","overlay","right_align","inline")
    style = 'overlay',
    -- ラベル再利用の制限 ("lowercase","all","none")
    reuse = 'lowercase',
    -- カーソルから近いマッチに優先的にラベルを割り振るか
    distance = true,
    -- ラベルを表示する際に必要なパターンの最小長
    min_pattern_length = 0,
    -- レインボーカラーでラベルを表示するかと、その濃淡
    rainbow = {
      enabled = true,
      shade = 5,
    },
  },

  highlight = {
    groups = {
      -- マッチ箇所全般に使うハイライトグループ
      match = 'FlashMatch',
      -- カーソル下のマッチ箇所に使うハイライトグループ
      current = 'FlashCurrent',
      -- マッチしていない部分（背景）のハイライトグループ
      backdrop = 'FlashBackdrop',
      -- ラベル表示に使うハイライトグループ
      label = 'FlashLabel',
    },
  },

  -- Flash の各モードにおける設定
  modes = {

    -- / や ? での検索時に発火するモード
    search = {
      -- true ならデフォルトの検索でも Flash が発火
      enabled = true,
      highlight = { backdrop = true },
      jump = {
        history = true, -- 検索履歴を残す
        register = true, -- レジスタに記録
        nohlsearch = true, -- 検索後に hlsearch をオフにする
      },
      search = {
        -- forward, mode, incremental などは自動で設定される
      },
    },

    -- f, F, t, T, ;, , といったキャラクタモーション時の設定
    char = {
      enabled = true,
      config = function(opts)
        -- operator-pending モード時、自動的に Flash を隠すかどうか
        opts.autohide = opts.autohide or (vim.fn.mode(true):find('no') and vim.v.operator == 'y')

        -- count が指定されている場合やレジスタ実行中はジャンプラベルを出さない
        opts.jump_labels = opts.jump_labels
          and vim.v.count == 0
          and vim.fn.reg_executing() == ''
          and vim.fn.reg_recording() == ''
      end,
      -- ジャンプ後に flash を隠すかどうか
      autohide = false,
      -- ジャンプラベルを表示するかどうか
      jump_labels = false,
      -- 複数行を跨ぐかどうか（false なら現在行のみ）
      multi_line = false,
      -- ラベルとして使わないキーの指定
      label = { exclude = 'hjkliardc' },
      -- 有効にするモーションキーの一覧
      keys = { 'f', 'F', 't', 'T', ';', ',' },
      -- 文字ごとのアクション設定
      char_actions = function(motion)
        return {
          [';'] = 'next',
          [','] = 'prev',
          [motion:lower()] = 'next',
          [motion:upper()] = 'prev',
        }
      end,
      -- 検索での wrap の有無などの設定
      search = { wrap = false },
      highlight = { backdrop = true },
      jump = {
        register = false,
        autojump = false,
      },
    },

    -- treesitter を用いたテキストオブジェクト選択などのモード
    treesitter = {
      labels = 'abcdefghijklmnopqrstuvwxyz',
      jump = {
        pos = 'range',
        autojump = true,
      },
      search = {
        incremental = false,
      },
      label = {
        before = true,
        after = true,
        style = 'inline',
      },
      highlight = {
        backdrop = false,
        matches = false,
      },
    },

    -- treesitter ベースの検索モード
    treesitter_search = {
      jump = { pos = 'range' },
      search = {
        multi_window = true,
        wrap = true,
        incremental = false,
      },
      remote_op = { restore = true },
      label = {
        before = true,
        after = true,
        style = 'inline',
      },
    },

    -- リモート操作（別ウィンドウに対する操作）時の設定
    remote = {
      remote_op = {
        restore = true, -- 操作後に元の状態に戻すかどうか
        motion = true,
      },
    },
  },

  -- 検索プロンプトを出す際のウィンドウ設定
  prompt = {
    enabled = true,
    prefix = { { '⚡', 'FlashPromptIcon' } },
    win_config = {
      -- relative = 'editor' でエディタ全体を基準にウィンドウを表示
      relative = 'editor',
      -- width が 1 以下ならエディタ幅に対しての割合
      width = 1,
      height = 1,
      -- 負数の場合はエディタ下端からのオフセット
      row = -1,
      col = 0,
      zindex = 1000,
    },
  },

  -- リモートオペレータペンディングモード用の設定
  remote_op = {
    -- リモート操作後にウィンドウビューやカーソル位置を復元するかどうか
    restore = false,
    -- pos = "range" のときは無効
    motion = false,
  },
})

-- カスタムキーマッピング

-- 現在のウィンドウ内でのみジャンプ
vim.keymap.set('n', 'f', function()
  require('flash').jump({
    search = { forward = true, wrap = true, multi_window = false },
  })
end)

-- 全てのウィンドウを対象にジャンプ
vim.keymap.set('n', 'F', function()
  require('flash').jump({
    search = { forward = true, wrap = true, multi_window = true },
  })
end)

-- Treesitterベースのテキストオブジェクト選択
vim.keymap.set('n', 't', function()
  require('flash').treesitter()
end)

-- Treesitterベースの高度な検索
vim.keymap.set('n', 'T', function()
  require('flash').treesitter_search()
end)

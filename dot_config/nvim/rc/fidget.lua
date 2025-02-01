-- Fidget.nvim の設定
-- LSP（Language Server Protocol）の進行状況を通知として表示するプラグイン

require('fidget').setup({
  -- LSPの進行状況表示に関する設定
  progress = {
    poll_rate = 0,                -- 進行状況メッセージのポーリング間隔（0で自動）
    suppress_on_insert = false,    -- インサートモード中の新規メッセージを抑制するかどうか
    ignore_done_already = false,   -- 既に完了しているタスクを無視するかどうか
    ignore_empty_message = false,  -- メッセージのない新規タスクを無視するかどうか

    -- LSPサーバーが切断された時の通知グループのクリア設定
    clear_on_detach = function(client_id)
      local client = vim.lsp.get_client_by_id(client_id)
      return client and client.name or nil
    end,

    -- 進行状況メッセージの通知グループキーの取得方法
    notification_group = function(msg)
      return msg.lsp_client.name
    end,

    ignore = {},  -- 無視するLSPサーバーのリスト

    -- LSPの進行状況メッセージの表示設定
    display = {
      render_limit = 16,          -- 同時に表示するLSPメッセージの最大数
      done_ttl = 3,              -- 完了メッセージの表示時間（秒）
      done_icon = '✔',           -- タスク完了時のアイコン
      done_style = 'Constant',    -- 完了タスクのハイライトグループ
      progress_ttl = math.huge,   -- 進行中メッセージの表示時間
      progress_icon = {           -- 進行中タスクのアイコン設定
        pattern = 'dots',         -- アニメーションパターン
        period = 1               -- アニメーション周期
      },
      progress_style = 'WarningMsg',  -- 進行中タスクのハイライトグループ
      group_style = 'Title',          -- グループ名のハイライトグループ
      icon_style = 'Question',        -- アイコンのハイライトグループ
      priority = 30,                  -- 通知グループの優先順位
      skip_history = true,            -- 進行状況を履歴に残さないかどうか

      -- メッセージのフォーマット設定
      format_message = require('fidget.progress.display').default_format_message,
      format_annote = function(msg)   -- 進行状況の注釈フォーマット
        return msg.title
      end,
      format_group_name = function(group)  -- グループ名のフォーマット
        return tostring(group)
      end,
    },

    -- Neovim組み込みのLSPクライアントに関する設定
    lsp = {
      progress_ringbuf_size = 0,  -- LSP進行状況リングバッファのサイズ
      log_handler = false,        -- $/progressハンドラのログ記録（デバッグ用）
    },
  },

  -- 通知サブシステムに関する設定
  notification = {
    poll_rate = 10,              -- 通知の更新・表示頻度
    filter = vim.log.levels.INFO, -- 最小通知レベル
    history_size = 128,          -- 保持する削除済みメッセージの数
    override_vim_notify = false,  -- vim.notify()を自動的にオーバーライドするかどうか

    -- 通知グループの設定
    configs = { 
      default = require('fidget.notification').default_config,
      update_hook = false 
    },

    -- 通知のリダイレクト設定
    redirect = function(msg, level, opts)
      if opts and opts.on_open then
        return require('fidget.integration.nvim-notify').delegate(msg, level, opts)
      end
    end,

    -- 通知のテキスト表示に関する設定
    view = {
      stack_upwards = true,     -- 通知を下から上に積み上げて表示
      icon_separator = ' ',      -- グループ名とアイコンの区切り文字
      group_separator = '---',   -- 通知グループ間の区切り文字
      group_separator_hl = 'Comment',  -- グループ区切りのハイライトグループ

      -- 通知メッセージのレンダリング方法
      render_message = function(msg, cnt)
        return cnt == 1 and msg or string.format('(%dx) %s', cnt, msg)
      end,
    },

    -- 通知ウィンドウとバッファに関する設定
    window = {
      normal_hl = 'Comment',    -- 通知ウィンドウの基本ハイライトグループ
      winblend = 100,           -- 通知ウィンドウの背景色透過度
      border = 'none',          -- 通知ウィンドウの境界線スタイル
      zindex = 45,             -- 通知ウィンドウの重ね順優先度
      max_width = 0,           -- 通知ウィンドウの最大幅（0で制限なし）
      max_height = 0,          -- 通知ウィンドウの最大高さ（0で制限なし）
      x_padding = 1,           -- ウィンドウ右端からのパディング
      y_padding = 0,           -- ウィンドウ下端からのパディング
      align = 'bottom',        -- 通知ウィンドウの配置位置
      relative = 'editor',     -- 通知ウィンドウの基準位置
    },
  },

  -- 他のプラグインとの連携設定
  integration = {
    ['nvim-tree'] = {
      enable = true,  -- nvim-treeとの連携を有効化
    },
    ['xcodebuild-nvim'] = {
      enable = true,  -- xcodebuild.nvimとの連携を有効化
    },
  },

  -- ログ出力に関する設定
  logger = {
    level = vim.log.levels.WARN,  -- 最小ログレベル
    max_size = 10000,             -- ログファイルの最大サイズ（KB）
    float_precision = 0.01,       -- 浮動小数点数の表示精度
    -- ログファイルの保存先
    path = string.format('%s/fidget.nvim.log', vim.fn.stdpath('cache')),
  },
})

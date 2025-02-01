-- コードフォーマッタープラグイン（conform.nvim）の設定

-- JavaScriptのフォーマッタ設定
-- biome → prettierd → prettier の順で利用可能なフォーマッタを使用
local jsFormatter = { 'biome', 'prettierd', 'prettier', stop_after_first = true }

-- TypeScriptのフォーマッタ設定
-- package.jsonが存在する場合はJavaScriptと同じフォーマッタを使用
-- 存在しない場合はdeno_fmtを使用
local tsFormatter = function()
  if vim.fs.root(0, 'package.json') then
    return jsFormatter
  else
    return { 'deno_fmt' }
  end
end

require('conform').setup({
  -- ファイルタイプごとのフォーマッタ設定
  formatters_by_ft = {
    lua = { 'stylua' }, -- 特に設定しなくても ~/.config/stylua/stylua.toml を見てくれる
    sql = { 'sql_formatter' },
    yaml = { 'yamlfmt' },
    java = { lsp_format = 'fallback' }, -- LSPフォーマッタをフォールバックとして使用
    sh = {
      'shellcheck', -- シェルスクリプトの静的解析
      'shfmt',      -- シェルスクリプトのフォーマット
      stop_after_first = false, -- 全てのフォーマッタを実行
    },
    -- JSON関連のファイルタイプ設定
    json = tsFormatter,
    jsonc = tsFormatter,
    -- フロントエンド関連のファイルタイプ設定
    svelte = { 'eslint' },
    fsharp = { 'fantomas' },
    html = jsFormatter,
    css = jsFormatter,
    javascript = jsFormatter,
    javascriptreact = jsFormatter,
    typescript = tsFormatter,
    typescriptreact = jsFormatter,
    go = { 'gofmt' },
    -- ['*'] = { 'typos' }, -- 勝手に訂正されてしまうので、状況次第では有用
    markdown = {
      'injected',           -- 埋め込みコードのフォーマット
      'typos',             -- タイプミスの修正
      'markdownlint-cli2', -- Markdownのリント
      stop_after_first = false, -- 全てのフォーマッタを実行
    },
  },

  -- 保存時の自動フォーマット設定
  format_after_save = {
    async = true,         -- 非同期でフォーマットを実行
    timeout_ms = 3000,    -- タイムアウト時間（ミリ秒）
    quiet = false,        -- フォーマット時のメッセージを表示
    stop_after_first = false, -- エラーがあっても全てのフォーマッタを実行
  },

  -- カスタムフォーマッタの設定例（現在はコメントアウト）
  -- formatters = {
  --   textlint = {
  --     meta = {
  --       url = 'https://github.com/textlint/textlint',
  --       description = 'The pluggable natural language linter for text and markdown.',
  --     },
  --     command = require('conform.util').from_node_modules('textlint'),
  --     stdin = true,
  --     args = {
  --       '--fix',
  --       '--stdin',
  --       '--stdin-filename',
  --       '$FILENAME',
  --       '--format',
  --       'fixed-result',
  --       '--dry-run',
  --     },
  --     cwd = require('conform.util').root_file({
  --       'package.json',
  --     }),
  --   },
  -- },

  -- conformにファイルタイプを指定しないとフォーマットがかからないようにする
  -- LSPのフォーマットは使用しない設定
  default_format_opts = {
    lsp_format = 'never',
  },
})

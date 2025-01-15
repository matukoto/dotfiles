local jsFormatter = { 'biome', 'prettierd', 'prettier', stop_after_first = true }

local tsFormatter = function()
  if vim.fs.root(0, 'package.json') then
    return jsFormatter
  else
    return { 'deno_fmt' }
  end
end

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' }, -- 特に設定しなくても ~/.config/stylua/stylua.toml を見てくれる
    sql = { 'sql_formatter' },
    yaml = { 'yamlfmt' },
    java = { lsp_format = 'fallback' },
    sh = { 'shellcheck', 'shfmt', stop_after_first = false },
    json = { 'jq' },
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
    markdown = { 'typos', 'markdownlint-cli2', stop_after_first = false },
  },
  format_on_save = {
    async = true,
    timeout_ms = 3000,
    quiet = false,
    stop_after_first = false,
  },
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
  -- conform にファイルタイプを指定しないとフォーマットがかからないようにする
  default_format_opts = {
    lsp_format = 'never',
  },
})

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
    java = { lsp_format = 'fallback' },
    sh = { 'shellcheck', 'shfmt', stop_after_first = false },
    json = { 'jq' },
    svelte = { 'eslint' },
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
    timeout_ms = 1000,
    quiet = false,
    stop_after_first = false,
  },
  -- conform にファイルタイプを指定しないとフォーマットがかからないようにする
  default_format_opts = {
    lsp_format = 'never',
  },
})

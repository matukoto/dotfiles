local jsFormatter = { { 'biome', 'prettierd', 'prettier', stop_after_first = true } }

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' }, -- 特に設定しなくても ~/.config/stylua/stylua.toml を見てくれる
    sql = { 'sql_formatter' },
    java = { lsp_format = 'fallback' },
    sh = { 'shellcheck', 'shfmt', stop_after_first = false },
    json = { 'jq' },
    javascript = jsFormatter,
    javascriptreact = jsFormatter,
    typescript = jsFormatter,
    typescriptreact = jsFormatter,
    -- ['*'] = { 'typos' }, -- 勝手に訂正されてしまうので、状況次第では有用
    markdown = { 'typos', 'markdownlint-cli2', stop_after_first = false },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true, -- LSP のフォーマッタを使う
    quiet = false,
    stop_after_first = true,
  },
})

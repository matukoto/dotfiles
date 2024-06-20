local jsFormatter = { { 'biome', 'prettierd', 'prettier' } }

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' }, -- 特に設定しなくても ~/.config/stylua/stylua.toml を見てくれる
    sql = { 'sql_formatter' },
    java = { 'google-java-format' },
    sh = { 'shellcheck', 'shfmt' },
    json = jsFormatter,
    javascript = jsFormatter,
    javascriptreact = jsFormatter,
    typescript = jsFormatter,
    typescriptreact = jsFormatter,
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true, -- LSP のフォーマッタを使う
    quiet = false,
  },
})

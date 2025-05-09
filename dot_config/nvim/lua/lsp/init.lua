-- 勉強会で改めてソースを読んだ所、LSP の設定は
-- 1. vim.lsp.config('*', {……})
-- 2. lsp/*.lua
-- 3. after/lsp/*.lua
-- 4. vim.lsp.config('hoge', {……})
-- の順に後勝ちで読み込まれる by delphinus さん

require('mason').setup({
  registries = {
    'github:nvim-java/mason-registry',
    'github:mason-org/mason-registry',
  },
})

require('mason-lspconfig').setup({
  -- mason でインストールした LS を自動で enable する
  automatic_enable = true,
  ensure_installed = {
    'svelte',
    'vtsls',
    'lua_ls',
    'sqls',
    'typos_lsp',
    'bashls',
    -- 'marksman',
    -- 'fsautocomplete',
    'vimls',
    'markdown_oxide',
    'jsonls',
    'yamlls',
    'lemminx',
    'gopls',
    'tailwindcss',
    -- 'jdtls', -- If Java is needed
  },
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
-- vim.lsp.config('*', {
--   capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
-- })

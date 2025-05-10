-- MEMO
-- 1. vim.lsp.config('*', {……})
-- 2. lsp/*.lua
-- 3. after/lsp/*.lua
-- 4. vim.lsp.config('hoge', {……})
-- の順に後勝ちで読み込まれる by delphinus さん

local mason_servers = {
  'svelte',
  'vtsls',
  'lua_ls',
  'sqls',
  'typos_lsp',
  'bashls',
  -- 'marksman',
  -- 'fsautocomplete',
  'vimls',
  'jsonls',
  'yamlls',
  'lemminx',
  'tailwindcss',
  -- 'jdtls', -- If Java is needed
}

local non_mason_servers = {
  'gopls',
}

local mason_tools = {
  'stylua',
  'shellcheck',
  'typos',
  'shfmt',
  'sql-formatter',
  'fixjson',
  'eslint',
  'markdownlint-cli2',
  'yamlfmt',
}

require('mason').setup({
  registries = {
    'github:nvim-java/mason-registry',
    'github:mason-org/mason-registry',
  },
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

require('mason-lspconfig').setup({
  -- mason でインストールした LS を自動で enable する
  automatic_enable = {
    exclude = {
      'vtsls',
    },
  },
  ensure_installed = mason_servers,
})

require('mason-tool-installer').setup({
  ensure_installed = mason_tools,
  auto_update = false,
  run_on_start = true,
})

vim.lsp.enable(non_mason_servers)

-- js, ts の設定を共通化するためにグローバル変数で定義
SharedTsJsSettings = {
  typescript = {
    inlayHints = {
      parameterNames = { enabled = 'all' },
      parameterTypes = { enabled = true },
      variableTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      enumMemberValues = { enabled = true },
    },
  },
  javascript = {
    inlayHints = {
      parameterNames = { enabled = 'all' },
      parameterTypes = { enabled = true },
      variableTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      enumMemberValues = { enabled = true },
    },
  },
}

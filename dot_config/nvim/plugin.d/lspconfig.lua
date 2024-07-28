require('mason').setup({
  registries = {
    'github:nvim-java/mason-registry',
    'github:mason-org/mason-registry',
  },
})
require('mason-lspconfig').setup({
  ensure_installed = {
    'svelte',
    'vtsls',
    'lua_ls',
    'sqls',
    'typos_lsp',
    'bashls',
    -- 'marksman',
    'zk',
    'vimls',
    'markdown_oxide',
  },
})

require('ddc_source_lsp_setup').setup()
-- local capabilities = require('ddc_source_lsp').make_client_capabilities()
-- require('mason-lspconfig').setup_handlers({
--   function(server_name)
--     require('lspconfig')[server_name].setup({
--     })
--   end,
-- })

require('java').setup({})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ctx)
    local set = vim.keymap.set
    local opts = { buffer = ctx.buffer }
    -- 宣言ジャンプ
    -- set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = true })
    -- 定義ジャンプ
    set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    set('n', 'gD', function()
      vim.cmd([[ vsplit ]])
      vim.lsp.buf.definition()
    end, opts)
    -- 定義ホバー
    set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { buffer = true })
    -- 実装へ移動
    set('n', 'gj', vim.lsp.buf.implementation, opts)
    -- 実装をホバー
    set('n', 'gJ', '<cmd>Lspsaga peek_definition<CR>', opts)
    -- 型の実装をホバー
    set('n', 'gt', '<cmd>Lspsaga peek_type_definition<CR>', opts)
    -- 呼び出し元の表示
    set('n', 'gf', '<cmd>Lspsaga finder ref<CR>', opts)
    -- リネーム
    set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
    -- Code action
    set('n', 'ga', '<cmd>Lspsaga code_action<CR>', opts)
    -- 次の診断へ移動
    set('n', 'g[', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    -- 前の診断へ移動
    set('n', 'g]', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

    -- 深刻度によるソート
    vim.diagnostic.config({ severity_sort = true })
  end,
})

-- 保存時自動フォーマット
-- local on_attach = function(client, bufnr)
--   -- ここで `bufnr` は現在のバッファ番号を指す
--   if client.server_capabilities.document_formatting then
--     vim.api.nvim_create_augroup('LspFormatting', { clear = true })
--     vim.api.nvim_create_autocmd('BufWritePre', {
--       group = 'LspFormatting',
--       buffer = bufnr,
--       callback = function()
--         vim.lsp.buf.format({ async = false })
--       end,
--     })
--   end
-- end

local signs = { Error = ' ', Warn = ' ', Hint = '󱩎 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
        path = { '?.lua', '?/init.lua' },
      },
      workspace = {
        library = vim.list_extend(vim.api.nvim_get_runtime_file('lua', true), {
          '${3rd}/luv/library',
          '${3rd}/busted/library',
          '${3rd}/luassert/library',
        }),
        checkThirdParty = 'Disable',
      },
    },
  },
})

lspconfig.jdtls.setup({
  on_attach = on_attach,
  settings = {
    java = {
      format = {
        settings = {
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
    },
  },
})
require('zk').setup({
  -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
  picker = 'telescope',

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { 'zk', 'lsp' },
      name = 'zk',
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { 'markdown' },
    },
  },
})
lspconfig.svelte.setup({
  on_attach = on_attach,
})
-- lspconfig.vtsls.setup({})
lspconfig.vimls.setup({
  on_attach = on_attach,
})

lspconfig.sqls.setup({
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr)
  end,
  settings = {
    sqls = {
      connections = {
        -- {
        --   driver = 'mysql',
        --   dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
        -- },
        {
          driver = 'postgresql',
          dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=postgres dbname=postgres sslmode=disable',
        },
      },
    },
  },
})

lspconfig.typos_lsp.setup({
  init_options = {
    config = '~/.config/typos/typos.toml',
    -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
    diagnosticSeverity = 'Hint',
  },
})

-- Typst LSP
lspconfig.tinymist.setup({
  on_attach = on_attach,
})

lspconfig.zk.setup({
  on_attach = on_attach,
})

-- lspconfig.markdown_oxide.setup({
--   on_attach = on_attach,
-- })
-- vim.lsp.set_log_level('debug')

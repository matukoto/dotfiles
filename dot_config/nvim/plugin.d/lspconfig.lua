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

require('java').setup({
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ctx)
    local set = vim.keymap.set
    set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = true })
    set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = true })
    set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = true })
    set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = true })
    -- set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })
    -- set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { buffer = true })
    -- set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { buffer = true })
    -- set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { buffer = true })
    -- set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    -- set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    -- set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = true })
    set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { buffer = true })
    -- set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { buffer = true })
    set('n', '<Leader>D', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { buffer = true })
    set('n', '<Leader>d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { buffer = true })
    -- set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { buffer = true })
    -- set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })

    -- -- 保存時に自動フォーマット
    -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
    --
    -- if client.supports_method('textDocument/formatting') then
    --   local set_auto_format = function(lsp_name, pattern)
    --     if client.name == lsp_name then
    --       print(string.format('[%s] Enable auto-format on save', lsp_name))
    --       vim.api.nvim_clear_autocmds({ group = augroup })
    --       vim.api.nvim_create_autocmd('BufWritePre', {
    --         group = augroup,
    --         pattern = pattern,
    --         callback = function()
    --           print('[LSP] ' .. client.name .. ' format')
    --           vim.lsp.buf.format({ buffer = ev.buf, async = false })
    --         end,
    --       })
    --     end
    --   end
    --
    --   set_auto_format('rust_analyzer', { '*.rs' })
    --   set_auto_format('ruff_lsp', { '*.py' })
    --   set_auto_format('denols', { '*.ts', '*.js' })
    -- end
    vim.diagnostic.config({ severity_sort = true })
  end,
})

local on_attach = function(client, bufnr)
  -- ここで `bufnr` は現在のバッファ番号を指す
  if client.server_capabilities.document_formatting then
    vim.api.nvim_create_augroup('LspFormatting', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = 'LspFormatting',
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

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
})
lspconfig.bashls.setup({
  on_attach = on_attach,
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

-- lspconfig.markdown_oxide.setup({
--   on_attach = on_attach,
-- })
-- vim.lsp.set_log_level('debug')

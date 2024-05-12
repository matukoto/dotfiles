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
    'marksman',
    'vimls',
  },
})

require("ddc_source_lsp_setup").setup()
-- local capabilities = require('ddc_source_lsp').make_client_capabilities()
require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({})
  end,
})

require('java').setup({})

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
    set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { buffer = true })
    set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { buffer = true })
    -- set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { buffer = true })
    -- set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })
  end,
})

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

lspconfig.jdtls.setup({})

lspconfig.vimls.setup({})
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
          dataSourceName = 'postgresql://postgres:postgres@localhost:5432/postgres',
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

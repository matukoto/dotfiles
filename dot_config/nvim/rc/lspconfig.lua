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
    'jsonls',
    'yamlls',
    'lemminx',
  },
})

require('mason-tool-installer').setup({
  ensure_installed = {
    -- you can pin a tool to a particular version
    --{ 'golangci-lint', version = 'v1.47.0' },
    'stylua',
    'shellcheck',
    'typos',
    'shellcheck',
    'shfmt',
    'sql-formatter',
    'biome',
    'prettierd',
    'prettier',
    'eslint',
    'markdownlint-cli2',
  },
  auto_update = false,
  run_on_start = true,
})

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
    set('n', 'gl', vim.lsp.buf.implementation, opts)
    -- 実装をホバー
    set('n', 'gL', '<cmd>Lspsaga peek_definition<CR>', opts)
    -- 型の実装をホバー
    set('n', 'gt', '<cmd>Lspsaga peek_type_definition<CR>', opts)
    -- 呼び出し元の表示
    set('n', 'gf', '<cmd>Lspsaga finder ref<CR>', opts)
    -- リネーム
    set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
    -- Code action
    set('n', 'ga', '<cmd>Lspsaga code_action<CR>', opts)
    -- diagnostic
    set('n', 'gb', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)
    set('n', 'gw', '<cmd>Lspsaga show_workspace_diagnostics<CR>', opts)
    set('n', 'ge', vim.diagnostic.open_float, { desc = 'diagnostic open_float' })
    set('n', 'gq', vim.diagnostic.setqflist, { desc = 'LSP diagnostic setqflist' })
    -- 次の診断へ移動
    set('n', 'g[', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    -- 前の診断へ移動
    set('n', 'g]', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

    -- inlay hint
    -- if client.supports_method('textDocument/inlayHint') then
    --   vim.lsp.inlay_hint.enable()
    -- end

    vim.diagnostic.config({
      -- 深刻度によるソート
      severity_sort = true,
      -- vertual_text = {
      --   severity = { min = 'Warn' },
      -- },
      float = {
        border = 'single',
        header = {},
        suffix = {},
        format = function(diag)
          if diag.code then
            return string.format('[%s](%s): %s', diag.source, diag.code, diag.message)
          else
            return string.format('[%s]: %s', diag.source, diag.message)
          end
        end,
      },
    })
  end,
})

local signs = { Error = ' ', Warn = ' ', Hint = '󱩎 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

local lspconfig = require('lspconfig')

lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})

lspconfig.lua_ls.setup({
  hint = {
    enable = true,
    paramName = 'Disable',
    semicolon = 'Disable',
  },
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

lspconfig.jsonls.setup({})

lspconfig.bashls.setup({})

lspconfig.rust_analyzer.setup({})

lspconfig.yamlls.setup({})

-- require('zk').setup({
--   -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
--   -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
--   picker = 'telescope',
--
--   lsp = {
--     -- `config` is passed to `vim.lsp.start_client(config)`
--     config = {
--       cmd = { 'zk', 'lsp' },
--       name = 'zk',
--       -- etc, see `:h vim.lsp.start_client()`
--     },
--
--     -- automatically attach buffers in a zk notebook that match the given filetypes
--     auto_attach = {
--       enabled = true,
--       filetypes = { 'markdown' },
--     },
--   },
-- })
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
lspconfig.tinymist.setup({})

-- node , deno 使い分け
local is_node_dir = function()
  return lspconfig.util.root_pattern('package.json')(vim.fn.getcwd())
end

-- ts_ls
local ts_opts = {}
ts_opts.on_attach = function(client)
  if not is_node_dir() then
    client.stop(true)
  end
end
lspconfig.vtsls.setup({
  on_attach = ts_opts.on_attach,
  single_file_support = false,
})

-- denols
local deno_opts = {}
deno_opts.on_attach = function(client)
  if is_node_dir() then
    client.stop(true)
  end
end

lspconfig.denols.setup({
  on_attach = deno_opts.on_attach,
  single_file_support = true,
})

lspconfig.svelte.setup({})

-- lspconfig.zk.setup({})

lspconfig.lemminx.setup({})

-- require('java').setup({
--   -- load java test plugins
--   java_test = {
--     enable = true,
--   },
--
--   -- load java debugger plugins
--   java_debug_adapter = {
--     enable = true,
--   },
--
--   spring_boot_tools = {
--     enable = false,
--   },
--
--   jdk = {
--     -- install jdk using mason.nvim
--     auto_install = true,
--   },
--
--   notifications = {
--     -- enable 'Configuring DAP' & 'DAP configured' messages on start up
--     dap = false,
--   },
--
--   -- We do multiple verifications to make sure things are in place to run this
--   -- plugin
--   verification = {
--     -- nvim-java checks for the order of execution of following
--     -- * require('java').setup()
--     -- * require('lspconfig').jdtls.setup()
--     -- IF they are not executed in the correct order, you will see a error
--     -- notification.
--     -- Set following to false to disable the notification if you know what you
--     -- are doing
--     invalid_order = true,
--
--     -- nvim-java checks if the require('java').setup() is called multiple
--     -- times.
--     -- IF there are multiple setup calls are executed, an error will be shown
--     -- Set following property value to false to disable the notification if
--     -- you know what you are doing
--     duplicate_setup_calls = true,
--
--     -- nvim-java checks if nvim-java/mason-registry is added correctly to
--     -- mason.nvim plugin.
--     -- IF it's not registered correctly, an error will be thrown and nvim-java
--     -- will stop setup
--     invalid_mason_registry = true,
--   },
-- })
--
-- require('lspconfig').jdtls.setup({
--   settings = {
--     java = {
--       import = {
--         gradle = {
--           enabled = true,
--         },
--         maven = {
--           enabled = true,
--         },
--       },
--       format = {
--         settings = {
--           url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
--           profile = 'GoogleStyle',
--         },
--       },
--       saveActions = {
--         organizeImports = true,
--       },
--     },
--   },
-- })

require('lspconfig').tailwindcss.setup({})
-- lspconfig.markdown_oxide.setup({
-- })
-- vim.lsp.set_log_level('debug')
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { bg = '#888888', fg = '#efef33' })
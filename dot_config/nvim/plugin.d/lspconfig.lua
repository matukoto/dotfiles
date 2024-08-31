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

require('ddc_source_lsp_setup').setup()
-- local capabilities = require('ddc_source_lsp').make_client_capabilities()
-- require('mason-lspconfig').setup_handlers({
--   function(server_name)
--     require('lspconfig')[server_name].setup({
--     })
--   end,
-- })

require('java').setup({
  --  list of file that exists in root of the project
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
    'build.gradle',
    'mvnw',
    'gradlew',
    'build.gradle',
    'build.gradle.kts',
    '.git',
  },

  -- load java test plugins
  java_test = {
    enable = true,
  },

  -- load java debugger plugins
  java_debug_adapter = {
    enable = true,
  },

  spring_boot_tools = {
    enable = false,
  },

  jdk = {
    -- install jdk using mason.nvim
    auto_install = true,
  },

  notifications = {
    -- enable 'Configuring DAP' & 'DAP configured' messages on start up
    dap = false,
  },

  -- We do multiple verifications to make sure things are in place to run this
  -- plugin
  verification = {
    -- nvim-java checks for the order of execution of following
    -- * require('java').setup()
    -- * require('lspconfig').jdtls.setup()
    -- IF they are not executed in the correct order, you will see a error
    -- notification.
    -- Set following to false to disable the notification if you know what you
    -- are doing
    invalid_order = true,

    -- nvim-java checks if the require('java').setup() is called multiple
    -- times.
    -- IF there are multiple setup calls are executed, an error will be shown
    -- Set following property value to false to disable the notification if
    -- you know what you are doing
    duplicate_setup_calls = true,

    -- nvim-java checks if nvim-java/mason-registry is added correctly to
    -- mason.nvim plugin.
    -- IF it's not registered correctly, an error will be thrown and nvim-java
    -- will stop setup
    invalid_mason_registry = true,
  },
})

on_attach = function(client, bufnr)
  require('lsp_signature').on_attach({
    bind = true,
    hint_enable = true,
    floating_window = true,
    hint_prefix = '🐼 ',
    hi_parameter = 'LspSignatureActiveParameter',
    handler_opts = {
      border = 'rounded',
    },
  }, bufnr)
end

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
    -- 次の診断へ移動
    set('n', 'g[', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    -- 前の診断へ移動
    set('n', 'g]', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

    -- inlay hint
    -- if client.supports_method('textDocument/inlayHint') then
    --   vim.lsp.inlay_hint.enable()
    -- end

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
  on_attach = on_attach,
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

lspconfig.jsonls.setup({
  on_attach = on_attach,
})

lspconfig.jdtls.setup({
  on_attach = on_attach,
  settings = {
    java = {
      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
      },
      format = {
        settings = {
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
      saveActions = {
        organizeImports = true,
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
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { bg = '#888888', fg = '#efef33' })

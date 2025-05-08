-- dot_config/nvim/lua/plugins/lspconfig.lua
return {
  -- Main LSP configuration plugin
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  -- Dependencies - these should also be listed in the main plugins file
  -- lazy.nvim handles loading dependencies before the main plugin
  dependencies = {
    {
      'williamboman/mason.nvim',
      registries = {
        'github:nvim-java/mason-registry',
        'github:mason-org/mason-registry',
      },
    },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'j-hui/fidget.nvim',
    'nvimdev/lspsaga.nvim',
    'jinzhongjia/LspUI.nvim',
    'saghen/blink.cmp',
  },

  -- config function runs after the plugin and its dependencies are loaded
  config = function()
    local lspconfig = require('lspconfig')
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    -- Define diagnostic signs
    local signs = { Error = ' ', Warn = ' ', Hint = '󱩎 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end

    -- Configure Mason
    mason.setup({
      registries = {
        'github:nvim-java/mason-registry',
        'github:mason-org/mason-registry',
      },
      -- Other mason options like ui = { border = 'rounded' } can go here
    })

    -- Configure Mason Tool Installer
    mason_tool_installer.setup({
      ensure_installed = {
        'stylua',
        'shellcheck',
        'typos',
        'shfmt',
        'sql-formatter',
        'fixjson',
        'biome',
        'prettierd',
        'prettier',
        'eslint', -- Corrected from duplicate shellcheck
        'markdownlint-cli2',
      },
      auto_update = false,
      run_on_start = true,
    })

    -- Function to register servers with capabilities
    local function server_register(server_name)
      local opts = {}
      local success, req_opts = pcall(require, 'plugins.lsp.servers.' .. server_name)
      if success then
        opts = req_opts
      end
      opts.capabilities = require('blink.cmp').get_lsp_capabilities(opts.capabilities)
      lspconfig[server_name].setup(opts)
    end

    -- Configure Mason Lspconfig bridge
    -- This defines which servers to install and manages their setup via server_register
    mason_lspconfig.setup({
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
        'gopls', -- Added missing servers from individual setups below
        'rust_analyzer',
        'tinymist',
        'denols',
        'tailwindcss',
        -- 'jdtls', -- If Java is needed
      },
      handlers = {
        -- Default handler using the server_register function defined above
        server_register,

        -- Custom setup for specific servers can be done here if needed,
        -- overriding the default handler.
        -- Example:
        -- ["lua_ls"] = function()
        --   lspconfig.lua_ls.setup({
        --     capabilities = capabilities, -- Make sure capabilities are in scope
        --     settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
        --   })
        -- end,

        -- Keep individual setups below for settings overrides for now
      },
    })

    -- Autocmd for LspAttach to configure keymaps and diagnostics
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local set = vim.keymap.set

        -- Keymaps using LspUI / Lspsaga if available, otherwise fallback to vim.lsp.buf
        local lspsaga_ok, lspsaga = pcall(require, 'lspsaga')
        local lspui_ok, LspUI = pcall(require, 'LspUI')

        -- Hover
        if lspui_ok then
          set('n', 'K', '<cmd>LspUI hover<CR>', opts)
        else
          set('n', 'K', vim.lsp.buf.hover, opts)
        end

        -- Go to Definition
        set('n', 'gd', vim.lsp.buf.definition, opts)
        set('n', 'gD', function()
          vim.cmd([[ vsplit ]])
          vim.lsp.buf.definition()
        end, opts) -- Split definition

        -- Go to Implementation
        if lspui_ok then
          set('n', 'gl', '<cmd>LspUI implementation<CR>', opts)
        else
          set('n', 'gi', vim.lsp.buf.implementation, opts) -- Standard mapping is gi
        end

        -- Go to Type Definition
        if lspui_ok then
          set('n', 'gt', '<cmd>LspUI type_definition<CR>', opts)
        else
          set('n', 'gy', vim.lsp.buf.type_definition, opts) -- Standard mapping is gy
        end

        -- Find References
        if lspui_ok then
          set('n', 'gf', '<cmd>LspUI finder ref<CR>', opts)
        else
          set('n', 'gr', vim.lsp.buf.references, opts) -- Standard mapping is gr
        end

        -- Rename
        if lspui_ok then
          set('n', 'gr', '<cmd>LspUI rename<CR>', opts) -- Note: Overlaps with standard 'gr' if LspUI not present
        else
          set('n', '<F2>', vim.lsp.buf.rename, opts) -- Use F2 as a common alternative
        end

        -- Code Actions
        if lspsaga_ok then
          set({ 'n', 'v' }, 'ga', '<cmd>Lspsaga code_action<CR>', opts)
        else
          set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts)
        end

        -- Diagnostics
        if lspsaga_ok then
          set('n', 'gb', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)
          set('n', 'gw', '<cmd>Lspsaga show_workspace_diagnostics<CR>', opts)
        else
          -- Fallback or use other diagnostic plugins like trouble.nvim
        end
        set('n', 'ge', vim.diagnostic.open_float, opts)
        set('n', 'gq', vim.diagnostic.setqflist, opts)
        if lspui_ok then
          set('n', 'g[', '<cmd>LspUI diagnostic prev<CR>', opts)
          set('n', 'g]', '<cmd>LspUI diagnostic next<CR>', opts)
        else
          set('n', '[d', vim.diagnostic.goto_prev, opts) -- Standard mapping
          set('n', ']d', vim.diagnostic.goto_next, opts) -- Standard mapping
        end

        -- Configure diagnostics appearance
        vim.diagnostic.config({
          severity_sort = true,
          virtual_text = false, -- Disable virtual text diagnostics (can be noisy)
          signs = true, -- Use signs defined earlier
          underline = true,
          update_in_insert = false,
          float = {
            border = 'single',
            header = '', -- No header
            prefix = '', -- No prefix
            suffix = '', -- No suffix
            source = 'if_many', -- Show source only if multiple sources exist for the same diagnostic
            format = function(diag) -- Custom format
              local code = diag.code or ''
              local source = diag.source or ''
              local message = diag.message or ''
              -- Simple format: [Source Code] Message
              if code ~= '' then
                return string.format('[%s %s] %s', source, code, message)
              elseif source ~= '' then
                return string.format('[%s] %s', source, message)
              else
                return message
              end
            end,
          },
        })

        -- Inlay Hints (if server supports it)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          -- Check if inlay hint function exists (Neovim 0.10+)
          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            -- Legacy check for older Neovim versions (if needed)
            -- elseif vim.lsp.buf.inlay_hint then
            --    vim.lsp.buf.inlay_hint(ev.buf, true)
          end
        end

        -- Optional: Format on save
        -- if client and client.server_capabilities.documentFormattingProvider then
        --   vim.api.nvim_create_autocmd('BufWritePre', {
        --     buffer = ev.buf,
        --     callback = function() vim.lsp.buf.format({ async = false }) end
        --   })
        -- end
      end,
    })

    -- Highlight for active signature parameter
    vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { bg = '#888888', fg = '#efef33' })

    -- Specific Server Settings (Applied *after* the default handler runs)
    -- These settings will be merged with the defaults provided by mason-lspconfig

    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true,
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          },
        },
      },
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) }, -- Include vim runtime paths
          hint = {
            enable = true,
            await = true,
            paramName = 'Literal',
            paramType = true,
            semicolon = 'Disable',
            arrayIndex = 'Disable',
          },
          diagnostics = { globals = { 'vim' }, groupFileStatus = { await = 'Opened' } }, -- Recognize vim global
          completion = { callSnippet = 'Replace' }, -- Better snippet handling
        },
      },
    })

    lspconfig.sqls.setup({
      -- on_attach is handled globally by the LspAttach autocmd now
      settings = {
        sqls = {
          connections = {
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
        -- Consider making the config path absolute or relative to a known location
        -- config = vim.fn.expand('~/.config/typos/typos.toml'),
        diagnosticSeverity = 'Hint',
      },
    })

    -- Node/Deno switching logic
    local is_node_dir = function()
      return vim.fs.find('package.json', { upward = true, stop = vim.loop.os_homedir() })[1]
    end

    local shared_ts_js_settings = {
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
      javascript = { -- Also apply hints to JS if desired
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

    lspconfig.vtsls.setup({
      -- on_attach handled globally, but add conditional logic here if needed
      on_attach = function(client, bufnr)
        if not is_node_dir() then
          -- print("Stopping vtsls in non-node directory: " .. vim.api.nvim_buf_get_name(bufnr))
          client.stop()
        -- Optionally detach completely if stop doesn't prevent further interaction
        -- vim.lsp.buf_detach_client(bufnr, client.id)
        else
          -- print("Attaching vtsls in node directory: " .. vim.api.nvim_buf_get_name(bufnr))
          -- Call the global attach function if you still want the keymaps etc.
          -- Find the UserLspConfig autocmd callback and call it
          local group_id = vim.api.nvim_get_autocmds({ group = 'UserLspConfig', event = 'LspAttach' })
          if group_id and group_id[1] and group_id[1].callback then
            group_id[1].callback({ buf = bufnr, data = { client_id = client.id } })
          end
        end
      end,
      settings = shared_ts_js_settings,
    })

    lspconfig.denols.setup({
      -- on_attach handled globally, but add conditional logic here if needed
      on_attach = function(client, bufnr)
        if is_node_dir() then
          -- print("Stopping denols in node directory: " .. vim.api.nvim_buf_get_name(bufnr))
          client.stop()
        -- vim.lsp.buf_detach_client(bufnr, client.id)
        else
          -- print("Attaching denols in non-node directory: " .. vim.api.nvim_buf_get_name(bufnr))
          local group_id = vim.api.nvim_get_autocmds({ group = 'UserLspConfig', event = 'LspAttach' })
          if group_id and group_id[1] and group_id[1].callback then
            group_id[1].callback({ buf = bufnr, data = { client_id = client.id } })
          end
        end
      end,
      root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
      init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
              ['https://deno.land'] = true,
              ['https://cdn.skypack.dev'] = true,
              ['https://esm.sh'] = true,
            },
          },
        },
      },
      settings = shared_ts_js_settings,
    })

    lspconfig.svelte.setup({
      -- on_attach handled globally
      settings = {
        -- Apply shared settings and svelte specific ones
        typescript = shared_ts_js_settings.typescript,
        javascript = shared_ts_js_settings.javascript,
        svelte = {
          inlayHints = {
            parameterNames = { enabled = 'all' },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      },
    })
    -- local home_dir = vim.env.HOME
    -- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    -- local workspace_dir = home_dir .. '/.cache/nvim/jdtls/workspaces/' .. project_name
    -- lspconfig.jdtls.setup({
    --   cmd = {
    --     home_dir .. '/.local/share/mise/installs/java/corretto-17.0.14.7.1/bin/java',
    --     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    --     '-Dosgi.bundles.defaultStartLevel=4',
    --     '-Declipse.product=org.eclipse.jdt.ls.core.product',
    --     '-Dosgi.checkConfiguration=true',
    --     '-Dosgi.sharedConfiguration.area=/home/matsumoto/.local/share/nvim/mason/share/jdtls/config',
    --     '-Dosgi.sharedConfiguration.area.readOnly=true',
    --     '-Dosgi.configuration.cascaded=true',
    --     '-Xms1G',
    --     '--add-modules=ALL-SYSTEM',
    --     '--add-opens',
    --     'java.base/java.util=ALL-UNNAMED',
    --     '--add-opens',
    --     'java.base/java.lang=ALL-UNNAMED',
    --     '-javaagent:/home/matsumoto/.local/share/nvim/mason/share/lombok-nightly/lombok.jar',
    --     '-jar',
    --     '/home/matsumoto/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    --     '-configuration',
    --     '/home/matsumoto/.cache/nvim/jdtls/config',
    --     '-data',
    --     workspace_dir,
    --   },
    --   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
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

    lspconfig.bashls.setup({})
    lspconfig.rust_analyzer.setup({})
    lspconfig.yamlls.setup({})
    lspconfig.vimls.setup({})
    lspconfig.jsonls.setup({})
    lspconfig.lemminx.setup({})
    lspconfig.fsautocomplete.setup({})
    lspconfig.tailwindcss.setup({})
    lspconfig.markdown_oxide.setup({})
    lspconfig.tinymist.setup({})
  end,
}

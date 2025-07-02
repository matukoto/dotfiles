-- MEMO
-- 1. vim.lsp.config('*', {……})
-- 2. lua/lsp/*.lua
-- 3. nvim-lspconfig
-- 4. after/lsp/*.lua
-- 5. vim.lsp.config('hoge', {……})
-- の順に後勝ちで読み込まれる

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
}

local non_mason_servers = {
  'gopls',
  'denols',
  'jdtls',
}

local mason_tools = {
  'stylua',
  'shellcheck',
  'typos',
  'shfmt',
  'sql-formatter',
  'fixjson',
  'eslint_d',
  'markdownlint-cli2',
  'yamlfmt',
}

return {
  -- Main LSP configuration plugin
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    -- Dependencies - these should also be listed in the main plugins file
    -- lazy.nvim handles loading dependencies before the main plugin
    dependencies = {
      'j-hui/fidget.nvim',
      'nvimdev/lspsaga.nvim',
      'jinzhongjia/LspUI.nvim',
      'saghen/blink.cmp',
      {
        'mason-org/mason.nvim',
        config = function()
          require('mason').setup({
            registries = {
              'github:nvim-java/mason-registry',
              'github:mason-org/mason-registry',
            },
          })
        end,
      },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },

    -- config function runs after the plugin and its dependencies are loaded
    config = function()
      local lspconfig = require('lspconfig')
      -- Add additional capabilities supported by nvim-cmp
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      require('mason')
      require('mason-lspconfig').setup({
        -- mason でインストールした LS を自動で enable する
        automatic_enable = {
          exclude = {
            -- 'vtsls',
          },
        },
        ensure_installed = mason_servers,
      })

      require('mason-tool-installer').setup({
        ensure_installed = mason_tools,
        auto_update = false,
        run_on_start = true,
      })

      vim.lsp.enable(non_mason_servers) -- Define diagnostic signs
      local signs = { Error = ' ', Warn = ' ', Hint = '󱩎 ', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
      end

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
          -- if lspsaga_ok then
          --   set({ 'n', 'v' }, 'ga', '<cmd>Lspsaga code_action<CR>', opts)
          -- else
          --   set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts)
          -- end

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
    end,
  },
  {
    'mfussenegger/nvim-jdtls',
    dependencies = { 'mason-org/mason.nvim' },
    ft = 'java',
  },
}

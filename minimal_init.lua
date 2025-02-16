-- 最小構成のサンプル
-- このファイルを保存後、以下のように起動してテストしてください:
--    nvim -u ~/.config/nvim/minimal_init.lua sample.lua

-- packpath の設定 (必要に応じて書き換え)
-- Windows / 各環境に合わせて調整してください
-- vim.opt.packpath = vim.fn.stdpath('data') .. '/site'

-- ネイティブ LSP を利用するために 'nvim-lspconfig' がインストールされている前提
-- packer / lazy などのプラグインマネージャでインストールしている場合、packadd が必要になることもあります
--  例): vim.cmd [[packadd nvim-lspconfig]]
vim.opt.runtimepath:append('/home/matukoto/.local/share/nvim/site/pack/jetpack/opt/nvim-lspconfig')
vim.opt.runtimepath:append('/home/matukoto/.local/share/nvim/site/pack/jetpack/opt/lazydev.nvim')
vim.opt.runtimepath:append('/home/matukoto/.local/share/nvim/site/pack/jetpack/opt/nvim-treesitter')

require('lazydev').setup()
local lspconfig = require('lspconfig')

-- Lua LSの設定 (inlay hint 有効化)
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
      },
      hint = {
        enable = true,
        arrayIndex = 'Enable',
        setType = true,
      },
    },
  },
})

-- Enable inlay hints
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true)
      end
    end
  end,
})

-- エラーなどの診断表示設定 (必要に応じて調整)
vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = 'single',
  },
})

print('Minimal LSP config loaded.')

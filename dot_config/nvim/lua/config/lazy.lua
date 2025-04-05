-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  -- クローン時に安定版ブランチを指定
  local out =
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins.aerial' },
    { import = 'plugins.blink' },
    { import = 'plugins.bufferline' },
    { import = 'plugins.camelcasemotion' },
    { import = 'plugins.ccc' },
    { import = 'plugins.chowcho' },
    { import = 'plugins.codecompanion' },
    { import = 'plugins.comment' },
    { import = 'plugins.conform' },
    { import = 'plugins.copilot-chat' },
    { import = 'plugins.copilot' },
    { import = 'plugins.ddc' },
    { import = 'plugins.denops' },
    { import = 'plugins.dial' },
    { import = 'plugins.dmacro' },
    -- { import = "plugins.fern-git-status" }, -- Moved to fern.lua dependencies
    -- { import = "plugins.fern-renderer-nerdfont" }, -- Moved to fern.lua dependencies
    { import = 'plugins.fern' }, -- Keep this, it loads fern.lua which now includes dependencies
    { import = 'plugins.fidget' },
    { import = 'plugins.flash' },
    { import = 'plugins.fm-nvim' },
    { import = 'plugins.full_visual_line' },
    { import = 'plugins.fuzzy-motion' },
    { import = 'plugins.gin' },
    { import = 'plugins.gitgraph' },
    { import = 'plugins.gitsigns' },
    { import = 'plugins.hlchunk' },
    { import = 'plugins.hlslens' },
    { import = 'plugins.lazydev' },
    { import = 'plugins.lexima' },
    { import = 'plugins.lspconfig' },
    { import = 'plugins.lspsaga' },
    { import = 'plugins.lspui' },
    { import = 'plugins.lualine' },
    { import = 'plugins.markdown' },
    { import = 'plugins.mini-test' },
    { import = 'plugins.neotest' },
    { import = 'plugins.nvim-lastplace' },
    { import = 'plugins.nvim-lint' },
    { import = 'plugins.nvim-ts-autotag' },
    { import = 'plugins.oil' },
    { import = 'plugins.open-browser' },
    { import = 'plugins.project' },
    { import = 'plugins.quicker' },
    { import = 'plugins.rainbow-csv' },
    { import = 'plugins.scope' },
    { import = 'plugins.skkeleton_indicator' },
    { import = 'plugins.skkeleton' },
    { import = 'plugins.smartbufs' },
    { import = 'plugins.smoothcursor' },
    { import = 'plugins.snacks' },
    { import = 'plugins.styler' },
    { import = 'plugins.telescope' },
    { import = 'plugins.term-edit' },
    { import = 'plugins.tiny-code-action' },
    { import = 'plugins.todo-comments' },
    { import = 'plugins.toggleterm' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.trouble' },
    { import = 'plugins.ufo' },
    { import = 'plugins.vim-cheatsheet' },
    { import = 'plugins.vim-dadbod-ui' },
    { import = 'plugins.vim-edgemotion' },
    { import = 'plugins.vim-quickrun' },
    { import = 'plugins.vim-sonictemplate' },
    { import = 'plugins.waitevent' },
    { import = 'plugins.which-key' },
    { import = 'plugins.yazi' },

    -- plugins.lua にのみ記載があり、個別の設定ファイルがないプラグイン
    { 'vim-jp/vimdoc-ja', event = 'VeryLazy' },
    { 'williamboman/mason.nvim' }, -- LSP基盤なので一旦そのまま
    { 'williamboman/mason-lspconfig.nvim' }, -- LSP基盤なので一旦そのまま
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', event = 'VeryLazy' },
    { 'nanotee/sqls.nvim', event = 'VeryLazy' },
    { 'rachartier/tiny-inline-diagnostic.nvim', event = 'VeryLazy' },
    { 'shougo/pum.vim', event = 'VeryLazy' },
    -- { "yuki-yano/fern-preview.vim" }, -- Moved to fern.lua dependencies
    -- { "lambdalisue/vim-fern-hijack" }, -- Moved to fern.lua dependencies
    { 'AndreM222/copilot-lualine', event = 'VeryLazy' },
    { 'nvim-treesitter/nvim-treesitter-context', event = 'VeryLazy' },
    -- { "lambdalisue/vim-nerdfont" }, -- Moved to fern.lua dependencies
    { 'ogaken-1/nvim-gin-preview', event = 'VeryLazy' },
    { 'sindrets/diffview.nvim', cmd = 'DiffviewOpen' }, -- コマンド実行時にロード
    { 'lambdalisue/vim-kensaku', event = 'VeryLazy' },
    { 'lambdalisue/vim-kensaku-search', event = 'VeryLazy' },
    { 'famiu/bufdelete.nvim', event = 'VeryLazy' },
    { 'kevinhwang91/nvim-bqf', event = 'VeryLazy' }, -- Quickfix/Location Listが開かれた時に必要だが、VeryLazyでも問題ないことが多い
    { 'haya14busa/vim-asterisk', event = 'VeryLazy' },
    { 'tyru/capture.vim', event = 'VeryLazy' },
    { 'itchyny/vim-cursorword', event = 'VeryLazy' },
    { 'lambdalisue/vim-suda', cmd = 'SudaWrite' }, -- コマンド実行時にロード
    { 'nanotee/zoxide.vim', cmd = { 'Zi', 'Zcd' } }, -- コマンド実行時にロード
    { 'simeji/winresizer', event = 'VeryLazy' },
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'machakann/vim-sandwich', event = 'VeryLazy' },
    { 'wakatime/vim-wakatime', event = 'VeryLazy' },
    { 'tpope/vim-dadbod', event = 'VeryLazy' }, -- dadbod-ui などが cmd でロードされるならこれも遅延可能
    { 'neko-night/nvim' }, -- カラースキームは即時ロード

    -- 依存関係として必要だが import されていないプラグイン
    { 'kevinhwang91/promise-async' }, -- nvim-ufo dependency (依存関係は即時ロード)
    { 'nvim-tree/nvim-web-devicons' }, -- lualine dependency (依存関係は即時ロード)
    { 'nvim-neotest/nvim-nio' }, -- neotest dependency (依存関係は即時ロード)
    { 'antoinemadec/FixCursorHold.nvim' }, -- neotest dependency (依存関係は即時ロード)
    { 'marilari88/neotest-vitest' }, -- neotest dependency (依存関係は即時ロード)
    { 'nvim-lua/plenary.nvim' }, -- telescope dependency (依存関係は即時ロード)
    { 'natecraddock/telescope-zf-native.nvim', build = 'make' }, -- telescope dependency (依存関係は即時ロード)
    { 'kkharji/sqlite.lua' }, -- telescope dependency (依存関係は即時ロード)
    { 'danielfalk/smart-open.nvim' }, -- telescope dependency (依存関係は即時ロード)
    { 'atusy/qfscope.nvim' }, -- telescope dependency (依存関係は即時ロード)
    { 'cljoly/telescope-repo.nvim' }, -- telescope dependency (依存関係は即時ロード)
    { 'prochri/telescope-all-recent.nvim' }, -- telescope dependency (依存関係は即時ロード)

    -- 必要に応じて他のプラグインや設定をここに追加
  },
  -- 必要に応じて他の lazy.nvim の設定をここに追加できます
  -- 例: change_detection = { notify = false }
})

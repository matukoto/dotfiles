-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  -- クローン時に安定版ブランチを指定
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
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
    { import = 'plugins.conform' },
    { import = 'plugins.copilot-chat' },
    { import = 'plugins.copilot' },
    { import = 'plugins.ddc' },
    { import = 'plugins.denops' },
    { import = 'plugins.dial' },
    { import = 'plugins.dmacro' },
    { import = 'plugins.fern' },
    { import = 'plugins.fidget' },
    { import = 'plugins.flash' },
    { import = 'plugins.fm-nvim' },
    { import = 'plugins.full_visual_line' },
    { import = 'plugins.fuzzy-motion' },
    { import = 'plugins.gin' },
    { import = 'plugins.gitgraph' },
    { import = 'plugins.gitsigns' },
    { import = 'plugins.hlslens' },
    { import = 'plugins.lazydev' },
    { import = 'plugins.lexima' },
    { import = 'plugins.lspconfig' },
    { import = 'plugins.lspsaga' },
    { import = 'plugins.lspui' },
    { import = 'plugins.nvim-java' },
    { import = 'plugins.lualine' },
    { import = 'plugins.render-markdown' },
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
    { import = 'plugins.smoothcursor' },
    { import = 'plugins.snacks' },
    { import = 'plugins.styler' },
    { import = 'plugins.term-edit' },
    { import = 'plugins.todo-comments' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.trouble' },
    { import = 'plugins.ufo' },
    { import = 'plugins.vim-dadbod-ui' },
    { import = 'plugins.vim-edgemotion' },
    { import = 'plugins.vim-quickrun' },
    { import = 'plugins.vim-sonictemplate' },
    { import = 'plugins.waitevent' },
    { import = 'plugins.which-key' },
    { import = 'plugins.yazi' },
    { import = 'plugins.aider' },
    -- plugins.lua にのみ記載があり、個別の設定ファイルがないプラグイン
    { 'vim-jp/vimdoc-ja', event = 'VeryLazy' },
    -- { 'nanotee/sqls.nvim', event = 'VeryLazy' },
    { 'rachartier/tiny-inline-diagnostic.nvim', event = 'VeryLazy' },
    { 'shougo/pum.vim', event = 'VeryLazy' },
    { 'nvim-treesitter/nvim-treesitter-context', event = 'VeryLazy' },
    { 'ogaken-1/nvim-gin-preview', event = 'VeryLazy' },
    { 'sindrets/diffview.nvim', cmd = 'DiffviewOpen' },
    { 'lambdalisue/vim-kensaku', event = 'VeryLazy' },
    { 'lambdalisue/vim-kensaku-search', event = 'VeryLazy' },
    { 'kevinhwang91/nvim-bqf', event = 'VeryLazy' },
    { 'haya14busa/vim-asterisk', event = 'VeryLazy' },
    { 'tyru/capture.vim', event = 'VeryLazy' },
    { 'itchyny/vim-cursorword', event = 'VeryLazy' },
    { 'lambdalisue/vim-suda', cmd = 'SudaWrite' },
    { 'simeji/winresizer', event = 'VeryLazy' },
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'machakann/vim-sandwich', event = 'VeryLazy' },
    { 'wakatime/vim-wakatime', event = 'VeryLazy' },
    { 'tpope/vim-dadbod', event = 'VeryLazy' },
    { 'neko-night/nvim' }, -- カラースキームは即時ロード
  },
})

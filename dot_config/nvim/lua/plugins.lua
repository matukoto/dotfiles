-- lua/plugins.lua
return {
  -- Core plugin manager
  'folke/lazy.nvim', -- Not strictly needed to list here, but good for clarity

  -- Documentation
  'vim-jp/vimdoc-ja',

  -- Denops
  'vim-denops/denops.vim',
  -- 'vim-denops/denops-shared-server.vim', -- systemd required

  -- LSP
  'neovim/nvim-lspconfig',
  -- 'nvim-lua/lsp-status.nvim', -- Consider alternatives like lualine
  'nvimdev/lspsaga.nvim',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  'jinzhongjia/LspUI.nvim',
  {'j-hui/fidget.nvim', tag = 'legacy' }, -- Specify tag if needed, check repo for latest
  'nanotee/sqls.nvim',
  'rachartier/tiny-code-action.nvim',
  'rachartier/tiny-inline-diagnostic.nvim',
  -- 'nvimtools/none-ls.nvim', -- Consider alternatives like conform.nvim + nvim-lint

  -- Java specific (Consider enabling if needed)
  -- 'nvim-java/lua-async-await',
  -- 'nvim-java/nvim-java-refactor',
  -- 'nvim-java/nvim-java-core',
  -- 'nvim-java/nvim-java-test',
  -- 'nvim-java/nvim-java-dap',
  -- 'MunifTanjim/nui.nvim',
  -- 'JavaHello/spring-boot.nvim',
  -- 'nvim-java/nvim-java',

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },

  -- Completion (ddc - consider switching to nvim-cmp for a more Lua-native experience)
  'shougo/ddc.vim',
  { 'saghen/blink.cmp', build = 'cargo build --release' },
  -- filter
  -- 'shougo/ddc-matcher_head',
  -- 'shougo/ddc-sorter_rank',
  -- 'tani/ddc-fuzzy',
  -- ui
  'shougo/ddc-ui-pum',
  'shougo/pum.vim',
  -- sources
  -- 'shougo/ddc-source-lsp',
  -- 'shougo/ddc-source-around',
  -- 'LumaKernel/ddc-source-file',
  -- 'uga-rosa/ddc-source-lsp-setup',
  -- 'matsui54/ddc-source-buffer',
  -- 'uga-rosa/ddc-source-nvim-lua',
  -- 'shougo/ddc-source-cmdline',
  -- 'shougo/ddc-source-cmdline_history',
  -- 'shougo/ddc-filter-converter_remove_overlap',
  -- popup
  -- 'matsui54/denops-popup-preview.vim',
  -- 'matsui54/denops-signature_help',

  -- File Explorer
  'lambdalisue/vim-fern',
  'yuki-yano/fern-preview.vim',
  'stevearc/oil.nvim',
  'lambdalisue/vim-fern-git-status',
  'lambdalisue/vim-fern-hijack',

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  'AndreM222/copilot-lualine',
  -- 'mvllow/modes.nvim', { tag = 'v0.2.0' },

  -- Terminal
  'chomosuke/term-edit.nvim',
  'akinsho/toggleterm.nvim',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'nvim-treesitter/nvim-treesitter-context',

  -- Nerd Fonts
  'lambdalisue/vim-nerdfont',
  'lambdalisue/vim-fern-renderer-nerdfont',

  -- Git
  'lambdalisue/vim-gin',
  'ogaken-1/nvim-gin-preview',
  'lewis6991/gitsigns.nvim',
  'isakbm/gitgraph.nvim',
  'sindrets/diffview.nvim',

  -- Testing (Neotest)
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'antoinemadec/FixCursorHold.nvim', -- Recommended for neotest
      'marilari88/neotest-vitest',
      -- Java test adapters (enable if needed)
      -- 'mfussenegger/nvim-jdtls',
      -- 'rcasia/neotest-java',
      -- DAP adapters (enable if needed)
      -- 'mfussenegger/nvim-dap',
      -- 'rcarriga/nvim-dap-ui',
      -- 'theHamsta/nvim-dap-virtual-text',
    },
  },

  -- Japanese Input / Search
  'lambdalisue/vim-kensaku',
  'lambdalisue/vim-kensaku-search',
  -- 'hrsh7th/vim-searchx',
  'vim-skk/skkeleton',
  'delphinus/skkeleton_indicator.nvim',

  -- Obsidian (Enable if needed)
  -- 'epwalsh/obsidian.nvim',

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'natecraddock/telescope-zf-native.nvim', build = 'make' }, -- Ensure build step if needed
      'kkharji/sqlite.lua',
      'danielfalk/smart-open.nvim',
      'atusy/qfscope.nvim',
      'cljoly/telescope-repo.nvim',
      'prochri/telescope-all-recent.nvim',
    },
  },

  -- Snacks (Notifications)
  'folke/snacks.nvim',

  -- Buffer Management
  'johann2357/nvim-smartbufs',
  'famiu/bufdelete.nvim',
  'tiagovla/scope.nvim',
  'akinsho/bufferline.nvim',

  -- Utility / Enhancement Plugins
  'kevinhwang91/nvim-bqf', -- Better quickfix
  'notomo/waitevent.nvim',
  'mfussenegger/nvim-lint',
  'folke/which-key.nvim',
  'folke/trouble.nvim', -- Diagnostics viewer
  'folke/lazydev.nvim', -- For Neovim Lua development
  'mattn/vim-sonictemplate',
  'thinca/vim-quickrun',
  'numToStr/comment.nvim',
  'folke/todo-comments.nvim',
  'yuki-yano/fuzzy-motion.vim',
  'ethanholz/nvim-lastplace', -- Reopen files at last cursor position
  'haya14busa/vim-edgemotion',
  'uga-rosa/ccc.nvim', -- Color picker
  -- 'gamoutatsumi/gyazoupload.vim',
  -- 'skanehira/denops-docker.vim',
  -- 'skanehira/k8s.vim',
  -- 'cshuaimin/ssr.nvim', -- Search and replace
  'shellRaining/hlchunk.nvim', -- Highlight chunks
  'stevearc/quicker.nvim',
  'stevearc/aerial.nvim', -- Code outline
  'kevinhwang91/nvim-hlslens', -- Highlight search results
  'haya14busa/vim-asterisk', -- Enhanced * command
  '0xAdk/full_visual_line.nvim',
  'tyru/capture.vim',
  -- 'reireias/vim-cheatsheet',
  'itchyny/vim-cursorword', -- Highlight word under cursor
  'tyru/open-browser.vim',
  'lambdalisue/vim-suda', -- Edit files with sudo
  -- 'lambdalisue/vim-mr',
  -- 'lambdalisue/vim-mr-quickfix',
  -- 'Bakudankun/BackAndForward.vim',
  'MeanderingProgrammer/markdown.nvim',
  -- 'Decodetalkers/csv-tools.lua',
  'mechatroner/rainbow_csv',
  'tkmpypy/chowcho.nvim', -- Choose and insert characters
  'folke/styler.nvim', -- Apply styles based on filetype
  'ahmedkhalf/project.nvim', -- Project management
  'monaqa/dial.nvim', -- Increment/decrement numbers/dates etc.
  'nanotee/zoxide.vim', -- cd replacement
  -- '4513ECHO/nvim-keycastr',
  'tani/dmacro.nvim', -- Better macros
  'simeji/winresizer', -- Resize windows easily
  'bkad/CamelCaseMotion', -- CamelCase motion
  'cohama/lexima.vim', -- Auto close pairs
  'windwp/nvim-ts-autotag', -- Auto close/rename HTML tags
  'tpope/vim-surround', -- Add/change/delete surroundings
  -- 'folke/persistence.nvim', -- Session management
  -- 'nvimdev/dashboard-nvim', -- Start screen
  'stevearc/conform.nvim', -- Formatting
  'matukoto/fm-nvim', -- Open TUI file managers
  'folke/flash.nvim', -- Enhanced jump motions (alternative to easymotion)
  'machakann/vim-sandwich', -- Add/change/delete surroundings (alternative to surround)
  'wakatime/vim-wakatime', -- Time tracking
  'mikavilpas/yazi.nvim', -- Yazi file manager integration
  'echasnovski/mini.test', -- Testing framework (might be for plugin dev)

  -- AI / Copilot
  'zbirenbaum/copilot.lua',
  { 'CopilotC-Nvim/CopilotChat.nvim', branch = 'main' },
  'olimorris/codecompanion.nvim',

  -- Database
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',

  -- Colorschemes & UI Enhancements
  'gen740/SmoothCursor.nvim',
  'neko-night/nvim',
  -- 'sainnhe/gruvbox-material',
  -- 'sainnhe/edge',
  -- 'sainnhe/sonokai',
  -- 'sainnhe/everforest',
  -- 'edeneast/nightfox.nvim',
  -- 'AlexvZyl/nordic.nvim',
  -- 'folke/tokyonight.nvim',
  -- 'tanvirtin/monokai.nvim',
  -- 'hachy/eva01.vim',
  -- 'ray-x/aurora',
  -- { 'bluz71/vim-nightfly-colors', name = 'nightfly' }, -- Use 'name' for alias
  -- 'kyoh86/momiji',
  -- 'taniarascia/new-moon.vim',
  -- { 'catppuccin/nvim', name = 'catppuccin' },
}

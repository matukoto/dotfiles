function! s:init() abort
  call s:ensure()
  call jetpack#begin()
  call jetpack#add('tani/vim-jetpack')

  call jetpack#add('vim-jp/vimdoc-ja')

  " denops
  call jetpack#add('vim-denops/denops.vim')
  " systemd 使えないとだめなので wsl ではコメントアウト
  " call jetpack#add('vim-denops/denops-shared-server.vim')

  " lsp
  call jetpack#add('neovim/nvim-lspconfig')
  " call jetpack#add('nvim-lua/lsp-status.nvim')
  call jetpack#add('nvimdev/lspsaga.nvim')
  call jetpack#add('williamboman/mason.nvim')
  call jetpack#add('williamboman/mason-lspconfig.nvim')
  call jetpack#add('WhoIsSethDaniel/mason-tool-installer.nvim')
  call jetpack#add('neovim/nvim-lspconfig')
  call jetpack#add('j-hui/fidget.nvim')
  " call jetpack#add('nvimtools/none-ls.nvim')
  " java
  call jetpack#add('nvim-java/lua-async-await')
  call jetpack#add('nvim-java/nvim-java-refactor')
  call jetpack#add('nvim-java/nvim-java-core')
  call jetpack#add('nvim-java/nvim-java-test')
  call jetpack#add('nvim-java/nvim-java-dap')
  call jetpack#add('MunifTanjim/nui.nvim')
  call jetpack#add('JavaHello/spring-boot.nvim')
  call jetpack#add('nvim-java/nvim-java')
  call jetpack#add('renerocksai/telekasten.nvim')
  call jetpack#add('jakewvincent/mkdnflow.nvim')
  call jetpack#add('zk-org/zk-nvim')
  call jetpack#add('nanotee/sqls.nvim')
  call jetpack#add('stevearc/conform.nvim')

   call jetpack#add('kevinhwang91/nvim-ufo')
   call jetpack#add('kevinhwang91/promise-async')

  " ddc
  call jetpack#add('shougo/ddc.vim')
  " filter
  call jetpack#add('shougo/ddc-matcher_head')
  call jetpack#add('shougo/ddc-sorter_rank')
  call jetpack#add('tani/ddc-fuzzy')
  " ui
  call jetpack#add('shougo/ddc-ui-pum')
  call jetpack#add('shougo/pum.vim')
  " sources
  call jetpack#add('shougo/ddc-source-lsp')
  call jetpack#add('shougo/ddc-source-around')
  call jetpack#add('LumaKernel/ddc-source-file')
  call jetpack#add('uga-rosa/ddc-source-lsp-setup')
  call jetpack#add('matsui54/ddc-source-buffer')
  call jetpack#add('uga-rosa/ddc-source-nvim-lua')
  call jetpack#add('shougo/ddc-source-cmdline')
  call jetpack#add('shougo/ddc-source-cmdline-history')
  " popup
  call jetpack#add('matsui54/denops-popup-preview.vim')
  call jetpack#add('matsui54/denops-signature_help')

  " ファイラ
  call jetpack#add('lambdalisue/vim-fern')
  call jetpack#add('yuki-yano/fern-preview.vim')
  call jetpack#add('stevearc/oil.nvim')
  call jetpack#add('lambdalisue/vim-fern-git-status')
  call jetpack#add('lambdalisue/vim-fern-hijack')

  " ステータスラインプラグイン
  call jetpack#add('nvim-lualine/lualine.nvim')
  call jetpack#add('nvim-tree/nvim-web-devicons')
  " call jetpack#add('mvllow/modes.nvim', { 'tag': 'v0.2.0' })

  " terminal
  call jetpack#add('chomosuke/term-edit.nvim')
  call jetpack#add('akinsho/toggleterm.nvim')
  " treesitter
  call jetpack#add('nvim-treesitter/nvim-treesitter')
  call jetpack#add('nvim-treesitter/nvim-treesitter-context')
  " nerdfont
  call jetpack#add('lambdalisue/vim-nerdfont')
  call jetpack#add('lambdalisue/vim-fern-renderer-nerdfont')
  " git
  call jetpack#add('lambdalisue/vim-gin')
  call jetpack#add('ogaken-1/nvim-gin-preview')
  call jetpack#add('lewis6991/gitsigns.nvim')
  call jetpack#add('isakbm/gitgraph.nvim')
  call jetpack#add('sindrets/diffview.nvim')

  " neotest
  call jetpack#add('nvim-neotest/neotest')
  call jetpack#add('nvim-neotest/nvim-nio')
  call jetpack#add('antoinemadec/FixCursorHold.nvim')
  call jetpack#add('marilari88/neotest-vitest')
  " call jetpack#add('mfussenegger/nvim-jdtls')
  " call jetpack#add('rcasia/neotest-java')
  call jetpack#add('mfussenegger/nvim-dap')
  call jetpack#add('rcarriga/nvim-dap-ui')
  " call jetpack#add('theHamsta/nvim-dap-virtual-text')

  " 日本語
  call jetpack#add('lambdalisue/vim-kensaku')
  call jetpack#add('lambdalisue/vim-kensaku-search')
  " call jetpack#add('hrsh7th/vim-searchx')
  call jetpack#add('vim-skk/skkeleton')
  call jetpack#add('NI57721/skkeleton-state-popup')
  " call jetpack#add('yasunori0418/statusline_skk.vim')

  " Obsidian
  " call jetpack#add('epwalsh/obsidian.nvim')

  " telescope
  call jetpack#add('nvim-lua/plenary.nvim')
  call jetpack#add('nvim-telescope/telescope.nvim')
  call jetpack#add('nvim-telescope/telescope-fzf-native.nvim')
  call jetpack#add('kkharji/sqlite.lua')
  call jetpack#add('danielfalk/smart-open.nvim')
  call jetpack#add('atusy/qfscope.nvim')
  call jetpack#add('cljoly/telescope-repo.nvim')
  call jetpack#add('prochri/telescope-all-recent.nvim')

  " 便利系 useful
  call jetpack#add('kevinhwang91/nvim-bqf')
  " call jetpack#add ('folke/which-key.nvim')
  call jetpack#add('mattn/vim-sonictemplate')
  call jetpack#add('thinca/vim-quickrun')
  call jetpack#add('numToStr/comment.nvim')
  call jetpack#add('folke/todo-comments.nvim')
  call jetpack#add('yuki-yano/fuzzy-motion.vim')
  call jetpack#add('ethanholz/nvim-lastplace')
  call jetpack#add('haya14busa/vim-edgemotion')
  call jetpack#add('uga-rosa/ccc.nvim')
  "call jetpack#add('gamoutatsumi/gyazoupload.vim')
  "call jetpack#add('skanehira/denops-docker.vim')
  "call jetpack#add('skanehira/k8s.vim')
  "call jetpack#add('cshuaimin/ssr.nvim')
  call jetpack#add('shellRaining/hlchunk.nvim')
  call jetpack#add('stevearc/aerial.nvim')
  " call jetpack#add('tris203/hawtkeys.nvim')
  call jetpack#add('kevinhwang91/nvim-hlslens')
  call jetpack#add('haya14busa/vim-asterisk')
  call jetpack#add('0xAdk/full_visual_line.nvim')
  call jetpack#add('github/copilot.vim')
  call jetpack#add('CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' })
  call jetpack#add('tyru/capture.vim')
  " call jetpack#add('reireias/vim-cheatsheet')
  call jetpack#add('itchyny/vim-cursorword')
  call jetpack#add('tyru/open-browser.vim')
  call jetpack#add('lambdalisue/vim-guise')
  call jetpack#add('lambdalisue/vim-suda')
  " call jetpack#add('lambdalisue/vim-mr')
  " call jetpack#add('lambdalisue/vim-mr-quickfix')
  " call jetpack#add('Bakudankun/BackAndForward.vim')
  call jetpack#add('johann2357/nvim-smartbufs')
  call jetpack#add('MeanderingProgrammer/markdown.nvim')
  " call jetpack#add('Decodetalkers/csv-tools.lua')
  call jetpack#add('mechatroner/rainbow_csv')
  call jetpack#add('tkmpypy/chowcho.nvim')
  call jetpack#add('folke/styler.nvim')
  " call jetpack#add('b0o/incline.nvim')
  call jetpack#add('ahmedkhalf/project.nvim')
  call jetpack#add('MeanderingProgrammer/markdown.nvim')
  call jetpack#add('monaqa/dial.nvim')
  call jetpack#add('nanotee/zoxide.vim')
  " call jetpack#add('4513ECHO/nvim-keycastr')
  call jetpack#add('tani/dmacro.nvim')
  call jetpack#add('famiu/bufdelete.nvim')
  call jetpack#add('simeji/winresizer')
  " キャメルケース単位でのオブジェクト指定
  call jetpack#add('bkad/CamelCaseMotion')
  " 閉じ括弧の自動挿入
  call jetpack#add('cohama/lexima.vim')
  " 閉じタグの自動挿入
  call jetpack#add('windwp/nvim-ts-autotag')
  " "(などで囲える
  call jetpack#add('tpope/vim-surround')
  " 前回作業時の画面を復元
  " call jetpack#add('folke/persistence.nvim')
  " Neovim 起動時に dashboard を開く
  " call jetpack#add('nvimdev/dashboard-nvim')

  " tui アプリを Neovim で開ける Gitui しか使っていないが
  call jetpack#add('matukoto/fm-nvim')
  " easymotion
  call jetpack#add('folke/flash.nvim')
  call jetpack#add('machakann/vim-sandwich')
  " WakaTime コーディング時間を計測してくれる
  call jetpack#add('wakatime/vim-wakatime')
    call jetpack#add('mikavilpas/yazi.nvim')

  " DB
  call jetpack#add('tpope/vim-dadbod')
  call jetpack#add('kristijanhusak/vim-dadbod-ui')

  " カラースキーマ
  call jetpack#add('gen740/SmoothCursor.nvim')
  " call jetpack#add('sainnhe/gruvbox-material')
  " call jetpack#add('sainnhe/edge')
  " call jetpack#add('sainnhe/sonokai')
  " call jetpack#add('sainnhe/everforest')
  call jetpack#add('edeneast/nightfox.nvim')
  " call jetpack#add('AlexvZyl/nordic.nvim')
  " call jetpack#add('folke/tokyonight.nvim')
  " call jetpack#add('tanvirtin/monokai.nvim')
  " call jetpack#add('hachy/eva01.vim')
  " call jetpack#add('ray-x/aurora')
  " call jetpack#add('bluz71/vim-nightfly-colors', { 'as': 'nightfly' })
  " call jetpack#add('kyoh86/momiji')
  " call jetpack#add('taniarascia/new-moon.vim')
  " call jetpack#add('catppuccin/nvim', { 'as': 'catppuccin' })

  call jetpack#end()
endfunction

function! s:ensure() abort
  let url = 'https://github.com/tani/vim-jetpack'
  let dir = expand('$VIMHOME/pack/jetpack/opt/vim-jetpack')
  if !isdirectory(dir)
    silent execute printf('!git clone --depth 1 %s %s', url, dir)
  endif
  packadd vim-jetpack
endfunction

function! s:configure() abort
  call s:load_configurations()
  if has('nvim')
    call s:load_lua_configurations()
  endif
endfunction
function! s:load_configurations() abort
  for path in glob('$VIMHOME/rc/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction

function! s:load_lua_configurations() abort
  for path in glob('$VIMHOME/rc/*.lua', 1, 1, 1)
    execute printf('luafile %s', fnameescape(path))
  endfor
endfunction

call s:init()
call s:configure()

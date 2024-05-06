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
  call jetpack#add('nvim-lua/lsp-status.nvim')
  call jetpack#add('nvimtools/none-ls.nvim')

  " dd
  call jetpack#add('shougo/ddc.vim')
  call jetpack#add('shougo/ddc-ui-native')
  call jetpack#add('shougo/ddc-matcher_head')
  call jetpack#add('shougo/ddc-sorter_rank')
  call jetpack#add('shougo/ddc-source-lsp')

  " ファイラ
  call jetpack#add('lambdalisue/fern.vim')
  call jetpack#add('yuki-yano/fern-preview.vim')
  call jetpack#add('stevearc/oil.nvim')

  " ステータスラインプラグイン
  call jetpack#add('nvim-lualine/lualine.nvim')
  call jetpack#add('nvim-tree/nvim-web-devicons')
  " call jetpack#add('mvllow/modes.nvim', { 'tag': 'v0.2.0' })

  " terminal
  call jetpack#add('chomosuke/term-edit.nvim')
  call jetpack#add('nvim-treesitter/nvim-treesitter')
  " nerdfont
  call jetpack#add('lambdalisue/nerdfont.vim')
  call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
  call jetpack#add('lambdalisue/fern-git-status.vim')
  " git
  call jetpack#add('lambdalisue/gin.vim')
  call jetpack#add('APZelos/blamer.nvim')
  call jetpack#add('iberianpig/tig-explorer.vim')
  call jetpack#add('lewis6991/gitsigns.nvim')

  " 日本語
  call jetpack#add('lambdalisue/kensaku.vim')
  call jetpack#add('lambdalisue/kensaku-search.vim')
  call jetpack#add('hrsh7th/vim-searchx')
  call jetpack#add('vim-skk/skkeleton')
  "call jetpack#add('NI57721/skkeleton-state-popup')
  call jetpack#add('yasunori0418/statusline_skk.vim')

  call jetpack#add('peteriho/nvim-scrollbar')
  " Obsidian
  " call jetpack#add('epwalsh/obsidian.nvim')

  " telescope
  call jetpack#add('nvim-lua/plenary.nvim')
  call jetpack#add('nvim-telescope/telescope.nvim')
  call jetpack#add('nvim-telescope/telescope-fzf-native.nvim')
  call jetpack#add('kkharji/sqlite.lua')
  call jetpack#add('danielfalk/smart-open.nvim')

  " 便利系
  call jetpack#add('mattn/vim-sonictemplate')
  call jetpack#add('thinca/vim-quickrun')
  call jetpack#add('numToStr/comment.nvim')
  call jetpack#add('yuki-yano/fuzzy-motion.vim')
  call jetpack#add('ethanholz/nvim-lastplace')
  call jetpack#add('haya14busa/vim-edgemotion')
  "call jetpack#add('gamoutatsumi/gyazoupload.vim')
  "call jetpack#add('skanehira/denops-docker.vim')
  "call jetpack#add('skanehira/k8s.vim')
  call jetpack#add('cshuaimin/ssr.nvim')
  call jetpack#add('shellRaining/hlchunk.nvim')
  call jetpack#add('stevearc/aerial.nvim')
  call jetpack#add('tris203/hawtkeys.nvim')
  call jetpack#add('kevinhwang91/nvim-hlslens')
  call jetpack#add('0xAdk/full_visual_line.nvim')
  call jetpack#add('j-hui/fidget.nvim')
  call jetpack#add('github/copilot.vim')
  call jetpack#add('CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' })
  call jetpack#add('tyru/capture.vim')
  call jetpack#add('reireias/vim-cheatsheet')
  call jetpack#add('itchyny/vim-cursorword')
  call jetpack#add('tyru/open-browser.vim')
  call jetpack#add('lambdalisue/guise.vim')
  call jetpack#add('lambdalisue/mr.vim')
  call jetpack#add('lambdalisue/mr-quickfix.vim')
  call jetpack#add('Bakudankun/BackAndForward.vim')
  call jetpack#add('MeanderingProgrammer/markdown.nvim')
  call jetpack#add('mechatroner/rainbow_csv')
  call jetpack#add('tkmpypy/chowcho.nvim')
  call jetpack#add('folke/styler.nvim')
  call jetpack#add('b0o/incline.nvim')

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
  for path in glob('$VIMHOME/plugin.d/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction

function! s:load_lua_configurations() abort
  for path in glob('$VIMHOME/plugin.d/*.lua', 1, 1, 1)
    execute printf('luafile %s', fnameescape(path))
  endfor
endfunction

call s:init()
call s:configure()

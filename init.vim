" vimrc  を読み込む
if has('win64')
    source ~\_vimrc
else
    source ~/.vimrc
endif

if has('vim_starting')
" Disable unnecessary default plugins
  let g:loaded_gzip              = 1
  let g:loaded_tar               = 1
  let g:loaded_tarPlugin         = 1
  let g:loaded_zip               = 1
  let g:loaded_zipPlugin         = 1
  let g:loaded_rrhelper          = 1
  let g:loaded_2html_plugin      = 1
  let g:loaded_vimball           = 1
  let g:loaded_vimballPlugin     = 1
  let g:loaded_getscript         = 1
  let g:loaded_getscriptPlugin   = 1
  let g:loaded_logipat           = 1
  let g:loaded_matchparen        = 1
  let g:loaded_man               = 1
  " NOTE:
  " The Netrw is use to download a missing spellfile
  let g:loaded_netrw             = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  let g:loaded_netrwFileHandlers = 1
endif

" クリップボード
let g:clipboard = {
    \   'name': 'myClipboard',
    \   'copy': {
    \      '+': 'win32yank.exe -i',
    \      '*': 'win32yank.exe -i',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o',
    \      '*': 'win32yank.exe -o',
    \   },
    \   'cache_enabled': 1,
    \ }

" " terminal
" :T で下部にターミナルを開く
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
" インサートモードでターミナルを開く
" autocmd TermOpen * startinsert

" install jetpackin
packadd vim-jetpack
call jetpack#begin()

Jetpack 'tani/vim-jetpack'

Jetpack 'vim-jp/vimdoc-ja'

" denops
Jetpack 'vim-denops/denops.vim'

" dd
Jetpack 'shougo/ddc.vim'
Jetpack 'shougo/ddc-matcher_head'
Jetpack 'shougo/ddc-sorter_rank'

Jetpack 'lambdalisue/fern.vim'
Jetpack 'yuki-yano/fern-preview.vim'

" ステータスラインプラグイン
Jetpack 'nvim-lualine/lualine.nvim'
Jetpack 'nvim-tree/nvim-web-devicons'
" Jetpack 'mvllow/modes.nvim', { 'tag': 'v0.2.0' }

" terminal
Jetpack 'chomosuke/term-edit.nvim'
Jetpack 'nvim-treesitter/nvim-treesitter'
" nerdfont
Jetpack 'lambdalisue/nerdfont.vim'
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
" git
Jetpack 'lambdalisue/gin.vim'
Jetpack 'APZelos/blamer.nvim'
Jetpack 'iberianpig/tig-explorer.vim'
" 日本語
Jetpack 'lambdalisue/kensaku.vim'
Jetpack 'lambdalisue/kensaku-search.vim'
Jetpack 'hrsh7th/vim-searchx'
Jetpack 'vim-skk/skkeleton'
Jetpack 'NI57721/skkeleton-state-popup'

" coc
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
" Obsidian
Jetpack 'epwalsh/obsidian.nvim'

" telescope
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim'
Jetpack 'nvim-telescope/telescope-frecency.nvim'
Jetpack 'fannheyward/telescope-coc.nvim'

" 便利系
Jetpack 'mattn/vim-sonictemplate'
Jetpack 'thinca/vim-quickrun'
Jetpack 'numToStr/comment.nvim'
Jetpack 'yuki-yano/fuzzy-motion.vim'
Jetpack 'ethanholz/nvim-lastplace'
Jetpack 'skanehira/denops-docker.vim'
Jetpack 'skanehira/k8s.vim'
Jetpack 'cshuaimin/ssr.nvim'
Jetpack 'shellRaining/hlchunk.nvim'
Jetpack 'stevearc/aerial.nvim'
Jetpack 'tris203/hawtkeys.nvim'
Jetpack 'is0n/fm-nvim'
Jetpack 'kevinhwang91/nvim-hlslens'
Jetpack '0xAdk/full_visual_line.nvim'

Jetpack 'github/copilot.vim'
Jetpack 'tyru/capture.vim'
Jetpack 'reireias/vim-cheatsheet'
Jetpack 'itchyny/vim-cursorword'

" カラースキーマ
Jetpack 'gen740/SmoothCursor.nvim'
Jetpack 'sainnhe/gruvbox-material'
Jetpack 'sainnhe/edge'
Jetpack 'sainnhe/sonokai'
Jetpack 'sainnhe/everforest'
Jetpack 'edeneast/nightfox.nvim'
Jetpack 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Jetpack 'kyoh86/momiji'
Jetpack 'taniarascia/new-moon.vim'
Jetpack 'catppuccin/nvim', { 'as': 'catppuccin' }
" Jetpack 'folke/styler.nvim'
call jetpack#end()

" cheat sheet
let g:cheatsheet#cheat_file = '$HOME/dotfiles/vim/cheatSheet/default.md'
let g:cheatsheet#float_window = 1
let g:cheatsheet#float_window_width_ratio = 0.6
let g:cheatsheet#float_window_height_ratio = 0.5

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

" copilot
imap <expr> <C-Space> copilot#expand()
imap <Tab> copilot#Accept()
imap <C-]> <plug>(copilot-dismiss)
let g:copilot_filetypes = {
      \ '*': v:true,
      \ 'java': v:false,
      \ }

" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500

" nerdfont
let g:fern#renderer = 'nerdfont'

" fern
" ドットファイルなどをデフォルトで表示
let g:fern#default_hidden = 1
nnoremap <silent> <Leader>e :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>E :<C-u>Fern . -reveal=%<CR>

function! s:fern_settings() abort
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

" ウィンドウ移動
nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l

" タブ移動
nnoremap <silent> H :tabprevious<CR>
nnoremap <silent> L :tabnext<CR>
cabbrev tc tabclose<CR>

" sonictemplate
let g:sonictemplate_vim_template_dir = '$HOME/dotfiles/vim/sonictemplate/'
cabbrev tp Template

"" gin
cabbrev gs GinPreview<CR>
cabbrev ga Gin add .<CR>
cabbrev gc Gin commit<CR>
cabbrev gp Gin push<CR>
cabbrev gd GinDiff<CR>
cabbrev gb GinBranch
let g:gin_proxy_apply_without_confirm = 1

" kensaku search
"cnoremap <CR> <Plug>(kensaku-search-replace)<CR>
" kensaku searchx
" let g:searchx = {}
" function g:searchx.convert(input) abort
"   return '\v' . kensaku#query(a:input)
" endfunction
" kensaku  fuzzy-motion
let g:fuzzy_motion_matchers = ['fzf', 'kensaku']
" fuzzy-motion
nnoremap <C-f> <cmd>FuzzyMotion<CR>

"quickrun
cabbrev qr QuickRun<CR>

" coc.nvim
let g:coc_global_extensions = ['coc-json','coc-yaml','coc-java','coc-go','coc-deno','coc-svelte','coc-snippets','@yaegassy/coc-marksman','coc-tsserver','coc-toml']

let g:denops#debug = 1

" coc keymap
" 定義ジャンプ
nnoremap  <Leader>d <Plug>(coc-definition)<CR>
" import
nnoremap <Leader>i <Plug>(coc-organize-imports)<CR>
" code action
nnoremap  <Leader>c <Plug>(coc-codeaction-cursor)<CR>
" rename
nnoremap <Leader>r <Plug>(coc-rename)<CR>

" エンターで補完を確定
inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" skk
call skkeleton#config({
      \ 'globalDictionaries': ['~/.skk/SKK-JISYO.L','~/.skk/SKK-JISYO.emoji.utf8', '~/.skk/SKK-JISYO.geo', '~/.skk/SKK-JISYO.jinmei', '~/.skk/SKK-JISYO.propernoun'],
      \ 'sources': ['deno_kv', 'google_japanese_input'],
      \ 'databasePath': '~/.skk/skkeleton.db',
      \ 'eggLikeNewline': v:true,
      \ 'immediatelyCancel': v:false,
      \ 'registerConvertResult': v:true,
      \ 'showCandidatesCount': 2,
      \})
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)

      " \ 'skkServerHost': '127.0.0.1',
      " \ 'skkServerPort': 55100,
      " \ 'useSkkServer': v:true,

" ddc
call ddc#custom#patch_global('sources',['skkeleton'])
call ddc#custom#patch_global('sourceOptions',{
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank'],
      \ },
      \ 'skkeleton': {
      \   'mark': 'skkeleton',
      \  'matchers': ['skkeleton'],
      \ 'sorters': [],
      \ },
      \})
call ddc#enable()

" skk-state-popup
call skkeleton_state_popup#config(#{
  \   labels: {
  \     'input': #{hira: "あ", kata: 'ア', hankata: 'ｶﾅ', zenkaku: 'Ａ'},
  \     'input:okurinasi': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽', abbrev: 'ab'},
  \     'input:okuriari': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽'},
  \     'henkan': #{hira: '▼▼', kata: '▼▼', hankata: '▼▼', abbrev: 'ab'},
  \     'latin': 'A',
  \   },
  \   opts: #{relative: 'cursor', col: 0, row: 1, anchor: 'NW', style: 'minimal'},
  \ })
call skkeleton_state_popup#run()

source ~/.config/nvim/plugin/gin-preview.vim

source ~/.config/nvim/lua/init.lua

" colorscheme
colorscheme sonokai

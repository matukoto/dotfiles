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

" " terminal
" :T で下部にターミナルを開く
command! -nargs=* T split | wincmd j | resize 15 | terminal <args>
" インサートモードでターミナルを開く
autocmd TermOpen * startinsert

" install jetpackin
packadd vim-jetpack
call jetpack#begin()

Jetpack 'tani/vim-jetpack'

Jetpack 'vim-jp/vimdoc-ja'

" denops
Jetpack 'vim-denops/denops.vim'
" systemd 使えないとだめなので wsl ではコメントアウト
" Jetpack 'vim-denops/denops-shared-server.vim'

" dd
Jetpack 'shougo/ddc.vim'
Jetpack 'shougo/ddc-matcher_head'
Jetpack 'shougo/ddc-sorter_rank'

" ファイラ
Jetpack 'lambdalisue/fern.vim'
Jetpack 'yuki-yano/fern-preview.vim'
" Jetpack 'stevearc/oil.nvim'

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
Jetpack 'lewis6991/gitsigns.nvim'

" 日本語
Jetpack 'lambdalisue/kensaku.vim'
Jetpack 'lambdalisue/kensaku-search.vim'
Jetpack 'hrsh7th/vim-searchx'
Jetpack 'vim-skk/skkeleton'
"Jetpack 'NI57721/skkeleton-state-popup'
Jetpack 'yasunori0418/statusline_skk.vim'

Jetpack 'peteriho/nvim-scrollbar'
" coc
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
" Obsidian
Jetpack 'epwalsh/obsidian.nvim'

" telescope
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim'
Jetpack 'fannheyward/telescope-coc.nvim'
Jetpack 'nvim-telescope/telescope-fzf-native.nvim'
Jetpack 'kkharji/sqlite.lua'
Jetpack 'danielfalk/smart-open.nvim'

" 便利系
Jetpack 'mattn/vim-sonictemplate'
Jetpack 'thinca/vim-quickrun'
Jetpack 'numToStr/comment.nvim'
Jetpack 'yuki-yano/fuzzy-motion.vim'
Jetpack 'ethanholz/nvim-lastplace'
Jetpack 'haya14busa/vim-edgemotion'
Jetpack 'gamoutatsumi/gyazoupload.vim'
"Jetpack 'skanehira/denops-docker.vim'
"Jetpack 'skanehira/k8s.vim'
Jetpack 'cshuaimin/ssr.nvim'
Jetpack 'shellRaining/hlchunk.nvim'
Jetpack 'stevearc/aerial.nvim'
Jetpack 'tris203/hawtkeys.nvim'
Jetpack 'kevinhwang91/nvim-hlslens'
Jetpack '0xAdk/full_visual_line.nvim'
Jetpack 'j-hui/fidget.nvim'
Jetpack 'github/copilot.vim'
Jetpack 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
Jetpack 'tyru/capture.vim'
Jetpack 'reireias/vim-cheatsheet'
Jetpack 'itchyny/vim-cursorword'
Jetpack 'tyru/open-browser.vim'
Jetpack 'lambdalisue/guise.vim'
Jetpack 'ryicoh/deepl.vim'
Jetpack 'lambdalisue/mr.vim'
Jetpack 'lambdalisue/mr-quickfix.vim'
Jetpack 'Bakudankun/BackAndForward.vim'
Jetpack 'MeanderingProgrammer/markdown.nvim'
Jetpack 'mechatroner/rainbow_csv'

" DB
Jetpack 'tpope/vim-dadbod'
Jetpack 'kristijanhusak/vim-dadbod-ui'

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
" drawer で開く
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>e :<C-u>Fern . -reveal=%<CR>

function! s:fern_settings() abort
  nmap <silent> <buffer> D     <Plug>(fern-action-remove=)y<CR>
  nmap <silent> <buffer> n     <Plug>(fern-action-new-file)
  nmap <silent> <buffer> N     <Plug>(fern-action-new-dir)
  nmap <silent> <buffer> h     <Plug>(fern-action-leave)
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" ウィンドウ移動
nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l

" タブ
nnoremap <silent> H :tabprevious<CR>
nnoremap <silent> L :tabnext<CR>
nnoremap qt <Cmd>tabclose<CR>

" sonictemplate
let g:sonictemplate_vim_template_dir = '$HOME/.vim/sonictemplate/'
cabbrev tp Template

"" gin
let g:gin_proxy_apply_without_confirm = 1
nnoremap <Leader>gs <Cmd>GinPreview<CR>
" バッファの差分を表示
nnoremap <Leader>ga <Cmd>Gin add --all<CR>
nnoremap <Leader>gc <Cmd>Gin commit --quiet<CR>
nnoremap <Leader>gp <Cmd>GinPatch ++opener=tabnew %<CR>
" nnoremap <Lieader>g<C-d> <Cmd>GinDiff ++processor=delta\ --no-gitconfig\ --color-only<CR>
nnoremap <Leader>gl  <Cmd>GinLog<CR>
" nnoremap <Lieader>gl <Cmd>GinLog -- %<CR>
nnoremap <Leader>gb <Cmd>GinBranch --all<CR>
nnoremap <Leader>gd <Cmd>GinDiff<CR>

function! s:my_gin_log() abort
  nnoremap <buffer> if <Plug>(gin-action-fixup:instant-fixup)
  nnoremap <buffer> ir <Plug>(gin-action-fixup:instant-reword)
  setl cursorline
endfunction

augroup my-gin
  autocmd!
  autocmd User GinComponentPost redrawtabline
  autocmd FileType gin-log silent! call s:my_gin_log()
augroup END

" 
if executable('delta')
  let g:gin_diff_persistent_args = [
        \ '++processor=delta --diff-highlight --keep-plus-minus-markers',
        \]
endif

" dadbod
nnoremap <Leader>w <Plug>(DBUI_SaveQuery)
let g:db_ui_save_location = '~/.vim/dadbod-ui'

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

"let g:denops#debug = 1
let g:denops#server#deno_args = ['-q', '--no-lock', '-A', '--unstable-ffi', '--unstable-kv']
" denops-shared-server port
" let g:denops_server_addr = "127.0.0.1:32123"

" denops-shared-server install 後、初回のみ実行すれば良い
" call denops_shared_server#install()

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

" edge-motion
nnoremap <C-j> <Plug>(edgemotion-j)
nnoremap <C-k> <Plug>(edgemotion-k)

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
imap <C-j> <Plug>(skkeleton-enable);
cmap <C-j> <Plug>(skkeleton-enable);

" statusline_skk
let g:lightline_skk_announce = v:true
call statusline_skk#option('display', {
  \ 'hiragana': 'あ',
  \ 'katakana': 'ア',
  \ 'hankaku-katakana': 'ｱ',
  \ 'zenkaku-alphabet': 'Ａ',
  \ 'alphabet': 'A',
  \ })
call statusline_skk#option('enable_mode', {
  \ 'INSERT': v:true,
  \ 'COMMAND': v:false,
  \ })

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

" deepl
let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
let g:deepl#auth_key = "00000000-0000-0000-0000-000000000000:fx" " or readfile(expand('~/.config/deepl.auth_key'))[0]

" replace a visual selection
vmap t<C-e> <Cmd>call deepl#v("EN")<CR>
vmap t<C-j> <Cmd>call deepl#v("JA")<CR>

" translate a current line and display on a new line
nmap t<C-e> yypV<Cmd>call deepl#v("EN")<CR>
nmap t<C-j> yypV<Cmd>call deepl#v("JA")<CR>

" specify the source language
" translate from FR to EN
" nmap t<C-e> yypV<Cmd>call deepl#v("EN", "FR")<CR>

" open browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" gyazoupload
let g:gyazo#token = '$GYAZO_TOKEN'

source ~/.config/nvim/plugin/gin-preview.vim

source ~/.config/nvim/lua/init.lua

" colorscheme
colorscheme everforest

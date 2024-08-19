" :p でフルパスを取得
" :h でディレクトリのみを取得
let $VIMHOME = expand('<sfile>:p:h')
let s:is_windows = has('win32')

" statusline を常に1つにする
set laststatus=3
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

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

" " terminal
" :T で下部にターミナルを開く
" command! -nargs=* T split | wincmd j | resize 15 | terminal <args>
" インサートモードでターミナルを開く
"autocmd TermOpen * startinsert

" ウィンドウ移動
nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l

" タブ
nnoremap <silent> H <Cmd>tabprevious<CR>
nnoremap <silent> L <Cmd>tabnext<CR>
nnoremap <silent> Q <Cmd>TCL<CR>
cabbrev qq TCL

nnoremap <silent> <Leader>p "*p

cabbrev cm <Cmd>Capture message<CR>

" Plugin
source $VIMHOME/jetpack.vim

" colorscheme
" colorscheme everforest

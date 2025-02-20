" :p でフルパスを取得
" :h でディレクトリのみを取得
let $VIMHOME = expand('<sfile>:p:h')
let s:is_windows = has('win32')

" statusline を常に1つにする
set laststatus=3

" 文字コードの自動判別
set encoding=utf-8
set fileencodings=utf-8
"
" 改行コードの自動認識
set fileformats=unix,dos

" 新しいウィンドウを下､右に開く
set splitbelow
set splitright

"  カーソルの位置を%で表示
set ruler

" カーソル行の背景色変更
set cursorline
" 折り畳んだあとの行数
set foldcolumn=1
" 自動的に開かれる折り畳みレベル
set foldlevel=99
" 開始時の折り畳みレベル
set foldlevelstart=99
" 折り畳みを有効にする
set foldenable

" タブ
set tabstop=2
set shiftwidth=2
set softtabstop=2

" インデントにスペースを使用
set expandtab

" 改行時に自動インデント
set autoindent
set smartindent

" Vim のビジュアルモードでは p を使うと、無名レジスタに選択したテキストがコピーされる
xnoremap p P
xnoremap P p

" vim diff
"- [vimdiffでより賢いアルゴリズム (patience, histogram) を使う #Git - Qiita](https://qiita.com/takaakikasai/items/3d4f8a4867364a46dfa3)
set diffopt=internal,filler,algorithm:histogram,indent-heuristic

" 折返したときもインデント
set breakindent

" 折り返したときにインデントの深さを同じに
set breakindentopt=shift:0

" 全角文字専用の設定
" アプリと端末ソフトとフォントの扱っている幅が全部一致していないとずれるのでコメントアウト
" set ambiwidth=double

" 対応する括弧やブレースを表示
set showmatch matchtime=1

"検索をファイルの先頭へ循環しない
set nowrapscan

" ヘルプを日本語優先に
set helplang=ja,en

" ターミナルモード
" esc
tnoremap <ESC> <C-\><C-n>
" " インサートモードで入る
" if has('nvim')
" 	autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
" else
" 	autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
" endif

" nnoremap <silent> <C-t><C-m> :split<CR> <C-w>j :terminal<CR> :resize 6<CR> i
"行番号を表示
set number
"大文字小文字の区別なし
set ignorecase
 
" swap しない
set noswapfile

"検索時に大文字を含んでいたら大/小を区別
set smartcase
 
"検索対象をハイライト
"ハイライトを消す場合は:noh[l]
set hlsearch
" Escでハイライト消去
nnoremap <silent> <ESC> :nohlsearch<CR><ESC>
"スクロール時に表示を10行確保
set scrolloff=10
 
"x キー削除でデフォルトレジスタに入れない
nnoremap x "_x
vnoremap x "_x
 
"vv で行末まで選択
vnoremap v ^$h
 
" インデントを手軽に変更
nnoremap > >>
nnoremap < <<

" ; と : の入れ替え
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" 相対的な行番号を表示
" set relativenumber

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
nnoremap J gJ

" 動作環境との統合
" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamedplus
" マウスの入力を受け付ける
set mouse=a

" 置換を簡単に monaqaさん
" https://zenn.dev/vim_jp/articles/2023-06-30-vim-substitute-tips
cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's'
" visual mode の範囲選択をした状態でも同じことをしたい
" cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':\'\<\,\'\>s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's'

" 大文字小文字を区別して検索(デフォルトは区別しない)
" https://zenn.dev/igrep/articles/2023-08-vim-backslash-c
nnoremap <Space>/ /\C
nnoremap <Space>? ?\C

" git commit message
lua << lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*commit',
  callback = function()
    vim.keymap.set('n', '<CR><CR>', function()
      vim.cmd('normal! ^w"zdiw')
      vim.cmd('normal! "_dip')
      vim.cmd('normal! "zPA(): ')
      vim.cmd('normal! 2h')
      vim.api.nvim_command('startinsert')
    end, { buffer = true })
  end,
})
lua

" タブを閉じた後に左のタブに移動するコマンド
function! CloseTabAndMoveLeft()
  if tabpagenr('$') > 1
    tabprevious
    tabclose #
  else
    tabclose
  endif
endfunction

" :TCL コマンドでカスタム関数を実行
command! TCL call CloseTabAndMoveLeft()

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
" autocmd CmdlineEnter [wW][aAqQ]* silent let g:silent_write = 1
" autocmd CmdlineLeave [wW][aAqQ]* if exists('g:silent_write') | unlet g:silent_write | endif
cabbrev w  <Cmd>silent w<CR>
cabbrev wa  <Cmd>silent wa<CR>

" Plugin
if  exists('g:vscode')
    " VSCode extension
else
  source $VIMHOME/jetpack.vim
endif

" リドゥ
nnoremap U <C-r>

nnoremap g<C-a> ggVG
nnoremap g<C-a>y ggVGy
nnoremap <C-z> <Cmd>wq<CR>

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview
augroup SaveViewOnLeave
  autocmd!
  autocmd BufWinLeave * if &filetype != '' && expand('%') != '' | mkview | endif
augroup END

augroup RestoreViewOnEnter
  autocmd!
  autocmd BufWinEnter * if &filetype != '' && expand('%') != '' | silent! loadview | endif
augroup END

autocmd CursorMoved * normal! zz

" colorscheme
" colorscheme everforest

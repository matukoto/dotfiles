" Windows vimrc 
" 文字コードの自動は別
set encoding=utf-8
set fileencodings=utf-8
" 改行コードの自動認識
set fileformats=unix,dos,mac

" 新しいウィンドウを下､右に開く
set splitbelow
set splitright
"  カーソルの位置を%で表示
set ruler
" カーソル行の背景色変更
set cursorline
" タブ
set tabstop=4
set shiftwidth=4
set softtabstop=4
" インデントにスペースを使用
set expandtab
" 開業時に自動インデント
set autoindent
set smartindent
" 折返医sたときもインデント
set breakindent
" 折り返したときにインデントの深さを同じに
set breakindentopt=shift:0
" 全角文字専用の設定
set ambiwidth=double
" 対応する括弧やブレースを表示
set showmatch matchtime=1
"検索をファイルの先頭へ循環しない
set nowrapscan

" ターミナルモード
" esc
tnoremap <ESC> <C-\><C-n>
" " インサートモードで入る
" if has('nvim')
" 	autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
" else
" 	autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
" endif

nnoremap <silent> <C-t><C-m> :split<CR> <C-w>j :terminal<CR> :resize 6<CR> i
"行番号を表示
set number
"大文字小文字の区別なし
set ignorecase
 
"検索時に大文字を含んでいたら大/小を区別
set smartcase
 
"検索対象をハイライト
"ハイライトを消す場合は:noh[l]
set hlsearch
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
"スクロール時に表示を10行確保
set scrolloff=10
 
"JIS 配列 C-[ で Esc
inoremap <C-[> <Esc>
 
"x キー削除でデフォルトレジスタに入れない
nnoremap x "_x
vnoremap x "_x
 
"vv で行末まで選択
vnoremap v ^$h
 
"選択範囲のインデントを連続して変更
vnoremap < <gv
vnoremap > >gv
 
"ノーマルモード中にEnterで改行
noremap <CR> i<CR><Esc>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" 動作環境との統合
" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
" マウスの入力を受け付ける
set mouse=a
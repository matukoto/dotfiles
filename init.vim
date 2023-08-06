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
call jetpack#begin('~/.vim/jetpack')  

Jetpack 'tani/vim-jetpack', {'opt': 1} 

Jetpack 'vim-jp/vimdoc-ja'

Jetpack 'neoclide/coc.nvim', {'branch': 'release'}
Jetpack 'megalithic/zk.nvim'

Jetpack 'lambdalisue/fern.vim'
Jetpack 'yuki-yano/fern-preview.vim'

" ステータスラインプラグイン
Jetpack 'itchyny/lightline.vim'
Jetpack 'itchyny/vim-gitbranch'
" Jetpack 'mvllow/modes.nvim', { 'tag': 'v0.2.0' }

" terminal
Jetpack 'chomosuke/term-edit.nvim'
Jetpack 'nvim-treesitter/nvim-treesitter'
" nerdfont
Jetpack 'lambdalisue/nerdfont.vim'
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
" easymotion
Jetpack 'easymotion/vim-easymotion'
" fzf
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim'
" Jetpack 'nvim-telescope/telescope-frecency.nvim'
" Jetpack 'kkharji/sqlite.lua'
" denops
Jetpack 'vim-denops/denops.vim'
" git
Jetpack 'lambdalisue/gin.vim'
Jetpack 'APZelos/blamer.nvim'
Jetpack 'iberianpig/tig-explorer.vim'
" chatgpt
" Jetpack 'lambdalisue/butler.vim'
" Jetpack 'yuki-yano/ai-review.vim'
" 日本語検索
Jetpack 'lambdalisue/kensaku.vim'
Jetpack 'lambdalisue/kensaku-search.vim'
Jetpack 'hrsh7th/vim-searchx'

" Jetpack 'skanehira/gyazo.vim'
" 便利系
Jetpack 'mattn/vim-sonictemplate'
Jetpack 'thinca/vim-quickrun'
Jetpack 'numToStr/comment.nvim'
Jetpack 'yuki-yano/fuzzy-motion.vim'
Jetpack 'ethanholz/nvim-lastplace'
Jetpack 'skanehira/denops-docker.vim'
Jetpack 'skanehira/k8s.vim'
" Jetpack 'cohama/lexima.vim'
Jetpack 'github/copilot.vim'

" カラースキーマ
Jetpack 'gen740/SmoothCursor.nvim'
Jetpack 'sainnhe/gruvbox-material'
Jetpack 'sainnhe/edge'
Jetpack 'sainnhe/sonokai'
Jetpack 'sainnhe/everforest'
Jetpack 'edeneast/nightfox.nvim'
Jetpack 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
" Jetpack 'folke/styler.nvim'
call jetpack#end()

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

" easymotion
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-ft)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)


" copilot
imap <expr> <C-Space> copilot#expand()
" imap <Tab> copilot#Accept()
imap <C-]> <plug>(copilot-dismiss)
imap <n> <plug>(copilot-next)
imap <N> <plug>(copilot-prev)

" coc.nvim
let g:coc_global_extensions = ['@yaegassy/coc-volar', '@yaegassy/coc-volar-tools', 'coc-tsserver', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-lists', 'coc-go', 'coc-sh', 'coc-docker']
inoremap <silent> <expr> <C-Space> coc#refresh()
nnoremap <silent> K       :<C-u>call <SID>show_documentation()<CR>
" 関数定義ジャンプ
nnoremap <silent> <C-a> :<C-u>call CocActionAsync('jumpDefinition', 'vsplit')<CR>

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction

" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500

" nerdfont
let g:fern#renderer = 'nerdfont'

" fern
" .ファイルなどをデフォルトで表示
let g:fern#default_hidden = 1

nnoremap <silent> <Leader>e :<C-u>Fern . -reveal=%<CR>
nnoremap <silent> <Leader>E :<c-u>Fern .<cr>

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
nnoremap <silent> <Leader>T :tabprevious<CR>
nnoremap <silent> <Leader>t :tabnext<CR>

" sonictemplate
let g:sonictemplate_vim_template_dir = '$HOME/dotfiles/vim/sonictemplate/'
cabbrev tp Template

"" lightline
" insert などを非表示に
set noshowmode
" ステータスラインを表示する
set laststatus=2
let g:lightline = {
   \ 'active': {
   \   'left': [
   \     [ 'mode', 'paste' ],
   \     [ 'gitbranch', 'readonly', 'cocstatus', 'filename', 'method', 'modified' ]
   \   ],
   \ },
   \ 'component_function': {
   \   'gitbranch': 'gitbranch#name',
   \   'cocstatus': 'coc#status',
   \ },
   \ 'colorscheme': 'edge',
\ }
 
"" telescope
" ファイル検索
nnoremap <C-p> <cmd>Telescope find_files action=MyFileVsplit<CR>
" function! MyFileVsplit(file)
"   execute "vsplit " . a:file
" endfunction

" ドットファイル含む検索
nnoremap <C-d> <cmd>Telescope git_files<CR>
" 文字列検索
nnoremap <C-g> <cmd>Telescope live_grep<CR>
" 横断検索
" nnoremap <C-f> <cmd>Telescope frecency<CR>
" バッファ検索
nnoremap <C-b> <cmd>Telescope buffers<CR>
" ヘルプ検索
cnoreabbrev H Telescope help_tags<CR>
" quickfixhistory
nnoremap <C-q> <cmd>Telescope quickfixhistory<CR>

" zk
nnoremap <leader>zn <cmd>lua require('telescope').extensions.zk.zk_notes()<CR>
nnoremap <leader>zg <cmd>lua require('telescope').extensions.zk.zk_grep()<CR>

" telescope でウィンドウのだし分けをしたい エンターならカレントウィンドウ 、丸々ならスプリットなど

" chatgpt
cabbrev ai AiReview
cabbrev gpt Butler<CR>

"" gin
cabbrev gs GinPreview<CR>
cabbrev ga Gin add .<CR>
cabbrev gc Gin commit<CR>
cabbrev gp Gin push<CR>
cabbrev gd GinDiff<CR>
cabbrev gb GinBranch

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

" 選択した文字列にリンクを追加
let s:clipboard_register = has('linux') || has('unix') ? '+' : '*'
function! InsertMarkdownLink() abort
  " use register `9`
  let old = getreg('9')
  let link = trim(getreg(s:clipboard_register))
  if link !~# '^http.*'
    normal! gvp
    return
  endif

  " replace `[text](link)` to selected text
  normal! gv"9y
  let word = getreg(9)
  let newtext = printf('[%s](%s)', word, link)
  call setreg(9, newtext)
  normal! gv"9p

  " restore old data
  call setreg(9, old)
endfunction

augroup markdown-insert-link
  au!
  au FileType markdown vnoremap <buffer> <silent> p :<C-u>call InsertMarkdownLink()<CR>
augroup END

source ~/.config/nvim/plugin/gin-preview.vim

" lua
lua <<EOF
-- comment.nvim
require('Comment').setup()

-- zk
require('telescope').load_extension('zk')

-- nvim-lastplace
require'nvim-lastplace'.setup {
  lastplace_ignore_buftype = {"quicfix", "nofile", "help"},
  lastplace_ignore_filetype = {"gitcommit", "gitrebase"},
  lastplace_open_folds = true
  }

-- modes.nvim
-- require('modes').setup({
-- 	colors = {
-- 		copy = "#f5c359",
-- 		delete = "#c75c6a",
-- 		insert = "#78ccc5",
-- 		visual = "#9745be",
-- 	},
-- })

-- SmoothCursor
require('smoothcursor').setup()

-- term-edit
require 'term-edit'.setup {
  prompt_end = '%$ ',
  }

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "typescript",
    "tsx",
    "javascript",
    "vue",
    "vim",
    "json",
    "markdown",
    "lua",
    "html",
    "css",
    "java",
    "yaml",
    "go",
  },
  highlight = {
    enable = true,
  },
}
EOF

" colorscheme
colorscheme nightfox

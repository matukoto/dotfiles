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
autocmd TermOpen * startinsert

" install jetpackin
packadd vim-jetpack
call jetpack#begin('~/.vim/jetpack')  

Jetpack 'tani/vim-jetpack', {'opt': 1} 

Jetpack 'vim-jp/vimdoc-ja'

Jetpack 'neoclide/coc.nvim', {'branch': 'release'}

Jetpack 'lambdalisue/fern.vim'
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
" chatgpt
Jetpack 'lambdalisue/butler.vim'
Jetpack 'yuki-yano/ai-review.vim'
" 日本語検索
Jetpack 'lambdalisue/kensaku.vim'

" Jetpack 'skanehira/gyazo.vim'
Jetpack 'mattn/vim-sonictemplate'
Jetpack 'thinca/vim-quickrun'
Jetpack 'numToStr/comment.nvim'
Jetpack 'yuki-yano/fuzzy-motion.vim'

" カラースキーマ
Jetpack 'sainnhe/gruvbox-material'
Jetpack 'sainnhe/edge'
Jetpack 'sainnhe/sonokai'
Jetpack 'sainnhe/everforest'
Jetpack 'edeneast/nightfox.nvim'
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

" coc.nvim
let g:coc_global_extensions = ['@yaegassy/coc-volar', '@yaegassy/coc-volar-tools', 'coc-tsserver', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-lists', 'coc-go']
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

" nerdfont
let g:fern#renderer = 'nerdfont'

" fern
nnoremap <silent> <Leader>e :<c-u>Fern . -drawer<cr>
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -reveal=%<CR>

" ウィンドウ移動
nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l

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
" telescope でウィンドウのだし分けをしたい エンターならカレントウィンドウ 、丸々ならスプリットなど

" chatgpt
cabbrev ai AiReview
cabbrev gpt Butler<CR>

"" gin
cabbrev gs GinPreview<CR>
cabbrev ga <cmd>Gin add .<CR>
cabbrev gc <cmd>Gin commit<CR>
cabbrev gp <cmd>Gin push<CR>
cabbrev gd <cmd>GinDiff<CR>
cabbrev gb GinBranch

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

" gin-preview.vim
" https://github.com/kuuote/dotvim/blob/master/bundle/gin-preview.vim/plugin/gin_preview.vim
function s:open(curwin) abort
  " in before VimEnter, do lazy evaluation
  " because gin.vim is using denops.vim
  if !denops#plugin#is_loaded('gin')
    execute 'autocmd User DenopsPluginPost:gin ++nested call s:open(' .. a:curwin .. ')'
    return
  endif

  " git root by gin
  let root = gin#util#worktree()

  " open window
  if a:curwin
    silent! only
  else
    tab split
  endif

  " cd to git root
  execute 'tcd' root
  " open status window
  GinStatus
  " remove previous handler
  augroup gin-preview
    autocmd! * <buffer>
  augroup END
  let t:gin_preview = {'cursor': [-1, -1], 'status': win_getid()}
  " open worktree window
  belowright new
  diffthis
  let t:gin_preview.worktree = win_getid()
  " open index window
  vnew
  diffthis
  let t:gin_preview.index = win_getid()
  " resize status window
  call win_gotoid(t:gin_preview.status)
  execute 'resize' &lines / 3
  " define handler
  autocmd gin-preview CursorMoved <buffer> ++nested call s:moved()
endfunction

function! s:moved() abort
  if !exists('t:gin_preview')
    return
  endif
  let new_cursor = [line('.'), col('.')]
  if t:gin_preview.cursor == new_cursor
    return
  endif
  let t:gin_preview.cursor = new_cursor
  let line = getline('.')
  if line =~# '^##'
    return
  endif
  diffoff!
  let file = fnamemodify(line[3:], ':p')
  call win_execute(t:gin_preview.worktree, 'edit ' .. file .. ' | diffthis')
  if line =~# '^??'
    call win_execute(t:gin_preview.index, 'call s:open_not_index(' .. string(file) ..')')
  else
    call win_execute(t:gin_preview.index, 'GinEdit ' .. file .. ' | diffthis')
  endif
  call win_execute(t:gin_preview.worktree, 'set wrap')
  call win_execute(t:gin_preview.index, 'set wrap')
endfunction

command! -bang GinPreview call s:open(<bang>0)

function! s:open_not_index(file) abort
  let path = 'ginpreview://' .. a:file
  let b = bufnr(path)
  if b != -1
    execute 'buf' b
    diffthis
    return
  endif
  enew
  diffthis
  let b:gin_preview_file = a:file
  setlocal buftype=acwrite bufhidden=hide noswapfile
  autocmd BufWriteCmd <buffer> call timer_start(0, function('s:write_not_index'))
  execute 'file' path
endfunction

function! s:write_not_index(...) abort
  let b = bufnr()
  let file = b:gin_preview_file
  let text = getline(1, '$')
  call system('git add -N ' .. file)
  execute 'GinEdit ' .. file .. ' | diffthis'
  call setline(1, text)
  write
  execute 'bdelete!' b
endfunction

" lua
lua <<EOF
-- comment.nvim
require('Comment').setup()

-- modes.nvim
-- require('modes').setup({
-- 	colors = {
-- 		copy = "#f5c359",
-- 		delete = "#c75c6a",
-- 		insert = "#78ccc5",
-- 		visual = "#9745be",
-- 	},
-- })

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
colorscheme edge

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

Jetpack 'nvim-treesitter/nvim-treesitter'
" nerdfont
Jetpack 'lambdalisue/nerdfont.vim'
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
" easymotion
Jetpack 'easymotion/vim-easymotion'
" fzf
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" denops
Jetpack 'vim-denops/denops.vim'
" markdown
"Jetpack 'tani/glance-vim'
" git
Jetpack 'lambdalisue/gin.vim'
" chatgpt
Jetpack 'lambdalisue/butler.vim'
" 日本語検索
Jetpack 'lambdalisue/kensaku.vim'

Jetpack 'mattn/vim-sonictemplate'
Jetpack 'thinca/vim-quickrun'
Jetpack 'numToStr/comment.nvim'

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
nmap     <silent> [dev]rn <Plug>(coc-rename)
nmap     <silent> [dev]a  <Plug>(coc-codeaction-selected)iw

function! s:coc_typescript_settings() abort
  nnoremap <silent> <buffer> [dev]f :<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

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
nnoremap <silent> <leader>e :<c-u>Fern . -drawer<cr>
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -reveal=%<CR>

" sonictemplate
let g:sonictemplate_vim_template_dir = '$HOME/dotfiles/vim/sonictemplate/'

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
nnoremap <C-p> <cmd>Telescope find_files<CR>
" 文字列検索
nnoremap <C-g> <cmd>Telescope live_grep<CR>
" 横断検索
" nnoremap <C-f> <cmd>Telescope frecency<CR>
" 不明
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

"" gin
nnoremap <leader>gs <cmd>GinStatus ++opener=split<CR>
nnoremap <leader>ga <cmd>Gin add .<CR>
nnoremap <leader>gc <cmd>Gin commit<CR>
nnoremap <leader>gp <cmd>Gin push<CR>
nnoremap <leader>gf <cmd>Gin fetch<CR>
nnoremap <leader>gd <cmd>GinDiff<CR>

" git message
augroup select-commit-title
  autocmd!
  autocmd FileType *commit nnoremap <buffer> <CR><CR>
        \  <Cmd>silent! execute 'normal! ^w"zdiw"_dip"zPA: ' <bar> startinsert!<CR>
augroup END

" kensaku 
cnoremap <CR> <Plug>(kensaku-auto-replace)<CR>

"quickrun
nnoremap <Leader>qr <cmd>QuickRun <CR>

" comment.nvim
lua <<EOF
require('Comment').setup()
EOF

" treesitter
lua <<EOF
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

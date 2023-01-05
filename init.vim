" vimrc  を読み込む
if has('win64')
    source ~\_vimrc
else
    source ~/.vimrc
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

" install vim-jetpack
let s:jetpackfile = expand('<sfile>:p:h') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
call system(printf('curl -fsslo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

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

" カラースキーマ
Jetpack 'sainnhe/gruvbox-material'
Jetpack 'sainnhe/edge'
Jetpack 'sainnhe/sonokai'
Jetpack 'sainnhe/everforest'
Jetpack 'edeneast/nightfox.nvim'
call jetpack#end()

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

" easymotion
map f <Jetpack>(easymotion-fl)
map t <Jetpack>(easymotion-ft)
map F <Jetpack>(easymotion-Fl)
map T <Jetpack>(easymotion-Tl)

" coc.nvim
let g:coc_global_extensions = ['@yaegassy/coc-volar','@yaegassy/coc-volar-tools', 'coc-tsserver', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-lists']
inoremap <silent> <expr> <C-Space> coc#refresh()
nnoremap <silent> K       :<C-u>call <SID>show_documentation()<CR>
nmap     <silent> [dev]rn <Jetpack>(coc-rename)
nmap     <silent> [dev]a  <Jetpack>(coc-codeaction-selected)iw

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

"" lightline
" insert などを非表示に
set noshowmode
" ステータスラインを表示する
set laststatus=2
" カラースキーム
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
   \ }
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
nnoremap <leader>gs <cmd>GinStatus<CR>
nnoremap <leader>ga <cmd>Gin add .<CR>
nnoremap <leader>gc <cmd>Gin commit<CR>
nnoremap <leader>gp <cmd>Gin push<CR>
nnoremap <leader>gf <cmd>Gin fetch<CR>
nnoremap <leader>gdiff <cmd>GinDiff<CR>

" git message
augroup select-commit-title
  autocmd!
  autocmd FileType *commit nnoremap <buffer> <CR><CR>
        \  <Cmd>silent! execute 'normal! ^w"zdiw"_dip"zPA: ' <bar> startinsert!<CR>
augroup END

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

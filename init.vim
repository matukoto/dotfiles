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
" fzf
Jetpack 'lambdalisue/gina.vim'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }

Jetpack 'nvim-treesitter/nvim-treesitter'
" nerdfont
Jetpack 'lambdalisue/nerdfont.vim'
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
" easymotion
Jetpack 'easymotion/vim-easymotion'
" denops
Jetpack 'vim-denops/denops.vim'
" markdown
"Jetpack 'tani/glance-vim'

" カラースキーマ
Jetpack 'sainnhe/gruvbox-material'
Jetpack 'sainnhe/edge'
Jetpack 'sainnhe/sonokai'
Jetpack 'sainnhe/everforest'
Jetpack 'edeneast/nightfox.nvim'
call jetpack#end()

" map prefix
let g:mapleader = "\<space>"
nnoremap <Leader> <nop>
xnoremap <Leader> <nop>
xnoremap [dev]    <Nop>
nmap     m        [dev]
xmap     m        [dev]
nnoremap [ff]     <Nop>
xnoremap [ff]     <Nop>
nmap     z        [ff]
xmap     z        [ff]


" easymotion
map f <Jetpack>(easymotion-fl)
map t <Jetpack>(easymotion-ft)
map F <Jetpack>(easymotion-Fl)
map T <Jetpack>(easymotion-Tl)

" coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-vetur', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-fzf-preview', 'coc-lists']
" coc のステータスを表示
set statusline=%{coc#status()}

inoremap <silent> <expr> <C-Space> coc#refresh()
nnoremap <silent> K       :<C-u>call <SID>show_documentation()<CR>
nmap     <silent> [dev]rn <Jetpack>(coc-rename)
nmap     <silent> [dev]a  <Jetpack>(coc-codeaction-selected)iw

function! s:coc_typescript_settings() abort
  nnoremap <silent> <buffer> [dev]f :<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
  autocmd!
  autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END

" nerdfont
let g:fern#renderer = 'nerdfont'

" fern
nnoremap <silent> <leader>e :<c-u>Fern . -drawer<cr>
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -reveal=%<CR>

" help
function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction
"" fzf-preview
let $BAT_THEME                     = 'gruvbox-dark'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox-dark'

nnoremap <silent> <C-p>  :<C-u>CocCommand fzf-preview.FromResources buffer project_mru project<CR>
nnoremap <silent> [ff]s  :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [ff]gg :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [ff]b  :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap          [ff]f  :<C-u>CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>
xnoremap          [ff]f  "sy:CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

nnoremap <silent> [ff]q  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> [ff]rf :<C-u>CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> [ff]d  :<C-u>CocCommand fzf-preview.CocDefinition<CR>
nnoremap <silent> [ff]t  :<C-u>CocCommand fzf-preview.CocTypeDefinition<CR>
nnoremap <silent> [ff]o  :<C-u>CocCommand fzf-preview.CocOutline --add-fzf-arg=--exact --add-fzf-arg=--no-sort<CR>

"" lightline
" insert などを非表示に
set noshowmode
" ステータスラインを表示する
set laststatus=2
" カラースキーム
let g:lightline = { 'colorscheme': 'wombat' }

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
  },
  highlight = {
    enable = true,
  },
}
EOF

" colorscheme
colorscheme gruvbox-material


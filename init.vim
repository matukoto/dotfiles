" vimrc を読み込む
if has('win64')
    source ~\_vimrc
else
    source ~/.vimrc
endif

" install vim-jetpack
let s:jetpackfile = expand('<sfile>:p:h') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

" Install Jetpackin
packadd vim-jetpack
call jetpack#begin('~/.vim/jetpack')  

Jetpack 'tani/vim-jetpack', {'opt': 2} 

"Jetpack 'vim-jp/vimdoc-ja'

Jetpack 'neoclide/coc.nvim', {'branch': 'release'}

Jetpack 'lambdalisue/fern.vim'

Jetpack 'nvim-treesitter/nvim-treesitter'
" カラースキーマ
Jetpack 'sainnhe/gruvbox-material'
Jetpack 'sainnhe/edge'
Jetpack 'sainnhe/sonokai'
Jetpack 'sainnhe/everforest'
" nerdfont
Jetpack 'lambdalisue/nerdfont.vim'
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
" easymotion
Jetpack 'easymotion/vim-easymotion'
" denops
Jetpack 'vim-denops/denops.vim'
" markdown
Jetpack 'tani/glance-vim'
call jetpack#end()

" 起動時にインストール
" for name in jetpack#names()
"   if !jetpack#tap(name)
"     call jetpack#sync()
"     break
"   endif
" endfor

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
let g:coc_global_extensions = ['@yaegassy/coc-volar', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-lists']
" coc のステータスを表示
set statusline^=%{coc#status()}

autocmd FileType vue let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'vue.config.js', 'nuxt.config.ts']

" fern
nnoremap <silent> <Leader>e :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -reveal=%<CR>

" nerdfont
let g:fern#renderer = 'nerdfont'

" treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "typescript",
    "tsx",
    "javascript",
    "vim",
    "vue",
    "json",
    "markdown",
    "lua",
    "html",
    "css",
  },
  highlight = {
    enable = true,
  },
}
EOF

" colorscheme
"colorscheme gruvbox-material
"colorscheme edge
colorscheme everforest

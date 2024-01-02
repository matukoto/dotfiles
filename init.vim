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
" denops
Jetpack 'vim-denops/denops.vim'
" git
Jetpack 'lambdalisue/gin.vim'
Jetpack 'APZelos/blamer.nvim'
Jetpack 'iberianpig/tig-explorer.vim'
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
Jetpack 'cshuaimin/ssr.nvim'
Jetpack 'shellRaining/hlchunk.nvim'
Jetpack 'stevearc/aerial.nvim'
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
" imap <expr> <C-Space> copilot#expand()
" imap <Tab> copilot#Accept()
" imap <C-]> <plug>(copilot-dismiss)
" imap <M-]> <plug>(copilot-next)
" imap <M=[> <plug>(copilot-prev)


" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500

" nerdfont
let g:fern#renderer = 'nerdfont'

" fern
" ドットファイルなどをデフォルトで表示
let g:fern#default_hidden = 1

nnoremap <silent> <Leader>e :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>E :<C-u>Fern . -reveal=%<CR>

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
nnoremap <silent> H :tabprevious<CR>
nnoremap <silent> L :tabnext<CR>

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
   \     [ 'gitbranch', 'readonly',  'filename', 'method', 'modified' ]
   \   ],
   \ },
   \ 'component_function': {
   \   'gitbranch': 'gitbranch#name'
   \ },
   \ 'colorscheme': 'edge',
\ }
 
"" gin
cabbrev gs GinPreview<CR>
cabbrev ga Gin add .<CR>
cabbrev gc Gin commit<CR>
cabbrev gp Gin push<CR>
cabbrev gd GinDiff<CR>
cabbrev gb GinBranch
let g:gin_proxy_apply_without_confirm = 1

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

-- hlchunk
require("hlchunk").setup({
    chunk = {
        enable = true,
        notify = true,
        use_treesitter = true,
        -- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
        -- support_filetypes = ft.support_filetypes,
        -- exclude_filetypes = ft.exclude_filetypes,
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
        },
        style = {
            { fg = "#806d9c" },
            { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
        },
        textobject = "",
        max_file_size = 1024 * 1024,
        error_sign = true,
    },
    indent = {
        enable = false
    },
    line_num = {
        enable = false
    },
    blank = {
        enable = false
    }
})

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

-- aerial アウトラインを表示する
require("aerial").setup()
-- アウトラインを表示、非表示を切り替える
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

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
    "svelte",
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
colorscheme gruvbox-material

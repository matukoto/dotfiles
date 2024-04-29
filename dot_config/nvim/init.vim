
" :p でフルパスを取得
" :h でディレクトリのみを取得
let $VIMHOME = expand('<sfile>:p:h')
let s:is_windows = has('win32')

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
command! -nargs=* T split | wincmd j | resize 15 | terminal <args>
" インサートモードでターミナルを開く
autocmd TermOpen * startinsert

" Plugin
source $VIMHOME/jetpack.vim

" cheat sheet
let g:cheatsheet#cheat_file = '$HOME/dotfiles/vim/cheatSheet/default.md'
let g:cheatsheet#float_window = 1
let g:cheatsheet#float_window_width_ratio = 0.6
let g:cheatsheet#float_window_height_ratio = 0.5

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

" copilot
imap <expr> <C-Space> copilot#expand()
imap <Tab> copilot#Accept()
imap <C-]> <plug>(copilot-dismiss)
let g:copilot_filetypes = {
      \ '*': v:true,
      \ 'java': v:false,
      \ }

" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500

" nerdfont
let g:fern#renderer = 'nerdfont'

" fern
" ドットファイルなどをデフォルトで表示
let g:fern#default_hidden = 1
" drawer で開く
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>e :<C-u>Fern . -reveal=%<CR>

function! s:fern_settings() abort
  nmap <silent> <buffer> D     <Plug>(fern-action-remove=)y<CR>
  nmap <silent> <buffer> n     <Plug>(fern-action-new-file)
  nmap <silent> <buffer> N     <Plug>(fern-action-new-dir)
  nmap <silent> <buffer> h     <Plug>(fern-action-leave)
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" ウィンドウ移動
nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l

" タブ
nnoremap <silent> H :tabprevious<CR>
nnoremap <silent> L :tabnext<CR>
nnoremap qt <Cmd>tabclose<CR>

" sonictemplate
let g:sonictemplate_vim_template_dir = '$HOME/.vim/sonictemplate/'
cabbrev tp Template

"" gin
let g:gin_proxy_apply_without_confirm = 1
nnoremap <C-g>s <Cmd>GinPreview<CR>
" バッファの差分を表示
nnoremap <C-g>a <Cmd>Gin add --all<CR>
nnoremap <C-g>c <Cmd>Gin commit --quiet<CR>
nnoremap <C-g>p <Cmd>GinPatch ++opener=tabnew %<CR>
" nnoremap <Lieader>g<C-d> <Cmd>GinDiff ++processor=delta\ --no-gitconfig\ --color-only<CR>
nnoremap <C-g>l  <Cmd>GinLog<CR>
" nnoremap <Lieader>gl <Cmd>GinLog -- %<CR>
nnoremap <C-g>b <Cmd>GinBranch --all<CR>
nnoremap <C-g>d <Cmd>GinDiff<CR>

function! s:my_gin_log() abort
  nnoremap <buffer> if <Plug>(gin-action-fixup:instant-fixup)
  nnoremap <buffer> ir <Plug>(gin-action-fixup:instant-reword)
  setl cursorline
endfunction

augroup my-gin
  autocmd!
  autocmd User GinComponentPost redrawtabline
  autocmd FileType gin-log silent! call s:my_gin_log()
augroup END

" 
if executable('delta')
  let g:gin_diff_persistent_args = [
        \ '++processor=delta --diff-highlight --keep-plus-minus-markers',
        \]
endif

" dadbod
nnoremap <Leader>w <Plug>(DBUI_SaveQuery)
let g:db_ui_save_location = '~/.vim/dadbod-ui'

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

"let g:denops#debug = 1
let g:denops#server#deno_args = ['-q', '--no-lock', '-A', '--unstable-ffi', '--unstable-kv']
" denops-shared-server port
" let g:denops_server_addr = "127.0.0.1:32123"

" denops-shared-server install 後、初回のみ実行すれば良い
" call denops_shared_server#install()

" edge-motion
nnoremap <C-j> <Plug>(edgemotion-j)
nnoremap <C-k> <Plug>(edgemotion-k)

" skk
call skkeleton#config({
      \ 'globalDictionaries': ['~/.skk/SKK-JISYO.L','~/.skk/SKK-JISYO.emoji.utf8', '~/.skk/SKK-JISYO.geo', '~/.skk/SKK-JISYO.jinmei', '~/.skk/SKK-JISYO.propernoun'],
      \ 'sources': ['deno_kv', 'google_japanese_input'],
      \ 'databasePath': '~/.skk/skkeleton.db',
      \ 'eggLikeNewline': v:true,
      \ 'immediatelyCancel': v:false,
      \ 'registerConvertResult': v:true,
      \ 'showCandidatesCount': 2,
      \})
imap <C-j> <Plug>(skkeleton-enable);
cmap <C-j> <Plug>(skkeleton-enable);

" statusline_skk
let g:lightline_skk_announce = v:true
call statusline_skk#option('display', {
  \ 'hiragana': 'あ',
  \ 'katakana': 'ア',
  \ 'hankaku-katakana': 'ｱ',
  \ 'zenkaku-alphabet': 'Ａ',
  \ 'alphabet': 'A',
  \ })
call statusline_skk#option('enable_mode', {
  \ 'INSERT': v:true,
  \ 'COMMAND': v:false,
  \ })

" ddc
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['skkeleton'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'skkeleton': {
      \     'isVolatile': v:true,
      \     'mark': 'skkeleton',
      \     'matchers': ['skkeleton'],
      \     'sorters': [],
      \     'minAutoCompleteLength': 2,
      \   },
      \ })
call ddc#enable()

" deepl
let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
let g:deepl#auth_key = "00000000-0000-0000-0000-000000000000:fx" " or readfile(expand('~/.config/deepl.auth_key'))[0]

" replace a visual selection
vmap t<C-e> <Cmd>call deepl#v("EN")<CR>
vmap t<C-j> <Cmd>call deepl#v("JA")<CR>

" translate a current line and display on a new line
nmap t<C-e> yypV<Cmd>call deepl#v("EN")<CR>
nmap t<C-j> yypV<Cmd>call deepl#v("JA")<CR>

" specify the source language
" translate from FR to EN
" nmap t<C-e> yypV<Cmd>call deepl#v("EN", "FR")<CR>

" open browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" gyazoupload
let g:gyazo#token = '$GYAZO_TOKEN'

source ~/.config/nvim/plugin/gin-preview.vim

source ~/.config/nvim/lua/init.lua

" colorscheme
colorscheme everforest

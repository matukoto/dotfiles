" :p でフルパスを取得
" :h でディレクトリのみを取得
let $VIMHOME = expand('<sfile>:p:h')
let s:is_windows = has('win32')

" statusline を常に1つにする
set laststatus=3
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

" Plugin
source $VIMHOME/jetpack.vim

" colorscheme
" colorscheme everforest


lua << EOF
-- nvim 起動時に :GinStatus を実行する {{{
vim.api.nvim_create_autocmd('User', {
  pattern = 'DenopsPluginPost:gin',
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if #buf_name > 0 then
      return
    end
    -- lualine のブランチ名取得でも良いけど、依存が増えるでボツ
    -- local branch = require('lualine.components.branch.git_branch').get_branch()
    -- if #branch > 0 then
    --     vim.schedule(function() vim.fn.execute('GinStatus') end)
    -- end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'GinComponentPost',
      callback = function()
        vim.schedule(function()
          -- local worktree_name = vim.fn['gin#internal#component#get']('component:worktree:name')
          local worktree_name = vim.fn['gin#component#worktree#name']()
          if #worktree_name ~= 0 then
            vim.fn.execute('GinStatus')
          end
        end)
      end,
      once = true,
    })
    -- 空バッファだとUser GinComponentPost イベントが発行されない！？ので無理やり更新させる
    -- (遅延ロードさせているのが原因かも)
    vim.fn['gin#internal#component#update']('component:worktree:name')
  end,
  once = true,
})
-- }}}

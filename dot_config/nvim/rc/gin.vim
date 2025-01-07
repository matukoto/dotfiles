let g:gin_proxy_apply_without_confirm = 1
nnoremap <C-g>s <Cmd>GinStatus<CR>
" バッファの差分を表示
nnoremap <C-g>a <Cmd>Gin add --all<CR>
nnoremap <C-g>c <Cmd>Gin commit --quiet<CR>
nnoremap <C-g>P <Cmd>GinPatch ++opener=tabnew ++no-head %<CR>
nnoremap <C-g>p <Cmd>Gin push --quiet<CR>
nnoremap <C-g>l <Cmd>GinLog ++opener=tabnew<CR>
nnoremap <C-g>b <Cmd>GinBranch --all<CR>
nnoremap <C-g>d <Cmd>GinDiff<CR>

function! s:my_gin_log() abort
  nnoremap <buffer> if <Plug>(gin-action-fixup:instant-fixup)
  nnoremap <buffer> ir <Plug>(gin-action-fixup:instant-reword)
  nnoremap <buffer> <CR> <Plug>(gin-action-show:vsplit)
  setl cursorline
endfunction

function! s:gin_checkout_current_file() abort
 " 現在行のファイル名を取得（行の先頭のステータスを無視）
  let l:file = matchstr(getline('.'), '\v^\s*[A-Z]+\s+\zs\S+')
  " Gin checkout コマンドを実行
  if !empty(l:file)
    execute 'Gin checkout -- ' . l:file
  else
    echo "No file found on the current line"
  endif
endfunction

function! s:my_gin_status() abort
  "nnoremap <buffer> co :Gin checkout -- <C-r>=expand('<cfile>')<CR><CR>
  nnoremap <buffer> co :call <SID>gin_checkout_current_file()<CR>
endfunction

function! s:my_gin_patch() abort
  nnoremap <buffer> dp <Plug>(gin-diffput)
  nnoremap <buffer> do <Plug>(gin-diffget)
endfunction

augroup my-gin
  autocmd!
  autocmd User GinComponentPost redrawtabline
  autocmd FileType gin-log silent! call s:my_gin_log()
  autocmd FileType gin-status silent! call s:my_gin_status()
  autocmd BufRead ginedit://* silent! call s:my_gin_patch()
augroup END

if executable('delta')
  let g:gin_diff_persistent_args = [
        \ '++processor=delta --diff-highlight --no-gitconfig --color-only'
        \]
endif

cabbrev gsc Gin switch -c

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

if executable('delta')
  let g:gin_diff_persistent_args = [
        \ '++processor=delta --diff-highlight --keep-plus-minus-markers',
        \]
endif

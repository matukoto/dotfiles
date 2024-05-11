" ドットファイルなどをデフォルトで表示しない
let g:fern#default_hidden = 0
" drawer で開く
nnoremap <silent> <Leader>E  :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>e  :<C-u>Fern . -reveal=%<CR>
nnoremap <silent> <Leader>ce :<C-u>Fern %:h<CR>
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

" nerdfont
let g:fern#renderer = 'nerdfont'

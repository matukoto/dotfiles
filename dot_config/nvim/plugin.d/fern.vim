" ドットファイルなどをデフォルトで表示しない
let g:fern#default_hidden = 0
" drawer で開く
nnoremap <silent> <Leader>E  :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>e  :<C-u>Fern . -reveal=%<CR>
nnoremap <silent> <Leader>ce :<C-u>Fern %:h<CR>


function! s:fern_settings() abort
  nmap <silent> <buffer> D     <Plug>(fern-action-remove=)y<CR>
  nmap <silent> <buffer> <C-f> <Plug>(fern-action-new-file)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-new-dir)
  nmap <silent> <buffer> H     <Plug>(fern-action-leave)
  nmap <silent> <buffer> L     <Plug>(fern-action-expand)
  nmap <silent> <buffer> <CR>  <Plug>(fern-action-open)
  nmap <silent> <buffer> <C-v> <Plug>(fern-action-open:vsplit)
  nmap <silent> <buffer> !   <Plug>(fern-action-hidden:toggle)
  nmap <silent> <buffer> <C-h> <Plug>(fern-action-open:split)
  nmap <silent> <buffer> <C-t> <Plug>(fern-action-open:tabedit)
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> R     <Plug>(fern-action-rename:select)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> <ESC> <Plug>(fern-quit-or-close-preview)
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" nerdfont
let g:fern#renderer = 'nerdfont'
let g:fern#disable_default_mappings = 1

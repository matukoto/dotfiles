" ドットファイルなどをデフォルトで表示
let g:fern#default_hidden = 1
" drawer で開く
nnoremap <silent> <Leader>E  :<C-u>Fern . -drawer<CR>
nnoremap <silent> <Leader>e  :<C-u>Fern . -reveal=%<CR>
nnoremap <silent> <Leader>ce :<C-u>Fern %:h<CR>


function! s:fern_settings() abort
  " 削除
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-remove=)y<CR>
  " 新規ファイル作成
  nmap <silent> <buffer> F     <Plug>(fern-action-new-file)
  " 新規ディレクトリ作成
  nmap <silent> <buffer> D     <Plug>(fern-action-new-dir)
  " 一階層上に移動
  nmap <silent> <buffer> h     <Plug>(fern-action-leave)
  " 一階層下に移動
  nmap <silent> <buffer> l     <Plug>(fern-action-expand)
  " ファイルを開く
  nmap <silent> <buffer> <CR>  <Plug>(fern-action-open)
  " ファイルを開く 垂直
  nmap <silent> <buffer> <C-v> <Plug>(fern-action-open:vsplit)
  " 隠しファイルの表示切り替え
  nmap <silent> <buffer> !   <Plug>(fern-action-hidden:toggle)
  " ファイルを開く 水平
  nmap <silent> <buffer> <C-h> <Plug>(fern-action-open:split)
  " ファイルを開く タブ
  nmap <silent> <buffer> <C-t> <Plug>(fern-action-open:tabedit)
  " プレビュー
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  " ファイル名変更
  nmap <silent> <buffer> R     <Plug>(fern-action-rename:vsplit)
  " path をヤンク
  nmap <silent> <buffer> yp    <Plug>(fern-action-yank:path)
  " ファイル名をヤンク
  nmap <silent> <buffer> yf    <Plug>(fern-action-yank:label)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  " プレビューを閉じる
  nmap <silent> <buffer> <ESC> <Plug>(fern-quit-or-close-preview)
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

let g:fern#disable_default_mappings = 1

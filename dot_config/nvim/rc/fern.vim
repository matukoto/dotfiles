" Fernファイラーの主要設定

" 基本設定
" ドットファイル（.で始まるファイル）などの隠しファイルをデフォルトで表示
let g:fern#default_hidden = 1

" デフォルトのキーマッピングを無効化（カスタムマッピングを使用）
let g:fern#disable_default_mappings = 1

" グローバルキーマッピング
" <Leader>E: カレントディレクトリをドロワー（サイドバー）として開く
nnoremap <silent> <Leader>E  :<C-u>Fern . -drawer<CR>
" <Leader>e: カレントファイルがある位置を展開して開く
nnoremap <silent> <Leader>e  :<C-u>Fern . -reveal=%<CR>
" <Leader>ce: カレントファイルのディレクトリを開く
nnoremap <silent> <Leader>ce :<C-u>Fern %:h<CR>

" Fernバッファ内での操作設定
function! s:fern_settings() abort
  " ファイル操作
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-remove=)y<CR>  " ファイル/ディレクトリの削除
  nmap <silent> <buffer> F     <Plug>(fern-action-new-file)      " 新規ファイル作成
  nmap <silent> <buffer> D     <Plug>(fern-action-new-dir)       " 新規ディレクトリ作成
  nmap <silent> <buffer> R     <Plug>(fern-action-rename:vsplit)  " ファイル名変更

  " ナビゲーション
  nmap <silent> <buffer> h     <Plug>(fern-action-leave)    " 一階層上に移動
  nmap <silent> <buffer> l     <Plug>(fern-action-expand)   " 一階層下に移動

  " ファイルを開く
  nmap <silent> <buffer> <CR>  <Plug>(fern-action-open)         " 現在のウィンドウで開く
  nmap <silent> <buffer> <C-v> <Plug>(fern-action-open:vsplit)  " 垂直分割で開く
  nmap <silent> <buffer> <C-l> <Plug>(fern-action-open:split)   " 水平分割で開く
  nmap <silent> <buffer> <C-t> <Plug>(fern-action-open:tabedit) " 新しいタブで開く

  " 表示設定
  nmap <silent> <buffer> !     <Plug>(fern-action-hidden:toggle)  " 隠しファイルの表示切り替え

  " プレビュー機能
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)      " プレビューの切り替え
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle) " 自動プレビューの切り替え

  " クリップボード操作
  nmap <silent> <buffer> yp    <Plug>(fern-action-yank:path)   " ファイルパスをヤンク
  nmap <silent> <buffer> yf    <Plug>(fern-action-yank:label)  " ファイル名をヤンク

  " 終了操作
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> <ESC> <Plug>(fern-quit-or-close-preview)  " プレビューを閉じるかFernを終了
  nmap <silent> <buffer> q     <Plug>(fern-quit-or-close-preview)  " プレビューを閉じるかFernを終了
endfunction

" Fernバッファ設定の自動適用
augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

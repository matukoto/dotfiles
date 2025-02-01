" GitHub Copilotの追加設定

" キーマッピング設定
" Ctrl+Space: 現在のサジェストを展開
imap <expr> <C-Space> copilot#expand()
" Ctrl+]: サジェストを閉じる
imap <C-]> <plug>(copilot-dismiss)

" Tabキーのマッピングを無効化するオプション（現在はコメントアウト）
" let g:copilot_no_tab_map = v:true

" 全てのデフォルトマッピングを無効化するオプション（現在はコメントアウト）
" let g:copilot_no_maps = v:true

" ファイルタイプごとのCopilot有効/無効設定
let g:copilot_filetypes = {
      \ }

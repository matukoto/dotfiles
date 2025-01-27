" CamelCaseMotionの設定
" キャメルケース（camelCase）やスネークケース（snake_case）での単語移動を可能にするプラグイン

" キャメルケースモーションのトリガーキーを'['に設定
let g:camelcasemotion_key = '['

" 以下はデフォルトのキーマッピングの例（現在はコメントアウト）
" ノーマルモードでの移動
" map <silent> w <Plug>CamelCaseMotion_w     " 次のキャメルケース部分へ移動
" map <silent> b <Plug>CamelCaseMotion_b     " 前のキャメルケース部分へ移動
" map <silent> e <Plug>CamelCaseMotion_e     " 現在のキャメルケース部分の末尾へ移動
" map <silent> ge <Plug>CamelCaseMotion_ge   " 前のキャメルケース部分の末尾へ移動
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

" オペレータ待機モードとビジュアルモードでのテキストオブジェクト
" omap <silent> iw <Plug>CamelCaseMotion_iw  " キャメルケース部分の内側を選択
" xmap <silent> iw <Plug>CamelCaseMotion_iw  " キャメルケース部分の内側を選択（ビジュアル）
" omap <silent> ib <Plug>CamelCaseMotion_ib  " 前のキャメルケース境界まで選択
" xmap <silent> ib <Plug>CamelCaseMotion_ib  " 前のキャメルケース境界まで選択（ビジュアル）
" omap <silent> ie <Plug>CamelCaseMotion_ie  " 次のキャメルケース境界まで選択
" xmap <silent> ie <Plug>CamelCaseMotion_ie  " 次のキャメルケース境界まで選択（ビジュアル）

" インサートモードでの移動
" imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b   " Shift+左で前のキャメルケース部分へ
" imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w  " Shift+右で次のキャメルケース部分へ

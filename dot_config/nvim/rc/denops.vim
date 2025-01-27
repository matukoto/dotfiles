" Denops（Deno + Vim/Neovim）の基本設定

" デバッグモードを有効化（エラー時により詳細な情報を表示）
" let g:denops#debug = 1

" Denoの実行時引数を設定
let g:denops#server#deno_args = [
      \ '-q',            
      \ '--no-lock',     
      \ '-A',            
      \ '--unstable-ffi', 
      \ '--unstable-kv'   
      \ ]

" denops-shared-serverのポート設定（現在はコメントアウト）
" 複数のNeovimインスタンス間でDenopsサーバーを共有する場合に使用
" let g:denops_server_addr = "127.0.0.1:32123"

" denops-shared-serverのインストールコマンド
" 注意: インストール後、初回のみ実行が必要
" call denops_shared_server#install()

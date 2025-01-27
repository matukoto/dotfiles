" Fern（ファイラー）のGitステータス表示設定

" .gitignoreで無視されたファイルのステータス表示を無効化（パフォーマンス向上のため）
let g:fern_git_status#disable_ignored = 1

" Gitの管理対象外（未追跡）ファイルのステータス表示を有効化
let g:fern_git_status#disable_untracked = 0

" Gitサブモジュールのステータス表示を無効化
let g:fern_git_status#disable_submodules = 1

" ディレクトリのGitステータス表示を有効化
" 例: ディレクトリ内に変更があった場合、ディレクトリ自体にもステータスを表示
let g:fern_git_status#disable_directories = 0

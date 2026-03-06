function pull_skk_dict
    # 現在のディレクトリを保存
    set current_dir (pwd)

    # skk ディレクトリへ移動
    cd ~/.skk

    # リモートリポジトリの更新
    git fetch --prune origin
    git rebase origin/main

    # 元のディレクトリへ戻る
    cd $current_dir

    echo "SKK dictionary pulled successfully."
end

function pull_skk_dict
    # 現在のディレクトリを保存
    set current_dir (pwd)

    # skk ディレクトリへ移動
    cd ~/.skk

    # リモートリポジトリの更新
    git fetch

    # Git 操作の実行
    if not git rebase origin/main
        echo "エラー: git pull --rebase に失敗しました。" >&2
        cd $current_dir
        return 1
    end

    # 元のディレクトリへ戻る
    cd $current_dir

    echo "SKK dictionary pulled successfully."
end

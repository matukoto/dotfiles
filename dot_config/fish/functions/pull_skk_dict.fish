function pull_skk_dict
    # 現在のディレクトリを保存
    set current_dir (pwd)

    # skk ディレクトリへ移動
    cd ~/.skk

    # 現在の日付を取得 (YYYY-MM-DD 形式)

    # Git 操作の実行
    if not git pull --quiet
        echo "エラー: git pullに失敗しました。" >&2
        cd $current_dir
        return 1
    end

    # 元のディレクトリへ戻る
    cd $current_dir

    echo "SKK dictionary pulled successfully."
end

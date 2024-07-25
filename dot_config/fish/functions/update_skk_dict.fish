function update_skk_dict
    # 現在のディレクトリを保存
    set current_dir (pwd)

    # skk ディレクトリへ移動
    cd ~/.skk

    # 現在の日付を取得 (YYYY-MM-DD 形式)
    set current_date (date +"%Y-%m-%d")

    # Git 操作の実行
    git add userdict.txt
    if not git commit -m "feat: add skk dictionary $current_date" --quiet
        echo "エラー: git commit に失敗しました。変更がないか確認してください。" >&2
        cd $current_dir
        return 1
    end

    if not git push --quiet
        echo "エラー: git push に失敗しました。ネットワーク接続やリモートリポジトリの状態を確認してください。" >&2
        cd $current_dir
        return 1
    end

    # 元のディレクトリへ戻る
    cd $current_dir

    echo "SKK dictionary updated and pushed successfully."
end

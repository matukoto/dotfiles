function update_skk_dict
    # 現在のディレクトリを保存
    set current_dir (pwd)

    # skk ディレクトリへ移動
    cd ~/.skk

    # 現在の日付を取得 (YYYY-MM-DD 形式)
    set current_date (date +"%Y-%m-%d")

    # Git 操作の実行
    git add my-skk-dict
    git commit --message "($current_date) add dictionary" --quiet 
    git push --quiet

    # 元のディレクトリへ戻る
    cd $current_dir

    echo "SKK dictionary updated and pushed successfully."
end

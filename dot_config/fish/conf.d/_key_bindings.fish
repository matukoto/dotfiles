# vi キーバインド設定
# conf.d は config.fish より先に読み込まれるため、ここで設定する
# _tide_init.fish より前（アルファベット順）に実行されるよう _ プレフィックスをつける
if status is-interactive
    if set -q NVIM
        fish_default_key_bindings
    else
        fish_vi_key_bindings
    end
end

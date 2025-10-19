#!/bin/bash

# run_once_hogehoge は `chezmoi apply` した際に以前に実行されたことがなければ実行されるファイル
# 主にツールのインストールなど、一度だけ実行すれば良いものを記述する

# aqua
curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.2/aqua-installer
echo "98b883756cdd0a6807a8c7623404bfc3bc169275ad9064dc23a6e24ad398f43d  aqua-installer" | sha256sum -c -
chmod +x aqua-installer
./aqua-installer

# nu starship
# git clone https://github.com/nushell/nushell.git
# cd nushell || exit
# cargo build --release --workspace
# cargo run --release

curl -sS https://starship.rs/install.sh | sh
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
use ~/.cache/starship/init.nu
# yay
# yay -S --noconfirm sqlite
# yay -S --noconfirm jq
# yay -S --noconfirm ripgrep

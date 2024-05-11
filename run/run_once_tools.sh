#!/bin/bash

# run_once_hogehoge は `chezmoi apply` した際に以前に実行されたことがなければ実行されるファイル
# 主にツールのインストールなど、一度だけ実行すれば良いものを記述する

# mise
curl https://mise.run | sh
mise i

# nu starship
git clone https://github.com/nushell/nushell.git
cd nushell
cargo build --release --workspace; cargo run --release

curl -sS https://starship.rs/install.sh | sh
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
use ~/.cache/starship/init.nu
# yay
# yay -S --noconfirm sqlite
# yay -S --noconfirm jq
# yay -S --noconfirm ripgrep

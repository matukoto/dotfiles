#!/bin/bash

# run_once_hogehoge は `chezmoi apply` した際に以前に実行されたことがなければ実行されるファイル
# 主にツールのインストールなど、一度だけ実行すれば良いものを記述する

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# aqua
curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer
echo "fb4b3b7d026e5aba1fc478c268e8fbd653e01404c8a8c6284fdba88ae62eda6a  aqua-installer" | sha256sum -c
chmod +x aqua-installer
./aqua-installer

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

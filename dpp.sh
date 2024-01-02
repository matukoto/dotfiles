mkdir -p ~/.cache/dpp/repos/github.com/
cd ~/.cache/dpp/repos/github.com/

mkdir dark-power
mkdir vim-denops

cd ./dark-power

# dpp 本体の clone
git clone https://github.com/Shougo/dpp.vim

# dpp 関連の clone
git clone https://github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-lazy
git clone https://github.com/Shougo/dpp-ext-toml

# denops.vim の clone
cd ../vim-denops
git clone https://github.com/vim-denops/denops.vim

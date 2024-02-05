#!bin/bash

# it is process for install dpp and denops
mkdir -p ~/.cache/dpp/repos/github.com/
cd ~/.cache/dpp/repos/github.com/

mkdir Shougo
mkdir vim-denops

# dpp install
cd ./Shougo
git clone https://github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-lazy
git clone https://github.com/Shougo/dpp-ext-toml

# denops install
cd ../vim-denops
git clone https://github.com/vim-denops/denops.vim

# create TS setting file
# symlink
mkdir ~/.config/nvim/dpp
ln -s ~/dotfiles/dpp/dpp.ts ~/.config/nvim/dpp.ts
ln -s ~/dotfiles/dpp/dpp.toml ~/.config/nvim/dpp/dpp.toml
ln -s ~/dotfiles/dpp/dpp_lazy.toml ~/.config/nvim/dpp/dpp_lazy.toml
ln -s ~/dotfiles/dpp/init.lua ~/.config/nvim/dpp/init.lua
ln -s ~/dotfiles/dpp/init.lua ~/.config/nvim/init.lua
unlink ~/.config/nvim/init.vim

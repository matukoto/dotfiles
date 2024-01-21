#!bin/bash

# it is process for install dpp and denops
mkdir -p ~/.cache/dpp/repos/github.com/
cd ~/.cache/dpp/repos/github.com/

mkdir dd
mkdir denops

# dpp install
cd ./dd
git clone https://github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-lazy
git clone https://github.com/Shougo/dpp-ext-toml

# denops install
cd ../denops
git clone https://github.com/vim-denops/denops.vim

# create TS setting file
touch ~/.config/nvim/dpp.ts

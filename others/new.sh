#!/bin/bash

# get nightly release version

get_nvim () {
    local LOCAL_BIN="$HOME/.local/bin" 
local app_name="nvim"
local app_path="$LOCAL_BIN/$app_name"

mkdir -p $LOCAL_BIN
rm -rf $LOCAL_BIN/$app_name

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract

mv squashfs-root/usr/bin/nvim $app_path
rm -rf squashfs-root

chmod u+x $app_path
}

get_nvim

# 参考
# https://zenn.dev/isksss/articles/0aa8c5c174d5d6

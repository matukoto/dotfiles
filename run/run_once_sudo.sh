#!/bin/sh

# Vim で使う
sudo apt install \
  libncurses5-dev \
  libncursesw5-dev \
  make \
  cmake \
  ninja-build \
  luajit \
  gettext \
  libssl-dev \
  libdbus-1-dev \
  libsqlite3-dev

# Neovim の画像表示（image.nvim）で使う
sudo apt install \
  imagemagick

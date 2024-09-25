#!/bin/sh

CURRENT_DIR=$(pwd "$0")

cd "${HOME}"/work/github.com/neovim/neovim || exit

git fetch --prune origin
git rebase origin/master

make distclean

make CMAKE_BUILD_TYPE=Release \
  CMAKE_INSTALL_PREFIX="$HOME"/.local/ \
  BUNDLED_CMAKE_FLAG='-DUSE_BUNDLED_TS_PARSERS=OFF'

make install

cd "${CURRENT_DIR}" || exit

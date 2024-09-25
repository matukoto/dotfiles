#!/bin/sh

CURRENT_DIR=$(pwd "$0")
VIM_ROOT=${HOME}/work/github.com/vim/vim
INSTALL_DIR=${HOME}/.local/

cd "${VIM_ROOT}" || exit

git fetch --prune origin
git rebase origin/master

cd src/ || exit

# make distclean |
#   tee vim_make_distclean.log

./configure \
  --enable-cscope \
  --enable-fail-if-missing \
  --enable-luainterp=yes \
  --prefix="${INSTALL_DIR}" \
  tee vim_configure.log

make |
  tee vim_make.log

make install prefix="${INSTALL_DIR}" |
  tee vim_make_install.log

cd "${CURRENT_DIR}" || exit

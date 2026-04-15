#!/bin/sh

# 1. 絶対パスでNeovimのディレクトリを指定
NVIM_DIR="${HOME}/work/github.com/neovim/neovim"

# ディレクトリが存在するかチェック
if [ ! -d "$NVIM_DIR" ]; then
  echo "Directory $NVIM_DIR does not exist."
  exit 1
fi

cd "$NVIM_DIR" || exit

# 2. 更新処理
git fetch --prune origin
git rebase origin/master

# 3. クリーンアップ（確実に消去）
make distclean
rm -rf .deps build

# 4. ビルド
# BUNDLED_CMAKE_FLAG は CMAKE_EXTRA_FLAGS 内で渡すのが一般的です
make CMAKE_BUILD_TYPE=Release \
  CMAKE_INSTALL_PREFIX="$HOME/.local" \
  CMAKE_EXTRA_FLAGS="-DUSE_BUNDLED_TS_PARSERS=OFF"

# 5. インストール
make install

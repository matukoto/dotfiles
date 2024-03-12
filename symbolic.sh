#!bin/bash

# git
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/.gitignore_global ~/.gitignore_global
# jj
ln -s ~/dotfiles/config/jj/config.toml ~/.config/jj/config.toml

# shell
ln -s ~/dotfiles/.bashrc ~/.bashrc
# ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.profile ~/.profile
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases

# vim
mkdir -p ~/.config/nvim/lua
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/init.lua ~/.config/nvim/lua/init.lua
ln -s ~/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim/after
ln -s ~/dotfiles/config/nvim/after/ftplugin.vim ~/.config/nvim/after/ftplugin.vim
ln -s ~/dotfiles/config/nvim/after/ftplugin/ ~/.config/nvim/after/
ln -s ~/dotfiles/vim/coc/coc-settings.json ~/.config/nvim/coc-settings.json
mkdir -p ~/.config/nvim/plugin
ln -s ~/dotfiles/vim/gin-preview.vim ~/.config/nvim/plugin/gin-preview.vim
mkdir -p ~/.vim/dadbod-ui
ln -s ~/dotfiles/vim/dadbod-ui/connections.json ~/.vim/dadbod-ui/connections.json
mkdir -p ~/.config/sqls
ln -s ~/dotfiles/config/sqls/config.yaml ~/.config/sqls/config.yaml

# skk
mkdir ~/.skk
ln -s ~/dotfiles/.skk/SKK-JISYO.L ~/.skk/SKK-JISYO.L
ln -s ~/dotfiles/.skk/SKK-JISYO.jinmei ~/.skk/SKK-JISYO.jinmei
ln -s ~/dotfiles/.skk/SKK-JISYO.geo ~/.skk/SKK-JISYO.geo
ln -s ~/dotfiles/.skk/SKK-JISYO.propernoun ~/.skk/SKK-JISYO.propernoun
ln -s ~/dotfiles/.skk/SKK-JISYO.emoji.utf8 ~/.skk/SKK-JISYO.emoji.utf8

# textlint
# ln -s ~/dotfiles/.textlintrc ~/.textlintrc
# ln -s ~/dotfiles/config/efm-langserver/config.yaml ~/.config/efm-langserver/config.yaml

# yazi
mkdir -p ~/.config/yazi
ln -s ~/dotfiles/config/yazi/theme.toml ~/.config/yazi/theme.toml
ln -s ~/dotfiles/config/yazi/yazi.toml ~/.config/yazi/yazi.toml
## starship

ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml
# gitui
ln -s ~/dotfiles/config/gitui/key_bindings.ron ~/.config/gitui/key_bindings.ron
# wezterm
ln -s ~/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/wezterm/keybinds.lua ~/.config/wezterm/keybinds.lua
# unlink
unlink ~/.gitconfig
unlink ~/.gitinore_global
unlink ~/.config/jj/config.toml
unlink ~/.bashrc
unlink ~/.bash_aliases
unlink ~/.profile
unlink ~/.vimrc
unlink ~/.config/nvim/init.vim
unlink ~/.config/nvim/lua/init.lua
unlink ~/.config/nvim/init.lua
unlink ~/.config/nvim/after/ftplugin.vim
unlink ~/.config/nvim/after/ftplugin/
unlink ~/.config/nvim/coc-settings.json

unlink ~/.skk/SKK-JISYO.L
unlink ~/.skk/SKK-JISYO.jinmei
unlink ~/.skk/SKK-JISYO.geo
unlink ~/.skk/SKK-JISYO.propernoun
unlink ~/.skk/SKK-JISYO.emoji.utf8

unlink ~/.config/nvim/plugin/gin-preview.vim
unlink ~/.vim/dadbod-ui/connections.json
unlink ~/.config/sqls/config.yaml
unlink ~/.config/yazi/yazi.toml
unlink ~/.config/yazi/theme.toml
unlink ~/.config/starship.toml
unlink ~/.config/gitui/key_bindings.ron
unlink ~/.wezterm.lua
unlink ~/.config/wezterm/keybinds.lua

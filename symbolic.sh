#!bin/bash

# git
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

# shell
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.profile ~/.profile
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases

# vim
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/config/nvim/after/ftplugin.vim ~/.config/nvim/after/ftplugin.vim
ln -s ~/dotfiles/config/nvim/after/ftplugin/ ~/.config/nvim/after/
ln -s ~/dotfiles/vim/coc/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/dotfiles/vim/gin-preview.vim ~/.config/nvim/plugin/gin-preview.vim

# textlint
ln -s ~/dotfiles/.textlintrc ~/.textlintrc
ln -s ~/dotfiles/config/efm-langserver/config.yaml ~/.config/efm-langserver/config.yaml

# yazi
ln -s ~/dotfiles/config/yazi ~/.config/

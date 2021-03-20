#!/bin/bash

set -e
dotfiles_dir="$HOME/.dotfiles"

# check dotfiles directory
if [[ ! -d $dotfiles_dir ]]; then
  echo "$dotfiles_dir does NOT exists !!!"
  exit 1;
fi

# copy vimrc file
if [[ -f "$HOME/.vimrc" ]]; then
  rm "$HOME/.vimrc" -f
fi
ln -fs "$dotfiles_dir/vim/.vimrc" "$HOME/.vimrc"

# Install plugins
if [[ -d "$HOME/.vim/bundle" ]]; then
  rm -rf "$HOME/.vim"
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

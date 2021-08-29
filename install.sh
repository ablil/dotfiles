#!/bin/bash

cwd=$(pwd)

dotfiles=(
  .aliases
  .exports
  .functions
  .gitconfig
  .gitignore
  .vimrc
  .zshrc
  .tmux.conf
)


for dotfile in "${dotfiles[@]}"; do
	ln -s -f "$cwd/$dotfile" "$HOME/$dotfile"
done

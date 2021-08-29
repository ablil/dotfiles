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

if [[ -d "$HOME/.config/Code/User" ]]; then
  rm -rf "$HOME/.config/Code/User" 
fi
ln -s -f "$cwd/Code/User" "$HOME/.config/Code/"

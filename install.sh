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

scripts=(
  ./scripts/bumpversion.sh
)

# Dotfiles
for dotfile in "${dotfiles[@]}"; do
	ln -s -f "$cwd/$dotfile" "$HOME/$dotfile"
done

# scripts : custom command
for script in "${scripts[@]}"; do
  naked=$(basename -s .sh "$script")
  ln -s -f "$cwd/$script" "$HOME/.local/bin/$naked"
  chmod +x "$HOME/.local/bin/$naked"
done

# vscode
if [[ -d "$HOME/.config/Code/User" ]]; then
  rm -rf "$HOME/.config/Code/User" 
fi
ln -s -f "$cwd/Code/User" "$HOME/.config/Code/"

# git
git config --global commit.template "$PWD/.gitmsg"

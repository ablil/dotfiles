#!/bin/bash

set -e
dotfiles="$HOME/.dotfiles/"

if [[ ! -d $dotfiles ]];then
  echo "$dotfiles does NOT exists"
  exit 1;
fi

# install oh-my-zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# configure zsh
ln -sf $dotfiles/zsh/.zsh_functions $HOME
ln -sf $dotfiles/zsh/.aliases $HOME
ln -sf $dotfiles/zsh/.zshrc $HOME

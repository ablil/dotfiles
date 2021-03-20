#!/bin/bash

set -e
dotfiles="$HOME/.dotfiles"

if [[ ! -d $dotfiles ]]; then
  echo "$dotfiles does NOT exists"
  exit 1
fi

ln -sf $dotfiles/git/.git* $HOME

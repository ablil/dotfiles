#!/bin/bash

[[ -z $1 ]] && {
  echo "Usage: bash $0 $HOME/.config/JetBrains/IntellijXXXX"
  exit 1;
}
[[ -z $DOTFILES ]] && {
  echo "DOTFILES variable is missing!"
  exit 2;
}

ln -sf -t $1 $DOTFILES/IntellijIdea/codestyles
ln -sf -t $1/options $DOTFILES/IntellijIdea/options/*.xml
ln -sf -t $1 $DOTFILES/IntellijIdea/templates

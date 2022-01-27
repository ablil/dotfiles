#!/bin/bash

[[ -z $DOTFILES ]] && echo "Variable \$DOTFILES is not set && exit 1"
[[ -z $1 ]] && echo "bash $0 /home/<user>/.config/JetBrains/InelljiXXX/" && exit 1
ln -sf "$DOTFILES/IntellijIdea/templates" "$1/templates"
ln -sf "$DOTFILES/IntellijIdea/.ideavimrc" "$HOME/.ideavimrc"

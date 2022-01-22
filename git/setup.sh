#!/bin/bash

[[ -z $DOTFILES ]] && echo "variable \$DOTFILES is not set" && exit 1

ln -sf "$DOTFILES/git/.gitmsg" "$HOME/.gitmsg";
ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig";

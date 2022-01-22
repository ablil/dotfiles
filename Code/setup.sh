#!/bin/bash

[[ -z $DOTFILES ]] && echo "Variable \$DOTFILES is not set" && exit 1

ln -sf $DOTFILES/Code/* $HOME/.config/Code/

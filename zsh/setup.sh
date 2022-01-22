#!/bin/bash

[[ -z $DOTFILES ]] && echo "variable \$DOTFILES is not set" && exit 1

ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.exports" "$HOME/.exports"
ln -sf "$DOTFILES/zsh/.aliases" "$HOME/.aliases"
ln -sf "$DOTFILES/zsh/.functions" "$HOME/.functions"
ln -sf "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"

# private env variables
touch "$HOME/.exports_private"

#!/bin/bash

declare -a extensions
extensions=(
  bradlc.vscode-tailwindcss
  csstools.postcss
  dbaeumer.vscode-eslint
  dsznajder.es7-react-js-snippets
  esbenp.prettier-vscode
  formulahendry.auto-rename-tag
  Gruntfuggly.todo-tree
  ms-python.python
  teabyii.ayu
  tomphilbin.gruvbox-themes
  vscode-icons-team.vscode-icons
  vscodevim.vim
)

[[ -z $DOTFILES ]] && echo "Variable \$DOTFILES is not set" && exit 1
ln -sf "$DOTFILES/Code/*" "$HOME/.config/Code/"

for extension in "${extensions[@]}"; do
  code --install-extension "$extension"
done

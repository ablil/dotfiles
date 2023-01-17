#!/bin/bash


if [[ -z $DOTFILES ]]; then
  echo "env variable $DOTFILES is missing!"
  exit 1;
elif [[ ! -d $HOME/.config/Code ]]; then
  echo "$HOME/.config/Code is missing, make sure vscode is installed!"
  exit 2;
else
  # link config folder
  ln -sf "$DOTFILES/Code/*" "$HOME/.config/Code/"

  # install extensions
  grep -v '^ *#' < extensions.txt | while IFS= read -r line
  do
    code --force --install-extension "$line"
  done

  echo "Done"
fi

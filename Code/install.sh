#!/bin/bash


if [[ -z $DOTFILES ]]; then
  echo "env variable $DOTFILES is missing!"
  exit 1;
elif [[ ! -d $HOME/.config/Code ]]; then
  echo "$HOME/.config/Code is missing, make sure vscode is installed!"
  exit 2;
else
# install vscode
  sudo apt-get install wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update && sudo apt install -y code
  code && pkill code # open and close immediately, so config folder is created

  # link config
  ln -sf -t $HOME/.config/Code/User $DOTFILES/Code/User/*.json
  ln -sf -t $HOME/.config/Code/User/snippets $DOTFILES/Code/User/snippets*.json

  # install extensions
  grep -v '^ *#' < $DOTFILES/Code/extensions.txt | while IFS= read -r line
  do
    code --force --install-extension "$line"
  done

  echo "Done"
fi

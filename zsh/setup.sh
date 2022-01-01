#!/bin/bash

if [[ $(grep -E -q -i 'fedora|redhat' /etc/*release) -eq 0 ]]; then
  sudo dnf install -y curl util-linux-user zsh
elif [[ $(grep -E -q -i 'debian|bunut|mint' /etc/*release) -eq 0 ]]; then
  sudo apt-get install -y curl zsh
else
  echo "It seems you are not running REHL or Debian based distro !!!"
  exit 1;
fi

# set zsh
#chsh -s "$(command -v zsh)"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# link dotfiles
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.exports" "$HOME/.exports"
ln -sf "$DOTFILES/zsh/.aliases" "$HOME/.aliases"
ln -sf "$DOTFILES/zsh/.functions" "$HOME/.functions"

# private env variables
touch "$HOME/.exports_private"

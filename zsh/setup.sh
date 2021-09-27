#!/bin/bash

cwd=$(dirname $0)
cd $cwd

if [[ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]]; then
  sudo dnf install -y curl util-linux-user zsh
elif [[ "$(grep -Ei 'debian|bunut|mint' /etc/*release)" ]]; then
  sudo apt-get install - y curl zsh
else
  echo "It seems you are not running REHL or Debian based distro !!!"
  exit 1;
fi

# set zsh
#chsh -s "$(command -v zsh)"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# link dotfiles
ln -sf $PWD/.zshrc $HOME/.zshrc 
ln -sf $PWD/.exports $HOME/.exports 
ln -sf $PWD/.aliases $HOME/.aliases 
ln -sf $PWD/.functions $HOME/.functions 

# private env variables
touch $HOME/.exports_private

cd -

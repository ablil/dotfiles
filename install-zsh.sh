#!/bin/bash

# Install zsh
sudo apt-get install -y curl
sudo apt-get install -y zsh
chsh -s "$(command -v zsh)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

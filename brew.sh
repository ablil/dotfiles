#!/usr/bin/env zsh

# update and upgrade existing tools
brew update
brew upgrade


# install some tools
brew install coreutils findutils gnu-sed rename ssh-copy-id tree
brew install git git-lfs gh
brew install fd fzf tree tmux vim direnv httpie k6 jq yt-dlp yq
brew install openjdk@25 openjdk@21 gradle maven
brew install pyenv pyenv-virtualenv nvm jenv pipx
brew install --cask docker


# remove outdated version
brew cleanup

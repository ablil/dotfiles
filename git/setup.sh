#!/bin/bash

if command -v dnf &> /dev/null; then
  sudo dnf install -y git
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install -y gh
elif command -v apt-get &> /dev/null; then
  sudo apt-get install -y curl
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y gh
else
  echo "It seems you are not running REHL or Debian based distro !!!"
  exit 1;
fi

# link dotfiles
ln -sf "$DOTFILES/git/.gitmsg" "$HOME/.gitmsg";
ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig";

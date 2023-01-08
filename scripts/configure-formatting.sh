#!/bin/bash
# Configure prettier, husky and lint-staged on the current directory


if [[ -z "$DOTFILES" ]]; then
  echo "DOTFILES env variable is missing"
  exit 1
fi

echo "Are you sure you want to configure on the current working directory $(pwd) [y/N] "
read -r choice

if [[ $choice == 'y' ]]; then
  # configure prettier
  yarn add -D prettier
  cp "$DOTFILES/.prettierrc" .
  cp "$DOTFILES/.prettierignore" .

  # configure lint-staged
  yarn add -D lint-staged
  cp "$DOTFILES/.lintstagedrc" .

  # configure husky
  yarn add -D husky
  npm pkg set scripts.prepare="husky install"
  npm pkg set scripts.postinstall="husky install"
  yarn prepare
  yarn husky add .husky/pre-commit "yarn lint-staged"

  echo "Dont forget to run: git add .husky/pre-commit"
else
  echo "Not OK"
fi

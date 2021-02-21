#!/bin/bash

DOTFILES_DIRECTORY="$HOME/.dotfiles/intellij-idea"

if [[ $# -eq 0 ]]; then
  INTELLIJ_IDEA_DIRECTORY="$HOME/.config/JetBrains/IntelliJIdea2020.2"
else 
  INTELLIJ_IDEA_DIRECTORY="$1"
fi


function usage() {
  echo ""
  echo "usage:"
  echo "bash $0 ~/.config/JetBrains/IntellijIdea2020.2"
  exit 1;
}

function check_arguments() {
  if [[ ! -d "$INTELLIJ_IDEA_DIRECTORY" ]]; then
    echo "$INTELLIJ_IDEA_DIRECTORY does NOT exists"
    usage
  fi

  if [[ ! -d "$DOTFILES_DIRECTORY" ]]; then
    echo "$DOTFILES_DIRECTORY does NOT exists"
    exit 1;
  fi
}

function setup() {
  if [[ -d "" ]]; then
    rm -rf "$INTELLIJ_IDEA_DIRECTORY/templates"
  fi

  ln -s "$DOTFILES_DIRECTORY/templates" "$INTELLIJ_IDEA_DIRECTORY/templates"
}

check_arguments
setup

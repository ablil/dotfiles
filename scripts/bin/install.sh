#!/bin/bash
# custom commands

if [[ -z "$DOTFILES" ]]; then
  echo "env variable DOTFILES is missing!"
  exit 1
else
  ln -sf -t $HOME/.local/bin/ "$DOTFILES"/scripts/bin/*
  echo "Done"
fi

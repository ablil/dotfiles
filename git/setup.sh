#!/bin/bash

set -e

ln -sf $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig

# setup git repository template
mkdir -p $HOME/.git-templates/hooks
ln -sf $HOME/.dotfiles/git/hooks/{commit-msg,pre-commit,pre-push} $HOME/.git-templates/hooks/


cat <<EOF
make sure to:
    * install Github cli
    * set correct user.name and user.email
EOF

#!/bin/bash

function usage() {
  echo "bash $0 /home/<user>/.config/JetBrains/InelljiXXX/"
  exit 1;
}


[[ -z $1 ]] && usage

ln -sf $PWD/templates $1/templates
ln -sf $PWD/.ideavimrc $HOME/.ideavimrc

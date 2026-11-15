#!/bin/zsh

export EDITOR='vim'
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"

typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  /opt/homebrew/bin
  /usr/local/bin
  $PYENV_ROOT/bin
  $HOME/.jenv/bin
  $PYENV_ROOT/shims
  $HOME/.jenv/shims
  $HOME/google-cloud-sdk/bin
  $path
)

if [[ -r $NVM_DIR/alias/default ]]; then
  _nvm_default=${$(<$NVM_DIR/alias/default)//[[:space:]]/}
  if [[ -d $NVM_DIR/versions/node/$_nvm_default/bin ]]; then
    path=($NVM_DIR/versions/node/$_nvm_default/bin $path)
  elif [[ -s $NVM_DIR/nvm.sh ]]; then
    . "$NVM_DIR/nvm.sh"
  fi
  unset _nvm_default
elif [[ -s $NVM_DIR/nvm.sh ]]; then
  . "$NVM_DIR/nvm.sh"
fi

export PATH

# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

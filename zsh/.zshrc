#!/bin/zsh

[[ -o interactive ]] || return 0

setopt extended_glob auto_cd interactive_comments no_beep
setopt hist_ignore_space hist_ignore_dups share_history

typeset -U path
path=($path)

# zsh
ZSH_THEME="less-noise"
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder

# must be set before zsh-vi-mode initialises
ZVM_SYSTEM_CLIPBOARD_ENABLED=true

plugins=(
  git
  gitignore
  docker
  one-character
  zsh-autosuggestions
  colored-man-pages
  terraform
  direnv
  zsh-vi-mode
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

KEYTIMEOUT=1

zstyle ':completion:*' menu select
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
[[ -d $_cache_dir ]] || command mkdir -p $_cache_dir
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $_cache_dir
unset _cache_dir

# version managers: shims stay on PATH, init runs on first use only
function nvm() {
  unset -f nvm
  . "$NVM_DIR/nvm.sh"
  [[ -s $NVM_DIR/bash_completion ]] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}

function pyenv() {
  unset -f pyenv
  eval "$(command pyenv init - --no-rehash)"
  pyenv "$@"
}

function jenv() {
  unset -f jenv
  eval "$(command jenv init -)"
  jenv "$@"
}

# gcloud completion is expensive, register it on first use
function gcloud() {
  unset -f gcloud
  if (( ! $+commands[gcloud] )); then
    [[ -f $HOME/google-cloud-sdk/path.zsh.inc ]] && . "$HOME/google-cloud-sdk/path.zsh.inc"
    path=(${(u)path})
  fi
  [[ -f $HOME/google-cloud-sdk/completion.zsh.inc ]] &&
    . "$HOME/google-cloud-sdk/completion.zsh.inc"
  gcloud "$@"
}

# Load shell dotfiles
for file in $HOME/.{exports,functions,aliases}; do
    [ -f "$file" ] && source "$file"
done
unset file

# fzf, cached to avoid forking on every shell
if (( $+commands[fzf] )); then
  _fzf_cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/fzf.zsh
  if [[ ! -s $_fzf_cache || $commands[fzf] -nt $_fzf_cache ]]; then
    [[ -d ${_fzf_cache:h} ]] || command mkdir -p ${_fzf_cache:h}
    fzf --zsh >| $_fzf_cache
  fi
  source $_fzf_cache
  unset _fzf_cache
fi

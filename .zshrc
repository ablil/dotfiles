#!/bin/zsh
ZSH_THEME="less-noise"

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' frequency 13 # auto update zsh every 13 days

plugins=(git gitignore docker one-character zsh-autosuggestions zsh-syntax-highlighting colored-man-pages)

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Load shell dotfiles
for file in $HOME/.{exports,functions,aliases}; do
    [ -f "$file" ] && source "$file"
done
unset file

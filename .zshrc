#!/bin/zsh

# zsh
ZSH_THEME="less-noise"
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' frequency 13 # auto update zsh every 13 days
plugins=(git gitignore docker one-character zsh-autosuggestions zsh-syntax-highlighting colored-man-pages)

source $ZSH/oh-my-zsh.sh

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

source <(fzf --zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOM/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

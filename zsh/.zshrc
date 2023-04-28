export TERM=xterm-256color
export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=15

ZSH_THEME="agnoster"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.exports ]] && source ~/.exports
[[ -f ~/.exports_private ]] && source ~/.exports_private
[[ -f ~/.exports_hybris ]] && source ~/.exports_hybris
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases_private ]] && source ~/.aliases_private
[[ -f ~/.aliases_hybris ]] && source ~/.aliases_hybris
[[ -f ~/.functions ]] && source ~/.functions
[[ -f ~/.functions_private ]] && source ~/.functions_private
fpath=($fpath "/home/ablil/.zfunctions")

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.ebcli-virtual-env/executables:$PATH"

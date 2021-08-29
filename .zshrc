export TERM=xterm-256color
export LANG=en_US.UTF-8
export ZSH="/home/$USER/.oh-my-zsh"
export UPDATE_ZSH_DAYS=15

ZSH_THEME=cloud
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git gitignore docker-compose)

source $ZSH/oh-my-zsh.sh
[[ -f ~/.exports ]] && source ~/.exports
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.functions ]] && source ~/.functions

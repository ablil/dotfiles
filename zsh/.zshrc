export TERM=xterm-256color
export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=15

ZSH_THEME=ys
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.exports ]] && source ~/.exports
[[ -f ~/.exports_private ]] && source ~/.exports_private
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -pf ~/.aliases_private ]] && source ~/.aliases_private
[[ -f ~/.functions ]] && source ~/.functions

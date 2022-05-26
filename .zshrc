export TERM=xterm-256color
export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=15

ZSH_THEME=ablil
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
[[ -f ~/.functions_hybris ]] && source ~/.functions_hybris
fpath=($fpath "/home/ablil/.zfunctions")

# Set typewritten ZSH as a prompt
autoload -U promptinit; promptinit
prompt typewritten

export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM=xterm-256color
export LANG=en_US.UTF-8
export ZSH="/home/$USER/.oh-my-zsh"
export UPDATE_ZSH_DAYS=15

ZSH_THEME="minimal"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git gitignore)

source $ZSH/oh-my-zsh.sh
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions
[[ -f ~/.zsh_private ]] && source ~/.zsh_private

[[ -f /usr/bin/most ]] && alias man='man --pager=most'

# You may need to manually set your language environment
export PATH="$PATH:/var/lib/snapd/snap/bin"

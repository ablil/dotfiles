# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ablil"

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitignore docker docker-compose one-character)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_functions

# User configuration

export EDITOR='vim'
export JAVA_HOME="$(readlink -f $(which java) | sed 's/\/bin\/java//')"


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias doc="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias l="ls -l -a"
alias la="ls -a"
alias ll="ls -l"
alias dc=docker-compose
alias dps="docker ps"
alias dpsa="docker ps -a"
alias gclnf="git clean -fd"
alias gclnb="git branch -l | grep -vE 'master|main|dev|develop' | xargs git branch -D"
alias rmr="rm -r"
alias o=xdg-open
alias yt=yt-dlp
alias igrep='grep -i'
alias esed'sed -E'
alias clip="xclip -selection clipboard"

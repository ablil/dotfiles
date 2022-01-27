# Simple theme based on my old zsh settings.

function get_host {
	echo '@'$HOST
}

function get_status() {
  if [[ $? != 0 ]]; then
    echo '?'
  fi
}

PROMPT='$(get_status)> '
RPROMPT='%2c%{$fg[green]%}$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""

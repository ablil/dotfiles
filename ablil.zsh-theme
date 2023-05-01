#!/bin/zsh
export TERM=xterm-256color

NEWLINE=$'\n'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[orange]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[orange]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[orange]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[orange]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[orange]%} ✱"

return_status="%(?.✔.%{$fg[red]%}✘%f)"

PS1='%F{166}%~ %F{106}$(git_current_branch)$(git_prompt_status) %{$reset_color%} ${NEWLINE}${return_status} '

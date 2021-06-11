get_folder()() {
  echo "%{$FG[161]%}%~%{$reset_color%}"
}

get_hostname() {
  COMPUTER_EMOJI="\U1F5A5"
  echo "%{$FG[098]%}%m%{$reset_color%}"
}

get_user() {
  COWBOY_EMOJI="\U1F920"
  echo "%{$FG[099]%}%n%{$reset_color%}"
}

return_status() {
   CROSS_EMOJI="%{$fg[red]%}✘%f"
   echo "%(?..$CROSS_EMOJI)"
}


PROMPT="$(return_status) $(get_user) at $(get_hostname) inside $(get_folder) "

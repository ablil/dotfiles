#!/bin/bash
# Configure zsh

if [[ -z $DOTFILES ]]; then
  echo "env variable DOTFILES is missing!"
  exit 1;
fi

# Install oh-myzsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  chsh -s /bin/zsh "$USER"
fi

# Zsh
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.exports" "$HOME/.exports"
ln -sf "$DOTFILES/zsh/.aliases" "$HOME/.aliases"
ln -sf "$DOTFILES/zsh/.functions" "$HOME/.functions"
ln -sf "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"

# create private dotfiles
touch "$HOME/.exports_private"
touch "$HOME/.aliases_private"

# set zsh theme
[[ ! -d "$HOME/.oh-my-zsh/themes" ]] && mkdir "$HOME/.oh-my-zsh/themes/" -p 
ln -sf "$DOTFILES/zsh/ablil.zsh-theme" "$HOME/.oh-my-zsh/themes/ablil.zsh-theme"

# Vim
ln -sf "$DOTFILES/.vimrc" "$HOME/.vimrc"
[[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Tmux
ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

# Git
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
[[ ! -f "$HOME/.ssh/config" ]] && mkdir "$HOME/.ssh" && touch "$HOME/.ssh/config"
cat >> "$HOME/.ssh/config" << EOF
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_github
EOF
echo "Make sure you generate ssh key ~/.ssh/id_github for git config"


echo "Done"

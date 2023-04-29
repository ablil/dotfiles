#!/bin/zsh

if [[ -z $DOTFILES ]]; then
	echo "DOTFILES env var is missing !"
	exit 1
fi

ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.zsh_functions $HOME/.zsh_functions
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -sf $DOTFILES/.vimrc $HOME/.vimrc

ln -sf $DOTFILES/ablil.zsh-theme $HOME/.oh-my-zsh/custom/themes/ablil.zsh-theme

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/one-character ]]; then
	git clone https://github.com/ablil/one-character.git $HOME/.oh-my-zsh/custom/plugins/one-character
fi

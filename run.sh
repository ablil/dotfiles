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

# install custom zsh plugins
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/one-character ]]; then
	git clone https://github.com/ablil/one-character.git $HOME/.oh-my-zsh/custom/plugins/one-character
fi

# Install Vundle (vim plugin manager)
if [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# setup custom shell commands
find $DOTFILES/scripts/bin/ -type f -executable -exec ln -sf {} $HOME/.local/bin/ \;

# add custom zsh plugins/themes
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/ablil/one-character ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/one-character

git clone https://github.com/ablil/ablil-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/ablil

# change default shell
chsh -s $(which zsh)

# install custom zsh theme
curl https://raw.githubusercontent.com/ablil/less-noise/main/less-noise.zsh-theme -o $HOME/.oh-my-zsh/custom/themes/less-noise.z
sh-theme

# DONT FORGET TO
echo "Do NOT forget to:"
echo "pip3 install -r $DOTFILES/scripts/bin/requirements.txt"

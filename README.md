
# dotfiles -- The developer's quick setup

A collections of dotfiles to speed up setting up a new environment and description of my environment setup.
All the files are centralized in one place, which make it easy to keep track of changes with git :wink:.

**How to use**

1. Clone the repo and set **\$DOTFILES** environment variable

```
git clone https://github.com/ablil/dotfiles $HOME/dotfiles && export DOTFILES=$HOME/dotfiles
```
2. Run the script **install.sh** to configure basic dotfiles which includes:
* zsh & oh-my-zsh
* vim
* tmux
* git 

**Make sure before you do anything, the environment variable `$DOTFILES` is set, and run the following command**

```
#Fedora
sudo dnf install vim git curl wget vlc tmux
# Ubuntu
sudo dnf install vim git curl wget vlc tmux
```

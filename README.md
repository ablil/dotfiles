
# dotfiles -- The developer's quick setup

A collections of dotfiles to speed up setting up a new environment and description of my environment setup.
All the files are centralized in one place, which make it easy to keep track of changes with git :wink:.

**How to use**
Clone the repo and set \$DOTFILES environment variable
`git clone https://github.com/ablil/dotfiles $HOME/dotfiles && export DOTFILES=$HOME/dotfiles`

Make sure before you do anything, the environment variable `$DOTFILES` is set.

# Linux config
Install basic linux packages.

```
# Fedora
sudo dnf install git vlc curl wget zsh vim tmux
# Ubuntu
sudo apt install git vlc curl wget zsh vim tmux
```

# Configure zsh
1. Change shell to zsh: `chsh -s /bin/zsh $USER` then logout and login again
2. Install **ohmyzsh**`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
3. Run **zsh/setup.sh** to link dotfiles.

# Configure git
1. Install **gh** cli from [official website](https://cli.github.com/), and authenticate with `gh auth login`
2. Run `git/setup.sh` to link .gitconfig
3. Configure ssh key in ~/.ssh/config
```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_github
```

# Configure vim
1. Link **.vimrc** to your home: `ln -sf $DOTFILES/.vimrc $HOME/.vimrc`
2. Install **Vundle** (vim package manager) from [offical website](https://github.com/VundleVim/Vundle.vim)
3. Install plugins: `vim +PluginInstall +qall`


# Development tools
## Java
1. Setup java
```
# Fedora
sudo dnf install java-11-openjdk-devel ant maven
# Ubuntu
sudo apt install default-jdk ant maven groovy
```
2. Set default version of java `sudo update-alternative --config java`

## Python
1. Install python package manager ```sudo dnf install python3-pip```
2. Install some python packages:  ` pip3 install setuptools wheel twine howdoi requests `

## Nodejs
1. Install nodejs ```sudo dnf install nodejs npm```
2. Install yarn `sudo npm install -g yarn`


## Docker
1. Install **docker** from [ official website ]( https://docs.docker.com/engine/install/ )
2. Install docker-compose `sudo dnf instal docker-compose`
3. Enable docker daemon at startup `systemctl enable docker && systemctl start docker`
4. Pull some most used images **mysql**, **postgres**, **python**, **redis**, **alpine**
5. Add user to docker group `sudo usermod -aG docker $USER`


## Intellij Idea
1. Install from [ official website ]( https://www.jetbrains.com/toolbox-app/ )
2. Run **IntellijIdea/setup.sh**
3. Install extensions: **GitToolBox**, **IdeaVim**, **Gruvbox Theme**, **KeyPromoter X,** **Lombok**

## Vscode
1. Install from [official website](https://code.visualstudio.com)
2. Run **Code/setup.sh** 
3. Install required extensions from file **Code/extensions.txt**

## othes
List of other tools you may consider installing and configuring:
* [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [Insominia](https://insomnia.rest/) or [Postman](https://www.postman.com/)


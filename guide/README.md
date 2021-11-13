# Guide to new installation


## Basic installation
basic packages to install on new linux box with a package manager:
* curl
* wget
* nmap
* git
* vim
* tmux
* zsh
* docker and docker-compose
* gimp

basic packages to install on new linux box manually:
* firefix
  * import saved logins and bookmark
* chrome
  * import saved logins and bookmark

## Basic configuration

* configure ssh: hosts and keys
* configure zhs: check `zsh` directory in this repo
* configure git: check `git` directory in this repo
* configure tmux: link `.tmux.conf` to `$HOME`
* configure vim: install vim and link `.vimrc`

## IDE

* install vscode
  * link config files from `dotfiles`
  * install extension (to be backedup manually)
* install intellij idea
  * vim
  * lombok
  * KeyPromoterX
  * MapStruct

## Java development

* java 11: `dnf install -y java`
* java 8 : `dnf install -y java`
* set default java :`update-alternatives --config java`
* Ant & Maven: `dnf install -y ant maven`

## Python Development

* PyPi: `pip3 install setuptools wheel twine --user`
* black: `pip3 install black --user`

## Nodejs Developement

* nodejs: `dnf install -y nodejs`
* package managers: `dnf install -y npm yarnpkg`
* set npm global directory: 
  ```
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  export PATH=~/.npm-global/bin:$PATH
  ```

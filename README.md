# Dotfiles
My collection of dotfiles, config, snippets ...

**Benefits**:
* Everything in one place and tracked by Git
* speed up config process on new machine

# Getting started

## Prerequisites

Some necessary packages to install:

```sh
# Ubuntu
$ sudo apt install -y vim git curl wget vlc tmux
# Fedora
$ sudo dnf install -y vim git curl wget vlc tmux
```

Before running any script, make sure the env variable **$DOTFILES** is set to the repo directory.
```sh
$ git clone git@github.com:ablil/dotfiles $HOME/dotfiles && export DOTFILES=$HOME/dotfiles
```
## Usage

This repo contains two type of files: 

install scrips (install.sh) which you can run to configure everything for you (eg, vscode settings and snippets ...)

or 

snippets/config file you can link symbolically whenever you need (eg, .prettierrc, .lintsagedrc ..)


# Manual configs

## Terminal color scheme

| Item             | Value        |
| ---------------- | ------------ |
| Background color | 1E1E1E       |
| Text color       | D3D7CF       |
| Font             | Monospace 12 |

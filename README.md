# Dotfiles
My collection of dotfiles, config, snippets ...

## Get started

1. Install some pre-requesites:

```shell
# Debian based
sudo apt install --yes zsh curl git vim tmux pip
```

2. Clone repo

`git clone https://github.com/ablil/dotfiles $HOME/.dotfiles`


3. run dotbot
```shell
pip install dotbot
cd $HOME/.dotfiles
dotbot -c install.conf.yaml
```

4. run install.sh for some extra setup

## Manualy setup
   
### Java dev environment
1. Install Java
2. Setup [jenv](https://github.com/jenv/jenv)
3. Install and setup intellij idea
4. link dotfiles (.ideavim, live templates files ...)

### Python dev environment
1. Install Python
2. Setup [pyenv](https://github.com/pyenv/pyenv)

### Node dev environment
1. Install node,npm and yarn
2. Setup [nvm](https://github.com/nvm-sh/nvm)

## Terminal

Terminal color scheme

| Item             | Value        |
| ---------------- | ------------ |
| Background color | 1E1E1E       |
| Text color       | D3D7CF       |
| Font             | Monospace 12 |

## Disclaimer

These are my personal dotfiles and they may or may not work on your end so keep that in mind.

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h1 align="center">Dotfiles</h1>

  <p align="center">
    A collections of dotfiles to speed up setting up a new environment and
    description of my environment setup. All the files are centralized in one place,
    which make it easy to keep track of changes with git. 
    <br />
    <a href="https://github.com/ablil/dotfiles/issues">Report Bug</a>
    ·
    <a href="https://github.com/ablil/dotfiles/issues">Request Feature</a>
  </p>
</div>

# Getting started

This is a guide on how to setup dotfiles your local machine.

## Prerequisites

There are some necessary and basic package required for some scripts on this
repo, install them with:

**Ubuntu**:

```sh
  sudo apt install vim git curl wget vlc tmux
```

**Fedora**:

```sh
  sudo dnf install vim git curl wget vlc tmux
```

## Installation

1. Prepare your local machine and clone the projets. **clone the repo**

```sh
  git clone https://github.com/ablil/dotfiles $HOME/dotfiles
```

2. Set environment variable (_this is important because all of the scripts are
   based on this location!_):

```sh
  export DOTFILES=$HOME/dotfiles
```

# Usage

This will guide you how to setup all of these dotfiles on your machine. Most of
the thing can be configured with `install.sh` which is a simple bash script to
links dotfiles from the repo to your local machine.

Some directories may have a specific install script for them inside their
relative directory (eg, Vscode, Intellji Idea)

**Basic setup**

Run `install.sh` (root level of the directory), to link dotfiles for: zsh,
oh-my-zsh, vim, tmux & git

**Other setups**

Run install.sh script for each thing your want to configure.


# Terminal theme
|Item|Value
|----|----
|Background color|1E1E1E
|Text color| D3D7CF
|Font| Monospace 12


# License

Distributed under the MIT license, see `LICENSE.md` for more information.

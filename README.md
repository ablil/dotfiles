# dotfiles

This is a collection of my dotfiles, for quick setup on a new machine.

## Advantages for using dotfiles

* all dotfiles are grouped in one place.
* all dotfiles are tracked by git, if your screw up, you could `git restore`
* all dotfiles are independant of the host machine.
* one quick command and you could setup all your dotfiles

## Description

Each directory contains dotfiles for a specific use case.
For example `zsh` contains dotfiles related to zsh and a `setup.sh` script to setup the environment.

If you run `setup.sh`, it will configure what is required to be configured, then it will link the
dotfiles symbolically to their appropriate location.

For instance, $HOME/.dotfiles/zsh/.zshrc will be linked to $HOME/.zshrc

## Usage

1. Clone the repo to `~/.dotfiles`
command: ```git clone https://github.com/ablil/dotfiles ~/.dotfiles```

2. Call **setup.sh** script to setup your environement
command: ```bash $HOME/.dotfiles/zsh/setup.sh```

3. Re-open your terminal to see the changes

### References
[youtube video](https://www.youtube.com/watch?v=r_MpUP6aKiQ)
[inspiration](https://dotfiles.github.io/)


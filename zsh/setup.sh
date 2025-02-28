#!/bin/env bash

ln -sf $HOME/.dotfiles/zsh/.{aliases,functions,zprofile,zshrc} $HOME/

echo do NOT forget to run: source $HOME/.zshrc

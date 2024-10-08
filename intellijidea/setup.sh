#!/bin/bash

script_path=$(realpath $0)
script_dir=$(dirname $script_path)

ln -sf $script_dir/.ideavimrc $HOME/.ideavimrc 

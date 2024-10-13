#!/bin/bash

script_path=$(realpath $0)
script_dir=$(dirname $script_path)

mkdir -p ~/.git-templates/hooks
ln -sf $(find $script_dir -type f -exec realpath {} \; | xargs) ~/.git-templates/hooks/ 



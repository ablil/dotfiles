#!/bin/bash

script_path=$(realpath $0)
script_dir=$(dirname $script_path)

mkdir -p ~/.git-templates/hooks
ln -sf -t ~/.git-templates/hooks/ $(find $script_dir -type f -executable -exec realpath {} \; | xargs)

#!/bin/bash

function usage() {
  echo "Usage: "
  echo -e "\tbash $0 <backup-destination>"
  echo ""
  exit 1;
}

[[ -z "$1" ]] && usage
destination=$1
if [[ ! -d $destination ]]; then
  echo "$destination NOT found !"
  exit 2;
fi

# ssh
if [[ -d $HOME/.ssh ]]; then
  ssh_backup_directory="$destination/ssh"
  [[ ! -d $ssh_backup_directory ]] && mkdir -p $ssh_backup_directory

  cp -r -u $HOME/.ssh/id_* $ssh_backup_directory
  cp -r -u $HOME/.ssh/config $ssh_backup_directory

  echo "SSH backup is done"
fi


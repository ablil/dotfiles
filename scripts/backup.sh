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

# gpg
which gpg
if [[ $? != 0 ]]; then
  gpg_backup_directory="$destination/gpg"
  [[ ! -d $gpg_backup_directory ]] && mkdir -p $gpg_backup_directory
  gpg --export --armor > $gpg_backup_directory/my-key.pub
  gpg --export-secret-keys --armor > $gpg_backup_directory/my-key
fi

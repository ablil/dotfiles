#!/bin/bash

function usage() {
  echo "Usage: "
  echo -e "\tbash $0 <backup-destination>"
  echo ""
  exit 1;
}

[[ -z "$1" ]] && usage
destination=$1
if [[ ! -d "$destination" ]]; then
  echo "$destination NOT found !"
  exit 2;
fi

# ssh
if [[ -d "$HOME/.ssh" ]]; then
  ssh_backup_directory="$destination/ssh"
  [[ ! -d "$ssh_backup_directory" ]] && mkdir -p "$ssh_backup_directory"

  cp -r -u "$HOME/.ssh/id_*" "$ssh_backup_directory"
  cp -r -u "$HOME/.ssh/config" "$ssh_backup_directory"

  echo "SSH backup is done"
fi

# gpg
which gpg
if [[ $(which code)  ]]; then
  gpg_backup_directory="$destination/gpg"
  [[ ! -d "$gpg_backup_directory" ]] && mkdir -p "$gpg_backup_directory"
  gpg --export --armor > "$gpg_backup_directory/my-key.pub"
  gpg --export-secret-keys --armor > "$gpg_backup_directory/my-key"

  echo "GPG backup is done"
fi

# vscode extension
if [[ $(which code) ]]; then
  code_backup_directory="$destination/vscode"
  [[ ! -d "$code_backup_directory" ]] && mkdir -p "$code_backup_directory"
  code --list-extensions > "$code_backup_directory/installed-extensions.txt"

  echo "vscode bakup is done"
fi

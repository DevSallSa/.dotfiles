#!/usr/bin/env bash

###################################################################
# Description  : script for uninstall my dotfiles
# Author       : DevSallSa
# Email        : devsallsa@linuxmail.org
# Date         : 2023-01-07
# Version      : 1.0.2
###################################################################

set -eo pipefail

setup () {
  if [[ -z "$DOTFILES" ]]; then
    DOTFILES="$HOME"/.dotfiles
  fi
}

restore_backup () {
  if [[ -e "$HOME"/.zshrc.pre-dotfiles ]]; then
    mv "$HOME"/.zshrc.pre-dotfiles "$HOME"/.zshrc   
  fi
}

run () {
  pushd "$DOTFILES" > /dev/null || exit
  echo "Uninstalling configs...."
  stow -D config 2> /dev/null || exit
  rm "$HOME"/.zshrc
  echo "Restoring backups"
  restore_backup
  popd > /dev/null || exit
  echo "Uninstall completed."
}

# Main 
setup
run

#!/usr/bin/env bash

###################################################################
# Description  : script for installing my dotfiles
# Author       : DevSallSa
# Email        : devsallsa@linuxmail.org
# Date         : 2023-01-05
# Version      : 1.2.0
###################################################################

cleanup () {
  local old_configs=(firejail gdb kitty logid npm nvim \
    python tmux touchegg yarn yamllint zsh .clang-format aliases \
    shellcheckrc starship.toml)

  stow -D config 2> /dev/null || exit

  mkdir -p /tmp/old-configs/config
  for config in "${old_configs[@]}"
  do
    mv "$HOME"/.config/"$config"\
      /tmp/old-configs/config 2> /dev/null
  done

  local old_files=("$HOME"/.zcompdump* "$HOME"/.zsh_* "$HOME"/.yarn)
  for file in "${old_files[@]}"
  do
    mv "$file" /tmp/old-configs 2> /dev/null
  done

  echo "cleanup complete"
}

setup () {
  if [[ -z "$DOTFILES" ]]; then
    DOTFILES="$HOME"/.dotfiles
  fi

  if [[ -z "$STOW_FOLDERS" ]]; then
    STOW_FOLDERS="$DOTFILES/config"
  fi
}

backup () {
  if [[ -e "$HOME"/.zshrc ]]; then
    mv "$HOME"/.zshrc "$HOME"/.zshrc.pre-dotfiles
  fi
}

run () {
  pushd "$DOTFILES" > /dev/null || exit
  echo "Installing configs...."
  backup
  stow config
  ln -s "$STOW_FOLDERS"/.config/zsh/.config/.zshrc "$HOME"/.zshrc
  "$DOTFILES"/config/.local/Scripts/bash/update-scripts.sh
  echo "Installation completed."
  popd > /dev/null || exit
}

# Main 
setup
cleanup
run

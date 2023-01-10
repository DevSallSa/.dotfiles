#!/usr/bin/env bash

# This script is for personal use only.
# To be able to share it, I'll need to remove all dependencies.

if [ -z "${CUSTOM_SCRIPTS_DIR:-}" ]; then
  echo -e "[ ERROR ] -> Cannot find utility script." >&2
  echo -e "[ ERROR ] -> CUSTOM_SCRIPTS_DIR was not set." >&2
  exit 1
fi

source "${CUSTOM_SCRIPTS_DIR:?}"/bash/utils/utils.sh

# TODO: error handling
prompt -i "Downloading latest version of Neovim from remote....."
curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -o /tmp/nvim.appimage
prompt -s "Download complete !"
prompt -i "Making backup of current version....."
progressbar 0.05
mv "$HOME"/Apps/nvim.appimage "$HOME"/Apps/nvim.appimage.bak
prompt -s "Backup complete !"
prompt -i "Updating Neovim....."
progressbar 0.35
mv /tmp/nvim.appimage "$HOME"/Apps/nvim.appimage
chmod +x "$HOME"/Apps/nvim.appimage
prompt -s "Updating complete, Ready to rock !"

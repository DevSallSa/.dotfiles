#!/usr/bin/env bash

# This script is for personal use only.
# To be able to share it, I'll need to remove all dependencies.
set -e

if [ -z "${CUSTOM_SCRIPTS_DIR:-}" ]; then
  echo -e "[ ERROR ] -> Cannot find utility script." >&2
  echo -e "[ ERROR ] -> CUSTOM_SCRIPTS_DIR was not set." >&2
  exit 1
fi
source "${CUSTOM_SCRIPTS_DIR:?}"/bash/utils/utils.sh

purge_package() {
  prompt -i "Purging unused deb packages..."
  sudo apt autoremove
  packages=($(aptitude search "~c" | awk '{ print $2 }'))
  for i in "${packages[@]}"
  do
    sudo apt remove -y --purge "$i"
  done
}

purge_lib() {
  prompt -i "Purging unused flatpak libraries..."
  flatpak uninstall --unused
}

if check_root; then
  prompt -i "Starting purge..."
  purge_package
  purge_lib
  prompt -s "Purge finished !"
else
  cancel_operation "Only root user can run this program."
fi

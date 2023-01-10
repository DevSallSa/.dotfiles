#!/usr/bin/env bash

# This script is for personal use only.
# To be able to share it, I'll need to remove all dependencies.

set -eo pipefail

if [ -z "${CUSTOM_SCRIPTS_DIR:-}" ]; then
  echo -e "[ ERROR ] -> Cannot find utility script." >&2
  echo -e "[ ERROR ] -> CUSTOM_SCRIPTS_DIR was not set." >&2
  exit 1
fi

source "${CUSTOM_SCRIPTS_DIR:?}"/bash/utils/utils.sh

function check_error(){
	error_code=$?
	if [ ! "$error_code" = 0 ]
	then
		prompt -e "An error occurred: $1"
		exit "$error_code"
	fi
}

if check_root; then
  prompt -i "Updating packages....."
  sudo apt update
  check_error "update"
  sudo apt full-upgrade
  check_error "full-upgrade"
  prompt -i "Updating flatpak apps....."
  prompt -w "You should update them using your appcenter."
  flatpak update
  prompt -s "Update complete. Ready to go!"
else
  cancel_operation "Only root user can run this program."
fi

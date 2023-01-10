#!/usr/bin/env bash

source "${CUSTOM_SCRIPTS_DIR:?}"/bash/utils/utils.sh

# TODO:
#   - Add help information
#   - Add dry-run option
#   - Skip files currently in the destination folder
readonly DEST="$1"

check_args() {
  if [ -z "$DEST" ]; then
    prompt -e "[ Error! ] -> You must specify the destination folder."
    echo ""
    exit 1
  fi
}

move_content() {
  prompt -i "[ Info! ] -> Moving files... !"
  find "$PWD" -type f -print0 | xargs -0 -I'{}' mv '{}' "$PWD"/"$DEST"
}

check_args
if move_content; then
  prompt -s "[ Success! ] -> Operation succeeded !"
  echo ""
else
  prompt -e "[ Error! ] -> An error has occurred while moving files."
  echo ""
  exit 2
fi

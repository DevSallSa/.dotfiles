#!/usr/bin/env bash

# This is DevSallSa
# source "${CUSTOM_SCRIPTS_DIR:?}"/bash/utils.sh


set -u
readonly ROOT_UID=0
readonly MAX_DELAY=5
readonly RETRY_NUMBER_TOTAL=3

#COLORS
readonly NO_COLOR="\033[0m"                      # default color
readonly BOLD_CYAN="\033[1;36m"                  # bold info color
readonly BOLD_GREEN="\033[1;32m"                 # bold success color
readonly BOLD_RED="\033[1;31m"                   # bold error color
readonly BOLD_YELLOW="\033[1;33m"                # bold warning color

# echo like ...  with flag type and display message colors
prompt() {
  case $1 in
    "-s"|"--success")
      echo -e "\n${BOLD_GREEN}[ SUCCESS ] -> $2${NO_COLOR}"
      ;;
      "-e"|"--error")
      echo -e "\n${BOLD_RED}[ ERROR ] -> $2${NO_COLOR}"
      ;;
    "-w"|"--warning")
      echo -e "\n${BOLD_YELLOW}[ WARN ] -> $2${NO_COLOR}"
      ;;
    "-i"|"--info")
      echo -e "\n${BOLD_CYAN}[ INFO ] -> $2${NO_COLOR}"
      ;;
    *)
      echo -e "$@"
    ;;
  esac
}

# This is for showing a progress bar based on a sleep time
# passed in as an argument.
progressbar() {
  for ((k = 0; k <= 10 ; k++))
  do
      echo -n "[ "
      for ((i = 0 ; i <= k; i++)); do echo -n "==="; done
      for ((j = i ; j <= 10 ; j++)); do echo -n "   "; done
      v=$((k * 10))
      echo -n " ] "
      echo -n "$v %" $'\r'
      sleep "$1"
  done
}

# Change the user to root profile.
become_root() {
  # Checking for root access and proceed if it is present
  if [ "$UID" -eq "$ROOT_UID" ]; then
    return 0
  else
    # Error message
    prompt -w "You should be root to continue !"

    # persisted execution of the script as root
    read -rp "[ trusted ] specify the root password : " -t"$MAX_DELAY" -s
    if [ -n "$REPLY" ]; then
      # become sudo
      sudo -S <<< "$REPLY" echo ""
    else
      return 1
    fi
  fi
}

# Check if the user is root.
check_root() {
  local count=0
  while [ "$count" -lt "$RETRY_NUMBER_TOTAL" ]; do
    if become_root; then
      return 0
    fi
    ((count++))
  done
  return 1
}

cancel_operation() {
  prompt -e "$1"
  exit 1
}

#!/usr/bin/env bash

###################################################################
# Description  :
# Author       : DevSallSa
# Email        : devsallsa@linuxmail.org
# Date         :
# Version      :
###################################################################

# set -eo pipefail
set -x

TEMP_DIR=/tmp/script/.config 
cd "$1"
mkdir -p "$TEMP_DIR"
mv -f {.,}* "$TEMP_DIR"
mv "$TEMP_DIR" "$PWD"/dot-config
rm -rf "$TEMP_DIR"

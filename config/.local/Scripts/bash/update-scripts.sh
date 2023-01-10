#!/usr/bin/env bash

###################################################################
# Description  : using custom scripts as binaries
# Author       : DevSallSa
# Email        : devsallsa@linuxmail.org
# Date         : 2022/10/07
# Version      : 1.1
###################################################################

MY_SCRIPTS_PATH="$HOME"/.local/Scripts
SCRIPT_PATH="$MY_SCRIPTS_PATH"/bin

compute() {
  mkdir -p "$SCRIPT_PATH"
  mv "$MY_SCRIPTS_PATH"/bash/utils /tmp/ 

  # TODO: remove dependency to tree program
  tree -Ffi $MY_SCRIPTS_PATH/bash | grep -o ".*\.sh" | \
	  xargs -I'{}' basename '{}' | \
	  xargs -I'{}' bash -c 'ln -s $HOME/.local/Scripts/bash/{} \
	  			    $HOME/.local/Scripts/bin/$(echo {} | \
			     cut -d. -f1)'
  mv /tmp/utils  "$MY_SCRIPTS_PATH"/bash/utils
}

if [ -z "$SCRIPT_PATH" ]; then
  compute
else
  rm -r "$SCRIPT_PATH"
  compute
fi

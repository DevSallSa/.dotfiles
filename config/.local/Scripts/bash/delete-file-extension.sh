#!/usr/bin/env bash

# readonly FILE_NAME="$1"
# delete file_extension in files name in current directory
readonly FILE_EXTENSION="$1"
# if [ -z "$FILE_NAME" ] || [ -z "$FILE_EXTENSION" ]; then
if [ -z "$FILE_EXTENSION" ]; then
  echo err.. Missing arguments !
  echo ./delete-file-extension  file_extension_to_remove
  exit 34;
fi
ls *."$FILE_EXTENSION" | sed -r "s/\."$FILE_EXTENSION"//" | xargs -I'{}' mv '{}'."$FILE_EXTENSION" '{}'


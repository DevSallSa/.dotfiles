#!/usr/bin/env bash

# Vérifier qu'il y'a bien 2 argument
original_filename="$1"
input_file=$(echo "$original_filename" | tr "'" '_' | cut -d. -f1)

# Prévenir qu'on va remplacer les ' par des _ dans le nom du fichier original
# for file in *.mp4; do mv $file ${file/\'/_}; done
mv "$original_filename" "${input_file/\'/_}"
#mv "$original_filename" "$input_file"

ffmpeg -loglevel error -y -i "$input_file" "$2"/"$input_file".mp3
mv "$input_file" "$original_filename"

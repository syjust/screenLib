#!/bin/bash
default_folder="$PWD"
read -e -p "Folder (default: '$default_folder'): " folder
[[ -z "$folder" ]] && folder="$default_folder"
folder="${folder/#\~/$HOME}"
if [[ ! -d "$folder" ]] || [[ ! -r "$folder" ]] || [[ ! -x "$folder" ]]; then
    echo "Error: '$folder' is not a readable/traversable directory" >&2
    exit 1
fi

default_prefix="$(basename "$folder" | sed 's/ +/-/g')"
read -r -p "Tab prefix (default: '$default_prefix'): " prefix
[[ -z "$prefix" ]] && prefix="$default_prefix"

dir="$folder"
session="$STY"

screen -S "$session" -X chdir "$dir"
screen -S "$session" -X screen -t "${prefix}-C"
screen -S "$session" -X screen -t "${prefix}-GIT"
screen -S "$session" -X screen -t "${prefix}-RUN"

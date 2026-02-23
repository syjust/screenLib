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

current_window=$(screen -S "$session" -Q number 2>/dev/null | awk '{print $1}')
next=$((current_window + 1))

screen -S "$session" -X chdir "$dir"
screen -S "$session" -X screen -t "${prefix}-C" $next
screen -S "$session" -X screen -t "${prefix}-GIT" $((next + 1))
screen -S "$session" -X screen -t "${prefix}-RUN" $((next + 2))
screen -S "$session" -X chdir "$HOME"

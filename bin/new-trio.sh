#!/bin/bash
if [[ ! -z "$1" ]] ; then
    dir="$1"
else
    default_dir="$PWD"
    read -e -p "Folder (default: '$default_dir'): " dir
    [[ -z "$dir" ]] && dir="$default_dir"
    dir="${dir/#\~/$HOME}"
fi
if [[ ! -d "$dir" ]] || [[ ! -r "$dir" ]] || [[ ! -x "$dir" ]]; then
    echo "Error: '$dir' is not a readable/traversable directory" >&2
    exit 1
fi

if [[ ! -z "$2" ]] ; then
    prefix="$2"
else
    default_prefix="$(basename "$dir" | sed 's/ +/-/g')"
    read -r -p "Tab prefix (default: '$default_prefix'): " prefix
    [[ -z "$prefix" ]] && prefix="$default_prefix"
fi

session="$STY"

current_window=$(screen -S "$session" -Q number 2>/dev/null | awk '{print $1}')
next=$((current_window + 1))

screen -S "$session" -X chdir "$dir"
screen -S "$session" -X screen -t "${prefix}-C" $next
screen -S "$session" -X screen -t "${prefix}-GIT" $((next + 1))
screen -S "$session" -X screen -t "${prefix}-RUN" $((next + 2))
screen -S "$session" -X chdir "$HOME"

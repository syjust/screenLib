#!/bin/bash
dir="${1:?usage: source.sh <dir>}"
[[ -d "$dir" ]] || exit 0
for f in "$dir"*.screenrc; do
    [ -f "$f" ] && screen -S "$STY" -X source "$f"
done

#!/bin/bash
for f in "$HOME/.screen/custom/"*.screenrc; do
    [ -f "$f" ] && screen -S "$STY" -X source "$f"
done

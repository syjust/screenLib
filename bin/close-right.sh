#!/bin/bash
current=$WINDOW
session=$STY

screen -S "$session" -X msgwait 0
for num in $(screen -S "$session" -Q windows 2>/dev/null \
    | grep -oE '(^|  )[0-9]+' \
    | grep -oE '[0-9]+' \
    | sort -n \
    | awk -v cur="$current" '$1 > cur'); do
    screen -S "$session" -p "$num" -X kill >/dev/null 2>&1
done
screen -S "$session" -X msgwait 5

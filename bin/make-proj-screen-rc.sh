#!/bin/bash

# {{{ function quit
quit() {
    echo "ERROR ${FUNCNAME[1]}: $@"
    exit 1
}
export -f quit
# }}}

[[ -z "$HOME_SCREEN_DIR" ]] && HOME_SCREEN_DIR="$HOME/.screen"
[[ -z "$SCREEN_TEMPLATE" ]] && SCREEN_TEMPLATE="$HOME_SCREEN_DIR/templates/default-template.screenrc"
[[ -z "$SCREEN_PROJ_DIR" ]] && SCREEN_PROJ_DIR="$HOME/projects"

TARGET_STY="${1}"

[[ -z "$TARGET_STY" ]] && quit "'TARGET_STY': missing argument"
[[ -d "$HOME_SCREEN_DIR" ]] || quit "'$HOME_SCREEN_DIR': dir not found"
[[ -d "$SCREEN_PROJ_DIR" ]] || quit "'$SCREEN_PROJ_DIR': dir not found"
[[ -e "$SCREEN_TEMPLATE" ]] || quit "'$SCREEN_TEMPLATE': file not found"
if [[ ! -d "$SCREEN_PROJ_DIR/$TARGET_STY" ]] && [[ ! -L "$SCREEN_PROJ_DIR/$TARGET_STY" ]] ; then
    quit "'$SCREEN_PROJ_DIR/$TARGET_STY': dir or link not found"
fi
if [[ -e "$HOME_SCREEN_DIR/sessions/$TARGET_STY.screenrc" ]] ; then
    echo "$HOME_SCREEN_DIR/sessions/$TARGET_STY.screenrc: file already exists"
else
    cp -v $SCREEN_TEMPLATE $HOME_SCREEN_DIR/sessions/$TARGET_STY.screenrc
fi

screen -S "$TARGET_STY" -X source "$HOME_SCREEN_DIR/sessions/$TARGET_STY.screenrc"
